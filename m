From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 4/6] Add a no-act flag to stg-dispatch and
	stg-fold-file-from.
Date: Thu, 02 Aug 2007 22:18:31 +0200
Message-ID: <20070802201831.16614.33481.stgit@gandelf.nowhere.earth>
References: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:20:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGh9M-0007HH-NE
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759981AbXHBUTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759931AbXHBUTg
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:19:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55143 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759973AbXHBUTf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:19:35 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CE6DF5DF0;
	Thu,  2 Aug 2007 22:19:34 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B25D738F2;
	Thu,  2 Aug 2007 22:19:34 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 710D31F06F;
	Thu,  2 Aug 2007 22:18:31 +0200 (CEST)
In-Reply-To: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54597>

From: Yann Dirson <yann.dirson@sagem.com>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-dispatch        |   20 +++++++++++++++-----
 contrib/stg-fold-files-from |   15 +++++++++++++--
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/contrib/stg-dispatch b/contrib/stg-dispatch
index 8911946..e9cfb05 100755
--- a/contrib/stg-dispatch
+++ b/contrib/stg-dispatch
@@ -6,7 +6,7 @@ set -e
 # do so), but from the patch containing the changes to migrate,
 # instead of doing so from the target patch.
 
-# usage: stg-dispatch <topatch> [-#<n>[-<n>][,<n>]...] <file-pattern>
+# usage: stg-dispatch [-n] <topatch> [-#<n>[-<n>][,<n>]...] <file-pattern>
 
 # Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
 # Subject to the GNU GPL, version 2.
@@ -17,6 +17,12 @@ die()
     exit 1
 }
 
+noact=0
+if [ "x$1" = "x-n" ]; then
+    noact=1
+    shift
+fi
+
 TOPATCH="$1"
 shift
 
@@ -28,7 +34,11 @@ CURRENTPATCH=$(stg top)
 [ "x$TOPATCH" != "x$CURRENTPATCH" ] ||
     die "dispatching to current patch ($CURRENTPATCH) makes no sense"
 
-stg goto "$TOPATCH"
-stg-fold-files-from "$CURRENTPATCH" "$@"
-stg refresh
-stg goto "$CURRENTPATCH"
+if [ $noact = 1 ]; then
+    stg-fold-files-from "$CURRENTPATCH" -n "$@"
+else
+    stg goto "$TOPATCH"
+    stg-fold-files-from "$CURRENTPATCH" "$@"
+    stg refresh
+    stg goto "$CURRENTPATCH"
+fi
diff --git a/contrib/stg-fold-files-from b/contrib/stg-fold-files-from
index 806a157..c52abfc 100755
--- a/contrib/stg-fold-files-from
+++ b/contrib/stg-fold-files-from
@@ -8,7 +8,7 @@ set -e
 # identify hunk numbers easily.
 # Use "-O -U<n>" to get finer hunk granularity for -#<n>.
 
-# usage: stg-fold-files-from <patch> [-O <stg-show-flags>] [-#<n>[-<n>][,<n>]...] <file-pattern>
+# usage: stg-fold-files-from <patch> [-n] [-O <stg-show-flags>] [-#<n>[-<n>][,<n>]...] <file-pattern>
 
 # Copyright (c) 2006-2007 Yann Dirson <ydirson@altern.org>
 # Subject to the GNU GPL, version 2.
@@ -20,10 +20,12 @@ filtercmd=cat
 hunks=
 foldflags=
 showflags=()
+noact=0
 while [ "$#" -gt 0 ]; do
     case "$1" in
 	-\#*) hunks="$1" ;;
 	-t) foldflags="-t" ;;
+	-n) noact=1 ;;
 	-O) showflags+=(-O "$2"); shift ;;
 	-*) { echo >&2 "unknown flag '$1'"; exit 1; } ;;
 	*) break ;;
@@ -32,4 +34,13 @@ while [ "$#" -gt 0 ]; do
 done
 [ "$#" = 1 ] || { echo >&2 "supports one file only"; exit 1; }
 
-stg show "${showflags[@]}" "$PATCH" | filterdiff -p1 $hunks -i "$1" | stg fold $foldflags
+getpatch()
+{
+    stg show "${showflags[@]}" "$PATCH" | filterdiff -p1 $hunks -i "$1"
+}
+
+if [ $noact = 1 ]; then
+    getpatch "$1"
+else
+    getpatch "$1" | stg fold $foldflags
+fi
