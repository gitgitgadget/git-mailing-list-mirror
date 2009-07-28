From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 5/5] Implement 'git stash save --patch'
Date: Tue, 28 Jul 2009 23:20:11 +0200
Message-ID: <fab366a3117f00e8987dc0bdb2be80729f13cd8f.1248815580.git.trast@student.ethz.ch>
References: <200907271210.40001.trast@student.ethz.ch> <cover.1248815580.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 23:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVu6I-0001P2-CH
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 23:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095AbZG1VUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 17:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbZG1VUa
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 17:20:30 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28959 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728AbZG1VUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 17:20:25 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 23:20:23 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 23:20:22 +0200
X-Mailer: git-send-email 1.6.4.rc3.215.gd714f
In-Reply-To: <cover.1248815580.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 28 Jul 2009 21:20:22.0735 (UTC) FILETIME=[377E55F0:01CA0FC9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124277>

This adds a hunk-based mode to git-stash.  You can select hunks from
the difference between HEAD and worktree, and git-stash will build a
stash that reflects these changes.  The index state of the stash is
the same as your current index, and we also let --patch imply
--keep-index.

Note that because the selected hunks are rolled back from the worktree
but not the index, the resulting state may appear somewhat confusing
if you had also staged these changes.  This is not entirely
satisfactory, but due to the way stashes are applied, other solutions
would require a change to the stash format.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-stash.txt |   14 ++++++-
 git-add--interactive.perl   |   13 ++++++-
 git-stash.sh                |   80 +++++++++++++++++++++++++++++++++++-------
 t/t3904-stash-patch.sh      |   66 +++++++++++++++++++++++++++++++++++
 4 files changed, 155 insertions(+), 18 deletions(-)
 create mode 100755 t/t3904-stash-patch.sh

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1c64a02..4b15459 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--keep-index] [-q|--quiet] [<message>]]
+'git stash' [save [--patch] [--[no-]keep-index] [-q|--quiet] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -42,7 +42,7 @@ is also possible).
 OPTIONS
 -------
 
