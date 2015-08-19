From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state stack machinery
Date: Wed, 19 Aug 2015 16:56:45 +0200
Message-ID: <vpqvbcb2uoi.fsf@anie.imag.fr>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 16:57:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS4nR-00056Z-2u
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 16:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbbHSO4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 10:56:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52416 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096AbbHSO4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 10:56:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JEuhfN003085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 19 Aug 2015 16:56:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JEujQK020699;
	Wed, 19 Aug 2015 16:56:45 +0200
In-Reply-To: <1439923052-7373-4-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Wed, 19 Aug 2015 00:07:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Aug 2015 16:56:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7JEuhfN003085
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440601005.75531@RCvvM8yUQaGJA60BMy7zag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276181>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void pop_state(struct ref_formatting_state **stack)
> +{
> +	struct ref_formatting_state *current = *stack;
> +	struct ref_formatting_state *prev = current->prev;
> +
> +	if (prev)
> +		strbuf_addbuf(&prev->output, &current->output);

I find this "if (prev)" suspicious: if there's a previous element in the
stack, push to it, but otherwise, you're throwing away the content of
the stack top silently.

Given the rest of the patch, this is correct, since you're using
state->output before pop_state(), but I find it weird to have the same
function to actually pop a state, and to destroy the last element.

Just thinking out loudly, I don't have specific alternative to propose
here.

> @@ -1262,23 +1284,24 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>  {
>  	const char *cp, *sp, *ep;
> -	struct ref_formatting_state state;
> +	struct strbuf *final_buf;
> +	struct ref_formatting_state *state = NULL;
>  
> -	strbuf_init(&state.output, 0);
> -	state.quote_style = quote_style;
> +	push_new_state(&state);
> +	state->quote_style = quote_style;

I do not think that the quote_style should belong to the stack. At the
moment, only the bottom of the stack has it set, and as a result you're
getting weird results like:

$ ./git for-each-ref --shell --format '|%(align:80,left)<%(author)>%(end)|' | head -n 3 
|<Junio C Hamano <gitster@pobox.com> 1435173702 -0700>                           ''|
|<Junio C Hamano <gitster@pobox.com> 1435173701 -0700>                           ''|
|<Junio C Hamano <gitster@pobox.com> 1433277352 -0700>                           ''|

See, the '' are inserted where the %(end) was, but not around atoms as
one would expect.

One stupid fix would be to propagate the quote_style accross the stack,
like this:

--- a/ref-filter.c
+++ b/ref-filter.c
@@ -155,6 +155,8 @@ static void push_new_state(struct ref_formatting_state **stack)
 
        strbuf_init(&s->output, 0);
        s->prev = *stack;
+       if (*stack)
+               s->quote_style = (*stack)->quote_style;
        *stack = s;
 }
 

After applying this, I do get the '' around the author (= correct
behavior I think), but then one wonders even more why this is part of
the stack.

You replaced the quote_style argument with ref_formatting_state, and I
think you should have kept this argument and added ref_formatting_state.
The other option is to add an extra indirection like

struct ref_formatting_state {
	int quote_style;
	struct ref_formatting_stack *stack;
}

(ref_formatting_stack would be what you currently call
ref_formatting_state). But that's probably overkill.

Also, after applying my toy patch above, I get useless '' around
%(align) and %(end). I can get rid of them with

--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1499,7 +1501,8 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
                get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
                if (atomv->handler)
                        atomv->handler(atomv, &state);
-               append_atom(atomv, state);
+               else
+                       append_atom(atomv, state);
        }
        if (*cp) {
                sp = cp + strlen(cp);

Unless I missed something, this second patch is sensible anyway and
should be squashed into [PATCH v12 05/13]: you don't need to call
append_atom() when you have a handler, right?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
