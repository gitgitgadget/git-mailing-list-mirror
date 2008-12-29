From: Thomas Rast <trast@student.ethz.ch>
Subject: rebase -i: learn to rebase root commit
Date: Mon, 29 Dec 2008 17:45:46 +0100
Message-ID: <5d0be6d15bbdaa8b95c1df161b67ecd4120d7ce4.1230569041.git.trast@student.ethz.ch>
References: <cover.1230568082.git.trast@student.ethz.ch>
 <e8008f8e16a28c83a4fc6984966c91733b138598.1230569041.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 17:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHLGz-00063I-1q
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 17:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbYL2Qp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 11:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYL2Qp5
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 11:45:57 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14401 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbYL2Qpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 11:45:55 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 17:45:53 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 29 Dec 2008 17:45:52 +0100
X-Mailer: git-send-email 1.6.1.1.g4c1d9.dirty
In-Reply-To: <e8008f8e16a28c83a4fc6984966c91733b138598.1230569041.git.trast@student.ethz.ch>
In-Reply-To: <cover.1230569041.git.trast@student.ethz.ch>
References: <cover.1230569041.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 29 Dec 2008 16:45:52.0911 (UTC) FILETIME=[E98D61F0:01C969D4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104111>

Teach git-rebase -i a new option --root, which instructs it to rebase
the entire history leading up to <branch>.  This is mainly for
symmetry with ordinary git-rebase; it cannot be used to edit the root
commit in-place (it requires --onto).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-rebase--interactive.sh |   53 +++++++++++++++++++++++++++++++++----------
 t/t3412-rebase-root.sh     |   14 +++++++++++
 2 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c8b0861..f29b5ee 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -27,6 +27,7 @@ continue           continue rebasing process
 abort              abort rebasing process and restore original branch
 skip               skip current patch and continue rebasing process
 no-verify          override pre-rebase hook from stopping the operation
+root               rebase all reachable commmits up to the root(s)
 "
 
 . git-sh-setup
@@ -44,6 +45,7 @@ STRATEGY=
 ONTO=
 VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
+REBASE_ROOT=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -154,6 +156,11 @@ pick_one () {
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
+	if test ! -z "$REBASE_ROOT"
+	then
+		output git cherry-pick "$@"
+		return
+	fi
 	parent_sha1=$(git rev-parse --verify $sha1^) ||
 		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
@@ -443,6 +450,7 @@ get_saved_options () {
 	test -d "$REWRITTEN" && PRESERVE_MERGES=t
 	test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 	test -f "$DOTEST"/verbose && VERBOSE=t
+	test ! -s "$DOTEST"/upstream && REBASE_ROOT=t
 }
 
 while test $# != 0
@@ -547,6 +555,9 @@ first and then run 'git rebase --continue' again."
 	-i)
 		# yeah, we know
 		;;
+	--root)
+		REBASE_ROOT=t
+		;;
 	--onto)
 		shift
 		ONTO=$(git rev-parse --verify "$1") ||
@@ -555,7 +566,7 @@ first and then run 'git rebase --continue' again."
 	--)
 		shift
 		run_pre_rebase_hook ${1+"$@"}
-		test $# -eq 1 -o $# -eq 2 || usage
+		test ! -z "$REBASE_ROOT" -o $# -eq 1 -o $# -eq 2 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
 
@@ -566,15 +577,22 @@ first and then run 'git rebase --continue' again."
 
 		require_clean_work_tree
 
-		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
-		test -z "$ONTO" && ONTO=$UPSTREAM
+		if test -z "$REBASE_ROOT"
+		then
+			UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
+			test -z "$ONTO" && ONTO=$UPSTREAM
+			shift
+		else
+			test -z "$ONTO" &&
+				die "You must specify --onto when using --root"
+		fi
 
-		if test ! -z "$2"
+		if test ! -z "$1"
 		then
-			output git show-ref --verify --quiet "refs/heads/$2" ||
-				die "Invalid branchname: $2"
-			output git checkout "$2" ||
-				die "Could not checkout $2"
+			output git show-ref --verify --quiet "refs/heads/$1" ||
+				die "Invalid branchname: $1"
+			output git checkout "$1" ||
+				die "Could not checkout $1"
 		fi
 
 		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
@@ -613,12 +631,21 @@ first and then run 'git rebase --continue' again."
 			MERGES_OPTION="--no-merges --cherry-pick"
 		fi
 
-		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
 		SHORTHEAD=$(git rev-parse --short $HEAD)
 		SHORTONTO=$(git rev-parse --short $ONTO)
+		if test -z "$REBASE_ROOT"
+			# this is now equivalent to ! -z "$UPSTREAM"
+		then
+			SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
+			REVISIONS=$UPSTREAM...$HEAD
+			SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
+		else
+			REVISIONS=$HEAD
+			SHORTREVISIONS=$SHORTHEAD
+		fi
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
-			$UPSTREAM...$HEAD | \
+			$REVISIONS | \
 			sed -n "s/^>//p" | while read shortsha1 rest
 		do
 			if test t != "$PRESERVE_MERGES"
@@ -647,11 +674,11 @@ first and then run 'git rebase --continue' again."
 		then
 			mkdir "$DROPPED"
 			# Save all non-cherry-picked changes
-			git rev-list $UPSTREAM...$HEAD --left-right --cherry-pick | \
+			git rev-list $REVISIONS --left-right --cherry-pick | \
 				sed -n "s/^>//p" > "$DOTEST"/not-cherry-picks
 			# Now all commits and note which ones are missing in
 			# not-cherry-picks and hence being dropped
-			git rev-list $UPSTREAM..$HEAD |
+			git rev-list $REVISIONS |
 			while read rev
 			do
 				if test -f "$REWRITTEN"/$rev -a "$(grep "$rev" "$DOTEST"/not-cherry-picks)" = ""
@@ -670,7 +697,7 @@ first and then run 'git rebase --continue' again."
 		test -s "$TODO" || echo noop >> "$TODO"
 		cat >> "$TODO" << EOF
 
-# Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
+# Rebase $SHORTREVISIONS onto $SHORTONTO
 #
 # Commands:
 #  p, pick = use commit
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 63ec5e6..bb44a52 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -49,4 +49,18 @@ test_expect_success 'rebase --root --onto <newbase> <branch>' '
 	test_cmp expect rebased2
 '
 
+test_expect_success 'rebase -i --root --onto <newbase>' '
+	git checkout -b work3 other &&
+	GIT_EDITOR=: git rebase -i --root --onto master &&
+	git log --pretty=tformat:"%s" > rebased3 &&
+	test_cmp expect rebased3
+'
+
+test_expect_success 'rebase -i --root --onto <newbase> <branch>' '
+	git branch work4 other &&
+	GIT_EDITOR=: git rebase -i --root --onto master work4 &&
+	git log --pretty=tformat:"%s" > rebased4 &&
+	test_cmp expect rebased4
+'
+
 test_done
-- 
1.6.1.1.g4c1d9.dirty
