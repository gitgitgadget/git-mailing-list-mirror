From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Re: [PATCH/RFC] builtin-checkout: suggest creating local
 branch when appropriate to do so
Date: Mon, 12 Oct 2009 20:36:58 +0200
Message-ID: <20091012183658.GA17857@atjola.homenet>
References: <0016e68fd0123a175304754694b4@google.com>
 <alpine.DEB.1.00.0910120941150.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:50:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPyY-0007oN-F3
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725AbZJLSiD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 14:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757721AbZJLSiC
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:38:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:48498 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757627AbZJLSiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:38:00 -0400
Received: (qmail invoked by alias); 12 Oct 2009 18:37:04 -0000
Received: from i59F55BF7.versanet.de (EHLO atjola.homenet) [89.245.91.247]
  by mail.gmx.net (mp062) with SMTP; 12 Oct 2009 20:37:04 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX182+Eskb0M2HIHdRy8yVbxBZQ+Olb5HZhKB8Pa7RA
	rG1o6KtvVuYCnn
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0910120941150.4985@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130050>

On 2009.10.12 09:49:50 +0200, Johannes Schindelin wrote:
> On Tue, 6 Oct 2009, Euguess@gmail.com wrote:
> > I'ma new user of git and I don't think i will ever have a commit in=
=20
> > git.git, because I'm not a programmer (I'm QA).
[...]
> > As for the solution i would choose the "simplest thing that will wo=
rk" -=20
> > so i think that we just have to notify user about his suicide attem=
pt to=20
> > checkout nonlocal branch and offer him a correct syntax to go with.
> >
> > Something like below should work:
> >=20
> > % git clone git://git.git git
> > % git checkout next
> > You're attempting to checkout to non-local branch. This will lead t=
o your HEAD
> > being detached (our team is on its way!).
> > Do you want to check out local branch 'next' tracking 'origin/next'=
 instead?
> > y/n
> >=20
> > if yes, then:
> > Created branch "next" tracking "origin/next"
> > You can update it with 'git pull'.
> >=20
> > If no - abort or continue with checkout to nonlocal branch? ('m not=
 sure if
> > detaching HEAD can provide some benefits if done on purpose)
> >=20
> > I hope I'm not missing anything...
>=20
> No, I think that is something perfectly fine to expect in a software =
whose=20
> UI complexity is unfortunately pretty much in disagreement with its=20
> internal complexity.
>=20
> One thing one might add for the technically inclined folks (i.e. thos=
e who=20
> need to implement, and to see that Git is in dear need of some=20
> user-friendliness first): "git checkout" is a porcelain (i.e. a progr=
am=20
> meant for end-user consumption), and as such should not have a proble=
m to=20
> react to isatty(0) (i.e. "is the input coming directly from the=20
> console?").

So I didn't mean to chime in, but anyway... A few days ago, uau on #git
said that he thinks that "git clone" shouldn't create any branch heads
at all. Instead, git should learn to do something like "svn up", when
the user checked out a remote tracking branch. That was specifically
meant for users that _don't_ commit, like, say, QA guys ;-)

I didn't quite agree on the idea (feel free to tell me that I just blan=
k
out UI problems :-p), but anyway, I felt like coming up with some hack
that achieves said functionality. The result was inspired by "git
checkout -" and looks at HEAD's reflog to figure out whether the user
has checked out a remote tracking branch the last time he used checkout
to switch branches. I dared to call it "git-up" in my $HOME/bin ;-)

#!/bin/bash
MODE=3D${1:---merge}

RTB=3D$(git rev-parse --symbolic-full-name $(git reflog | grep 'checkou=
t: moving from .* to' | head -1 | sed -e 's/.* to //'))

if [ ${RTB:0:13} !=3D "refs/remotes/" ]
then
	echo "You're not on a remote tracking branch"
	exit 1
fi

SRTB=3D${RTB#refs/remotes/}
REMOTE=3D${SRTB%/*}
git fetch $REMOTE
git reset $MODE $RTB


It's obviously basically just "git reset" on crack, happily dropping
local commits. A "real" implementation would likely have to have more
checks to ensure that the user is using it in an expected way (like
checking that refs/remotes/whatever..HEAD is empty). And it could be
made to work with regular branch heads as well then, as a "fast-forward
only" way of updating (think "git merge --ff-only", but in a less
illogical way, as "--ff-only" actually means "don't create a merge",
which is kinda weird, at least to me).

As I said, I don't really agree on the idea of not creating any branch
heads on "clone", but maybe it's because I'm not a "don't commit, just
watch" person. And the theoretical "git up" command might be handy for
guys that just want to follow things, and thus don't really need branch
heads. At the moment, I don't have any intentions to improve the hack
(also due to lack of time), but if it seems worthwhile to anyone, feel
free to pick it up.

Bj=F6rn, -ENOPATCH ;-)
