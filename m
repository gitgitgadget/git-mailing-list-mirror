From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: top-git, idea .topbase replacing refs/top-bases,
	implementation issues and questions..
Date: Tue, 21 Apr 2009 11:04:13 +0200
Message-ID: <20090421090413.GA5718@pengutronix.de>
References: <20090420205023.GB2005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 11:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwBvR-0005na-Ar
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903AbZDUJER convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 05:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbZDUJEQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:04:16 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52574 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbZDUJEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 05:04:15 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LwBtm-0001iS-8A; Tue, 21 Apr 2009 11:04:14 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LwBtl-00025F-Fe; Tue, 21 Apr 2009 11:04:13 +0200
Content-Disposition: inline
In-Reply-To: <20090420205023.GB2005@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117111>

Hi Marc,

I supplement and correct your description a bit, not to be pedantic but
to give the other readers a better overview.

On Mon, Apr 20, 2009 at 10:50:23PM +0200, Marc Weber wrote:
> introduction:
>=20
> topgit (tg) is a tool keeping track of patches on top of branches so =
that you
> can work on those patches before comitting them upstream.
And IMHO more importantly you can update your branches after feedback
from upstream without rebasing.

> So you can do
>   tg create dep1 dep2
This should read
	tg create TG_NAME dep1 dep2

> to make your new topic branch depend on the two branches dep1, dep2.
>=20
> tg first merges dep1 dep2 into a base. On top of this base you start
> comitting your changes. when following upstream a new base is created=
 by
> merging the old base with dep1, then dep2 again. The new base is merg=
ed
> into your topic branch.
The patch represented by TG_NAME is always the diff between the base an=
d
the topic branch.
=20
> This requires keeping track of the base. That has been done by adding=
 an
> extra references to .git/refs/top-bases/TG_NAME.
> problems: You have to push the branch and the base to the remote
> location. If you clone a top git related branch you have to get the
> bases as well (tg remote --populate does this for you).
tg remote adds some config to your repo such that a later git fetch get=
s
the top-bases, too.

> Uwe Kleine-K=F6nig (current maintainer?
yes

>                                      ) has proposed no longer trackin=
g
> the topgit branch base using a ref but adding antoher .top* file .top=
base
> containing the hash of the base.
I think for now using both is a good start.  There are too many places
in topgit that depend on the topbase branch.

>                                  Neither pushing nor pulling causes
> trouble because the base is always contained in the topic branch. So =
no
> need to extra push/ pull contents of that branch. Another benefit of
> this change is that you can easily make a top git branch out of an
> ordinary branch by adding those 3 files (.topbase, .topmsg, .topdeps)=
=2E
hhm, not adding .topbase but another (git) branch isn't much harder, is
it?
=20
> I don't see any problems implementing this except one. I'm not sure i=
n
> which way this has been adressed in the past by topgit:
>=20
>=20
> Have a look at the following illustration:
> http://mawercer.de/~marc/tg.svg (32kb).
Either I don't interpret your image correctly or it's not exact.
B1 is a base?  Where is the corresponding topic-branch that both cloner=
s
should have in common?  Further it's not clear to me if merge1 and
merge2 are bases or topic branches.

Let me try an ascii-history with slightly different names ...

> Imagine two independant clones of a topgit branch (red, green).
This is the state cloned by red and green:

	                            T.origin
	                           /
	dep1.1 --- dep1.2--B.origin
	                  /
	dep2.1 --- dep2.2-

where B.something is a topbase, T.thesamesomething is the corresponding
topic branch.

> Now users run tg update at slightly different points in time. So both
> will get a different new base (B2 and B3) of the clone topgit branch.
Then it looks as follows (simplified to only a single dependency dep1
and assuming they get different commits of dep1, not only different
times, as suggested by your image).

	                      ,------------------------T.green
	                     /                          /
	             ,-------------------------------B.green
	            /      /                        /
	           /   T.origin----T.red           /
	          /   /           /               /
	        B.origin-------B.red             /
	      /               /                 /
	dep1.2----------dep1.3----------------dep1.4

