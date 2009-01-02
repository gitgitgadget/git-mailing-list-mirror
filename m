From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 3/4] rebase -i: learn to rebase root commit
Date: Fri,  2 Jan 2009 23:28:28 +0100
Message-ID: <43e09eaf2b9a9a3805b9262957ece32190ae4c32.1230935095.git.trast@student.ethz.ch>
References: <200901022320.14055.trast@student.ethz.ch>
 <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch>
 <7c74d8be216b4667f470e34644c4aa26dcfe0cfb.1230935095.git.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>, bss@iguanasuicide.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 23:30:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsWv-0008K5-MK
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbZABW2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbZABW2d
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:28:33 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:2229 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757698AbZABW22 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:28:28 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:28:23 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 23:28:22 +0100
X-Mailer: git-send-email 1.6.1.71.gaaa47.dirty
In-Reply-To: <7c74d8be216b4667f470e34644c4aa26dcfe0cfb.1230935095.git.trast@student.ethz.ch>
In-Reply-To: <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch>
References: <6a754e4198413c4051a6085c5e5baab163835463.1230935095.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 02 Jan 2009 22:28:22.0923 (UTC) FILETIME=[6BF75DB0:01C96D29]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104433>

Teach git-rebase -i a new option --root, which instructs it to rebase
the entire history leading up to <branch>.  This is mainly for
symmetry with ordinary git-rebase; it cannot be used to edit the root
commit in-place (it requires --onto <newbase>).  Commits that already
exist in <newbase> are skipped.

In the normal mode of operation, this is fairly straightforward.  We
run cherry-pick in a loop, and cherry-pick has supported picking the
root commit since f95ebf7 (Allow cherry-picking root commits,
2008-07-04).

In --preserve-merges mode, we track the mapping from old to rewritten
commits and use it to update the parent list of each commit.  In this
case, we define 'rebase -i -p --root --onto $onto $branch' to rewrite
the parent list of all root commit(s) on $branch to contain $onto
instead.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-rebase--interactive.sh |  109 +++++++++++++++++++++++++++++++------------
 t/t3412-rebase-root.sh     |  101 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 31 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2c668cd..14d3e38 100755
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
@@ -197,7 +204,11 @@ pick_one_preserving_merges () {
 
 	# rewrite parents; if none were rewritten, we can fast-forward.
 	new_parents=
-	pend=" $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)"
+	pend=" $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)"
+	if test "$pend" = " "
+	then
+		pend=" root"
+	fi
 	while [ "$pend" != "" ]
 	do
 		p=$(expr "$pend" : ' \([^ ]*\)')
@@ -227,7 +238,9 @@ pick_one_preserving_merges () {
 			if test -f "$DROPPED"/$p
 			then
 				fast_forward=f
-				pend=" $(cat "$DROPPED"/$p)$pend"
+				replacement="$(cat "$DROPPED"/$p)"
+				test -z "$replacement" && replacement=root
+				pend=" $replacement$pend"
 			else
 				new_parents="$new_parents $p"
 			fi
@@ -443,6 +456,7 @@ get_saved_options () {
 	test -d "$REWRITTEN" && PRESERVE_MERGES=t
 	test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 	test -f "$DOTEST"/verbose && VERBOSE=t
+	test ! -s "$DOTEST"/upstream && REBASE_ROOT=t
 }
 
 while test $# != 0
@@ -547,6 +561,9 @@ first and then run 'git rebase --continue' again."
 	-i)
 		# yeah, we know
 		;;
+	--root)
+		REBASE_ROOT=t
+		;;
 	--onto)
 		shift
 		ONTO=$(git rev-parse --verify "$1") ||
@@ -554,28 +571,36 @@ first and then run 'git rebase --continue' again."
 		;;
 	--)
 		shift
