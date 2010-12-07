From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] yet another doc formatting problem
Date: Tue, 07 Dec 2010 09:42:48 +0100
Message-ID: <4CFDF388.6060907@drmicha.warpmail.net>
References: <20101207050737.GA32485@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 09:45:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPtAk-0006Kc-TT
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 09:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab0LGIpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 03:45:10 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56126 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753113Ab0LGIpJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 03:45:09 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B8DD133F;
	Tue,  7 Dec 2010 03:45:08 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 07 Dec 2010 03:45:08 -0500
X-Sasl-enc: aG7cxEHG/xLABR3l9Ap+A52lfMhnjaR4ninbywzZWnPC 1291711508
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 130ED402017;
	Tue,  7 Dec 2010 03:45:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101207050737.GA32485@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163071>

Jeff King venit, vidit, dixit 07.12.2010 06:07:
> When I build git-rm.1, some of the headings look odd. For example:
>=20
>    Using  git commit -a""
>           If you intend that your next commit should record...
>    ...
>    Using  git add -A""
>           When accepting a new code drop for a vendor branch
>=20
> Note the funny double-space and the weird "" at the end. I get the sa=
me
> thing from "git show origin/man:man1/git-rm.1 | nroff -man".
>=20
> The source looks like this:
>=20
>   $ git grep -A1 Using..git.commit git-rm.txt
>   git-rm.txt:Using "git commit -a"
>   git-rm.txt-~~~~~~~~~~~~~~~~~~~~~
>=20
> which looks sane to me. The generated xml also looks OK to me:
>=20
>   $ grep Using..git.commit git-rm.xml
>   <title>Using "git commit -a"</title>
>=20
> But the resulting roff doesn't:
>=20
>   $ grep Using..git.commit git-rm.1
>   .SS "Using "git commit \-a""
>=20
> which looks like a quoting error to me, which implies a bug in docboo=
k.
>=20
> I guess we can hack around it with some XSL magic, but I am tempted t=
o
> do the simple:
>=20
> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index 71e3d9f..8ee559b 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -89,8 +89,8 @@ the paths that have disappeared from the filesystem=
=2E However,
>  depending on the use case, there are several ways that can be
>  done.
> =20
> -Using "git commit -a"
> -~~~~~~~~~~~~~~~~~~~~~
> +Using git commit -a
> +~~~~~~~~~~~~~~~~~~~
>  If you intend that your next commit should record all modifications
>  of tracked files in the working tree and record all removals of
>  files that have been removed from the working tree with `rm`
> @@ -98,8 +98,8 @@ files that have been removed from the working tree =
with `rm`
>  automatically notice and record all removals.  You can also have a
>  similar effect without committing by using `git add -u`.
> =20
> -Using "git add -A"
> -~~~~~~~~~~~~~~~~~~
> +Using git add -A
> +~~~~~~~~~~~~~~~~
>  When accepting a new code drop for a vendor branch, you probably
>  want to record both the removal of paths and additions of new paths
>  as well as modifications of existing paths.
>=20
> -Peff

Couple'o'things goin' on here ;)

=46irst of all, we shouldn't use a literal " to denote a "quotation". J=
ust
like in HTML, this may or may not work. Typographically, the outcome wa=
s
*always* wrong. The proper way in asciidoc is surrounding the
``quotation'' by double backticks and double ticks. Doing it right in
git-rm.txt will lead to proper nroff and html outputs, e.g.:

Using =E2=80=9Cgit commit -a=E2=80=9D

Of course, literal " works in most place - well, save the fact that it
never really works because it never produces typographically correct
output. Am I repeating myself? ;)

Here, a literal " in asciidoc ends up as a literal " in html and xml.
Any browser groks it in a place like that, producing correct output -
well, save the fact that...

docbook (translating xml to nroff) does not grok it. Now that is a
surprise... Pleeease, someone get me straight asciidoc to nroff!

On a side note, looking at origin/man I get the impression that these
subheaders were always wrong.

So, in summary, we should really ``quote'' things properly, but this
would need to be done consistently, because a mix of new
(typographhically correct) quotes and old ones looks even worse. If we
really want to go that route I'd volunteer to do things one by one.
Actually, it seems we've been partially going that route already, using
{tilde}, {apostrophe} etc.

Michael
