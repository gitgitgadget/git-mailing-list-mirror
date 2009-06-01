From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix colouring of matches with zero length
Date: Mon, 01 Jun 2009 14:17:20 -0700
Message-ID: <7voct7k61r.fsf@alter.siamese.dyndns.org>
References: <4A2405DA.7010801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 01 23:17:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBEt0-0001eM-9Z
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 23:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbZFAVRX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2009 17:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZFAVRX
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 17:17:23 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43908 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZFAVRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 17:17:22 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601211720.HSDT2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Mon, 1 Jun 2009 17:17:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id ylHL1b0024aMwMQ04lHLkj; Mon, 01 Jun 2009 17:17:20 -0400
X-Authority-Analysis: v=1.0 c=1 a=aCLce5l3CrUA:10 a=a5mrOJr5uoMA:10
 a=s4-7ANFqFB3nzbUZ9IEA:9 a=N9f3aVwia-CdzpUZoF5bb6hsz_kA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120482>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The first hunk fixes match colouring if the patterns is the empty str=
ing.
> Such a pattern matches the whole line,...

Hmmm...

An empty pattern may have to produce a match with any line, but I do no=
t
think it should match the whole line.  GNU seems to agree with me.

	echo foo | grep --color -e ''
        echo foo | grep --color -F -e ''
        echo foo | grep --color -e '.*'
        echo foo | grep --color -F -e 'foo'

The first two are uncoloured (but still show matches).

> The second hunk of the patch makes sure that grep match colouring doe=
sn't
> get stuck in an infinite loop if the length of a match is zero.

Certainly we need to advance the match pointer, and this issue needs to=
 be
addressed.  I think it is a good change.

> of the line is simply printed without colouring.  Even though the emp=
ty
> pattern string doesn't result in empty matches any more, this defensi=
ve
> measure catches unknown cases.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  grep.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index cc6d5b0..745b3c0 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -324,7 +324,11 @@ static int match_one_pattern(struct grep_pat *p,=
 char *bol, char *eol,
>  	}
> =20
>   again:
> -	if (p->fixed)
> +	if (p->pattern[0] =3D=3D '\0') {
> +		hit =3D 1;
> +		pmatch[0].rm_so =3D 0;
> +		pmatch[0].rm_eo =3D eol - bol;
> +	} else if (p->fixed)
>  		hit =3D !fixmatch(p->pattern, bol, pmatch);
>  	else
>  		hit =3D !regexec(&p->regexp, bol, 1, pmatch, eflags);
> @@ -500,6 +504,8 @@ static void show_line(struct grep_opt *opt, char =
*bol, char *eol,
> =20
>  		*eol =3D '\0';
>  		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
> +			if (match.rm_so =3D=3D match.rm_eo)
> +				break;
>  			printf("%.*s%s%.*s%s",
>  			       (int)match.rm_so, bol,
>  			       opt->color_match,
> --=20
> 1.6.3.1
