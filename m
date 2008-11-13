From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/9 v4] bisect: add "git bisect replace" subcommand
Date: Thu, 13 Nov 2008 18:50:40 +0100
Message-ID: <200811131850.40951.chriscool@tuxfamily.org>
References: <20081111063904.7da4df94.chriscool@tuxfamily.org> <200811121515.48277.chriscool@tuxfamily.org> <7v63mshsb7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 18:50:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0gKj-0002w0-Pq
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 18:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbYKMRs5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 12:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbYKMRs5
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 12:48:57 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:43457 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173AbYKMRsy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 12:48:54 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id E9EBA3EA6A8;
	Thu, 13 Nov 2008 18:48:48 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with ESMTP id AB7723EA6C1;
	Thu, 13 Nov 2008 18:48:36 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v63mshsb7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100892>

Le jeudi 13 novembre 2008, Junio C Hamano a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Le mercredi 12 novembre 2008, Junio C Hamano a =C3=A9crit :
> > ...
> >
> >> When you want to hunt for a bug, it is certainly possible that you=
r
> >> tests fail for a bug that is unrelated to what you are hunting for=
 for
> >> a range of commits.  Borrowing from your picture:
> >>
> >>     ...--O--A--X1--X2--...--Xn--B--...
> >>
> >> non of the commit marked as Xi may not be testable.
> >>
> >> But at that point, will you really spend time to rebuild history
> >> between A and B by fixing an unrelated bug that hinders your bisec=
t,
> >> so that you can have a parallel history that is bisectable?  I dou=
bt
> >> anybody would.
> >
> > I think kernel developers and perhaps others do that somehow. I mea=
n,
> > there is the following text in the git-bisect(1) documentation:
> >
> > "
> > You may often find that during bisect you want to have near-constan=
t
> > tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, =
or
> > "revision that does not have this commit needs this patch applied t=
o
> > work around other problem this bisection is not interested in") app=
lied
> > to the revision being tested.
> >
> > To cope with such a situation, after the inner git-bisect finds the
> > next revision to test, with the "run" script, you can apply that tw=
eak
> > before compiling,...
> > "
> >
> > So we suggest that people patch at bisect time in case of problems.=
 But
> > I think creating a parallel branch should be better in the long run=
,
> > because you can easily keep the work you did to make things easier =
to
> > bisect and you can easily share it with other people working with y=
ou.
>
> I strongly disagree.
>
> Maybe you hit X2 which does have a breakage, and you would need to pa=
tch
> up that one before being able to test for your bug, but after you say
> good or bad on that one, the next pick will be far away from that Xi
> segment. You will test many more revisions before you come back to X3=
 or
> X5.  Why should we force the users to fix all the commits in the segm=
ent
> "just in case" somebody's bisect falls into the range before that
> actually happens?

The users would not be _forced_ at all to use "git bisect replace", the=
y can=20
ignore it if they want. And even if other coworkers use it, they are no=
t=20
forced at all to use it themself. If they get none of=20
the "bisect-replace-*" branches, the behavior of git bisect will not ch=
ange=20
at all.

> In other words, unless the breakage you are hunting for exists betwee=
n
> point A and B that you cannot bisect for that other breakage, you won=
't
> need to patch-up _every single revision_ in the range for the breakag=
e.
> Doing so beforehand is wasteful.

I think that it depends on many factors. More precisely, it depends on =
how=20
easy it is to fully test (because to make sure that the bug your are=20
bisecting is between A and B you need to test A and B, so you waste som=
e=20
testing) vs how easy it is to patch up every single revision between A =
and=20
B.

And I think it can be really easy to patch up every revision between A =
and=20
B, you might need only something like:

$ git checkout -b patch-up B
$ git rebase -i A^

and then squash the last commit into the first one, in the list "git=20
rebase -i" gives you. It may even be easy to automate this with code li=
ke=20
this (completely untested, and it assumes git rebase -i accept a script=
=20
from stdin which may not work right now):

create_replace_branch() {
	_a=3D"$1"
	_b=3D"$2"
	git checkout -b bisect-replace-$_b "$_b" || exit
	git rev-list ^"$_a"^ "$_b" | {
		while read sha1
		do
			case $sha1 in
				$_a) echo "pick $_a"; echo "squash $_b" ;;
				$_b) ;;
				*) echo "pick $sha1 ;;
			esac
		done
	} | git rebase -i "$_a"^
}

> And if you know the range of A..B and the fix, the procedure to follo=
w
> the suggestion you quoted above from the doc can even be automated
> relatively easily.  Your "run" script would need to do two merge-base=
 to
> see if the version to be tested falls inside the range, and if so app=
ly
> the known fix before testing (and clean it up afterwards).
>
> Come to think of it, you do not even need to have a custom run script=
=2E
> How about an approach illustrated by this patch?

This is interesting, but the fix up patch might not apply cleanly on al=
l the=20
commits in the range, and there is no simple way to share these patches=
=20
(and changes to them) in a team. Perhaps more importantly, there is als=
o no=20
simple way to look at the result from applying the patch or to manipula=
te=20
it with other git commands.

I mean it was decided to store changes in Git as blob, trees and commit=
s,=20
not patches, so why would we store these changes as patches?

Regards,
Christian.
