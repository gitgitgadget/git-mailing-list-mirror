From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 01/11] ref-filter: introduce 'ref_formatting_state'
Date: Mon, 27 Jul 2015 14:42:15 +0200
Message-ID: <vpqmvyhai1k.fsf@anie.imag.fr>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJhjk-00083U-HN
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 14:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbG0Mm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 08:42:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37012 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbbG0Mm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 08:42:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6RCgEEm019810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 14:42:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RCgFWq011601;
	Mon, 27 Jul 2015 14:42:15 +0200
In-Reply-To: <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Mon, 27 Jul 2015 12:57:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Jul 2015 14:42:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RCgEEm019810
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438605735.58254@hfkAAzQbNyaY7X1oRaq30w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274671>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void ref_formatting(struct ref_formatting_state *state,
> +			   struct atom_value *v, struct strbuf *value)
>  {
> -	struct strbuf sb = STRBUF_INIT;
> -	switch (quote_style) {
> +	strbuf_addf(value, "%s", v->s);
> +}

You're taking 'state' as argument, but you're not using it in the
function for now. Perhaps add a temporary comment like:

static void ref_formatting(...)
{
	/* Formatting according to 'state' will be applied here */
	strbuf_addf(...)
}

Or perhaps it's OK like this.

> -static void print_value(struct atom_value *v, int quote_style)
> +static void print_value(struct ref_formatting_state *state, struct atom_value *v)

Changing the position of the v parameter makes the patch a bit harder to
read. I would have written in this order:

static void print_value(struct atom_value *v, struct ref_formatting_state *state)

So the patch reads as "encapsulate quote_style in a struct" more
straightforwardly.

> @@ -1257,6 +1269,10 @@ static void emit(const char *cp, const char *ep)
>  void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>  {
>  	const char *cp, *sp, *ep;
> +	struct ref_formatting_state state;

I still found it a bit hard to read, and I would have appreciated a
comment here, like

	/*
	 * Some (pseudo) atom have no immediate side effect, but only
	 * affect the next atom. Store the relevant information from 	
	 * these atoms in the 'state' variable for use when displaying
	 * the next atom.
	 */

With this in mind, it becomes more obvious that you also need to reset
the state after using it, which you forgot to do. See:

$ ./git for-each-ref --format '%(padright:30)|%(refname)|%(refname)|' refs/tags/v2.4.\*
|refs/tags/v2.4.0              |refs/tags/v2.4.0              |
|refs/tags/v2.4.0-rc0          |refs/tags/v2.4.0-rc0          |
|refs/tags/v2.4.0-rc1          |refs/tags/v2.4.0-rc1          |
|refs/tags/v2.4.0-rc2          |refs/tags/v2.4.0-rc2          |
|refs/tags/v2.4.0-rc3          |refs/tags/v2.4.0-rc3          |
|refs/tags/v2.4.1              |refs/tags/v2.4.1              |
|refs/tags/v2.4.2              |refs/tags/v2.4.2              |
|refs/tags/v2.4.3              |refs/tags/v2.4.3              |
|refs/tags/v2.4.4              |refs/tags/v2.4.4              |
|refs/tags/v2.4.5              |refs/tags/v2.4.5              |
|refs/tags/v2.4.6              |refs/tags/v2.4.6              |

I think only the first column should have padding, not the second. You
can fix this with a patch like this:

--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1431,6 +1431,14 @@ static void apply_pseudo_state(struct ref_formatting_state *state,
                state->ifexists = v->s;
 }
 
+static void reset_formatting_state(struct ref_formatting_state *state)
+{
+       int quote_style = state->quote_style;
+       memset(state, 0, sizeof(*state));
+       state->quote_style = quote_style;
+}
+
+
 /*
  * If 'lines' is greater than 0, print that many lines from the given
  * object_id 'oid'.
@@ -1492,8 +1500,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
                get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
                if (atomv->pseudo_atom)
                        apply_pseudo_state(&state, atomv);
-               else
+               else {
                        print_value(&state, atomv);
+                       reset_formatting_state(&state);
+               }
+
        }
        if (*cp) {
                sp = cp + strlen(cp);

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
