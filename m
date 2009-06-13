From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Sat, 13 Jun 2009 09:50:47 +0200
Message-ID: <200906130950.47832.chriscool@tuxfamily.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org> <7vskidcf9s.fsf@alter.siamese.dyndns.org> <200906070932.36913.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 09:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFO13-0001c3-Kc
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 09:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbZFMHup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2009 03:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbZFMHuo
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 03:50:44 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:59033 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbZFMHun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 03:50:43 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id B00A84C801D;
	Sat, 13 Jun 2009 09:50:37 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id AFF0B4C8095;
	Sat, 13 Jun 2009 09:50:34 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200906070932.36913.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121484>

Le Sunday 07 June 2009, Christian Couder a =E9crit :
> Le Saturday 06 June 2009, Junio C Hamano a =E9crit :
> > Here is a fairly unscientific test to see how these three patches
> > improve things.  It involves two test scripts:
> >
> >  - ./+runme is a "bisect run" script.  It says "tests OK" for all t=
he
> >    commits given, except that it says "untestable" for all commits =
that
> >    are on the side branch of a merge that we first test.  I think t=
his
> >    reflects what happens in the real world setting very well, in th=
at a
> >    merge brings in a topic whose breakge is irrelevant to the bug w=
e
> > are hunting.
> >
> >  - ./+runall is run in one git tree with two parameters (bad commit=
 and
> >    good commit); it assumes that
> >
> >    - ./+runme script above is in /var/tmp/+runme;
> >
> >    - a version of git without these three patches is installed with
> >      prefix=3D/var/tmp/cc-original;
> >
> >    - a version of git with these three patches is installed with
> >      prefix=3D/var/tmp/cc-updated;
> >
> >    and runs the bisection using both versions of git.
> >
> > The results are not that great; these three patches do not give cle=
ar
> > win as we hoped:
> >
> >     $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc8 v2.6.30-rc1
> >     Total 2681 commits...
> >     Marked 254 commits as untestable
> >     Took 14 rounds with cc-updated
> >     Marked 254 commits as untestable
> >     Took 13 rounds with cc-original
> >     $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc8 v2.6.29
> >     Total 12917 commits...
> >     Marked 141 commits as untestable
> >     Took 15 rounds with cc-updated
> >     Marked 141 commits as untestable
> >     Took 15 rounds with cc-original
> >     $ linux-2.6/master; /var/tmp/+runall v2.6.30-rc1 v2.6.29
> >     Total 10236 commits...
> >     Marked 7749 commits as untestable
> >     Took 15 rounds with cc-updated
> >     Marked 7749 commits as untestable
> >     Took 14 rounds with cc-original
> >
> > I think this shows that the "skip ratio" heuristics based on the
> > distance in the "goodness scale" space does not help in avoiding
> > commits that are close in topological space.  There may be cases wh=
ere
> > the version with patch gives fewer rounds especially when the histo=
ry
> > is very linear, but I was mostly interested in the number of commit=
s at
> > least in the thousands, which I think is what we should optimize th=
ings
> > for, not a toy history of linear 100 commits.
>
> I get the same results as yours, and I think that in these tests case=
s
> "git bisect" was not stuck with having only untestable commits with t=
he
> highest "goodness" values. So in these cases the original behavior do=
es
> quite well and that's why the updated behavior can't do better.
>
> > Here are the test scripts you can use to reproduce the results.
> >
> > diff --git a/+runall b/+runall
> > new file mode 100755
> > index 0000000..291d000
> > --- /dev/null
> > +++ b/+runall
> > @@ -0,0 +1,23 @@
> > +#!/bin/sh
> > +
> > +BAD=3D${1?BAD}
> > +GOOD=3D${2?GOOD}
> > +TOTAL=3D$(git rev-list $GOOD..$BAD | wc -l)
> > +
> > +echo Total $TOTAL commits...
> > +
> > +for git in cc-updated cc-original
> > +do
> > +	logfile=3D/var/tmp/log-$git-$BAD-$GOOD
> > +	(
> > +		PATH=3D/var/tmp/$git/bin:$PATH
> > +		export PATH
> > +		rm -f .git/UNTESTABLE
> > +		git bisect reset
> > +		git bisect start $BAD $GOOD
> > +		git bisect run /var/tmp/+runme
> > +		git bisect reset
> > +	) >$logfile 2>&1
> > +	grep "^Marked " $logfile
> > +	echo Took $(grep -c "Bisecting:" $logfile) rounds with $git
> > +done
> > diff --git a/+runme b/+runme
> > new file mode 100755
> > index 0000000..7b77338
> > --- /dev/null
> > +++ b/+runme
> > @@ -0,0 +1,23 @@
> > +#!/bin/sh
> > +
> > +# Pretend that the first merged branch were untestable
> > +
> > +THIS=3D$(git rev-parse HEAD)
> > +
> > +if ! test -f .git/UNTESTABLE
> > +then
> > +	if MERGED=3D$(git rev-parse HEAD^2 2>/dev/null)
> > +	then
> > +		git rev-list HEAD^ ^$MERGED >.git/UNTESTABLE
> > +		echo Marked $(wc -l <.git/UNTESTABLE) commits as untestable
> > +		exit 125
> > +	else
> > +		exit 0
> > +	fi
> > +fi
> > +
> > +if grep "$THIS" .git/UNTESTABLE >/dev/null
> > +then
> > +	exit 125
> > +fi
> > +exit 0
>
> Thanks.
>
> I renamed your +runme to +runme-good and created a +runme-bad script =
with
> the following changes:
>
> $ diff -u +runme-good +runme-bad
> --- +runme-good 2009-06-07 03:53:08.000000000 +0200
> +++ +runme-bad  2009-06-07 08:11:33.000000000 +0200
> @@ -12,7 +12,7 @@
>                 echo Marked $(wc -l <.git/UNTESTABLE) commits as
> untestable exit 125
>         else
> -               exit 0
> +               exit 1
>         fi
>  fi
>
> @@ -20,4 +20,4 @@
>  then
>         exit 125
>  fi
> -exit 0
> +exit 1
>
> So that the +runme-bad says "tests KO" (instead of "tests OK" for
> +runme-good) for all the commits given, except that it says "untestab=
le"
> for all commits that are on the side branch of a merge that we first
> test.
>
> Then I created the "+runme -> +runme-bad" symlink and tried your
> examples:
>
> $ /var/tmp/+runall v2.6.30-rc8 v2.6.30-rc1
> Total 2681 commits...
> Marked 254 commits as untestable
> Took 11 rounds with cc-updated
> Marked 254 commits as untestable
> Took 12 rounds with cc-original
>
> $ /var/tmp/+runall v2.6.30-rc8 v2.6.29
> Total 12917 commits...
> Marked 141 commits as untestable
> Took 15 rounds with cc-updated
> Marked 141 commits as untestable
> Took 15 rounds with cc-original
>
> $ /var/tmp/+runall v2.6.30-rc1 v2.6.29
> Total 10236 commits...
> Marked 1777 commits as untestable
> Took 9 rounds with cc-updated
> Marked 1777 commits as untestable
> Took 492 rounds with cc-original
>
> The last one is very interesting. It seems that the original
> implementation got stuck while the updated one did a great job...

