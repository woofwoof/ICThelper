/* ICT HELPER 2 */
/* Version 1.0 */

go :- 	hypothesise(Solution),
	write('You should consider: '),
	write(Solution),
	nl,
	undo.

/* hypotheses to be tested */

hypothesise(asking_DIYNGO_for_help_please) :- ask_diyngo, !.
hypothesise(a_solar_computer_solution) :- solar_comp, !.
hypothesise(a_wind_computer_solution) :- wind_comp, !.
hypothesise(sorry_we_cannot_help).

/* rules */

ask_diyngo :- 	renewables,
		verify(plenty_of_sunshine),
		verify(little_knowledge_of_renewables).
ask_diyngo :- 	renewables,
		verify(plenty_of_wind),
		verify(little_knowledge_of_renewables).

solar_comp :-	renewables,
		verify(understanding_of_computers),
		verify(plenty_of_sunshine).

wind_comp :-	renewables,
		verify(understanding_of_computers),
		verify(plenty_of_wind).

/* classification rules */

renewables :- verify(no_grid_electricity).
renewables :- verify(often_lose_power).

/* ask questions */

ask(Question)	:- 	write('In your community is there the following: '),
			write(Question),
			write('? '),
			read(Response),
			nl,
			((Response == yes ; Response == y)
				->
					assert(yes(Question)) ;
					assert(no(Question)), fail).
		:- dynamic yes/1,no/1.

/* verify something */

verify(S) :-
	(yes(S)
		->
		true ;
		(no(S)
			->
				fail ;
				ask(S))).

/*undo all yes/no assertions) */

undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.	
