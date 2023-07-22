#SELECT  * FROM  "census data" ;
#SELECT * FROM `census\ data`;

## check/ view table dataset.
SELECT * FROM `census data`;

## count number of rows
select count(*) from `census data` ;

# dataset from jharkand and bihar state
select * from `census data` where state in ('Bihar', 'Jharkhand') ;

# total population / literacy rate from jharkand and bihar

select sum(literacy) from `census data` where state in ('Bihar', 'Jharkhand') ;

# total population / literacy rate
select sum(literacy) from `census data`;
select sum(literacy) as literacy from `census data`;

# avg highest literecay rate greater than 90 
select state ,round (avg(literacy),0) as avg_literacy_ratio from `census data`  group by state  having round (avg(literacy),0) >90  order by avg_literacy_ratio desc ;

# avg growth
select avg(Growth)*100 from `census data`;
select avg(Growth)*100 avg_growth from `census data`;

# avg growth percentile of each state 
select state ,avg(Growth)*100 as avg_growth from `census data` group by state ;

# avg sex_ratio of each state 
select state ,avg(Sex_Ratio) as avg_ratio from `census data` group by state ;
select state , round (avg(Sex_Ratio),0) as avg_ratio from `census data` group by state ;
select state ,round (avg(Sex_Ratio),0) as avg_ratio from `census data` group by state order by avg_ratio desc ;


# top 3 states that shows highest growth ratio 
select 'top 3'as ranking , state ,avg(Growth)*100 as avg_growth_ratio from `census data` group by state order by avg_growth_ratio desc limit 3;
select state ,avg(Growth)*100 as avg_growth_ratio from `census data` group by state order by avg_growth_ratio desc limit 3 ;


# bottom 3 states that shows lowest sex ratio 
select state ,round (avg(Sex_Ratio),0) as avg_ratio from `census data` group by state order by avg_ratio asc limit 3 ;


#create table
create table  top_states
( state varchar (255) , topstatus float );

insert into  top_states
select state ,round (avg(literacy),0) as avg_literacy_ratio from `census data` group by state order by avg_literacy_ratio desc limit 3 ;

select * from  top_states;



#create table
create table  bottom_states
( state varchar (255) , botstatus float );

insert into  bottom_states
select state ,round (avg(literacy),0) as avg_literacy_ratio from `census data` group by state order by avg_literacy_ratio asc limit 3 ;

select  * from  bottom_states;

--- join both table 
select * from (select state ,round (avg(literacy),0) as avg_literacy_ratio from `census data` group by state order by avg_literacy_ratio desc limit 3) as a 
union
select * from (select state ,round (avg(literacy),0) as avg_literacy_ratio from `census data` group by state order by avg_literacy_ratio asc limit 3) as b  ;



--- state starting with letter a  and a or b
select distinct state from `census data` where state  like 'a%';
select distinct state from `census data` where state  like 'a%' or state like 'b%' ;

select distinct state from `census data` where state  like 'a%' and state like 'b%' ;
select distinct state from `census data` where lower(state)  like 'a%' or lower(state) like 'b%' ;
select distinct state from `census data` where state  like 'a%' or state like '%d' ;
select distinct state from `census data` where state  like 'a%' and state like '%d' ;

--- IN (INNER , cross , left , right)

select a.district ,a.sex_ratio , a.state , a.literacy, b.population  from `census data` as a left join  `population_data`as b   on a.district = b.district;
select a.district ,a.sex_ratio , a.state , a.literacy, b.population  from `census data` as a inner join  `population_data`as b   on a.district = b.district;
select a.district ,a.sex_ratio , a.state , a.literacy, b.population  from `census data` as a right join  `population_data`as b   on a.district = b.district;
select a.district ,a.sex_ratio , a.state ,  a.literacy,b.population  from `census data` as a cross join  `population_data`as b   on a.district = b.district;


--- checking new table 
select * from `population_data`;

# check total females and males ratio from population 
select c.district,c.state state, 
            round(c.population /(c.sex_ratio*1),0) as males , 
            round(c.population*(c.sex_ratio*1)/(c.sex_ratio*1),0) as females
from
			(select a.district ,a.sex_ratio/1000 as sex_ratio, a.state, a.literacy, b.population  from `census data` as a inner join  `population_data`as b   on a.district = b.district) as c;


SELECT c.district, c.state,
       ROUND(c.population / (c.sex_ratio + 1), 0) AS males,
       ROUND(c.population * (c.sex_ratio / (c.sex_ratio + 1)), 0) AS females
FROM (
    SELECT a.district, a.state, a.literacy, b.population, a.sex_ratio
    FROM `census data` AS a
    INNER JOIN `population_data` AS b ON a.district = b.district
) AS c;

---- total females and males from population.
select d.state , sum(d.males) as total_males  ,  sum(d.females) as total_females from
(select c.district,c.state state, 
            round(c.population /(c.sex_ratio*1),0) as males , 
            round(c.population*(c.sex_ratio*1)/(c.sex_ratio*1),0) as females
from
			(select a.district ,a.sex_ratio/1000 as sex_ratio, a.state, a.literacy, b.population  from `census data` as a inner join  `population_data`as b   on a.district = b.district) as c) 
            as d 
             group by d.state ;
             
---  total literacy rate 
             
--- select a.district ,a.sex_ratio/1000 as sex_ratio, a.state, a.literacy, b.population  from `census data` as a inner join  `population_data`as b   on a.district = b.district) as c             