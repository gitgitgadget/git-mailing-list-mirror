From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-count-objects --all support
Date: Sun, 22 Jan 2006 03:27:19 +0100
Message-ID: <20060122022718.16375.78611.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 22 03:26:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0UvT-0000ZC-54
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 03:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWAVCZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 21:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWAVCZs
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 21:25:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33462 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751252AbWAVCZs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 21:25:48 -0500
Received: (qmail 16397 invoked from network); 22 Jan 2006 03:27:19 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 22 Jan 2006 03:27:19 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15034>

Having command called "git-count-objects" count only unpacked objects is
a little strange and confusing. This patch adds a warning if packs are
already present in the current repository, an --unpacked argument to
suppress the warning, and an --all argument to count even packed objects
(useful at least for statistics).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-count-objects.txt |    9 ++++----
 git-count-objects.sh                |   41 ++++++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 36888d9..105721b 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -3,16 +3,17 @@ git-count-objects(1)
 
 NAME
 ----
-git-count-objects - Reports on unpacked objects.
+git-count-objects - Reports on objects count.
 
 SYNOPSIS
 --------
-'git-count-objects'
+'git-count-objects' [--unpacked | --all]
 
 DESCRIPTION
 -----------
-This counts the number of unpacked object files and disk space consumed by
-them, to help you decide when it is a good time to repack.
+This counts the number of objects and disk space consumed by them.
+It by default counts only unpacked objects in order to help you decide
+when it is a good time to repack.
 
 Author
 ------
diff --git a/git-count-objects.sh b/git-count-objects.sh
index 40c58ef..986ff14 100755
--- a/git-count-objects.sh
+++ b/git-count-objects.sh
@@ -3,7 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
+USAGE='[--unpacked | --all]'
+. git-sh-setup
 
 dc </dev/null 2>/dev/null || {
 	# This is not a real DC at all -- it just knows how
@@ -20,12 +21,44 @@ dc </dev/null 2>/dev/null || {
 	}
 }
 
-echo $(find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null | wc -l) objects, \
+all= unpacked=
+while case "$#" in 0) break;; esac
+do
+  case "$1" in
+  -a|--a|--al|--all)
+    all=t
+    shift ;;
+  -u|--u|--un|--unp|--unpa|--unpac|--unpack|--unpacke|--unpacked)
+    unpacked=t
+    shift ;;
+  *)
+    usage ;;
+  esac
+done
+
+has_packs=
+test -d "$GIT_DIR/objects/pack" && test -n "$(ls "$GIT_DIR/objects/pack")" &&
+	has_packs=objects/pack
+test -n "$has_packs" && test -z "$all" && test -z "$unpacked" &&
+	echo "Warning: Ignoring packed objects"
+test -z "$all" &&
+	has_packs=
+
+
+objcount=$(find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null | wc -l)
+test -n "$has_packs" && for pack in "$GIT_DIR/objects/pack"/*.idx; do
+	objcount=$((objcount+$(git-pack-ls-objects <"$pack" 2>/dev/null | wc -l)))
+done
+
+echo $objcount objects, \
 $({
     echo 0
+
+    cd "$GIT_DIR"
     # "no-such" is to help Darwin folks by not using xargs -r.
-    find "$GIT_DIR/objects"/?? -type f -print 2>/dev/null |
-    xargs du -k "$GIT_DIR/objects/no-such" 2>/dev/null |
+    find objects/?? $has_packs -type f -print 2>/dev/null |
+    xargs du -k "objects/no-such" 2>/dev/null |
     sed -e 's/[ 	].*/ +/'
+
     echo p
 } | dc) kilobytes