With the patch I just posted that use a PRNG with a bias, I get the=20
following results.

With the "+runme -> +runme-good" symlink:

$ /var/tmp/+runall v2.6.30-rc8 v2.6.30-rc1
Total 2681 commits...
Marked 254 commits as untestable
Took 13 rounds with cc-updated
Marked 254 commits as untestable
Took 13 rounds with cc-original

$ /var/tmp/+runall v2.6.30-rc8 v2.6.29
Total 12917 commits...
Marked 141 commits as untestable
Took 15 rounds with cc-updated
Marked 141 commits as untestable
Took 15 rounds with cc-original

$ /var/tmp/+runall v2.6.30-rc1 v2.6.29
Total 10236 commits...
Marked 7749 commits as untestable
Took 14 rounds with cc-updated
Marked 7749 commits as untestable
Took 14 rounds with cc-original

And with the "+runme -> +runme-bad" symlink:

$ /var/tmp/+runall v2.6.30-rc8 v2.6.30-rc1
Total 2681 commits...
Marked 254 commits as untestable
Took 13 rounds with cc-updated
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
Took 12 rounds with cc-updated
Marked 1777 commits as untestable
Took 492 rounds with cc-original

So there the results are quite similar to my alternating between 3 rati=
os=20
algorithm.

Best regards,
Christian.
