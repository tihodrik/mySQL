create database university;
use university;

drop table if exists students, cities;

create table cities (
	city_id int(4) auto_increment not null primary key,
    city varchar(40) not null,
    country varchar(20) not null
);


create table students (
	student_id int(4) primary key auto_increment,
    first_name varchar(40) not null,
    middle_name varchar(40),
    last_name varchar(40) not null,
    course int(1) not null,
    gender varchar(1) not null,
    city_id int(4) not null,
    foreign key (city_id) references cities (city_id)
);


insert into cities (city, country) values
	('Erfurt', 'Germany'),
    ('San-Francisco','USA'),
    ('Capetown','RSA'),
    ('Beijing','China'),
    ('Essen','Germany'),
    ('Hamburg','Germany'),
    ('Athlanta','USA');


insert into students (first_name, last_name, course, gender, city_id) values
	('Mark','Schmidt','3','m','1'),
    ('Helen','Hunt','2','f','2'),
    ('Matumba','Zuko','4','m','3'),
    ('Rin','Kupo','4','f','3'),
	('Peter','Zimmer','3','m','5'),
    ('Hanz','Mueller','4','m','6'),
    ('Alisa','Kepler','4','f','1'),
    ('Anna','Madavie','2','f','7');
    
insert into students (first_name, middle_name, last_name, course, gender, city_id) values
    ('Zhen','Chi','Bao','2','m','4');
    

#Сколько всего студентов приехало к нам учиться
select count(student_id) from students;

#Сколько студенток-девочек приехало учиться и на каких они курсах
select count(student_id) from students where gender='f';
select course from students where gender='f' group by course;

#Сколько студентов приехало учиться из Германии
select count(*) from students, cities where students.city_id = cities.city_id and cities.country = 'Germany';

#Сколько студентов младше четвертого курса у нас обучаются (не включая сам 4 курс)
select count(student_id) from students where course<'4';

#Необходимо перевести Анну со 2 на 3 курс, а Питера за неуспеваемость на второй курс
update students set course='3' where first_name='Anna';
update students set course='2' where first_name='Peter';

#Необходимо удалить записи обо всех студентках-девушках из Германии, т.к. им не дали разрешение на обучение у нас
delete from students where gender='f' and students.city_id in (select city_id from cities where country='Germany');

#Всем студентам необходимо добавить данные об отметке об успешном освоении нашего курса, по-умолчанию у всех курс не освоен, кроме студентов 4-го курса из Германии
alter table students add column finished bool default '0' after gender;
update students set finished='1' where course='4' and city_id in (select city_id from cities where country = 'Germany');

