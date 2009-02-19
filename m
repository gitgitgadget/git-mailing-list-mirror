From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Thu, 19 Feb 2009 06:16:18 +0100
Message-ID: <200902190616.18747.chriscool@tuxfamily.org>
References: <20090217060944.488184b0.chriscool@tuxfamily.org> <7vljs58qul.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 06:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La1Iu-0005qW-2c
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 06:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbZBSFRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 00:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZBSFRE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 00:17:04 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:36823 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbZBSFRB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 00:17:01 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id C4D7A4C802B;
	Thu, 19 Feb 2009 06:16:53 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id C397B4C80B9;
	Thu, 19 Feb 2009 06:16:50 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vljs58qul.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110627>

Le mardi 17 f=E9vrier 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > +static int estimate_bisect_steps(int all)
> > +{
> > +	int log2 =3D 0;
> > +	int left =3D (all >> 1) - 1;
> > +
> > +	if (left <=3D 0)
> > +		return 0;
> > +
> > +	do {
> > +		left =3D left >> 1;
> > +		log2++;
> > +	} while (left);
> > +
> > +	return log2;
> > +}
> > ...
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index 85db4ba..6b23439 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -500,7 +500,7 @@ bisect_next() {
> >  	# commit is also a "skip" commit (see above).
> >  	exit_if_skipped_commits "$bisect_rev"
> >
> > -	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test
> > after this" +	bisect_checkout "$bisect_rev" "$bisect_nr revisions l=
eft
> > to test after this (roughtly $bisect_steps steps)"
>
> "roughly".

Yes, thanks.

> all	left
> 0	0
> 1	0
> 2	0
> 3	0
> 4	1
> 5	1
> 6	2
> 7	2
> 8	2
> 9	2
>
> It seems that at the very low end the estimate is a bit too optimisti=
c.
> How about showing this number from the Porcelain only when $bisect_st=
eps
> is more than 2 (or all is more than 9)?

I think it's more consistent to always show it.

Now for the algorithm, first please note that we are looking for an est=
imate=20
of the number of bisect steps left _after the current one_, and that gi=
t=20
bisect currently only displays an estimate of the number of revisions l=
eft=20
to test _after the current one_.

Here is a table to help analyse what should be the best estimate for
the number of bisect steps left.

N : linear case                    --> probabilities --> best | v1
------------------------------------------------------------------
1 : G-B                            --> 0             --> 0    | 0
2 : G-U1-B                         --> 0             --> 0    | 0
3 : G-U1-U2-B                      --> 0(1/3) 1(2/3) --> 1    | 0
4 : G-U1-U2-U3-B                   --> 1             --> 1    | 1
5 : G-U1-U2-U3-U4-B                --> 1(3/5) 2(2/5) --> 1    | 1
6 : G-U1-U2-U3-U4-U5-B             --> 1(2/6) 2(4/6) --> 2    | 2
7 : G-U1-U2-U3-U4-U5-U6-B          --> 1(1/7) 2(6/7) --> 2    | 2
8 : G-U1-U2-U3-U4-U5-U6-U7-B       --> 2             --> 2    | 2
9 : G-U1-U2-U3-U4-U5-U6-U7-U8-B    --> 2(7/9) 3(2/9) --> 2    | 2
10: G-U1-U2-U3-U4-U5-U6-U7-U8-U9-B --> 2(6/10)3(4/10)--> 2    | 3

In the column "N", there is the number of revisions that could _now_
be the first bad commit we are looking for.

The "linear case" column describes the linear history corresponding to
the number in column N. G means good, B means bad, and Ux means
unknown. Note that the first bad revision we are looking for can be
any Ux or B.

In the "probabilities" column, there are the different outcomes in
number of steps with the odds of each outcome in parenthesis
corresponding to the linear case.

The "best" column gives the most accurate estimate among the different
outcomes in the "probabilities" column.

The "v1" column gives the estimates according my first patch.

Now looking at the table, we have the following:

best(2^n) =3D=3D n - 1

and for any x between 0 included and 2^n excluded, the probability for
n - 1 steps left looks like:

P(2^n + x) =3D=3D (2^n - x) / (2^n + x)=20

If P(2^n + x) < 0.5 we should return n and otherwise n - 1.

But P(2^n + x) < 0.5 means:

2 * (2^n - x) < (2^n + x)

that is: 2^n < 3x

So the improved algorithm could be something like:

static int estimate_bisect_steps(int all)
{
	int n, x, e;
	float p;

	if (all < 3)
		return 0;

	n =3D log2(all);
	e =3D exp2(n);
	x =3D all - e;

	return (e < 3 * x) ? n : n - 1 ;
}

But on Linux, log2 and exp2 are defined in "math.h" and available with:

_XOPEN_SOURCE >=3D 600 || _ISOC99_SOURCE; or cc -std=3Dc99

and we must link with -lm, but I don't know about the other platforms.

So I don't know what to do about them. Please advise.

Thanks in advance,
Christian.
