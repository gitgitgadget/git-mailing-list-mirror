From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH not for master] Use gitk --argscmd in contrib/stg-gitk.
Date: Mon, 04 Jun 2007 00:52:06 +0200
Message-ID: <20070603225017.30044.16832.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:52:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huyvo-0003WL-EO
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXFCWwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 18:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbXFCWwJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:52:09 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:38214 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbXFCWwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 18:52:08 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D98995A13E;
	Mon,  4 Jun 2007 00:52:05 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id BBB5D1F019;
	Mon,  4 Jun 2007 00:52:06 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49046>


This allows to ask gitk to recompute the list of patches to show at
every refresh.  Before this, we had problems with 'stg-gitk --all':

 - deleting a patch that was existing at startup time would trigger an
 "unknown ref" error from gitk and force to quit/restart manually;
 - patches created since startup were only visible when applied, or
 when below one of the startup patches.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

Note that this flag is added by the gitk patch I just posted, so it
should not be applied to StGIT master right now - we want that git
gets released with the necessary support before we do that.

 contrib/stg-gitk |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/contrib/stg-gitk b/contrib/stg-gitk
index dd01ef0..f2fca84 100755
--- a/contrib/stg-gitk
+++ b/contrib/stg-gitk
@@ -20,11 +20,16 @@ usage()
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
@@ -58,4 +63,13 @@ else
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
+    gitk --argscmd="$0 --refs $@"
+fi