-		test $# -eq 1 -o $# -eq 2 || usage
+		test ! -z "$REBASE_ROOT" -o $# -eq 1 -o $# -eq 2 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
 
 		git var GIT_COMMITTER_IDENT >/dev/null ||
 			die "You need to set your committer info first"
 
-		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
-		run_pre_rebase_hook ${1+"$@"}
+		if test -z "$REBASE_ROOT"
+		then
+			UPSTREAM_ARG="$1"
+			UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
+			test -z "$ONTO" && ONTO=$UPSTREAM
+			shift
+		else
+			UPSTREAM_ARG=--root
+			test -z "$ONTO" &&
+				die "You must specify --onto when using --root"
+		fi
+		run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
 
 		comment_for_reflog start
 
 		require_clean_work_tree
 
-		test -z "$ONTO" && ONTO=$UPSTREAM
-
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
@@ -599,12 +624,19 @@ first and then run 'git rebase --continue' again."
 			# This ensures that commits on merged, but otherwise
 			# unrelated side branches are left alone. (Think "X"
 			# in the man page's example.)
-			mkdir "$REWRITTEN" &&
-			for c in $(git merge-base --all $HEAD $UPSTREAM)
-			do
-				echo $ONTO > "$REWRITTEN"/$c ||
+			if test -z "$REBASE_ROOT"
+			then
+				mkdir "$REWRITTEN" &&
+				for c in $(git merge-base --all $HEAD $UPSTREAM)
+				do
+					echo $ONTO > "$REWRITTEN"/$c ||
+						die "Could not init rewritten commits"
+				done
+			else
+				mkdir "$REWRITTEN" &&
+				echo $ONTO > "$REWRITTEN"/root ||
 					die "Could not init rewritten commits"
-			done
+			fi
 			# No cherry-pick because our first pass is to determine
 			# parents to rewrite and skipping dropped commits would
 			# prematurely end our probe
@@ -614,12 +646,21 @@ first and then run 'git rebase --continue' again."
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
+			REVISIONS=$ONTO...$HEAD
+			SHORTREVISIONS=$SHORTHEAD
+		fi
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
-			$UPSTREAM...$HEAD | \
+			$REVISIONS | \
 			sed -n "s/^>//p" | while read shortsha1 rest
 		do
 			if test t != "$PRESERVE_MERGES"
@@ -627,14 +668,19 @@ first and then run 'git rebase --continue' again."
 				echo "pick $shortsha1 $rest" >> "$TODO"
 			else
 				sha1=$(git rev-parse $shortsha1)
-				preserve=t
-				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
-				do
-					if test -f "$REWRITTEN"/$p -a \( $p != $UPSTREAM -o $sha1 = $first_after_upstream \)
-					then
-						preserve=f
-					fi
-				done
+				if test -z "$REBASE_ROOT"
+				then
+					preserve=t
+					for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
+					do
+						if test -f "$REWRITTEN"/$p -a \( $p != $UPSTREAM -o $sha1 = $first_after_upstream \)
+						then
+							preserve=f
+						fi
+					done
+				else
+					preserve=f
+				fi
 				if test f = "$preserve"
 				then
 					touch "$REWRITTEN"/$sha1
@@ -648,11 +694,11 @@ first and then run 'git rebase --continue' again."
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
@@ -661,17 +707,18 @@ first and then run 'git rebase --continue' again."
 					# not worthwhile, we don't want to track its multiple heads,
 					# just the history of its first-parent for others that will
 					# be rebasing on top of it
-					git rev-list --parents -1 $rev | cut -d' ' -f2 > "$DROPPED"/$rev
+					git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$DROPPED"/$rev
 					short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
 					grep -v "^[a-z][a-z]* $short" <"$TODO" > "${TODO}2" ; mv "${TODO}2" "$TODO"
 					rm "$REWRITTEN"/$rev
 				fi
 			done
 		fi
+
 		test -s "$TODO" || echo noop >> "$TODO"
 		cat >> "$TODO" << EOF
 
-# Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
+# Rebase $SHORTREVISIONS onto $SHORTONTO
 #
 # Commands:
 #  p, pick = use commit
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 1978512..cbf3414 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -67,6 +67,100 @@ test_expect_success 'pre-rebase got correct input (2)' '
 	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work2
 '
 
+test_expect_success 'rebase -i --root --onto <newbase>' '
+	git checkout -b work3 other &&
+	GIT_EDITOR=: git rebase -i --root --onto master &&
+	git log --pretty=tformat:"%s" > rebased3 &&
+	test_cmp expect rebased3
+'
+
+test_expect_success 'pre-rebase got correct input (3)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,
+'
+
+test_expect_success 'rebase -i --root --onto <newbase> <branch>' '
+	git branch work4 other &&
+	GIT_EDITOR=: git rebase -i --root --onto master work4 &&
+	git log --pretty=tformat:"%s" > rebased4 &&
+	test_cmp expect rebased4
+'
+
+test_expect_success 'pre-rebase got correct input (4)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work4
+'
+
+test_expect_success 'rebase -i -p with linear history' '
+	git checkout -b work5 other &&
+	GIT_EDITOR=: git rebase -i -p --root --onto master &&
+	git log --pretty=tformat:"%s" > rebased5 &&
+	test_cmp expect rebased5
+'
+
+test_expect_success 'pre-rebase got correct input (5)' '
+	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,
+'
+
+test_expect_success 'set up merge history' '
+	git checkout other^ &&
+	git checkout -b side &&
+	echo 5 > C &&
+	git add C &&
+	git commit -m 5 &&
+	git checkout other &&
+	git merge side
+'
+
+sed 's/#/ /g' > expect-side <<'EOF'
+*   Merge branch 'side' into other
+|\##
+| * 5
+* | 4
+|/##
+* 3
+* 2
+* 1
+EOF
+
+test_expect_success 'rebase -i -p with merge' '
+	git checkout -b work6 other &&
+	GIT_EDITOR=: git rebase -i -p --root --onto master &&
+	git log --graph --topo-order --pretty=tformat:"%s" > rebased6 &&
+	test_cmp expect-side rebased6
+'
+
+test_expect_success 'set up second root and merge' '
+	git symbolic-ref HEAD refs/heads/third &&
+	rm .git/index &&
+	rm A B C &&
+	echo 6 > D &&
+	git add D &&
+	git commit -m 6 &&
+	git checkout other &&
+	git merge third
+'
+
+sed 's/#/ /g' > expect-third <<'EOF'
+*   Merge branch 'third' into other
+|\##
+| * 6
+* |   Merge branch 'side' into other
+|\ \##
+| * | 5
+* | | 4
+|/ /##
+* | 3
+|/##
+* 2
+* 1
+EOF
+
+test_expect_success 'rebase -i -p with two roots' '
+	git checkout -b work7 other &&
+	GIT_EDITOR=: git rebase -i -p --root --onto master &&
+	git log --graph --topo-order --pretty=tformat:"%s" > rebased7 &&
+	test_cmp expect-third rebased7
+'
+
 test_expect_success 'setup pre-rebase hook that fails' '
 	mkdir -p .git/hooks &&
 	cat >.git/hooks/pre-rebase <<EOF &&
@@ -83,4 +177,11 @@ test_expect_success 'pre-rebase hook stops rebase' '
 	test 0 = $(git rev-list other...stops1 | wc -l)
 '
 
+test_expect_success 'pre-rebase hook stops rebase -i' '
+	git checkout -b stops2 other &&
+	GIT_EDITOR=: test_must_fail git rebase --root --onto master &&
+	test "z$(git symbolic-ref HEAD)" = zrefs/heads/stops2
+	test 0 = $(git rev-list other...stops2 | wc -l)
+'
+
 test_done
-- 
1.6.1.71.gaaa47.dirty
