From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Thu, 14 May 2009 00:22:43 +0200
Message-ID: <20090513222243.GQ15420@raven.wolf.lan>
References: <20090502215852.GJ15420@raven.wolf.lan> <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com> <20090504211423.GK15420@raven.wolf.lan> <20090506185224.GM15420@raven.wolf.lan> <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> <20090506225042.GN15420@raven.wolf.lan> <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> <20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan> <32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 00:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4MzS-0001Oe-Dn
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 00:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761217AbZEMWbB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 18:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbZEMWbB
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 18:31:01 -0400
Received: from quechua.inka.de ([193.197.184.2]:39373 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761217AbZEMWbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 18:31:00 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1M4MyZ-0005fz-Od; Thu, 14 May 2009 00:30:59 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 78BDE2CCFD; Thu, 14 May 2009 00:22:43 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119118>

Thanks for your patience, Avery!  I would be completely lost here witho=
ut
your help..

On Wed, May 13, 2009 at 01:28:04PM -0400, Avery Pennarun wrote:
> On Wed, May 13, 2009 at 8:09 AM, Josef Wolf <jw@raven.inka.de> wrote:
> > Now here's the problem: =A0This last dcommit does simply a reset, b=
ecause
> > nothing has changed since the last dcommit. =A0So a5cf3..c3ff2 are =
_not_
> > marked as ancestors of svn-2/trunk, causing those cherries to be re=
based
> > at the next dcommit with real changes.
>=20
> I find this a *bit* curious, since each dcommit should be adding the
> cherry-picked changes you just now picked from the opposite branch,
> right?

They _are_ already added.  I try to outline what happens based on the
graph I posted in my previous mail:

  # move cherries from svn-1 to svn-2
  #
  git svn fetch svn-1
  git checkout svn-2
  [ cherry-picking, creates 67446..0a742 ]
  git merge --no-ff -s ours svn-1 -m 'merge ours svn-1 to svn-2' # 5d9a=
0
  git checkout svn-2/trunk
  git merge --no-ff svn-2 -m 'merge svn-1 to svn-2'              # f80d=
2
  git svn dcommit

This sequence moves cherries 67446..0a742 to svn-2/trunk and creates
5d9a0+f80d2
67446..0a742 are now ancestors of svn-2/trunk
a5cf3..c3ff2 are _not_ ancestors of svn-2/trunk (they don't even exist =
yet)

  # move cherries from svn-1 to svn-2
  #
  git svn fetch svn-2
  git checkout svn-1
  [ cherry-picking, creates a5cf3..c3ff2 ]
  git merge --no-ff -s ours svn-2 -m 'merge ours svn-2 to svn-1' # 2379=
d
  git checkout -q svn-1/trunk
  git merge --no-ff svn-1 -m 'merge svn-2 to svn-1'              # 693f=
a
  git svn dcommit --no-rebase

This sequence moves cherries a5cf3..c3ff2 to svn-1/trunk and creates
2379d+693fa
a5cf3..c3ff2 are now ancestors of svn-1/trunk
67446..0a742 are also ancestors of svn-1/trunk since 5d9a0 pulls them i=
n.

Please notice the asymmetry here. If I try to merge another change to
svn-2 at this point, dcommit tries to pull the cherries a5cf3..c3ff2.
Since those cherries came initially from 17156..e0772, they are already
included literally in the current tree and I get a lot of conflicts,
To tell git about the fact that those cherries are already available in
svn-2/trunk, I try yet another merge set of commands:

  git checkout svn-2
  git merge --no-ff -s ours svn-1

This works fine, a5cf3..c3ff2 are now recorded as ancestors of svn-2 an=
d
will no longer be picked on future merges.

  git checkout svn-2/trunk
  git merge --no-ff -s ours svn-1
  git svn dcommit

And _this_ is the dcommit I was talking about in the paragraph you cite=
d
above.  This dcommit notices that the resulting tree is identical to th=
e
tree already in svn, since it was merged with "-s ours" and no real cha=
nge
was done in the mean time.  So dcommit just resets and a5cf3..c3ff2 are
still not marked as ancestors of svn-2/trunk and would be pulled again
at the next merge attempt, resulting in conflicts.

> If you weren't going to change anything, then you wouldn't
> have needed to do the cherry picks at all; you could have just done a
> merge -s ours in both directions in the first place.

The cherries _are_ moved in both directions. But the ancestry is not ye=
t
adopted because at the time of the move from svn-1 to svn-2 the cherrie=
s
that were picked from svn-2 did not exist.  Therefore dcommit wants to
move them to svn-2 (where the textual contents of those cherries alread=
y
are).

> Anyway, regardless of the above, AFAIK there's no way to force svn to
> make an empty commit, which is a problem in this case.  You can make =
a
> nonempty commit, though; I've done this in the past by just adding a
> newline to the end of some arbitrary file.  Basically:
>=20
> git merge -s ours whatever
> echo >>Makefile
> git add Makefile
> git commit --amend
> git svn dcommit

Ah, I see :-)  You can do a _lot_ with git if you know _how_ to do it ;=
-)

Yes, that helps a little bit: all the cherries are now ancestors of bot=
h
remote branches and both local branches. But after this, all dcommits
complain about outdated transactions although there were no commits
to the svn repositories in the meantime:

  $ git merge --no-ff -s ours svn-1
  Merge made by ours.              =20
  $ echo >>Makefile
  $ git add Makefile
  $ git commit --amend -m 'Force merge ours svn-1 to svn-2/trunk'
  Created commit ae455ca: Force merge ours svn-1 to svn-2/trunk
  $ git svn dcommit
  Committing to file:///var/tmp/builds/git-sync/svn/svn-2/trunk ...
          M       Makefile                                             =
 =20
  Committed r1260                                                      =
   =20
          M       Makefile                                             =
 =20
  r1260 =3D 372579ff221a151f026eef42213e52e1b9bb9d47 (svn-2/trunk)  =20
  No changes between current HEAD and refs/remotes/svn-2/trunk    =20
  Resetting to the latest refs/remotes/svn-2/trunk                =20
  $ git checkout svn-2
  Previous HEAD position was 372579f... Force merge ours svn-1 to svn-2=
/trunk
  Switched to branch "svn-2"                                           =
        =20
  $ git svn fetch svn-1
  $ git merge --no-ff svn-1
  Already up-to-date.      =20
  $ git svn dcommit
  Committing to file:///var/tmp/builds/git-sync/svn/svn-2/trunk ...
  Transaction is out of date: File '/trunk/policy.pl' is out of date at=
 /usr/lib64/git/git-svn line 469

Gitk shows that svn-2 is no longer an ancestor of svn-2/trunk.  Might t=
his
be the reason for the "transaction out of date"?  How do I recover from=
 that?

> > Unfortunately, dcommit doesn't seem to have an option to force reba=
se
> > instead of resetting.
>=20
> Well, in fact it *is* rebasing, which throws away the extra commit
> because it thinks that commit didn't do anything.  I've experienced
> this problem a few times in the past, but I knew what was happening
> and I figured my case was too rare to matter.  Perhaps not.
>=20
> This could be considered a bug in git-svn, so I cc:'d Eric Wong, who =
I
> think is the main git-svn developer.  Anyway, try the workaround
> above.

I am not sure this is a bug.  I have still the feeling that I am doing
something wrong.  Maybe I should not try to throw two svn remotes onto
a single git repository?  Maybe I should create a separate repository
for every direction?
