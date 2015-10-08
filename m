From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Thu, 08 Oct 2015 14:27:30 +0200
Message-ID: <vpqr3l5zgst.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 14:28:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkAIh-0004Th-37
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 14:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235AbbJHM1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 08:27:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39648 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757192AbbJHM1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 08:27:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t98CRTem031790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 14:27:30 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98CRU1u002542;
	Thu, 8 Oct 2015 14:27:30 +0200
In-Reply-To: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 8 Oct 2015 14:47:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Oct 2015 14:27:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98CRTem031790
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444912052.24545@02yrzLcwjUovIYby8dRMEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279238>

Karthik Nayak <karthik.188@gmail.com> writes:

> +An example to show the usage of %(if)...%(then)...%(else)...%(end).
> +This prefixes the current branch with a star.
> +
> +------------
> +#!/bin/sh
> +
> +git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)  %(end)%(refname:short)" refs/heads/

I don't think the #!/bin/sh adds any value here. Just the 'git
for-each-ref' line is sufficient IMHO.

> +An example to show the usage of %(if)...%(then)...%(end).
> +This adds a red color to authorname, if present

I don't think this is such a good example.
%(color:red)%(authorname)%(color:reset) just works even if %(authorname)
is empty.

A better example would be

git for-each-ref --format='%(if)%(authorname)%(then)Authored by %(authorname)%(end)'

which avoids writting "Authored by " with no author.

> -static int is_empty(const char * s){
> +static int is_empty(const char *s){

You still have the { on the declaration line, it should be on the next
line.

> @@ -309,10 +311,14 @@ static int is_empty(const char * s){
>  static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>  {
>  	struct ref_formatting_stack *cur = state->stack;
> -	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
> +	struct if_then_else *if_then_else = NULL;
>  
> +	if (cur->at_end == if_then_else_handler)
> +		if_then_else = (struct if_then_else *)cur->at_end_data;

OK, now the cast is safe since at_end_data has to be of type struct
if_then_else * if at_end is if_then_else_handler.

> +				unsigned int nobracket = 0;
> +
> +				if (!strcmp(valp, ",nobracket"))
> +					nobracket = 1;

The code to parse comma-separated values is different here and
elsewhere. I'd rather have the same code (possibly factored into a
helper function), both to get consistent behavior (you're not allowing
%(upstream:nobracket,track) for example, right?) and consistent code.

>  				if (!num_ours && !num_theirs)
>  					v->s = "";
>  				else if (!num_ours) {
> -					sprintf(buf, "[behind %d]", num_theirs);
> +					if (nobracket)
> +						sprintf(buf, "behind %d", num_theirs);
> +					else
> +						sprintf(buf, "[behind %d]", num_theirs);

Perhaps use sprintf(buf, "%sbehind %d%s", obracket, num_their, cbracket)
unconditionnally, and set obracket = "" or obracket = "[" once and for
all when you test for "nobracket" above. This avoids these "if
(nobracket)" spread accross the code, but at the price of extra %s in
the format strings.

> @@ -1170,6 +1173,29 @@ static void populate_value(struct ref_array_item *ref)
>  				else
>  					v->s = "<>";
>  				continue;
> +			} else if (!strcmp(formatp, "dir") &&
> +				   (starts_with(name, "refname"))) {
> +				const char *sp, *ep, *tmp;
> +
> +				sp = tmp = ref->refname;
> +				/*  Obtain refs/foo/bar/ from refname refs/foo/bar/abc */
> +				do {
> +					ep = tmp;
> +					tmp = strchr(ep + 1, '/');
> +				} while (tmp);

To look for the last occurence of '/' you can also use strrchr().
Doesn't it do what you want here?

> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -58,11 +58,11 @@ test_expect_success 'branch -v' '
>  '
>  
>  cat >expect <<\EOF
> -b1 [origin/master] [ahead 1, behind 1] d
> -b2 [origin/master] [ahead 1, behind 1] d
> -b3 [origin/master] [behind 1] b
> -b4 [origin/master] [ahead 2] f
> -b5 [brokenbase] [gone] g
> +b1 [origin/master: ahead 1, behind 1] d
> +b2 [origin/master: ahead 1, behind 1] d
> +b3 [origin/master: behind 1] b
> +b4 [origin/master: ahead 2] f
> +b5 [brokenbase: gone] g
>  b6 [origin/master] c
>  EOF

Cool!

I didn't go through the patches themselves, but modulo my remarks above
the interdiff looks good. Thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
