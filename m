From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [Alt. PATCH 1/2] repack: add -F flag to let user choose between
 --no-reuse-delta/object
Date: Mon, 27 Sep 2010 14:19:36 +0200
Message-ID: <20100927141936.590d71b3@jk.gs>
References: <20100927133104.25ce5285@jk.gs>
	<alpine.LFD.2.00.1009270742250.1146@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 27 14:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0CgL-0005EW-II
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 14:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab0I0MTk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 08:19:40 -0400
Received: from zoidberg.org ([88.198.6.61]:38313 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755967Ab0I0MTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 08:19:39 -0400
Received: from jk.gs (xdsl-89-0-0-81.netcologne.de [::ffff:89.0.0.81])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 27 Sep 2010 14:19:39 +0200
  id 004000B7.4CA08BDB.00004E36
In-Reply-To: <alpine.LFD.2.00.1009270742250.1146@xanadu.home>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157327>

In 479b56ba ('make "repack -f" imply "pack-objects --no-reuse-object"')=
,
git repack -f was changed to include recompressing all objects on the
zlib level on the assumption that if the user wants to spend that much
time already, some more time won't hurt (and recompressing is useful if
the user changed the zlib compression level).

However, "some more time" can be quite long with very big repositories,
so some users are going to appreciate being able to choose. If we are
going to give them the choice, --no-reuse-object will probably be
interesting a lot less frequently than --no-reuse-delta. Hence, this
reverts -f to the old behaviour (--no-reuse-delta) and adds a new -F
option that replaces the current -f.

Measurements taken using this patch on a current clone of git.git
indicate a 17% decrease in time being made available to users:

git repack -Adf  34.84s user 0.56s system 145% cpu 24.388 total
git repack -AdF  38.79s user 0.56s system 133% cpu 29.394 total

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---

--- Nicolas Pitre <nico@fluxnic.net> wrote:

> I personally don't find --no-reuse-object particularly useful.  I
> hardly imagine that people are changing the pack compression level
> that often if at all.  So I doubt moving the current
> --no-reuse-object behavior to -F and reverting -f to
> --no-reuse-delta would cause any serious inconvenience.  It certainly
> won't _break_ anything.  So you have my ACK to do that change.

Here we go.

 Documentation/git-repack.txt |    6 +++++-
 git-repack.sh                |    6 ++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
index 8c67d17..9566727 100644
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
@@ -62,6 +62,10 @@ other objects in that pack they already have locally=
=2E
 	linkgit:git-pack-objects[1].
=20
 -f::
+	Pass the `--no-reuse-delta` option to `git-pack-objects`, see
+	linkgit:git-pack-objects[1].
+
+-F::
 	Pass the `--no-reuse-object` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
=20
diff --git a/git-repack.sh b/git-repack.sh
index 1eb3bca..769baaf 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -10,7 +10,8 @@ git repack [options]
 a               pack everything in a single pack
 A               same as -a, and turn unreachable objects loose
 d               remove redundant packs, and run git-prune-packed
-f               pass --no-reuse-object to git-pack-objects
+f               pass --no-reuse-delta to git-pack-objects
+F               pass --no-reuse-object to git-pack-objects
 n               do not run git-update-server-info
 q,quiet         be quiet
 l               pass --local to git-pack-objects
@@ -34,7 +35,8 @@ do
 		unpack_unreachable=3D--unpack-unreachable ;;
 	-d)	remove_redundant=3Dt ;;
 	-q)	GIT_QUIET=3Dt ;;
-	-f)	no_reuse=3D--no-reuse-object ;;
+	-f)	no_reuse=3D--no-reuse-delta ;;
+	-F)	no_reuse=3D--no-reuse-object ;;
 	-l)	local=3D--local ;;
 	--max-pack-size|--window|--window-memory|--depth)
 		extra=3D"$extra $1=3D$2"; shift ;;
--=20
1.7.2.3.392.g02377.dirty
