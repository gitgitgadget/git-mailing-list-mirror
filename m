From: Jeff King <peff@peff.net>
Subject: Re: How to fix =?utf-8?B?4oCcWW91ciBicmFu?=
 =?utf-8?Q?ch_and_'origin=2Fmaster'_have_diverged?= =?utf-8?B?4oCd?= after
 editing a commit that came before a pull?
Date: Mon, 22 Nov 2010 00:38:14 -0500
Message-ID: <20101122053814.GA7568@sigill.intra.peff.net>
References: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
 <20101120043628.GB20725@sigill.intra.peff.net>
 <AANLkTikCnX5aBrmh9+wnb9JyOiynv0zhrpdMJwbhL2ji@mail.gmail.com>
 <20101121163001.GA29216@sigill.intra.peff.net>
 <AANLkTim6h17cd6LjCt8e8HBHGCdyCjw1yx7PVUsD7piJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gavin Guo <tuffkidtt@gmail.com>, git@vger.kernel.org
To: Yang Zhang <yanghatespam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 06:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKP6i-0007Ww-AY
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 06:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877Ab0KVFiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 00:38:23 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59345 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab0KVFiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 00:38:22 -0500
Received: (qmail 14339 invoked by uid 111); 22 Nov 2010 05:38:21 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 22 Nov 2010 05:38:21 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Nov 2010 00:38:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim6h17cd6LjCt8e8HBHGCdyCjw1yx7PVUsD7piJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161881>

On Sun, Nov 21, 2010 at 10:51:51AM -0800, Yang Zhang wrote:

> >> > =C2=A0git rebase --onto temp F'^ branch_name
> >> [...]
> >> > At that point your original branch should be in the state you wa=
nt. You
> >> > can delete the temp branch with "git branch -D temp".
> >>
> >> I'm sorry that I can't understand "your original branch should be =
in
> >> the state you want" ?
> >> You only create a temp branch, and rebase some commits on it, righ=
t ??
> >> What does that related to original branch ??
> >
> > The three-argument form of rebase above will switch to branch_name =
(your
> > original branch), consider F'^ as the upstream, and rebase
> > F'^..branch_name on top of the commits in "temp".
> >
> > -Peff
> >
>=20
> Actually, I missed this detail earlier, and now like Gavin I'm
> confused. *temp* is "in the state that you want," not original_branch=
,
> right? temp shouldn't be deleted just yet; master should be updated t=
o
> point to this....

No, the first thing rebase will do is switch back to your
original_branch, and then it will rebase the extra commits (the
rebased versions of things that happened after your initial pull), on
top of the new partial history in temp.

Yeah, the arguments to rebase are weird. In a simpler world you would
do:

  # assume we're on master, the broken branch; mark the point with a ta=
g
  git tag broken

  # go back to just before the broken rewritten commits
  git reset --hard C'

  # now re-do the merge
  git pull origin master

  # and now grab the other commits from our broken state
  git cherry-pick F'^..broken

except that cherry-pick doesn't actually walk the commit range as you
want it to. I think you can do:

  git cherry-pick F' G' H'

these days, so that is another option.

Anyway, just for fun I put together a script which graphically shows
your situation at each step. You can run it all at once, but it is
probably more instructive to cut and paste into a terminal, reading all
of the comments.

-Peff

-- >8 --
#!/bin/sh

# clean up any previous invocations
rm -rf parent child

# short helper function for making our commits
commit() {
  echo $1 >$1 && git add $1 && git commit -m $1 && git tag $1
}

# short helper to show state
show() {
  # or gitk "$@" if you prefer
  git log --oneline --graph --decorate "$@"
}

# make a parent and child with some shared base
mkdir parent && (cd parent && git init && commit base)
git clone parent child

# now child and parent diverge. child has a-b-c,
# parent has d-e
(cd child && commit A && commit B && commit C) &&
(cd parent && commit D && commit E) &&

# now let's recreate the problem situation. Everything
# now happens in the child.
cd child

# First we pull the parent's commits into the child
git pull origin master

# And build on top of it
commit F && commit G && commit H

# And then we "rebase -i", rewriting B
GIT_EDITOR=3D'perl -pi -e "s/pick (.* B)/edit \$1/"' git rebase -i base
echo changes >>B && git commit --amend -a -m B
git rebase --continue

# Now we have the broken state, because we rewrote parent's commits dur=
ing our
# rebase. We also failed to preserve merges, so the new history appears=
 linear.
# You can see the repeated commits easily by looking at the history gra=
ph of
# our new state versus our old.
#
# Let's also go ahead and tag the original history and each of the new =
commits
# so we can recognize and refer to them. Here H-new corresponds to H' i=
n my
# other explanation, and so on.
git branch original-history master@{1}
git tag H-new HEAD
git tag G-new HEAD~1
git tag F-new HEAD~2
git tag E-new HEAD~3
git tag D-new HEAD~4
git tag C-new HEAD~5
git tag B-new HEAD~6
show --all

# So now let's look at the solution. First we make a temporary branch f=
rom the
# rewritten commit just prior to the ones from upstream (in this case, =
C').
git checkout -b temp C-new
show temp

# Now re-pull from upstream, recreating the merge on top of your rewrit=
ten
# commits.
git pull origin master
show temp

# And now rebase the rewritten versions of all of the commits that came=
 after
# the merge. We know F-new is the first such rewritten commit, so its p=
arent
# (F-new^) becomes the upstream. We are rebasing onto the state we have=
 in
# temp, and we are rebasing the branch master (and the end result will =
go on
# master).
git rebase --onto temp F-new^ master
show master
