From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 7/7] If available,
	use gitk --argscmd in contrib/stg-gitk.
Date: Mon, 25 Jun 2007 23:24:56 +0200
Message-ID: <20070625212456.17189.87831.stgit@gandelf.nowhere.earth>
References: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2w3e-0004vE-4n
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbXFYVZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbXFYVZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:25:09 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51377 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbXFYVZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:25:08 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E4ED95A1EB;
	Mon, 25 Jun 2007 23:25:06 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id DAF771F150;
	Mon, 25 Jun 2007 23:24:56 +0200 (CEST)
In-Reply-To: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50927>

This allows to ask gitk to recompute the list of patches to show at
every refresh.  Before this, we had problems with 'stg-gitk --all':

 - deleting a patch that was existing at startup time would trigger an
 "unknown ref" error from gitk and force to quit/restart manually;
 - patches created since startup were only visible when applied, or
 when below one of the startup patches.

Note that --argscmd is not in official gitk yet, so we don't try to
use it if it's not available.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-gitk |   36 +++++++++++++++++++++++++++++-------
 1 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/contrib/stg-gitk b/contrib/stg-gitk
index dd01ef0..6ddcfb1 100755
--- a/contrib/stg-gitk
+++ b/contrib/stg-gitk
@@ -7,7 +7,6 @@ set -e
 # patch logs.
 
 # LIMITATIONS:
-# - asking gitk to "update" won't detect any new ref
 # - no support for spaces in branch names
 
 # Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
@@ -20,11 +19,16 @@ usage()
 }
 
 allbranches=0
-case "$1" in
---all) allbranches=1; shift ;;
---*) usage ;;
-*) break ;;
-esac
+refsonly=0
+while [ "$#" -gt 0 ]; do
+    case "$1" in
+	--refs) refsonly=1 ;;
+	--all) allbranches=1 ;;
+	--*) usage ;;
+	*) break ;;
+    esac
+    shift
+done
 
 if [ $allbranches = 1 ] && [ "$#" -gt 0 ]; then
     usage
@@ -58,4 +62,22 @@ else
     done
 fi
 
-gitk $(find $refdirs -type f -not -name '*.log' | cut -c${GIT_DIR_SPKIPLEN}- )
+printrefs()
+{
+    find $refdirs -type f -not -name '*.log' | cut -c${GIT_DIR_SPKIPLEN}-
+}
+
+if [ $refsonly = 1 ]; then
+    printrefs
+elif grep -q -- --argscmd $(which gitk); then
+    # This gitk supports --argscmd.
+    # Let's use a hack to pass --all, which was consumed during command-line parsing
+    if [ $allbranches = 1 ]; then
+	gitk --argscmd="$0 --refs --all"
+    else
+	gitk --argscmd="$0 --refs $*"
+    fi
+else
+    # This gitk does not support --argscmd, just compute refs onces
+    gitk $(printrefs)
+fi
