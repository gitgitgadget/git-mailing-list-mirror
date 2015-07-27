From: Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@koumbit.org>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Mon, 27 Jul 2015 15:37:26 -0400
Message-ID: <87twspe6ix.fsf@marcos.anarc.at>
References: <1415626412-573-1-git-send-email-anarcat@koumbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 21:47:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJoMm-0001l8-QY
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbbG0TrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2015 15:47:11 -0400
Received: from mail.orangeseeds.org ([72.0.72.144]:58644 "EHLO marcos.anarc.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbbG0TrK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2015 15:47:10 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2015 15:47:09 EDT
Received: by marcos.anarc.at (Postfix, from userid 1000)
	id 65A5A1A007B; Mon, 27 Jul 2015 15:37:26 -0400 (EDT)
In-Reply-To: <1415626412-573-1-git-send-email-anarcat@koumbit.org>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274700>

Any reason why this patch wasn't included / reviewed?

Thanks,

A.

On 2014-11-10 08:33:32, Antoine Beaupr=C3=A9 wrote:
> For projects with separate history lines and, thus, multiple root-com=
mits, the
> linear arrangement of `git log --graph --oneline` does not allow the =
user to
> spot where the sequence ends, giving the impression that it's a conti=
guous
> history. E.g.
>
> History sequence A: a1 -- a2 -- a3 (root-commit)
> History sequence B: b1 -- b2 -- b3 (root-commit)
>
>     git log --graph --oneline
>     * a1
>     * a2
>     * a3
>     * b1
>     * b2
>     * b3
>
> In a GUI tool, the root-commit of each series would stand out on the =
graph.
>
> This modification changes the commit char to a different symbol ('o')=
, so users
> of the command-line graph tool can easily identify root-commits and m=
ake sense
> of where each series is limited to.
>
>     git log --graph --oneline
>     * a1
>     * a2
>     o a3
>     * b1
>     * b2
>     o b3
>
> The 'o' character was chosen because it is the same character used in=
 rev-list
> to mark root commits.
>
> This patch is similar than the one provided by Milton Soares Filho in
> 1382734287.31768.1.git.send.email.milton.soares.filho@gmail.com but w=
as
> implemented independently and uses the 'o' character instead of 'x'.
>
> Other solutions were discarded for those reasons:
>
>  * line delimiters: we want to keep one commit per line
>  * tree indentation: it makes little sense with commit trees without
>    common history, and is more complicated to implement
>
> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@koumbit.org>
> ---
>  revision.c                                 |  8 ++++++--
>  t/t4202-log.sh                             | 10 +++++-----
>  t/t6016-rev-list-graph-simplify-history.sh | 14 +++++++-------
>  3 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 75dda92..5f21e24 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3246,8 +3246,12 @@ char *get_revision_mark(const struct rev_info =
*revs, const struct commit *commit
>  			return "<";
>  		else
>  			return ">";
> -	} else if (revs->graph)
> -		return "*";
> +	} else if (revs->graph) {
> +		if (commit->parents)
> +			return "*";
> +		else
> +			return "o";
> +	}
>  	else if (revs->cherry_mark)
>  		return "+";
>  	return "";
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 99ab7ca..d11876e 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -244,7 +244,7 @@ cat > expect <<EOF
>  * fourth
>  * third
>  * second
> -* initial
> +o initial
>  EOF
> =20
>  test_expect_success 'simple log --graph' '
> @@ -272,7 +272,7 @@ cat > expect <<\EOF
>  |/
>  * third
>  * second
> -* initial
> +o initial
>  EOF
> =20
>  test_expect_success 'log --graph with merge' '
> @@ -338,7 +338,7 @@ cat > expect <<\EOF
>  |
>  |     second
>  |
> -* commit tags/side-1~3
> +o commit tags/side-1~3
>    Author: A U Thor <author@example.com>
> =20
>        initial
> @@ -410,7 +410,7 @@ cat > expect <<\EOF
>  * | third
>  |/
>  * second
> -* initial
> +o initial
>  EOF
> =20
>  test_expect_success 'log --graph with merge' '
> @@ -799,7 +799,7 @@ cat >expect <<\EOF
>  | -one
>  | +ichi
>  |
> -* commit COMMIT_OBJECT_NAME
> +o commit COMMIT_OBJECT_NAME
>    Author: A U Thor <author@example.com>
> =20
>        initial
> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev=
-list-graph-simplify-history.sh
> index f7181d1..74b6fc3 100755
> --- a/t/t6016-rev-list-graph-simplify-history.sh
> +++ b/t/t6016-rev-list-graph-simplify-history.sh
> @@ -81,7 +81,7 @@ test_expect_success '--graph --all' '
>  	echo "|/|   " >> expected &&
>  	echo "* | $A2" >> expected &&
>  	echo "|/  " >> expected &&
> -	echo "* $A1" >> expected &&
> +	echo "o $A1" >> expected &&
>  	git rev-list --graph --all > actual &&
>  	test_cmp expected actual
>  	'
> @@ -111,7 +111,7 @@ test_expect_success '--graph --simplify-by-decora=
tion' '
>  	echo "|/|   " >> expected &&
>  	echo "* | $A2" >> expected &&
>  	echo "|/  " >> expected &&
> -	echo "* $A1" >> expected &&
> +	echo "o $A1" >> expected &&
>  	git rev-list --graph --all --simplify-by-decoration > actual &&
>  	test_cmp expected actual
>  	'
> @@ -139,7 +139,7 @@ test_expect_success '--graph --simplify-by-decora=
tion prune branch B' '
>  	echo "* | $A3" >> expected &&
>  	echo "|/  " >> expected &&
>  	echo "* $A2" >> expected &&
> -	echo "* $A1" >> expected &&
> +	echo "o $A1" >> expected &&
>  	git rev-list --graph --simplify-by-decoration --all > actual &&
>  	test_cmp expected actual
>  	'
> @@ -156,7 +156,7 @@ test_expect_success '--graph --full-history -- ba=
r.txt' '
>  	echo "| |/  " >> expected &&
>  	echo "* | $A3" >> expected &&
>  	echo "|/  " >> expected &&
> -	echo "* $A2" >> expected &&
> +	echo "o $A2" >> expected &&
>  	git rev-list --graph --full-history --all -- bar.txt > actual &&
>  	test_cmp expected actual
>  	'
> @@ -170,7 +170,7 @@ test_expect_success '--graph --full-history --sim=
plify-merges -- bar.txt' '
>  	echo "* | $A5" >> expected &&
>  	echo "* | $A3" >> expected &&
>  	echo "|/  " >> expected &&
> -	echo "* $A2" >> expected &&
> +	echo "o $A2" >> expected &&
>  	git rev-list --graph --full-history --simplify-merges --all \
>  		-- bar.txt > actual &&
>  	test_cmp expected actual
> @@ -183,7 +183,7 @@ test_expect_success '--graph -- bar.txt' '
>  	echo "* $A3" >> expected &&
>  	echo "| * $C4" >> expected &&
>  	echo "|/  " >> expected &&
> -	echo "* $A2" >> expected &&
> +	echo "o $A2" >> expected &&
>  	git rev-list --graph --all -- bar.txt > actual &&
>  	test_cmp expected actual
>  	'
> @@ -201,7 +201,7 @@ test_expect_success '--graph --sparse -- bar.txt'=
 '
>  	echo "| * $C1" >> expected &&
>  	echo "|/  " >> expected &&
>  	echo "* $A2" >> expected &&
> -	echo "* $A1" >> expected &&
> +	echo "o $A1" >> expected &&
>  	git rev-list --graph --sparse --all -- bar.txt > actual &&
>  	test_cmp expected actual
>  	'
> --=20
> 2.1.1
>

--=20
Pour marcher au pas d'une musique militaire, il n'y a pas besoin de
cerveau, une moelle =C3=A9pini=C3=A8re suffit.
                        - Albert Enstein
