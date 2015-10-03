From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/9] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Sat, 03 Oct 2015 11:39:47 +0200
Message-ID: <vpq8u7kb89o.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 11:40:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiJIZ-0003AP-WF
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 11:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbbJCJkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 05:40:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59214 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbbJCJj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 05:39:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t939dkNH023416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 3 Oct 2015 11:39:46 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t939dlqv001473;
	Sat, 3 Oct 2015 11:39:47 +0200
In-Reply-To: <1443807546-5985-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Fri, 2 Oct 2015 23:08:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 03 Oct 2015 11:39:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t939dkNH023416
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444469987.23243@4oOaSP5WMnLBzyfghd2FEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278965>

Karthik Nayak <karthik.188@gmail.com> writes:

> Implement %(if), %(then) and %(else) atoms. Used as
> %(if)..%(then)..%(end) or %(if)..%(then)..%(else)..%(end).

I prefer ... to .., which often means "interval" as in HEAD^^..HEAD.

> If there is an atom with value or string literal after the %(if)

I find this explanation hard to read, and ambiguous: what does "atom
with value" mean?

> then everything after the %(then) is printed, else if the %(else) atom
> is used, then everything after %(else) is printed. If the string
> contains only whitespaces, then it is not considered.

"the string" is ambiguous again. I guess it's "what's between %(if) and
%(then)", but it could be clearer. And it's not clear what "not
considered" means.

My take on it:

Implement %(if), %(then) and %(else) atoms. Used as
%(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
format string between %(if) and %(then) expands to an empty string, or
to only whitespaces, then the string following %(then) is printed.
Otherwise, the string following %(else), if any, is printed.

> +When a scripting language specific quoting is in effect,

This may not be immediately clear to the reader. I'd add explicitly:

When a scripting language specific quoting is in effect (i.e. one of
`--shell`, `--perl`, `--python`, `--tcl` is used), ...

>  EXAMPLES
>  --------

This is just the context of the patch, but I read it as a hint that we
could add some examples with complex --format usage to illustrate the
theory above.

> +	if (if_then_else->condition_satisfied && if_then_else->else_atom) {
// cs && else
> +		strbuf_reset(&cur->output);
> +		pop_stack_element(&cur);
> +	} else if (if_then_else->else_atom) {
// !cs && else
> +		strbuf_swap(&cur->output, &prev->output);
> +		strbuf_reset(&cur->output);
> +		pop_stack_element(&cur);
> +	} else if (!if_then_else->condition_satisfied)
// !cs && !else
> +		strbuf_reset(&cur->output);

This if/else if/else if looks hard to read to me. I had to add the
comments above as a note to myself to get the actual full condition for
3 branches.

The reasoning would be clearer to me as:

if (if_then_else->else_atom) {
	/*
	 * There is an %(else) atom: we need to drop one state from the
	 * stack, either the %(else) branch if the condition is satisfied, or
	 * the %(then) branch if it isn't.
	 */
	if (if_then_else->condition_satisfied) {
		strbuf_reset(&cur->output);
		pop_stack_element(&cur);
	} else {
		strbuf_swap(&cur->output, &prev->output);
		strbuf_reset(&cur->output);
		pop_stack_element(&cur);
	}
} else if (if_then_else->condition_satisfied)
	/*
         * No %(else) atom: just drop the %(then) branch if the
	 * condition is not satisfied.
         */
	strbuf_reset(&cur->output);

> +static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +	struct ref_formatting_stack *new;
> +	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
> +
> +	if_then_else->if_atom = 1;

Do you ever use this "if_atom"? It doesn't seem so in the current patch,
and it seems like a tautology to me: if you have a struct if_then_else,
then you have seen the %(if).

> +static int is_empty(const char * s){

char * s -> char *s

> +static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +	struct ref_formatting_stack *cur = state->stack;
> +	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
> +
> +	if (!if_then_else)
> +		die(_("format: %%(then) atom used without an %%(if) atom"));

You've just casted at_end_data to if_then_else. if_then_else being not
NULL does not mean that it is properly typed. It can be the at_end_data
of another opening atom. What happens if you use
%(align)foo%(then)bar%(end)?

One way to be safer would be to check that cur->at_end does point to
if_then_else_handler. Or add information to struct ref_formatting_stack
(a Boolean is_if_then_else or an enum).

Also, you need to check that if_then_else->then_atom is not 1.

> +static void else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +	struct ref_formatting_stack *prev = state->stack;
> +	struct if_then_else *if_then_else = (struct if_then_else *)state->stack->at_end_data;
> +
> +	if (!if_then_else)
> +		die(_("format: %%(else) atom used without an %%(if) atom"));

Same as above, I guess (not tested) %(align)...%(else) is accepted.

> +	if (!if_then_else->then_atom)
> +		die(_("format: %%(else) atom used without a %%(then) atom"));
> +	if_then_else->else_atom = 1;
> +	push_stack_element(&state->stack);

So, while parsing the %(else)...%(end), the stack contains both the
%(then)...%(else) part, and the %(else)...%(end).

I'm wondering if we can simplify this. We already know if the condition
is satisfied, and if it's not, we can just drop the %(then) part right
now, and write to the top of the stack normally (the %(end) atom will
only have to pop the string normally). But if the condition is not
satisfied, we need to preserve the %(then) part and need to do something
about the %(else).

> -	current->at_end(current);
> +	current->at_end(&state->stack);
> +
> +	/*  Stack may have been popped, hence reset the current pointer */

I'd say explicitly "... may have been popped within at_end, hence ..."

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
