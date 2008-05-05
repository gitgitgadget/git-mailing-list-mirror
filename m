From: martin f krafft <madduck@madduck.net>
Subject: inconsistent detached worktree handling: several bugs
Date: Mon, 5 May 2008 17:06:43 +0100
Message-ID: <20080505160643.GA28318@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 05 18:07:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3E0-0002rB-UO
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYEEQGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 12:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbYEEQGs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:06:48 -0400
Received: from clegg.madduck.net ([82.197.162.59]:53451 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYEEQGr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:06:47 -0400
Received: from lapse.madduck.net (chiu.ifi.unizh.ch [130.60.75.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 6AA46A83C8
	for <git@vger.kernel.org>; Mon,  5 May 2008 18:06:43 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 903D53FD83; Mon,  5 May 2008 17:06:43 +0100 (IST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7033/Mon May  5 17:00:00 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81291>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am playing around with detached worktrees and have identified
a number of bugs in the path handling. Specifically, it seems that
while git-status and git-add/git-rm are consistent with respect to
each other, they expose different behaviour in different scenarios.
git-diff, on the other hand, seems broken with respect to worktree
handling.

Let me run you through what I did, bugs are
identified with ###BUG. Output is prefixed with #, which should make
it easier to cut-n-paste to reproduce



Note how $GIT_DIR is set for the first part of this exercise:

mkdir worktree
GIT_DIR=3Drepo.git; export GIT_DIR
git --bare init
# Initialized empty Git repository in repo.git/
git config core.bare false
git config core.worktree ../worktree

echo This is just a file called foo > worktree/foo

git add worktree/foo
# fatal: pathspec 'worktree/foo' did not match any files
###BUG: git should be able to factor out the common path prefix

ls foo
# ls: cannot access foo: No such file or directory
git add foo      # very confusing, but works

git commit -m'initial checkin'
# Created initial commit 2f2cdf3: initial checkin
#  1 files changed, 1 insertions(+), 0 deletions(-)
#  create mode 100644 foo

git status
##  On branch master
# nothing to commit (working directory clean)

git diff
# diff --git a/foo b/foo
# deleted file mode 100644
# index 27b451e..0000000
# --- a/foo
# +++ /dev/null
# @@ -1 +0,0 @@
# -This is just a file called foo
###BUG: git-diff doesn't seem to honour worktree and thinks the file
###was deleted

git diff -- worktree/foo
###BUG: no output, even though path was given

echo Another line >> worktree/foo
git status
# # On branch master
# # Changed but not updated:
# #   (use "git add <file>..." to update what will be committed)
# #
# #       modified:   foo
# #
# no changes added to commit (use "git add" and/or "git commit -a")

git diff -- worktree/foo
###BUG: no output, even though path was given

git add foo
# diff --git a/foo b/foo
# deleted file mode 100644
# index 76404d8..0000000
# --- a/foo
# +++ /dev/null
# @@ -1,2 +0,0 @@
# -This is just a file called foo
# -Another line

git diff --cached
# diff --git a/foo b/foo
# index 27b451e..76404d8 100644
# --- a/foo
# +++ b/foo
# @@ -1 +1,2 @@
#  This is just a file called foo
# +Another line



-----------
If worktree is actually an ancestor of the Git repository *and* we
chdir() into the repository, whether GIT_DIR is set or not, things
look different again:

mv ../worktree/* ..
rmdir ../worktree
git config core.worktree ..
git status
# # On branch master
# # Changed but not updated:
# #   (use "git add <file>..." to update what will be committed)
# #
# #       modified:   ../foo
# #
# # Untracked files:
# #   (use "git add <file>..." to include in what will be committed)
# #
# #       ./
# no changes added to commit (use "git add" and/or "git commit -a")

git diff
# diff --git a/foo b/foo
# deleted file mode 100644
# index 76404d8..0000000
# --- a/foo
# +++ /dev/null
# @@ -1,2 +0,0 @@
# -This is just a file called foo
# -Another line
###BUG: again, git-diff can't find the local file

git add foo
# fatal: pathspec 'repo.git/foo' did not match any files
###BUG: inconsistent with above behaviour, but consistent with
###git-status output

git add ../foo
git commit -m'another linee'
# Created commit d016799: another linee
#  1 files changed, 1 insertions(+), 0 deletions(-)

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"i might disagree with what you have to say,
 but I'll defend to the death your right to say it."
                                                           -- voltaire
=20
spamtraps: madduck.bogus@madduck.net

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIHzCSIgvIgzMMSnURAsemAKC6KxdBVmfSQ8piivknkob0i+0ypQCgy3F5
+bWSpzP8DuokXCGVSbeuJGA=
=4Ejq
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
