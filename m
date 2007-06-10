From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH not for master,
	v2] Use gitk --argscmd in contrib/stg-gitk.
Date: Sun, 10 Jun 2007 23:40:02 +0200
Message-ID: <20070610213717.11427.26780.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:40:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxV8m-0006Vh-MR
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbXFJVj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755617AbXFJVj6
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:39:58 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:34616 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465AbXFJVj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:39:58 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DE6895A153;
	Sun, 10 Jun 2007 23:39:56 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 4C1BC1F08A;
	Sun, 10 Jun 2007 23:40:02 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49773>

This allows to ask gitk to recompute the list of patches to show at
every refresh.  Before this, we had problems with 'stg-gitk --all':

 - deleting a patch that was existing at startup time would trigger an
 "unknown ref" error from gitk and force to quit/restart manually;
 - patches created since startup were only visible when applied, or
 when below one of the startup patches.
---

This version fixes a couple of glitches when using stg-gitk to display
several branches simultaneously, introduced by the 1st version.  This
is a sure sign that this script should be pythonized soon :)

Still not to apply to master, since the gitk patch it depends has not
been applied.

 contrib/stg-gitk |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/contrib/stg-gitk b/contrib/stg-gitk
index dd01ef0..c258caf 100755
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
@@ -58,4 +62,18 @@ else
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
+else
+    # let's use a hack to pass --all, which was consumed during command-line parsing
+    if [ $allbranches = 1 ]; then
+	gitk --argscmd="$0 --refs --all"
+    else
+	gitk --argscmd="$0 --refs $*"
+    fi
+fi
