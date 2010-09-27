From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH] repack: add -F option that passes --no-reuse-delta to
 pack-objects
Date: Mon, 27 Sep 2010 13:31:04 +0200
Message-ID: <20100927133104.25ce5285@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 27 13:34:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0By8-0004R6-BC
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 13:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab0I0LbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 07:31:10 -0400
Received: from zoidberg.org ([88.198.6.61]:59188 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233Ab0I0LbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 07:31:09 -0400
Received: from jk.gs (xdsl-89-0-0-81.netcologne.de [::ffff:89.0.0.81])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 27 Sep 2010 13:31:08 +0200
  id 00400267.4CA0807C.000006AC
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157323>

In 479b56ba ('make "repack -f" imply "pack-objects --no-reuse-object"')=
,
git repack -f was changed to include recompressing all objects on the
zlib level on the assumption that if the user wants to spend that much
time already, some more time won't hurt (and recompressing is useful if
the user changed the zlib compression level).

However, "some more time" can be quite long with very big repositories,
so some users are going to appreciate being able to choose. Hence, this
adds a new -F option that uses the old behaviour of recalculating delta=
s
only and keeping the zlib compression intact.

Measurements taken using this patch on a current clone of git.git
indicate a 17% decrease in time being made available to users:

git repack -Adf  38.79s user 0.56s system 133% cpu 29.394 total
git repack -AdF  34.84s user 0.56s system 145% cpu 24.388 total

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---

The concrete case that prompted me to write this patch was a repository
of 25 GB that some guys were trying to repack. 17% of the time needed t=
o
repack -f that much data is... substantial.

Discussion point: it might make more sense to switch the meanings
around, making -F do the 'bigger' routine and reverting -f to what it
used to be. I don't feel strongly about that, however.

Cc'ing those who were involved in the discussion leading to 479b56ba.

 Documentation/git-repack.txt |    6 +++++-
 git-repack.sh                |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
index 8c67d17..cce32e2 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -8,7 +8,7 @@ git-repack - Pack unpacked objects in a repository
=20
 SYNOPSIS
 --------
-'git repack' [-a] [-A] [-d] [-f] [-l] [-n] [-q] [--window=3DN] [--dept=
h=3DN]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=3DN] [-=
-depth=3DN]
=20
 DESCRIPTION
 -----------
@@ -65,6 +65,10 @@ other objects in that pack they already have locally=
=2E
 	Pass the `--no-reuse-object` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
=20
+-F::
+	Pass the `--no-reuse-delta` option to `git-pack-objects`, see
+	linkgit:git-pack-objects[1].
+
 -q::
 	Pass the `-q` option to 'git pack-objects'. See
 	linkgit:git-pack-objects[1].
diff --git a/git-repack.sh b/git-repack.sh
index 1eb3bca..a010406 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -11,6 +11,7 @@ a               pack everything in a single pack
 A               same as -a, and turn unreachable objects loose
 d               remove redundant packs, and run git-prune-packed
 f               pass --no-reuse-object to git-pack-objects
+F               pass --no-reuse-delta to git-pack-objects
 n               do not run git-update-server-info
 q,quiet         be quiet
 l               pass --local to git-pack-objects
@@ -35,6 +36,7 @@ do
 	-d)	remove_redundant=3Dt ;;
 	-q)	GIT_QUIET=3Dt ;;
 	-f)	no_reuse=3D--no-reuse-object ;;
+	-F)	no_reuse=3D--no-reuse-delta ;;
 	-l)	local=3D--local ;;
 	--max-pack-size|--window|--window-memory|--depth)
 		extra=3D"$extra $1=3D$2"; shift ;;
--=20
1.7.2.3.392.g02377.dirty
