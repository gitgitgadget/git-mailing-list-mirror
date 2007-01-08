From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Add contrib/stg-gitk: helper script to run gitk
Date: Mon, 08 Jan 2007 23:12:26 +0100
Message-ID: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 23:14:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H42l1-0001u3-01
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 23:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbXAHWOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 17:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbXAHWOQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 17:14:16 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:49041 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030190AbXAHWOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 17:14:15 -0500
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 10235779D74
	for <git@vger.kernel.org>; Mon,  8 Jan 2007 23:14:14 +0100 (CET)
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 9BDBD8916;
	Mon,  8 Jan 2007 23:13:12 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1H42jg-0003ce-5w; Mon, 08 Jan 2007 23:12:56 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36284>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

Here is a small helper script implementing the display of current/named/all
stgit stacks (or standard branches) in gitk.  As noted earlier, that does not
allow to see new refs by requesting an update from gitk, but it will still be
useful to me at least :)

 contrib/stg-gitk |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-gitk b/contrib/stg-gitk
new file mode 100755
index 0000000..8d4ae43
--- /dev/null
+++ b/contrib/stg-gitk
@@ -0,0 +1,59 @@
+#!/bin/sh
+set -e
+
+# stg-gitk - helper script to graphically display an StGIT stack
+
+# Allows quick synchronization of a cvs mirror branch (does not try to
+# reconstruct patchsets, creates "jumbo" commits), and commits stgit
+# patches to CVS.
+
+# LIMITATIONS:
+# - asking gitk to "update" won't detect any new ref
+# - no support for spaces in branch names
+
+# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+usage()
+{
+    echo "Usage: $(basename $0) [<branches>|--all]"
+    exit 1
+}
+
+allbranches=0
+case "$1" in
+--all) allbranches=1; shift ;;
+--*) usage ;;
+*) break ;;
+esac
+
+if [ $allbranches = 1 ] && [ "$#" -gt 0 ]; then
+    usage
+fi
+
+GIT_DIR=$(git-rev-parse --git-dir)
+GIT_DIR_SPKIPLEN=$(printf "$GIT_DIR/X" | wc -c)
+
+refdirs=''
+if [ $allbranches = 1 ]; then
+    refdirs="$GIT_DIR/refs"
+else
+    if [ "$#" = 0 ]; then
+	set -- "$(stg branch)"
+    fi
+
+    for b in "$@"; do
+	if [ -e "$GIT_DIR/refs/patches/$b" ]; then
+	    # StGIT branch: show all patches
+	    refdirs="$refdirs $GIT_DIR/refs/patches/$b"
+	elif [ -e "$GIT_DIR/refs/heads/$b" ]; then
+	    # other GIT branch
+	    refdirs="$refdirs $GIT_DIR/refs/heads/$b"
+	else
+	    echo >&2 "ERROR: no such branch '$b'"
+	    usage
+	fi
+    done
+fi
+
+gitk $(find $refdirs -type f -not -name '*.log' | cut -c${GIT_DIR_SPKIPLEN}- )
