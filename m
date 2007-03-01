From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/8] Add contrib/stg-cvs: helper script to manage a mixed
	cvs/stgit working copy
Date: Fri, 02 Mar 2007 00:04:00 +0100
Message-ID: <20070301230400.32459.69204.stgit@gandelf.nowhere.earth>
References: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuJs-00041v-Eb
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbXCAXEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbXCAXEN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:04:13 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49913 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161215AbXCAXEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:04:11 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 803D43887;
	Fri,  2 Mar 2007 00:04:09 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 74C0E1F084;
	Fri,  2 Mar 2007 00:04:00 +0100 (CET)
In-Reply-To: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41147>


This is an early prototype only, use with care, and be sure to read the
LIMITATIONS section in the script comments.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-cvs |  171 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 171 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-cvs b/contrib/stg-cvs
new file mode 100755
index 0000000..7b968d6
--- /dev/null
+++ b/contrib/stg-cvs
@@ -0,0 +1,171 @@
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
+# NOTES
+# - you want to add a "CVS" line to .git/info/exclude
+# - you may want to add a ".git" line to the top .cvsignore
+
+# LIMITATIONS
+# - this is only a proof-of-concept prototype
+# - lacks an "init" command
+# - "commit" does not ensure the base is uptodate before trying to
+#   commit (but hey, it's CVS ;)
+# - "commit" can only commit a single patch
+# - not much robustness here
+# - still bad support for files removed in cvs (should catch "no
+#   longer in the repository" message)
+# - while fetching, if a file change was not git-update-index'd when
+#   cvs-update'd (eg. because of a stg-cvs bug), it is not seen on further
+#   fetches until it changes again, since we scan "cvs update" output.
+#   This yields possible inconsistencies with CVS.
+# - similarly, any conflict while cvs-updating (whether due to illegal
+#   changes to the cvs-mirror-branch, or due to files added to cvs but
+#   already-existing in working copy, or to directory moves inside the
+#   cvs repository, or <fill here>) has to be dealt with by hand (although
+#   the situation is better here: cvs sees the conflict on subsequent tries)
+# - this only deals with CVS but could surely be extended to any other
+#   VCS
+# - bad/no support for cvsutils:
+#   - stg push/pop operations confuse cvsu because of timestamp changes
+#   - cvspurge/cvsco would nuke .git => does not make it easy to ensure
+#     synchronisation
+# - should use a separate workspace for cvs branch like tailor does
+# - lacks synchronisation of .cvsignore <-> .gitignore
+# - no support for filenames with spaces (stg lacks --zero output format)
+# - git-commit is too chatty when it finds nothing to commit
+# - lacks a "quick cvs commit" feature
+# - confused by cvs keyword substitution
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
+    stg branch "$parent" || exit $?
+    cvs -fq update -dP | grep -v '^\? ' | tee /dev/tty | while read status path; do
+	if [ -e "$path" ]; then
+	    git update-index --add "$path" || exit $?
+	else
+	    git update-index --remove "$path" || exit $?
+	fi
+	# cvs update: `FELIN1_PEP/src/java/com/sagem/felin/ui/widget/PEPRifStateIcon.java' is no longer in the repository
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
+    stg branch "$branch" || exit $?
+
+    return $return
+}
+
+cvs_add_dir()
+{
+    local parent=$(dirname "$1")
+    if [ ! -e "$parent/CVS" ]; then
+	cvs_add_dir "$parent"
+    fi
+
+    cvs add "$1"
+}
+
+# get context
+branch=$(stg branch)
+parent=$(git-repo-config "branch.${branch}.merge") || 
+    usage "no declared parent for '$branch' - set branch.${branch}.merge"
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
+	#  --merged
+	stg rebase "$parent"
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
+    # adds
+    stg files | grep ^A | cut -c3- | while read file; do
+	parent=$(dirname "$file")
+	if [ ! -e "$parent/CVS" ]; then
+	    cvs_add_dir "$parent"
+	fi
+	cvs -f add "$file"
+    done
+
+    # removes
+    stg files | grep ^D | cut -c3- | xargs -r cvs -f remove
+
+    # commit
+    stg files --bare | xargs -r cvs -fq commit \
+	-F ".git/patches/$branch/patches/$patch/description"
+
+    # sync the parent branch
+    stg branch "$parent"
+    git-cherry-pick "patches/${branch}/${patch}"
+    stg branch "${branch}"
+
+    # update
+    # --merged
+    stg rebase "$parent"
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
