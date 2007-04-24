From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Add clean.requireForce option, and add -f option to git-clean
 to override it
Date: Mon, 23 Apr 2007 17:18:16 -0700
Message-ID: <462D4CC8.70006@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE219755E11CB4B5E10F350D9"
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 02:25:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8qd-0007xN-Si
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030894AbXDXAZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030937AbXDXAZd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:25:33 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:35491 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030894AbXDXAZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:25:32 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Apr 2007 20:25:32 EDT
Received: (qmail 21728 invoked from network); 24 Apr 2007 00:18:50 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 24 Apr 2007 00:18:49 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45390>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE219755E11CB4B5E10F350D9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Add a new configuration option clean.requireForce.  If set, git-clean wil=
l
refuse to run, unless forced with the new -f option, or not acting due to=
 -n.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
Passes the test suite, and works fine for me.

 Documentation/config.txt               |    4 ++++
 Documentation/git-clean.txt            |    6 +++++-
 contrib/completion/git-completion.bash |    1 +
 git-clean.sh                           |   13 ++++++++++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b13ff3a..e0aff53 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -300,6 +300,10 @@ branch.<name>.merge::
 	branch.<name>.merge to the desired branch, and use the special setting
 	`.` (a period) for branch.<name>.remote.
=20
+clean.requireForce::
+	A boolean to make git-clean do nothing unless given -f or -n.  Defaults=

+	to false.
+
 color.branch::
 	A boolean to enable/disable color in the output of
 	gitlink:git-branch[1]. May be set to `true` (or `always`),
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index c61afbc..5aff026 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git-clean' [-d] [-n] [-q] [-x | -X] [--] <paths>...
+'git-clean' [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...
=20
 DESCRIPTION
 -----------
@@ -25,6 +25,10 @@ OPTIONS
 -d::
 	Remove untracked directories in addition to untracked files.
=20
+-f::
+	If the git configuration specifies clean.forceRequire as true,
+	git-clean will refuse to run unless given -f or -n.
+
 -n::
 	Don't actually remove anything, just show what would be done.
=20
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
index 7c03403..46356e8 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -790,6 +790,7 @@ _git_config ()
 		core.legacyHeaders
 		core.packedGitWindowSize
 		core.packedGitLimit
+		clean.requireForce
 		color.branch
 		color.branch.current
 		color.branch.local
diff --git a/git-clean.sh b/git-clean.sh
index db177a7..299309d 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -3,9 +3,10 @@
 # Copyright (c) 2005-2006 Pavel Roskin
 #
=20
-USAGE=3D"[-d] [-n] [-q] [-x | -X] [--] <paths>..."
+USAGE=3D"[-d] [-f] [-n] [-q] [-x | -X] [--] <paths>..."
 LONG_USAGE=3D'Clean untracked files from the working directory
 	-d	remove directories as well
+	-f	override clean.requireForce and clean anyway
 	-n 	don'\''t remove anything, just show what would be done
 	-q	be quiet, only report errors
 	-x	remove ignored files as well
@@ -19,6 +20,7 @@ require_work_tree
 ignored=3D
 ignoredonly=3D
 cleandir=3D
+disabled=3D"`git-config --bool clean.requireForce`"
 rmf=3D"rm -f --"
 rmrf=3D"rm -rf --"
 rm_refuse=3D"echo Not removing"
@@ -30,7 +32,11 @@ do
 	-d)
 		cleandir=3D1
 		;;
+	-f)
+		disabled=3D
+		;;
 	-n)
+		disabled=3D
 		rmf=3D"echo Would remove"
 		rmrf=3D"echo Would remove"
 		rm_refuse=3D"echo Would not remove"
@@ -58,6 +64,11 @@ do
 	shift
 done
=20
+if [ "$disabled" =3D true ]; then
+	echo "clean.requireForce set and -n or -f not given; refusing to clean"=

+	exit 1
+fi
+
 case "$ignored,$ignoredonly" in
 	1,1) usage;;
 esac
--=20
1.5.1.1



--------------enigE219755E11CB4B5E10F350D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLUzIGJuZRtD+evsRAkMBAJ9CVBEmW3GGynmBvxw6xzjwPeqF1QCfVoCR
pcdudLTZ7l47Hs8RjsyqG6I=
=ihax
-----END PGP SIGNATURE-----

--------------enigE219755E11CB4B5E10F350D9--
