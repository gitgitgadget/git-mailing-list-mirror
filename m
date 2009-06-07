From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Sun, 7 Jun 2009 09:32:36 +0200
Message-ID: <200906070932.36913.chriscool@tuxfamily.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org> <7vskidcf9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 09:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDCsA-00040P-Tb
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 09:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbZFGHck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 03:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbZFGHcj
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 03:32:39 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:48718 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbZFGHci convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 03:32:38 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BB6D58180A3;
	Sun,  7 Jun 2009 09:32:31 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 666A78180E6;
	Sun,  7 Jun 2009 09:32:28 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vskidcf9s.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120956>

Le Saturday 06 June 2009, Junio C Hamano a =E9crit :
> Here is a fairly unscientific test to see how these three patches imp=
rove
> things.  It involves two test scripts:
>
>  - ./+runme is a "bisect run" script.  It says "tests OK" for all the
>    commits given, except that it says "untestable" for all commits th=
at
>    are on the side branch of a merge that we first test.  I think thi=
s
>    reflects what happens in the real world setting very well, in that=
 a
>    merge brings in a topic whose breakge is irrelevant to the bug we =
are
>    hunting.
>
>  - ./+runall is run in one git tree with two parameters (bad commit a=
nd
>    good commit); it assumes that
>
>    - ./+runme script above is in /var/tmp/+runme;
>
>    - a version of git without these three patches is installed with
>      prefix=3D/var/tmp/cc-original;
>
>    - a version of git with these three patches is installed with
>      prefix=3D/var/tmp/cc-updated;
>
>    and runs the bisection using both versions of git.
>
> The results are not that great; these three patches do not give clear=
 win
> as we hoped:
>
>     $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc8 v2.6.30-rc1
>     Total 2681 commits...
>     Marked 254 commits as untestable
>     Took 14 rounds with cc-updated
>     Marked 254 commits as untestable
>     Took 13 rounds with cc-original
>     $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc8 v2.6.29
>     Total 12917 commits...
>     Marked 141 commits as untestable
>     Took 15 rounds with cc-updated
>     Marked 141 commits as untestable
>     Took 15 rounds with cc-original
>     $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc1 v2.6.29
>     Total 10236 commits...
>     Marked 7749 commits as untestable
>     Took 15 rounds with cc-updated
>     Marked 7749 commits as untestable
>     Took 14 rounds with cc-original
>
> I think this shows that the "skip ratio" heuristics based on the dist=
ance
> in the "goodness scale" space does not help in avoiding commits that =
are
> close in topological space.  There may be cases where the version wit=
h
> patch gives fewer rounds especially when the history is very linear, =
but
> I was mostly interested in the number of commits at least in the
> thousands, which I think is what we should optimize things for, not a=
 toy
> history of linear 100 commits.

I get the same results as yours, and I think that in these tests cases =
"git=20
bisect" was not stuck with having only untestable commits with the=20
highest "goodness" values. So in these cases the original behavior does=
=20
quite well and that's why the updated behavior can't do better.

> Here are the test scripts you can use to reproduce the results.
>
> diff --git a/+runall b/+runall
> new file mode 100755
> index 0000000..291d000
> --- /dev/null
> +++ b/+runall
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +BAD=3D${1?BAD}
> +GOOD=3D${2?GOOD}
> +TOTAL=3D$(git rev-list $GOOD..$BAD | wc -l)
> +
> +echo Total $TOTAL commits...
> +
> +for git in cc-updated cc-original
> +do
> +	logfile=3D/var/tmp/log-$git-$BAD-$GOOD
> +	(
> +		PATH=3D/var/tmp/$git/bin:$PATH
> +		export PATH
> +		rm -f .git/UNTESTABLE
> +		git bisect reset
> +		git bisect start $BAD $GOOD
> +		git bisect run /var/tmp/+runme
> +		git bisect reset
> +	) >$logfile 2>&1
> +	grep "^Marked " $logfile
> +	echo Took $(grep -c "Bisecting:" $logfile) rounds with $git
> +done
> diff --git a/+runme b/+runme
> new file mode 100755
> index 0000000..7b77338
> --- /dev/null
> +++ b/+runme
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +# Pretend that the first merged branch were untestable
> +
> +THIS=3D$(git rev-parse HEAD)
> +
> +if ! test -f .git/UNTESTABLE
> +then
> +	if MERGED=3D$(git rev-parse HEAD^2 2>/dev/null)
> +	then
> +		git rev-list HEAD^ ^$MERGED >.git/UNTESTABLE
> +		echo Marked $(wc -l <.git/UNTESTABLE) commits as untestable
> +		exit 125
> +	else
> +		exit 0
> +	fi
> +fi
> +
> +if grep "$THIS" .git/UNTESTABLE >/dev/null
> +then
> +	exit 125
> +fi
> +exit 0

Thanks.

I renamed your +runme to +runme-good and created a +runme-bad script wi=
th=20
the following changes:

$ diff -u +runme-good +runme-bad
--- +runme-good 2009-06-07 03:53:08.000000000 +0200
+++ +runme-bad  2009-06-07 08:11:33.000000000 +0200
@@ -12,7 +12,7 @@
                echo Marked $(wc -l <.git/UNTESTABLE) commits as untest=
able
                exit 125
        else
-               exit 0
+               exit 1
        fi
 fi

@@ -20,4 +20,4 @@
 then
        exit 125
 fi
-exit 0
+exit 1

So that the +runme-bad says "tests KO" (instead of "tests OK" for=20
+runme-good) for all the commits given, except that it says "untestable=
"=20
for all commits that are on the side branch of a merge that we first te=
st.

Then I created the "+runme -> +runme-bad" symlink and tried your exampl=
es:

$ /var/tmp/+runall v2.6.30-rc8 v2.6.30-rc1
Total 2681 commits...
Marked 254 commits as untestable
Took 11 rounds with cc-updated
Marked 254 commits as untestable
Took 12 rounds with cc-original

$ /var/tmp/+runall v2.6.30-rc8 v2.6.29
Total 12917 commits...
Marked 141 commits as untestable
Took 15 rounds with cc-updated
Marked 141 commits as untestable
Took 15 rounds with cc-original

$ /var/tmp/+runall v2.6.30-rc1 v2.6.29
Total 10236 commits...
Marked 1777 commits as untestable
Took 9 rounds with cc-updated
Marked 1777 commits as untestable
Took 492 rounds with cc-original

The last one is very interesting. It seems that the original implementa=
tion=20
got stuck while the updated one did a great job...

Best regards,
Christian.
