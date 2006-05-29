From: Martin Waitz <tali@admingilde.org>
Subject: [RFC] git commit --branch
Date: Mon, 29 May 2006 22:28:55 +0200
Message-ID: <20060529202851.GE14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 22:29:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkoMI-0003eJ-EB
	for gcvg-git@gmane.org; Mon, 29 May 2006 22:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWE2U27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWE2U27
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 16:28:59 -0400
Received: from admingilde.org ([213.95.32.146]:37581 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751281AbWE2U26 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 16:28:58 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FkoMB-0004Wk-GU
	for git@vger.kernel.org; Mon, 29 May 2006 22:28:56 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20968>

Allow to commit to another branch and creating a merge in the current branch.

Sometimes it is neccessary to have some local modifications in the tree
in order to test it and work with it.  With this patch you can have
one working tree which combines several topic branches in order to
develop and test your changes.  When your changes are ready, you can
commit them to the appropriate topic branch.

With the --branch option, the commit will automatically be rebased to
that branch.  The original tree will then be commited to your working
branch as a merge.

---

Perhaps something like this can even be integrated into the extended
branch configuration which is currently under discussion.
It may make sense to have one branch which always contains a merge
of a selected set of other branches and having a default branch
for new commits.

 Documentation/git-commit.txt        |    6 +++
 git-commit.sh                       |   62 ++++++++++++++++++++++++++++++++++-
 t/t3800-commit-onto-other-branch.sh |   32 ++++++++++++++++++
 3 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 38df59c..8111ba4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -49,6 +49,12 @@ OPTIONS
 	Override the author name used in the commit.  Use
 	`A U Thor <author@example.com>` format.
 
+--branch <branch>::
+	Actually commit the changes to another branch.
+	Afterwards it will be merged into the current branch.
+	This is useful if you work on a branch with local modifications
+	but want to keep one clean branch without those.
+
 -m <msg>::
 	Use the given <msg> as the commit message.
 
diff --git a/git-commit.sh b/git-commit.sh
index 1983d45..9ed0050 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@ #
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>] [-u] [--amend] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>] [-u] [--amend] [-e] [--author <author>] [--branch <branch>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
@@ -245,6 +245,12 @@ do
       force_author="$1"
       shift
       ;;
+  -b|--b|--br|--bra|--bran|--branc|--branch)
+      case "$#" in 1) usage ;; esac
+      shift
+      onto_branch="$1"
+      shift
+      ;;
   -e|--e|--ed|--edi|--edit)
       no_edit=
       shift
@@ -405,6 +411,7 @@ t,,[1-9]*)
 	die "No paths with -i does not make sense." ;;
 esac
 
+
 ################################################################
 # Prepare index to have a tree to be committed
 
@@ -623,6 +630,32 @@ else
 	current=
 fi
 
+if test -n "$onto_branch"
+then
+	onto_branch_commit=$(git-rev-parse --verify "$onto_branch") ||
+		die "Branch $onto_branch does not exist."
+	test $(git merge-base "$onto_branch" HEAD) = $onto_branch_commit ||
+		die "Branch "$onto_branch" already contains unmerged commits."
+	case "$PARENTS" in
+	-p*-p*)	die "Cannot commit a merge to another branch." ;;
+	esac
+	if test $(git-rev-parse --verify HEAD) = $onto_branch_commit
+	then
+		# no merge neccessary, branches identically
+		forward_onto_branch="$onto_branch"
+		onto_branch=""
+	fi
+	if test "$amend" = t
+	then
+		# test that the tip of HEAD really came from the tip of
+		# $onto_branch and that we can amend both of them
+		test $(git merge-base "$onto_branch" HEAD^) != $onto_branch_commit &&
+		test $(git merge-base "$onto_branch"^ HEAD^) = $(git rev-parse --verify "$onto_branch"^) ||
+			die "commits on $onto_branch and HEAD differ, cannot amend."
+		onto_branch_commit=$(git rev-parse --verify "$onto_branch"^)
+	fi
+fi
+
 if test -z "$no_edit"
 then
 	{
@@ -689,8 +722,35 @@ then
 		tree=$(GIT_INDEX_FILE="$TMP_INDEX" git-write-tree) &&
 		rm -f "$TMP_INDEX"
 	fi &&
+	if test -n "$onto_branch"
+	then
+		# create temporary index
+		ONTO_INDEX="$GIT_DIR/onto-index"
+		cp "$USE_INDEX" "$ONTO_INDEX" &&
+		GIT_INDEX_FILE="$ONTO_INDEX" \
+		git-read-tree -i -m "$onto_branch_commit"
+		# merge new changes into the branch
+		GIT_INDEX_FILE="$ONTO_INDEX" \
+		git-read-tree -i --aggressive -m \
+			HEAD "$onto_branch_commit" "$tree" &&
+		GIT_INDEX_FILE="$ONTO_INDEX" \
+		git-merge-index git-merge-one-file -a || {
+			echo >&2 "Cannot rebase your commit to $onto_branch."
+			echo >&2 "Please merge and commit manually."
+			false
+		} &&
+		tree2=$(GIT_INDEX_FILE="$ONTO_INDEX" git-write-tree) &&
+		commit2=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree2 -p $onto_branch_commit) &&
+		git update-ref "$onto_branch" $commit2 &&
+		rm -f "$ONTO_INDEX" &&
+		PARENTS="$PARENTS -p $commit2"
+	fi &&
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
 	git-update-ref HEAD $commit $current &&
+	if test -n "$forward_onto_branch"
+	then
+		git-update-ref "$forward_onto_branch" $commit $current
+	fi &&
 	rm -f -- "$GIT_DIR/MERGE_HEAD" &&
 	if test -f "$NEXT_INDEX"
 	then
diff --git a/t/t3800-commit-onto-other-branch.sh b/t/t3800-commit-onto-other-branch.sh
new file mode 100755
index 0000000..f4f6410
--- /dev/null
+++ b/t/t3800-commit-onto-other-branch.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Martin Waitz
+#
+
+test_description='Test a commit to another branch'
+
+. ./test-lib.sh
+
+echo AAA > A
+echo BBB > B
+
+test_expect_success 'Initial commit' \
+'git add A B &&
+ git commit -m "Initial commit" &&
+ git branch topic'
+
+test_expect_success 'Modify HEAD' \
+'echo A2 > A &&
+ git commit -m "modify A" A'
+
+test_expect_success 'Commit to branch' \
+'echo B2 > B &&
+ git commit -m "modify B" --branch topic B'
+
+# now test that HEAD and topic only differs in A
+test_expect_success 'Verify trees' \
+'echo ":100644 100644 43d5a8e... 3ce238a... M	A" > expected &&
+ git diff-tree --abbrev topic HEAD > current &&
+ diff expected current'
+
+test_done
-- 
1.3.3.ged90


-- 
Martin Waitz
