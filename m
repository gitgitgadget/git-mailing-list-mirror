From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 6/8] Add contrib/stg-gitk: helper script to run gitk
Date: Fri, 02 Mar 2007 00:04:05 +0100
Message-ID: <20070301230405.32459.73120.stgit@gandelf.nowhere.earth>
References: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuK4-00047i-Oh
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbXCAXES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbXCAXER
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:04:17 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49941 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161216AbXCAXEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:04:15 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 93B993887;
	Fri,  2 Mar 2007 00:04:14 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 909B61F084;
	Fri,  2 Mar 2007 00:04:05 +0100 (CET)
In-Reply-To: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41149>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-gitk |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-gitk b/contrib/stg-gitk
new file mode 100755
index 0000000..dd01ef0
--- /dev/null
+++ b/contrib/stg-gitk
@@ -0,0 +1,61 @@
+#!/bin/sh
+set -e
+
+# stg-gitk - helper script to graphically display an StGIT stack
+
+# Displays given branches and stacks, without getting disturbed by
+# patch logs.
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
+	    refdirs="$refdirs $GIT_DIR/refs/heads/$b $GIT_DIR/refs/patches/$b"
+	elif [ -e "$GIT_DIR/refs/heads/$b" ]; then
+	    # other GIT branch
+	    refdirs="$refdirs $GIT_DIR/refs/heads/$b"
+	elif [ $(git-for-each-ref "refs/$b" | wc -l) != 0 ]; then
+	    # other ref
+	    refdirs="$refdirs $(git-for-each-ref --format="$GIT_DIR/%(refname)" "refs/$b")"
+	else
+	    echo >&2 "ERROR: no such ref '$b'"
+	    usage
+	fi
+    done
+fi
+
+gitk $(find $refdirs -type f -not -name '*.log' | cut -c${GIT_DIR_SPKIPLEN}- )