so my B.red is your B2, my B.green is your B3.

> Now red merges the topic branch (merge 1).
The image suggests red merges green's work.

OK, I fail to make a picture for that, anyhow then we have:

	B.red2 =3D B.red + B.green
	T.red2 =3D T.red + T.green + B.red2

where + stands for a merge[1][2].

And obviously T.red2:.topbase has to contain $(git rev-parse B.red2)

>                                            Then a third user (blue)
> merges that merge (merge 2).
OK, blue having T.origin merges T.red2, then we get:

	B.blue =3D B.origin + B.red2
	T.blue =3D T.origin + T.red2 + B.blue

>                              If a merge strategy "ours" is used the w=
ay
> its done for the other .top* files the blue user's base won't know ab=
out
> B3.
"ours" is wrong for .topbase.  You have to merge to get the right
content.

> First merge we have a conflict:
>=20
> If B3 and B2 are different a merge conflict occurs:
> .topbase:
> <<<<
> hash1
> =3D=3D=3D=3D
> hash2
> >>>>
I think it's not helpful to thing about merge conflicts, you simply nee=
d
to handle .topbase explicitly.

> Now the two bases should be merged to a new base (Bnew).
> That new base should be written to .topbase and everything is fine
> again?
>=20
> Is there a way to specify such a merge action:
> extract both hashes (easy)
> merge them and put the resulting hash back into .topbase.
> Of course this merge action must handle merge conflicts in a way whic=
h
> is similar to what tg already does. tg starts a subshell and asking t=
he
> user to fix the conflicts.
Actually I don't like this subshelling.  git does it better, it saves
the state somewhere in .git and exits.  I'm sure that people who's shel=
l
is !=3D /bin/sh don't like that we spawn a sh.
=20
> Even if there is a nice way to implement this merge action this doesn=
't
> seem to solve all trouble?
I don't see any trouble, but maybe it's me who missed something.

> The Bnew base is neither part of the red nor the green topic branch.
> Thus it can't be pushed somewhere by pushing red or green only
> containing the ref in .topbase?
I fail to understand that.  only blue has Bnew, so of course neither re=
d
nor green can push it. ???

> So in the end:
> Have I missed a point ?
>=20
> So are there more  advantages having a self contained top git branch
> compared to beeing able to merge bases?
You can have both.

> Maybe merging bases doesn't occur that often in practise?
you need it whenever you merge a remote.  There is no way around it.

> So if we don't want to give up beeing able to merge bases I=20
> till want to see a git push branch command also pushing the base.
> Currently you can do $git push which will push *all* bases and branch=
es.
Alternatively you can push the branch+base explicitly to have more
control.  OK, not very comfortable, though you could wrap that in a tg
push command.

Best regards
Uwe

[1] I have not thought deeply about which is the best of the various
possibilies to update T when merging, here are some of them:

	1) T.mynew =3D (T.myold + T.tomerge) + B.mynew
	2) T.mynew =3D T.myold + (T.tomerge + B.mynew)
	3) T.mynew =3D (T.myold + B.mynew) + T.tomerge
	4) T.mynew =3D T.myold + (B.mynew + T.tomerge)
	5) T.mynew =3D T.myold + T.tomerge

5) is out because then T.mynew doesn't contain B.mynew, but it only
misses a single merge, namely B.myold + B.tomerge.  Both bases as such
are already included in T.myold + T.tomerge.  So this is only a "would
be nice".
Ad hoc I'd choose 3) but this needs some more thinking.
Just from reading the code, I'd say topgit currently does 4)

[2] and note, that + has to behave differently in different situations
for the .top* files.  The following merges can happen

	a) merge a base into a topic
	b) merge two bases
	c) merge two topics

and depending on this the following low-level merge drivers should be
used for .topmsg and .topdeps:

	a): ours
	b): don't care (delete?)
	c): text

It would be nice if the topbases didn't contain any .top* files, this
only has some overhead if a patch has single (tgish) dependency because
then you cannot just use this branch as base.

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
