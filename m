From: Thomas Rast <trast@student.ethz.ch>
Subject: rebase: learn to rebase root commit
Date: Mon, 29 Dec 2008 17:45:45 +0100
Message-ID: <e8008f8e16a28c83a4fc6984966c91733b138598.1230569041.git.trast@student.ethz.ch>
References: <cover.1230568082.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 17:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHLGz-00063I-Q3
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 17:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbYL2QqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 11:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYL2Qp7
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 11:45:59 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:1411 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbYL2Qpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 11:45:55 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 17:45:52 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 17:45:52 +0100
X-Mailer: git-send-email 1.6.1.1.g4c1d9.dirty
In-Reply-To: <cover.1230568082.git.trast@student.ethz.ch>
In-Reply-To: <cover.1230569041.git.trast@student.ethz.ch>
References: <cover.1230569041.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 29 Dec 2008 16:45:52.0551 (UTC) FILETIME=[E9567370:01C969D4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104114>

Teach git-rebase a new option --root, which instructs it to rebase the
entire history leading up to <branch>.

The main use-case is with git-svn: suppose you start hacking (perhaps
offline) on a new project, but later notice you want to commit this
work to SVN.  You will have to rebase the entire history, including
the root commit, on a (possibly empty) commit coming from git-svn, to
establish a history connection.  This previously had to be done by
cherry-picking the root commit manually.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-rebase.sh          |   51 ++++++++++++++++++++++++++++++++--------------
 t/t3412-rebase-root.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 16 deletions(-)
 create mode 100755 t/t3412-rebase-root.sh

diff --git a/git-rebase.sh b/git-rebase.sh
index ebd4df3..89de3c4 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
+USAGE='[--interactive | -i] [-v] [--onto <newbase>] [<upstream>|--root] [<branch>]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -47,6 +47,7 @@ dotest="$GIT_DIR"/rebase-merge
 prec=4
 verbose=
 git_am_opt=
+rebase_root=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -297,6 +298,9 @@ do
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
+	--root)
+		rebase_root=t
+		;;
 	-*)
 		usage
 		;;
@@ -344,17 +348,23 @@ case "$diff" in
 	;;
 esac
 
+if test -z "$rebase_root"; then
 # The upstream head must be given.  Make sure it is valid.
-upstream_name="$1"
-upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-    die "invalid upstream $upstream_name"
+	upstream_name="$1"
+	shift
+	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+	die "invalid upstream $upstream_name"
+fi
+
+test ! -z "$rebase_root" -a -z "$newbase" &&
+	die "--root must be used with --onto"
 
 # Make sure the branch to rebase onto is valid.
 onto_name=${newbase-"$upstream_name"}
 onto=$(git rev-parse --verify "${onto_name}^0") || exit
 
 # If a hook exists, give it a chance to interrupt
-run_pre_rebase_hook ${1+"$@"}
+run_pre_rebase_hook ${upstream_name+"$upstream_name"} "$@"
 
 # If the branch to rebase is given, that is the branch we will rebase
 # $branch_name -- branch being rebased, or HEAD (already detached)
@@ -362,16 +372,16 @@ run_pre_rebase_hook ${1+"$@"}
 # $head_name -- refs/heads/<that-branch> or "detached HEAD"
 switch_to=
 case "$#" in
-2)
+1)
 	# Is it "rebase other $branchname" or "rebase other $commit"?
-	branch_name="$2"
-	switch_to="$2"
+	branch_name="$1"
+	switch_to="$1"
 
-	if git show-ref --verify --quiet -- "refs/heads/$2" &&
-	   branch=$(git rev-parse -q --verify "refs/heads/$2")
+	if git show-ref --verify --quiet -- "refs/heads/$1" &&
+	   branch=$(git rev-parse -q --verify "refs/heads/$1")
 	then
-		head_name="refs/heads/$2"
-	elif branch=$(git rev-parse -q --verify "$2")
+		head_name="refs/heads/$1"
+	elif branch=$(git rev-parse -q --verify "$1")
 	then
 		head_name="detached HEAD"
 	else
@@ -393,7 +403,8 @@ case "$#" in
 esac
 orig_head=$branch
 
-# Now we are rebasing commits $upstream..$branch on top of $onto
+# Now we are rebasing commits $upstream..$branch (or simply $branch
+# with --root) on top of $onto
 
 # Check if we are already based on $onto with linear history,
 # but this should be done only when upstream and onto are the same.
@@ -429,10 +440,18 @@ then
 	exit 0
 fi
 
+if test ! -z "$rebase_root"; then
+	revisions="$orig_head"
+	fp_flag="--root"
+else
+	revisions="$upstream..$orig_head"
+	fp_flag="--ignore-if-in-upstream"
+fi
+
 if test -z "$do_merge"
 then
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		"$upstream..$orig_head" |
+	git format-patch -k --stdout --full-index "$fp_flag" \
+		"$revisions" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
@@ -455,7 +474,7 @@ echo "$orig_head" > "$dotest/orig-head"
 echo "$head_name" > "$dotest/head-name"
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$upstream..$orig_head"`
+for cmt in `git rev-list --reverse --no-merges "$revisions"`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
new file mode 100755
index 0000000..63ec5e6
--- /dev/null
+++ b/t/t3412-rebase-root.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='git rebase --root
+
+Tests if git rebase --root --onto <newparent> can rebase the root commit.
+'
+. ./test-lib.sh
+
+test_expect_success 'prepare repository' '
+	echo 1 > A &&
+	git add A &&
+	git commit -m 1 &&
+	echo 2 > A &&
+	git add A &&
+	git commit -m 2 &&
+	git symbolic-ref HEAD refs/heads/other &&
+	rm .git/index &&
+	rm A &&
+	echo 3 > B &&
+	git add B &&
+	git commit -m 3 &&
+	echo 4 > B &&
+	git add B &&
+	git commit -m 4
+'
+
+test_expect_success 'rebase --root expects --onto' '
+	test_must_fail git rebase --root
+'
+
+cat > expect <<EOF
+4
+3
+2
+1
+EOF
+
+test_expect_success 'rebase --root --onto <newbase>' '
+	git checkout -b work &&
+	git rebase --root --onto master &&
+	git log --pretty=tformat:"%s" > rebased &&
+	test_cmp expect rebased
+'
+
+test_expect_success 'rebase --root --onto <newbase> <branch>' '
+	git branch work2 other &&
+	git rebase --root --onto master work2 &&
+	git log --pretty=tformat:"%s" > rebased2 &&
+	test_cmp expect rebased2
+'
+
+test_done
-- 
1.6.1.1.g4c1d9.dirty
