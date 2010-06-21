From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Mon, 21 Jun 2010 12:19:02 +0200
Message-ID: <201006211219.02911.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006210106.07758.johan@herland.net>
 <7vk4pttfo3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 12:19:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQe5z-0006by-Ep
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 12:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab0FUKTK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 06:19:10 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40804 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932068Ab0FUKTI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 06:19:08 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4D005KJ0NR6YC0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 21 Jun 2010 12:19:03 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8BA531EEEFAF_C1F3C97B	for <git@vger.kernel.org>; Mon,
 21 Jun 2010 10:19:03 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3F61F1EECD79_C1F3C97F	for <git@vger.kernel.org>; Mon,
 21 Jun 2010 10:19:03 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4D00JK20NR4B20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 21 Jun 2010 12:19:03 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <7vk4pttfo3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149416>

On Monday 21 June 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> >> For an "automated" heuristics based on "find common descendants" t=
o
> >> make sense, the branches you are merging have to share the common
> >> purpose, and you need to limit the common descendants you find to =
the
> >> ones that are compatible with the shared purpose.  The purpose of
> >> 'maintenance track' may be to maintain the previous version withou=
t
> >> dragging newer and more exciting things that happened in the later
> >> development.  In the above picture, G (that has nothing but B and =
=46)
> >> is the only commit that can be safely assumed that two commits in =
the
> >> superproject space that bind B and F respectively can use as the
> >> submodule as their merge result.  E and I are contaminated with D =
and
> >> H whose purpose in the superproject space is unknown without furth=
er
> >> hint.
> >=20
> > Yes, from a 'maint'-perspective, using G in the superproject probab=
ly
> > makes more sense than using E or I. From a different superproject
> > perspective, though, using E or I might make more sense.
>=20
> Actually, what I was alluding to was that 'G' would be the _only_ com=
mit
> that may make sense (note that G may not necessarily make sense, but =
the
> point is that we can say that others do _not_ make sense as alternati=
ves)
> if we know that the context of making the superproject merge is that =
it
> is doing the 'maintenance track' merge.  Similarly, if we know that t=
he
> merge being done in the superproject is in the 'master' context, 'E'
> would be the _only_ plausible candidate, similarly for 'I' in 'next'
> context.

Ah, so Git should automatically _eliminate_ other alternatives based on=
 the=20
fact that they are not compatible with the purpose of the superproject=20
merge. Still, that requires Git to know the purpose of the superproject=
=20
merge. Which it doesn't, AFAICS.

> It is further plausible to imagine that the .gitmodules file tracked =
in
> the superproject's 'maint' branch can be used to express that 'maint'
> branch of the submodule should be used.

Ok, so you want to create some kind of relationship between the=20
superproject's 'maint' branch and the submodule's 'maint' branch. At th=
is=20
point we're almost back to the (magic IMHO) "stable" branch setting tha=
t=20
Heiko alluded to in his initial patch series. Except, possibly, that in=
stead=20
of using the tip of that branch you'd use the first merge of B and F on=
 that=20
branch.

I still don't like this, as IMHO it's too subtle, and possibly conflict=
s=20
with explicitly tracking submodule branches (which, to me, is a more=20
important feature).


Or are you talking about outright tracking submodule branches (as propo=
sed=20
by =C6var in a different thread)? In that case, the issue changes compl=
etely:

If you're explicitly tracking the 'maint' branch in the submodule, then=
 IMHO=20
Git should always propose the tip of the submodule's 'maint' branch as =
the=20
merge resolution in the superproject (possibly with a warning printed i=
f=20
that tip does not descend from both B and F).

> If we revisit the Alice and Bob example with such an arrangement, if =
they
> were working on their branches so that their results would be include=
d in
> the 'maint' track of the superproject, there won't be a merge conflic=
t in
> the .gitmodules file at the superproject level when their branch tips=
 are
> merged; we will know that the merged .gitmodules file will tell us th=
at
> we would want to follow 'maint' branch of the submodule.
>
> Similarly if Alice were fixing a bug in 'maint' but Bob were advancin=
g
> features in 'master', then merging .gitmodules at the superproject le=
vel
> will fast-forward at the path level (i.e. Alice didn't touch, but Bob
> changed, so we take Bob's change), instructing us to follow 'master'
> branch from the submodule automatically.

Ok, so these are similar to =C6var's proposal (and its subsequent discu=
ssion)=20
for explicitly tracking submodule branches. Still not sure if we're act=
ually=20
talking about the same thing, though.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
