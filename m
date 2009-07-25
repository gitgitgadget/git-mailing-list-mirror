From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 5/5] Implement 'git stash save --patch'
Date: Sat, 25 Jul 2009 23:29:34 +0200
Message-ID: <e5ef2e602347914a7a14d769ca2297223cde8042.1248557241.git.trast@student.ethz.ch>
References: <7vzlat64u1.fsf@alter.siamese.dyndns.org> <cover.1248557241.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 23:30:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUooj-00037K-1H
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 23:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbZGYVaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 17:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbZGYVaB
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 17:30:01 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:7772 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbZGYV3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 17:29:48 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:45 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 25 Jul 2009 23:29:44 +0200
X-Mailer: git-send-email 1.6.4.rc2.227.gf5e17
In-Reply-To: <cover.1248557241.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 25 Jul 2009 21:29:44.0998 (UTC) FILETIME=[07639C60:01CA0D6F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124079>

This adds a hunk-based mode to git-stash.  You can select hunks from
the index and the worktree, and git-stash will attempt to build a
stash that reflects these changes.

Internally, we have the problem that we're trying to offer hunks from
one index (the one the user sees) for inclusion in another index (used
to build the stash).  We solve this by letting git-add--interactive
write out the hunks to a patch file, and then using git-apply with a
different GIT_INDEX_FILE.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-stash.txt |   10 +++-
 git-add--interactive.perl   |   30 ++++++++++-
 git-stash.sh                |  120 +++++++++++++++++++++++++++++++++++--------
 3 files changed, 134 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1c64a02..e6f310a 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--keep-index] [-q|--quiet] [<message>]]
+'git stash' [save [--patch] [--keep-index] [-q|--quiet] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -42,7 +42,7 @@ is also possible).
 OPTIONS
 -------
 
