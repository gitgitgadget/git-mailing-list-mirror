From: Johan Herland <johan@herland.net>
Subject: Re: [RFC?] Telling git about more complex relationships between
 commits (Was: Re: FFmpeg considering GIT)
Date: Sat, 05 May 2007 14:49:42 +0200
Message-ID: <200705051449.45447.johan@herland.net>
References: <loom.20070502T111026-882@post.gmane.org>
 <200705041353.17992.johan@herland.net> <20070504221152.GF4033@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=nextPart1721617.axnrYD0G3P;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 19:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOOe-0007km-Q4
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934154AbXEERuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934156AbXEERuN
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:50:13 -0400
Received: from smtp.getmail.no ([84.208.20.33]:57733 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934154AbXEERuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:50:11 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JHK00203JN79U00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 05 May 2007 14:49:55 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHK009R9JMYCB30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 05 May 2007 14:49:46 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHK009KDJMX8K60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 05 May 2007 14:49:46 +0200 (CEST)
In-reply-to: <20070504221152.GF4033@steel.home>
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46274>

--nextPart1721617.axnrYD0G3P
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 05 May 2007, Alex Riesen wrote:
> Johan Herland, Fri, May 04, 2007 13:53:10 +0200:
> > As for "Reverts", the commit pointed to should already be in your
> > history, since you cannot revert something that hasn't already been
> > applied at an earlier point in your history. In other words, the
> > reverted commit will automatically be included in your "git gc
> > --prune" or "git clone" regardless of the "Reverts" fields, since
> > "Reverts" can only point to an ancestor.
>
> So it becomes useless after rebase

Only if rebase also rebases the commit pointed to by "Reverts" (the=20
reverted commit). And even in that case, it should be possible for=20
rebase to detect the "Reverts" relationship and rewrite it properly,=20
or - if people want to - skip both the reverted and the reverting=20
commit in the rebase process.

> > As for "Cherry-Pick", it's a fairly weak relationship that
> > shouldn't affect anything except to give a hint to merge, blame,
> > and similar tools.
>
> In which case, just put it in the message part of commit (in fact, it
> was there for some time. And was mostly useless, and got dropped).

Ok. If merging branches which have had cherry-picks between them is such=20
a rare occurrence that there is no point in adding hints for merge (to=20
do better conflict resolution), blame (to see who _really_ wrote the=20
piece of code that was cherry-picked by someone else), etc. then there=20
is indeed no justification for the "Cherry-Pick" header field.

> And how exactly do you think the tools _can_ use this hint?
> Especially merge, which should be absolutely certain about what
> inputs and hints gets.

When merging two branches where one branch has a commit that is later=20
reverted, and the other branch has cherry-picked the first/reverted=20
commit, but not the second/reverting: With these hints, git can now ask=20
the user a more intelligent question like "The following commit was=20
reverted in one of the branches. Do you want to keep it or revert it?".=20
The current alternative seems to be to auto-choose one or the other (in=20
my testing, the reverting commit was dropped in the merge). Will git=20
always make the correct decision? If git is always correct, then what I=20
suggest is obviously useless.

> And what use is it for blame? How do you prioritze the hint? Is it
> more important than the history (which describes each and every
> line), or less? If the hint is more important, than how (and how
> often) do you tell the user that the hint was not found (because the
> commit is long pruned) and the tool switched back to looking into
> history.

Consider the following scenario:

=3D=3D=3D=3D
$ mkdir test
$ cd test
$ git init
Initialized empty Git repository in .git/
$ git config user.name "User A"
$ cat >f <<\EOF
foo
bar
baz
EOF
$ git add f && git commit -m "User A: foo, bar, baz"
Created initial commit bb0203aabb4936d95dca30f946cb1d849df59f24
 1 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 f
$ git config user.name "User B"
$ cat >f <<\EOF
foo
barf
baz
EOF
$ git commit -a -m "User B: bar -> barf"
Created commit 5ced0ccaba0bf4a982dc2cdd792a1a0e7b1883eb
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git config user.name "User C"
$ git revert HEAD
Created commit 38da1083ae4677000f8bb70729f474f358c71a3e
 1 files changed, 1 insertions(+), 1 deletions(-)
=3D=3D=3D=3D

At this point, what output do we _really_ want from "git blame f"?

Currently we get:
=3D=3D=3D=3D
^bb0203a (User A 2007-05-05 12:25:44 +0200 1) foo
38da1083 (User C 2007-05-05 12:28:00 +0200 2) bar
^bb0203a (User A 2007-05-05 12:25:44 +0200 3) baz
=3D=3D=3D=3D

Can you categorically say that there is no use for the following output?=20
(even if you need to pass an option to "git blame" to get it):
=3D=3D=3D=3D
^bb0203a (User A 2007-05-05 12:25:44 +0200 1) foo
^bb0203a (User A 2007-05-05 12:25:44 +0200 1) bar
^bb0203a (User A 2007-05-05 12:25:44 +0200 3) baz
=3D=3D=3D=3D

> It's useless.

Maybe. At least some of the fields I proposed are probably useless. But=20
I don't think we should throw away the core idea unless we can show=20
that _all_ fields are useless.


Have fun!

=2E..Johan
=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart1721617.axnrYD0G3P
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGPH1pBHj4kl4fT1wRAt1wAJ99Gu7ZFDkx3EXJVpVhTjTy6CIQhwCfSvtm
B41yGYgjZSvKqkM48JFXQT8=
=Ki0b
-----END PGP SIGNATURE-----

--nextPart1721617.axnrYD0G3P--