-save [--keep-index] [-q|--quiet] [<message>]::
+save [--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  This is the default action when no
@@ -51,6 +51,16 @@ save [--keep-index] [-q|--quiet] [<message>]::
 +
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
++
+With `--patch`, you can interactively select hunks from in the diff
+between HEAD and the working tree to be stashed.  The stash entry is
+constructed such that its index state is the same as the index state
+of your repository, and its worktree contains only the changes you
+selected interactively.  The selected changes are then rolled back
+from your worktree.
++
+The `--patch` option implies `--keep-index`.  You can use
+`--no-keep-index` to override this.
 
 list [<options>]::
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index bb76c37..91f1657 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -76,6 +76,7 @@
 
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
+sub apply_patch_for_stash;
 
 my %patch_modes = (
 	'stage' => {
@@ -86,6 +87,14 @@
 		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
 	},
+	'stash' => {
+		DIFF => 'diff-index -p HEAD',
+		APPLY => sub { apply_patch 'apply --cached', @_; },
+		APPLY_CHECK => 'apply --cached',
+		VERB => 'Stash',
+		PARTICIPLE => 'stashing',
+		FILTER => undef,
+	},
 	'reset' => {
 		DIFF => 'diff-index -p --cached',
 		APPLY => sub { apply_patch 'apply -R --cached', @_; },
@@ -1465,8 +1474,8 @@
 					$patch_mode_revision = $arg;
 					$arg = shift @ARGV or die "missing --";
 				}
-			} elsif ($1 eq 'stage') {
-				$patch_mode = 'stage';
+			} elsif ($1 eq 'stage' or $1 eq 'stash') {
+				$patch_mode = $1;
 				$arg = shift @ARGV or die "missing --";
 			} else {
 				die "unknown --patch mode: $1";
diff --git a/git-stash.sh b/git-stash.sh
index 03e589f..567aa5d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -21,6 +21,14 @@ trap 'rm -f "$TMP-*"' 0
 
 ref_stash=refs/stash
 
+if git config --get-colorbool color.interactive; then
+       help_color="$(git config --get-color color.interactive.help 'red bold')"
+       reset_color="$(git config --get-color '' reset)"
+else
+       help_color=
+       reset_color=
+fi
+
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
 	git diff-files --quiet --ignore-submodules
@@ -68,19 +76,44 @@ create_stash () {
 		git commit-tree $i_tree -p $b_commit) ||
 		die "Cannot save the current index state"
 
-	# state of the working tree
-	w_tree=$( (
+	if test -z "$patch_mode"
+	then
+
+		# state of the working tree
+		w_tree=$( (
+			rm -f "$TMP-index" &&
+			cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
+			GIT_INDEX_FILE="$TMP-index" &&
+			export GIT_INDEX_FILE &&
+			git read-tree -m $i_tree &&
+			git add -u &&
+			git write-tree &&
+			rm -f "$TMP-index"
+		) ) ||
+			die "Cannot save the current worktree state"
+
+	else
+
 		rm -f "$TMP-index" &&
-		cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
-		GIT_INDEX_FILE="$TMP-index" &&
-		export GIT_INDEX_FILE &&
-		git read-tree -m $i_tree &&
-		git add -u &&
-		git write-tree &&
-		rm -f "$TMP-index"
-	) ) ||
+		GIT_INDEX_FILE="$TMP-index" git read-tree HEAD &&
+
+		# find out what the user wants
+		GIT_INDEX_FILE="$TMP-index" \
+			git add--interactive --patch=stash -- &&
+
+		# state of the working tree
+		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
 		die "Cannot save the current worktree state"
 
+		git diff-tree -p HEAD $w_tree > "$TMP-patch" &&
+		test -s "$TMP-patch" ||
+		die "No changes selected"
+
+		rm -f "$TMP-index" ||
+		die "Cannot remove temporary index (can't happen)"
+
+	fi
+
 	# create the stash
 	if test -z "$stash_msg"
 	then
@@ -95,12 +128,20 @@ create_stash () {
 
 save_stash () {
 	keep_index=
+	patch_mode=
 	while test $# != 0
 	do
 		case "$1" in
 		--keep-index)
 			keep_index=t
 			;;
+		--no-keep-index)
+			keep_index=
+			;;
+		-p|--patch)
+			patch_mode=t
+			keep_index=t
+			;;
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
@@ -131,11 +172,22 @@ save_stash () {
 		die "Cannot save the current status"
 	say Saved working directory and index state "$stash_msg"
 
-	git reset --hard ${GIT_QUIET:+-q}
-
-	if test -n "$keep_index" && test -n $i_tree
+	if test -z "$patch_mode"
 	then
-		git read-tree --reset -u $i_tree
+		git reset --hard ${GIT_QUIET:+-q}
+
+		if test -n "$keep_index" && test -n $i_tree
+		then
+			git read-tree --reset -u $i_tree
+		fi
+	else
+		git apply -R < "$TMP-patch" ||
+		die "Cannot remove worktree changes"
+
+		if test -z "$keep_index"
+		then
+			git reset
+		fi
 	fi
 }
 
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
new file mode 100755
index 0000000..c7b8e5d
--- /dev/null
+++ b/t/t3904-stash-patch.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='git checkout --patch'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir dir &&
+	echo parent > dir/foo &&
+	echo dummy > dir/bar &&
+	git add dir &&
+	git commit -m initial &&
+	test_tick &&
+	test_commit second dir/foo head &&
+	echo index > dir/foo &&
+	git add dir/foo &&
+	echo work > dir/foo &&
+	echo bar_index > dir/bar &&
+	git add dir/bar &&
+	echo bar_work > dir/bar
+'
+
+# note: bar sorts before foo, so the first 'n' is always to skip 'bar'
+
+test_expect_success 'saying "n" does nothing' '
+	(echo n; echo n) | test_must_fail git stash save -p &&
+	test "$(git show :dir/foo)" = index &&
+	test "$(cat dir/foo)" = work &&
+	test "$(git show :dir/bar)" = bar_index &&
+	test "$(cat dir/bar)" = bar_work
+'
+
+test_expect_success 'git stash -p' '
+	(echo n; echo y) | git stash save -p &&
+	test "$(git show :dir/foo)" = index &&
+	test "$(cat dir/foo)" = head &&
+	test "$(git show :dir/bar)" = bar_index &&
+	test "$(cat dir/bar)" = bar_work &&
+	git reset --hard &&
+	git stash apply &&
+	test "$(git show :dir/foo)" = head &&
+	test "$(cat dir/foo)" = work &&
+	test "$(git show :dir/bar)" = dummy &&
+	test "$(cat dir/bar)" = dummy
+'
+
+test_expect_success 'git stash -p --no-keep-index' '
+	echo index > dir/foo &&
+	git add dir/foo &&
+	echo work > dir/foo &&
+	echo bar_index > dir/bar &&
+	git add dir/bar &&
+	echo bar_work > dir/bar &&
+	(echo n; echo y) | git stash save -p --no-keep-index &&
+	test "$(git show :dir/foo)" = head &&
+	test "$(cat dir/foo)" = head &&
+	test "$(git show :dir/bar)" = dummy &&
+	test "$(cat dir/bar)" = bar_work &&
+	git reset --hard &&
+	git stash apply --index &&
+	test "$(git show :dir/foo)" = index &&
+	test "$(cat dir/foo)" = work &&
+	test "$(git show :dir/bar)" = bar_index &&
+	test "$(cat dir/bar)" = dummy
+'
+
+test_done
-- 
1.6.4.rc3.215.g18405
