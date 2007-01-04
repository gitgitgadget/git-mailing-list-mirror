From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/5] Add contrib/stg-cvs: helper script to manage a mixed cvs/stgit working copy
Date: Fri, 05 Jan 2007 00:47:03 +0100
Message-ID: <20070104234703.13580.3781.stgit@gandelf.nowhere.earth>
References: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 00:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2cJk-0004Jk-S1
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 00:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbXADXsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 18:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbXADXsK
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 18:48:10 -0500
Received: from postfix2-g20.free.fr ([212.27.60.43]:53982 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030293AbXADXsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 18:48:08 -0500
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 8DE75898684
	for <git@vger.kernel.org>; Thu,  4 Jan 2007 23:48:12 +0100 (CET)
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BF0B049FF6;
	Fri,  5 Jan 2007 00:47:05 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1H2cIj-0001lE-MC; Fri, 05 Jan 2007 00:47:13 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35964>


This is an early prototype only, use with care, and be sure to read the
LIMITATIONS section in the script comments.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-cvs |  126 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-cvs b/contrib/stg-cvs
new file mode 100755
index 0000000..ee3e7fa
--- /dev/null
+++ b/contrib/stg-cvs
@@ -0,0 +1,126 @@
+#!/bin/bash
+set -e
+
+# stg-cvs - helper script to manage a mixed cvs/stgit working copy.
+
+# Allows quick synchronization of a cvs mirror branch (does not try to
+# reconstruct patchsets, creates "jumbo" commits), and commits stgit
+# patches to CVS.
+
+# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+# LIMITATIONS
+# - this is only a proof-of-concept prototype
+# - lacks an "init" command
+# - "commit" does not "cvs add/remove" any file or dir
+# - "commit" does not ensure the base is uptodate before trying to
+#   commit (but hey, it's CVS ;)
+# - "commit" can only commit a single patch
+# - not much robustness here
+# - this only deals with CVS but could surely be extended to any other
+#   VCS
+# - stg push/pop operations confuse cvsutils because of timestamp
+#   changes
+# - lacks synchronisation of .cvsignore <-> .gitignore
+
+usage()
+{
+    [ "$#" = 0 ] || echo "ERROR: $*"
+    echo "Usage: $(basename $0) <command>"
+    echo " commands: $(do_commands)"
+    exit 1
+}
+
+do_commands()
+{
+    echo $(grep '^[a-z-]*)' $0 | cut -d')' -f1)
+}
+
+do_fetch()
+{
+    local return=0
+    local path
+
+    local parent="$1"
+    local branch="$2"
+
+    # record changes from cvs into index
+    stg branch "$parent"
+    cvs -fq update -dP | grep -v '^\? ' | tee /dev/tty | while read status path; do
+	if [ -e "$path" ]; then
+	    git update-index "$path"
+	else
+	    git rm "$path"
+	fi
+    done
+
+    # create commit
+    if git commit -m "stg-cvs sync"; then
+	:
+    else
+	return=$?
+    fi
+
+    # back to branch
+    stg branch "$branch"
+
+    return $return
+}
+
+# get context
+branch=$(stg branch)
+parent=$(git-repo-config "stgit.yd.${branch}.parent") || 
+    usage "no declared parent for '$branch' - set stgit.yd.${branch}.parent"
+
+# extract command
+
+[ "$#" -ge 1 ] || usage
+command="$1"
+shift
+
+case "$command" in
+fetch)
+    do_fetch "$parent" "$branch"
+    ;;
+
+pull)
+    if do_fetch "$parent" "$branch"; then
+	# update
+	stg pull --merged . "$parent"
+	stg clean --applied
+    fi
+    ;;
+
+commit)
+    # sanity asserts
+    [ $(stg applied | wc -l) = 1 ] ||
+	usage "you don't have exactly one patch applied"
+
+    # context
+    patch=$(stg top)
+    
+    # commit
+    cvs -fq commit \
+	-F ".git/patches/$branch/patches/$patch/description" \
+	$(stg files --bare)
+
+    # sync the parent branch
+    stg branch "$parent"
+    git-cherry-pick "patches/${branch}/${patch}"
+    stg branch "${branch}"
+
+    # update
+    stg pull --merged . "$parent"
+    stg clean --applied
+    ;;
+
+_commands)
+    # hint for bash-completion people :)
+    do_commands
+    ;;
+
+*)
+    usage "unknown command '$command'"
+    ;;
+esac
