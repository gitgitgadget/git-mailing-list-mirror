From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 6/6] Implement 'git stash save --patch'
Date: Thu, 13 Aug 2009 14:29:44 +0200
Message-ID: <249f68309e4cc6a5a9e458cb9d429423e64f17c9.1250164190.git.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <cover.1250164190.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZSD-0002tc-9r
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbZHMMai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbZHMMah
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:30:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54458 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374AbZHMMaP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:30:15 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:10 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:02 +0200
X-Mailer: git-send-email 1.6.4.262.gbda8
In-Reply-To: <cover.1250164190.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125816>

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
 git-add--interactive.perl   |   14 ++++++-
 git-stash.sh                |   80 +++++++++++++++++++++++++++++++++++-------
 t/t3904-stash-patch.sh      |   55 +++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 18 deletions(-)
 create mode 100755 t/t3904-stash-patch.sh

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2f5ca7b..d206297 100644
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
index 9c202fc..c5e0586 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -76,6 +76,7 @@
 
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
+sub apply_patch_for_stash;
 
 my %patch_modes = (
 	'stage' => {
@@ -87,6 +88,15 @@
 		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
 	},
+	'stash' => {
+		DIFF => 'diff-index -p HEAD',
+		APPLY => sub { apply_patch 'apply --cached', @_; },
+		APPLY_CHECK => 'apply --cached',
+		VERB => 'Stash',
+		TARGET => '',
+		PARTICIPLE => 'stashing',
+		FILTER => undef,
+	},
 	'reset_head' => {
 		DIFF => 'diff-index -p --cached',
 		APPLY => sub { apply_patch 'apply -R --cached', @_; },
@@ -1493,8 +1503,8 @@
 						       'checkout_head' : 'checkout_nothead');
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
index 0000000..f37e3bc
--- /dev/null
+++ b/t/t3904-stash-patch.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='git checkout --patch'
+. ./lib-patch-mode.sh
+
+test_expect_success 'setup' '
+	mkdir dir &&
+	echo parent > dir/foo &&
+	echo dummy > bar &&
+	git add bar dir/foo &&
+	git commit -m initial &&
+	test_tick &&
+	test_commit second dir/foo head &&
+	echo index > dir/foo &&
+	git add dir/foo &&
+	set_and_save_state bar bar_work bar_index &&
+	save_head
+'
+
+# note: bar sorts before dir, so the first 'n' is always to skip 'bar'
+
+test_expect_success 'saying "n" does nothing' '
+	set_state dir/foo work index
+	(echo n; echo n) | test_must_fail git stash save -p &&
+	verify_state dir/foo work index &&
+	verify_saved_state bar
+'
+
+test_expect_success 'git stash -p' '
+	(echo n; echo y) | git stash save -p &&
+	verify_state dir/foo head index &&
+	verify_saved_state bar &&
+	git reset --hard &&
+	git stash apply &&
+	verify_state dir/foo work head &&
+	verify_state bar dummy dummy
+'
+
+test_expect_success 'git stash -p --no-keep-index' '
+	set_state dir/foo work index &&
+	set_state bar bar_work bar_index &&
+	(echo n; echo y) | git stash save -p --no-keep-index &&
+	verify_state dir/foo head head &&
+	verify_state bar bar_work dummy &&
+	git reset --hard &&
+	git stash apply --index &&
+	verify_state dir/foo work index &&
+	verify_state bar dummy bar_index
+'
+
+test_expect_success 'none of this moved HEAD' '
+	verify_saved_head
+'
+
+test_done
-- 
1.6.4.262.gbda8
