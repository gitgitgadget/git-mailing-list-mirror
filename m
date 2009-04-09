From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Add "list" and "rm" sub commands to tg-depend
Date: Thu, 9 Apr 2009 22:15:15 +0200
Message-ID: <20090409201515.GA4218@pengutronix.de>
References: <20090407133329.57b06727.weiny2@llnl.gov> <20090408080824.GF8940@machine.or.cz> <20090408083955.GA28482@pengutronix.de> <20090408091949.8a648d83.weiny2@llnl.gov> <20090409124337.GA6034@pengutronix.de> <20090409091021.5a7ded79.weiny2@llnl.gov> <36ca99e90904091101l6dd1685y5be70dd77bf52b57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ira Weiny <weiny2@llnl.gov>,
	Brian Behlendorf <behlendorf1@llnl.gov>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 22:17:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls0gN-0006WO-Lg
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 22:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935371AbZDIUPV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 16:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934122AbZDIUPV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 16:15:21 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33796 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761029AbZDIUPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 16:15:20 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Ls0ea-0001U7-MH; Thu, 09 Apr 2009 22:15:16 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Ls0eZ-0004bI-N2; Thu, 09 Apr 2009 22:15:15 +0200
Content-Disposition: inline
In-Reply-To: <36ca99e90904091101l6dd1685y5be70dd77bf52b57@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116205>

Hello,

On Thu, Apr 09, 2009 at 08:01:04PM +0200, Bert Wesarg wrote:
> 2009/4/9 Ira Weiny <weiny2@llnl.gov>:
> > On Thu, 9 Apr 2009 14:43:37 +0200
> > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> >> You might want to check
> >>
> >> =A0 =A0 =A0 http:// thread.gmane.org/gmane.comp.version-control.gi=
t/114581
> >
> > Ah this brings up more issues I had not thought about... =A0:-( =A0=
But perhaps
> > Bert's work could be used to help implement "rm". =A0Thoughts?
> No, it wont help. Because the base and tip of the topic should not
> changed in respect to the old state (expect for .topdeps of course).
>=20
> If you really want to remove a dependency, you need to revert a merge
> of this dep from the topic base. which is not possible today, or mayb=
e
> I have just an idea for this:
>=20
>   'topic': the topic
>   'base':  the base of the topic, i.e. a merge from all dependent
> topics dep0, ..., depN
>=20
> say you want to remove dep0
>=20
>   1) merge all deps dep1, ..,depN into 'new-base'
>=20
>   2) merge 'new-base' into base with the merge driver 'theirs', that
> would overwrite all changes from dep0 in the 'base'
>=20
>   3) update 'topic' to the updated 'base'
>=20
> Any thoughts from someone who knows more than me?
Some time ago I thought about a similar issue:

I based a branch on top of the Linux tree of the ARM maintainer (in the
following called "rmk") and decided later to base it on top of Linus'
tree.  So I did ~:

	git checkout refs/top-bases/$branch
	git merge -s theirs linus/master
	git checkout $branch
	sed -i s,rmk,linus, .topdeps
	git add -f .topdeps
	git commit -m $commitmsg
	tg update

When I thought about it with pencil and paper back then, I saw a proble=
m
with that approach.  Now I invested some time now to verify it really
exists:  In fact I reverted the changes in the rmk/master branch.
Consider Linus pulls from rmk and I update my topgit branch.  Guess wha=
t
happens?  Linus' pull + my revert yield Linus' tree without rmk's
changes.

Here is my recipe:

	# prepare linus/master
	git init
	echo 'VERSION=3D2.6.28' > Makefile
	git add Makefile; git commit -m 'v2.6.28'
	git branch -m master linus/master

	# prepare rmk/master
	git checkout -b rmk/master
	echo 'support for some machine' > arm.c
	git add arm.c; git commit -m 'support for some machine'

	# new topgit branch
	tg create t/test
	echo change > lib.c
	git add lib.c; git commit -m 'tralala'

	# Linus goes on ...
	git checkout linus/master
	echo 'VERSION=3D2.6.29-rc1' > Makefile
	git add Makefile; git commit -m 'v2.6.29-rc1'

	# "rebase" test branch on linus/master
	git checkout refs/top-bases/t/test
	git symbolic-ref HEAD refs/top-bases/t/test
	git merge --no-commit linus/master
	git read-tree linus/master
	git commit
	rm arm.c
	git checkout t/test
	sed -i s/rmk/linus/ .topdeps
	git add .topdeps; git commit -m 'change dep: rmk/master -> linus/maste=
r'
	tg update

	# Linus pulls from rmk
	git checkout linus/master
	git merge rmk/master

	# update test to linus+rmk
	git checkout t/test
	tg update

	# inspect:
	git diff linus/master refs/top-bases/t/test

The last command shows that refs/top-bases/t/test doesn't have arm.c
:-/

I'm sure the dependency deletion has exactly the same problem.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
