From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] A utility to perform merges between Subversion branches using git
Date: Thu, 26 Apr 2007 17:55:28 -0700
Message-ID: <20070427005528.GA12688@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 02:56:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhEl8-0006Zo-SN
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 02:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbXD0Azf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 20:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbXD0Azf
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 20:55:35 -0400
Received: from tater.midwinter.com ([216.32.86.90]:59297 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755306AbXD0Az3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 20:55:29 -0400
Received: (qmail 12805 invoked by uid 1001); 27 Apr 2007 00:55:28 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45668>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 contrib/svn/README       |    8 +++
 contrib/svn/git-svnmerge |  139 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 contrib/svn/README
 create mode 100755 contrib/svn/git-svnmerge

diff --git a/contrib/svn/README b/contrib/svn/README
new file mode 100644
index 0000000..f3627ab
--- /dev/null
+++ b/contrib/svn/README
@@ -0,0 +1,8 @@
+This directory contains tools useful for a mixed git/Subversion environment.
+They will likely all depend on git-svnimport or git-svn, which are the main
+Subversion bridges in git.
+
+git-svnmerge
+	Use git to make up for svn's lack of merge tracking. This tool lets
+	you merge between Subversion branches in your git-svn repository.
+
diff --git a/contrib/svn/git-svnmerge b/contrib/svn/git-svnmerge
new file mode 100755
index 0000000..e7ed45d
--- /dev/null
+++ b/contrib/svn/git-svnmerge
@@ -0,0 +1,139 @@
+#!/bin/sh
+#
+# Handles svn merges using git-svn.
+#
+# Usage: git-svnmerge [-m commit-message] other-branch-name
+#
+# This script pulls the changes from another svn branch into the current branch
+# and checks the result into svn. Then it updates the grafts file so that the
+# merge is known to git. That means that subsequent runs of the script will
+# automatically know which changes to apply.
+#
+# The user is assumed to have already updated the repository using git-svn.
+#
+# Exit codes:
+#   0 Merge successfully committed to svn.
+#   1 Merge has conflicts that need to be resolved.
+#   2 Encountered an error.
+#
+# Author: Steven Grimm <koreth@midwinter.com>
+#
+
+die() {
+	echo "$@" 1>&2
+	exit 2
+}
+
+store_status() {
+	echo $Status $OldHead $RevToMerge $CommitMessage > "$StatusFile"
+}
+
+while test $# -gt 1; do
+	case "$1" in
+		-m)
+			shift
+			CommitMessage="$1"
+			shift
+			;;
+		*)
+			die "Unknown argument $1"
+	esac
+done
+
+if test $# -lt 1; then
+	die "Usage: $0 [-m commit-message] other-branch-name"
+fi
+
+GitDir="`git rev-parse --git-dir`"
+if test -z "$GitDir"; then
+	die "Not a git repository."
+fi
+StatusFile="$GitDir/svnmerge-status"
+
+# We might be resuming a previous run, so get the old state if any.
+Status="start"
+if test -f "$StatusFile"; then
+	read Status OldHead RevToMerge CommitMessage < "$StatusFile"
+fi
+
+if test "$Status" = "start"; then
+	# Make sure there aren't uncommitted (to svn) changes here.
+	if test -n "`git svn dcommit -n`"; then
+		die "Can't merge to dirty branch"
+	fi
+
+	# Record the revisions we're merging. We'll use them in the
+	# grafts file later.
+	OldHead="`git rev-list --max-count=1 HEAD`"
+	RevToMerge="`git rev-list --max-count=1 $1`"
+	if test -z "$RevToMerge"; then
+		die "Can't merge nonexistent branch."
+	fi
+
+	# Do the actual merge.
+	git merge --squash "$RevToMerge" || \
+		MergeFailed=1
+
+	# Did we actually merge anything?
+	if git status > /dev/null; then
+		:
+	else
+		echo "No changes to merge. Have you fetched from svn?"
+		exit 0
+	fi
+
+	Status=merged
+	store_status
+
+	# If there are conflicts, bail out.
+	if test -n "$MergeFailed`git ls-files -u`"; then
+		echo "Please resolve conflicts and run again to continue."
+		exit 1
+	fi
+fi
+
+if test "$Status" = "merged"; then
+	if test -n "`git ls-files -u`"; then
+		echo "There are still conflicts; can't continue."
+		exit 1
+	fi
+
+	SvnRevision="`git log --pretty=format:%b -n 1 $RevToMerge | \
+			egrep '^git-svn-id:' | \
+			sed 's:.*/\([^/]*\)@\([0-9]*\) [0-9a-f].*:\1 revision \2:'`"
+	echo "$SvnRevision merged. Committing."
+
+	if test -z "$CommitMessage"; then
+		CommitMessage="Merge from $SvnRevision"
+	fi
+
+	git commit -m "$CommitMessage" || \
+		die "Commit failed"
+
+	Status=committed
+	store_status
+fi
+
+# Since git-svn dcommit can fail for reasons having nothing to do with the
+# local repository (e.g. the svn server is down), we allow the user to retry
+# the dcommit by running this command again.
+if test "$Status" = "committed"; then
+	git svn dcommit || \
+		die "Can't commit to Subversion"
+
+	# dcommit will update our current HEAD to point to the newly committed
+	# svn revision. Update grafts file to tell git that it's a merge.
+	NewRevision="`git rev-list --max-count=1 HEAD`"
+	echo "$NewRevision $OldHead $RevToMerge" >> $GitDir/info/grafts
+
+	rm "$StatusFile"
+	echo "Successfully merged $SvnRevision."
+
+	Status=""
+fi
+
+if test -n "$Status"; then
+	die "Unknown status $Status in status file!"
+fi
+
+exit 0
-- 
1.5.2.rc0.35.gf41c8