-save [--keep-index] [-q|--quiet] [<message>]::
+save [--patch] [--keep-index] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  This is the default action when no
@@ -51,6 +51,12 @@ save [--keep-index] [-q|--quiet] [<message>]::
 +
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
++
+With --patch, interactively select hunks of changes to be stashed.
+This first asks for the hunks to be taken from the HEAD..index
+difference, and afterwards for hunks from the index..worktree
+difference.  Then, a stash is constructed that contains these changes,
+and the changes are removed from the index and worktree, respectively.
 
 list [<options>]::
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5005a8d..17100d3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -76,6 +76,7 @@
 
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
+sub apply_patch_for_stash;
 
 my %patch_modes = (
 	'stage' => {
@@ -86,6 +87,22 @@
 		PARTICIPLE => 'staging',
 		FILTER => 'file-only',
 	},
+	'stash_index' => {
+		DIFF => 'diff-index -p --cached HEAD',
+		APPLY => \&apply_patch_for_stash,
+		APPLY_CHECK => 'apply --cached',
+		VERB => 'Stash',
+		PARTICIPLE => 'stashing',
+		FILTER => 'index-only',
+	},
+	'stash_worktree' => {
+		DIFF => 'diff-files -p',
+		APPLY => \&apply_patch_for_stash,
+		APPLY_CHECK => 'apply --cached',
+		VERB => 'Stash',
+		PARTICIPLE => 'stashing',
+		FILTER => 'file-only',
+	},
 	'reset' => {
 		DIFF => 'diff-index -p --cached',
 		APPLY => sub { apply_patch 'apply -R --cached', @_; },
@@ -1067,6 +1084,14 @@
 	return $ret;
 }
 
+sub apply_patch_for_stash {
+	my $fh;
+	open $fh, '>>', $ENV{GIT_STASH_TEMP_PATCH}
+		or die "cannot open temporary patch file: $!";
+	print $fh @_;
+	return close $fh;
+}
+
 sub apply_patch_for_checkout_commit {
 	my $applies_index = run_git_apply 'apply -R --cached --recount --check', @_;
 	my $applies_worktree = run_git_apply 'apply -R --recount --check', @_;
@@ -1458,8 +1483,9 @@
 					$patch_mode_revision = $arg;
 					$arg = shift @ARGV or die "missing --";
 				}
-			} elsif ($1 eq 'stage') {
-				$patch_mode = 'stage';
+			} elsif ($1 eq 'stage' or $1 eq 'stash_index'
+				 or $1 eq 'stash_worktree') {
+				$patch_mode = $1;
 				$arg = shift @ARGV or die "missing --";
 			} else {
 				die "unknown --patch mode: $1";
diff --git a/git-stash.sh b/git-stash.sh
index 03e589f..04c49e8 100755
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
@@ -62,24 +70,73 @@ create_stash () {
 	fi
 	msg=$(printf '%s: %s' "$branch" "$head")
 
-	# state of the index
-	i_tree=$(git write-tree) &&
-	i_commit=$(printf 'index on %s\n' "$msg" |
-		git commit-tree $i_tree -p $b_commit) ||
-		die "Cannot save the current index state"
-
-	# state of the working tree
-	w_tree=$( (
-		rm -f "$TMP-index" &&
-		cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
-		GIT_INDEX_FILE="$TMP-index" &&
-		export GIT_INDEX_FILE &&
-		git read-tree -m $i_tree &&
-		git add -u &&
-		git write-tree &&
-		rm -f "$TMP-index"
-	) ) ||
-		die "Cannot save the current worktree state"
+	if test -z "$patch_mode"
+	then
+
+		# state of the index
+		i_tree=$(git write-tree) &&
+		i_commit=$(printf 'index on %s\n' "$msg" |
+			git commit-tree $i_tree -p $b_commit) ||
+			die "Cannot save the current index state"
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
+		# find out what the user wants
+		echo
+		echo "${help_color}stash --patch: index changes${reset_color}"
+		echo
+		: > "$TMP-patch-i"
+		GIT_STASH_TEMP_PATCH="$TMP-patch-i" \
+			git add--interactive --patch=stash_index --
+		echo "${help_color}stash --patch: worktree changes${reset_color}"
+		echo
+		: > "$TMP-patch-w"
+		GIT_STASH_TEMP_PATCH="$TMP-patch-w" \
+			git add--interactive --patch=stash_worktree --
+
+		test -s "$TMP-patch-i" -o -s "$TMP-patch-w" ||
+		die "Neither index nor worktree changes selected."
+
+		# state of the index
+		i_tree=$( (
+			rm -f "$TMP-index" &&
+			GIT_INDEX_FILE="$TMP-index" &&
+			export GIT_INDEX_FILE &&
+			git read-tree --reset HEAD &&
+			( test ! -s "$TMP-patch-i" || \
+				git apply --cached < "$TMP-patch-i" ) &&
+			git write-tree
+			# keep $TMP-index for $w_tree construction
+		) ) &&
+		i_commit=$(printf 'index on %s\n' "$msg" |
+			git commit-tree $i_tree -p $b_commit) ||
+			( cat "$TMP-patch-i"; die "Cannot save the current index state" )
+
+		# state of the working tree
+		w_tree=$( (
+			GIT_INDEX_FILE="$TMP-index" &&
+			export GIT_INDEX_FILE &&
+			( test ! -s "$TMP-patch-w" || \
+				git apply --cached < "$TMP-patch-w" ) &&
+			git write-tree &&
+			rm -f "$TMP-index"
+		) ) ||
+			die "Cannot save the current worktree state"
+
+	fi
 
 	# create the stash
 	if test -z "$stash_msg"
@@ -95,12 +152,16 @@ create_stash () {
 
 save_stash () {
 	keep_index=
+	patch_mode=
 	while test $# != 0
 	do
 		case "$1" in
 		--keep-index)
 			keep_index=t
 			;;
+		-p|--patch)
+			patch_mode=t
+			;;
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
@@ -131,11 +192,26 @@ save_stash () {
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
+		if test -s "$TMP-patch-w"
+		then
+			git apply -R < "$TMP-patch-w" ||
+			die "Cannot remove worktree changes"
+		fi
+
+		if test -z "$keep_index" -a -s "$TMP-patch-i"
+		then
+			git apply -R --cached < "$TMP-patch-i" ||
+			die "Cannot remove index changes"
+		fi
 	fi
 }
 
-- 
1.6.4.rc2.227.gf5e17
