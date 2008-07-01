From: Stephan Beyer <s-beyer@gmx.net>
Subject: [RFC/PATCH 2/2] Migrate git-rebase--i to use git-sequencer
Date: Tue,  1 Jul 2008 04:39:28 +0200
Message-ID: <1214879968-17944-3-git-send-email-s-beyer@gmx.net>
References: <1214879914-17866-5-git-send-email-s-beyer@gmx.net>
 <1214879968-17944-1-git-send-email-s-beyer@gmx.net>
 <1214879968-17944-2-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 04:40:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVnH-0005Ky-6Q
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbYGACjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbYGACji
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:39:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:57461 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756528AbYGACjf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:39:35 -0400
Received: (qmail invoked by alias); 01 Jul 2008 02:39:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp062) with SMTP; 01 Jul 2008 04:39:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/GPaB6yG3GjRt8xSI9FpeBvu3kWHeKqaD8HxMlZV
	qUyybUpsslUbiR
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDVmC-0004fw-RG; Tue, 01 Jul 2008 04:39:28 +0200
X-Mailer: git-send-email 1.5.6.1.130.ga8860.dirty
In-Reply-To: <1214879968-17944-2-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86992>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-rebase--interactive.sh    |  423 ++++++-----------------------------------
 t/t3404-rebase-interactive.sh |   29 ++--
 2 files changed, 71 insertions(+), 381 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ad16fa2..60f43b2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -35,28 +35,13 @@ skip               skip current patch and continue rebasing process
 require_work_tree
 
 DOTEST="$GIT_DIR/.dotest-merge"
-TODO="$DOTEST"/git-rebase-todo
-DONE="$DOTEST"/done
-MSG="$DOTEST"/message
-SQUASH_MSG="$DOTEST"/message-squash
+TODO="$DOTEST/git-rebase-todo"
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
+INTERACTIVE=
 ONTO=
-MARK_PREFIX='refs/rebase-marks'
-test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
-test -f "$DOTEST"/verbose && VERBOSE=t
-
-GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
-mark the corrected paths with 'git add <paths>', and
-run 'git rebase --continue'"
-export GIT_CHERRY_PICK_HELP
-
-mark_prefix=refs/rebase-marks/
-
-warn () {
-	echo "$*" >&2
-}
+test -f "$DOTEST"/verbose && VERBOSE=--verbose
 
 output () {
 	case "$VERBOSE" in
@@ -83,51 +68,11 @@ require_clean_work_tree () {
 
 ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
 
-comment_for_reflog () {
-	case "$ORIG_REFLOG_ACTION" in
-	''|rebase*)
-		GIT_REFLOG_ACTION="rebase -i ($1)"
-		export GIT_REFLOG_ACTION
-		;;
-	esac
-}
-
-last_count=
-mark_action_done () {
-	sed -e 1q < "$TODO" >> "$DONE"
-	sed -e 1d < "$TODO" >> "$TODO".new
-	mv -f "$TODO".new "$TODO"
-	count=$(grep -c '^[^#]' < "$DONE")
-	total=$(($count+$(grep -c '^[^#]' < "$TODO")))
-	if test "$last_count" != "$count"
-	then
-		last_count=$count
-		printf "Rebasing (%d/%d)\r" $count $total
-		test -z "$VERBOSE" || echo
-	fi
-}
-
-make_patch () {
-	parent_sha1=$(git rev-parse --verify "$1"^) ||
-		die "Cannot get patch for $1^"
-	git diff-tree -p "$parent_sha1".."$1" > "$DOTEST"/patch
-	test -f "$DOTEST"/message ||
-		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
-	test -f "$DOTEST"/author-script ||
-		get_author_ident_from_commit "$1" > "$DOTEST"/author-script
-}
-
-die_with_patch () {
-	make_patch "$1"
-	git rerere
-	die "$2"
+warn () {
+	echo "$*" >&2
 }
 
 cleanup_before_quit () {
-	for ref in $(git for-each-ref --format='%(refname)' "${mark_prefix%/}")
-	do
-		git update-ref -d "$ref" "$ref" || return 1
-	done
 	rm -rf "$DOTEST"
 }
 
@@ -136,229 +81,13 @@ die_abort () {
 	die "$1"
 }
 
-has_action () {
-	grep '^[^#]' "$1" >/dev/null
-}
-
-redo_merge () {
-	rm_sha1=$1
-	shift
-
-	eval "$(get_author_ident_from_commit $rm_sha1)"
-	msg="$(git cat-file commit $rm_sha1 | sed -e '1,/^$/d')"
-
-	if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-		GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-		GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-		output git merge $STRATEGY -m "$msg" "$@"
-	then
-		git rerere
-		printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
-		die Error redoing merge $rm_sha1
-	fi
-	unset rm_sha1
-}
-
-pick_one () {
-	no_ff=
-	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
-	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
-	parent_sha1=$(git rev-parse --verify $sha1^) ||
-		die "Could not get the parent of $sha1"
-	current_sha1=$(git rev-parse --verify HEAD)
-	if test "$no_ff$current_sha1" = "$parent_sha1"; then
-		output git reset --hard $sha1
-		test "a$1" = a-n && output git reset --soft $current_sha1
-		sha1=$(git rev-parse --short $sha1)
-		output warn Fast forward to $sha1
-	else
-		output git cherry-pick "$@"
-	fi
-}
-
-nth_string () {
-	case "$1" in
-	*1[0-9]|*[04-9]) echo "$1"th;;
-	*1) echo "$1"st;;
-	*2) echo "$1"nd;;
-	*3) echo "$1"rd;;
-	esac
-}
-
-make_squash_message () {
-	if test -f "$SQUASH_MSG"; then
-		COUNT=$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p" \
-			< "$SQUASH_MSG" | sed -ne '$p')+1))
-		echo "# This is a combination of $COUNT commits."
-		sed -e 1d -e '2,/^./{
-			/^$/d
-		}' <"$SQUASH_MSG"
-	else
-		COUNT=2
-		echo "# This is a combination of two commits."
-		echo "# The first commit's message is:"
-		echo
-		git cat-file commit HEAD | sed -e '1,/^$/d'
-	fi
-	echo
-	echo "# This is the $(nth_string $COUNT) commit message:"
-	echo
-	git cat-file commit $1 | sed -e '1,/^$/d'
-}
-
-peek_next_command () {
-	sed -n "1s/ .*$//p" < "$TODO"
-}
-
-mark_to_ref () {
-	if expr "$1" : "^:[0-9][0-9]*$" >/dev/null
-	then
-		echo "$mark_prefix$(printf %d ${1#:})"
-	else
-		echo "$1"
-	fi
-}
-
-do_next () {
-	rm -f "$DOTEST"/message "$DOTEST"/author-script \
-		"$DOTEST"/amend || exit
-	read command sha1 rest < "$TODO"
-	case "$command" in
-	'#'*|'')
-		mark_action_done
-		;;
-	pick|p)
-		comment_for_reflog pick
-
-		mark_action_done
-		pick_one $sha1 ||
-			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		;;
-	edit|e)
-		comment_for_reflog edit
-
-		mark_action_done
-		pick_one $sha1 ||
-			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		make_patch $sha1
-		: > "$DOTEST"/amend
-		warn
-		warn "You can amend the commit now, with"
-		warn
-		warn "	git commit --amend"
-		warn
-		warn "Once you are satisfied with your changes, run"
-		warn
-		warn "	git rebase --continue"
-		warn
-		exit 0
-		;;
-	squash|s)
-		comment_for_reflog squash
-
-		has_action "$DONE" ||
-			die "Cannot 'squash' without a previous commit"
-
-		mark_action_done
-		make_squash_message $sha1 > "$MSG"
-		case "$(peek_next_command)" in
-		squash|s)
-			EDIT_COMMIT=
-			USE_OUTPUT=output
-			cp "$MSG" "$SQUASH_MSG"
-			;;
-		*)
-			EDIT_COMMIT=-e
-			USE_OUTPUT=
-			rm -f "$SQUASH_MSG" || exit
-			;;
-		esac
-
-		failed=f
-		author_script=$(get_author_ident_from_commit HEAD)
-		output git reset --soft HEAD^
-		pick_one -n $sha1 || failed=t
-		echo "$author_script" > "$DOTEST"/author-script
-		if test $failed = f
-		then
-			# This is like --amend, but with a different message
-			eval "$author_script"
-			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-			$USE_OUTPUT git commit --no-verify -F "$MSG" $EDIT_COMMIT || failed=t
-		fi
-		if test $failed = t
-		then
-			cp "$MSG" "$GIT_DIR"/MERGE_MSG
-			warn
-			warn "Could not apply $sha1... $rest"
-			die_with_patch $sha1 ""
-		fi
-		;;
-	mark)
-		mark_action_done
-
-		mark=$(mark_to_ref :${sha1#:})
-		test :${sha1#:} = "$mark" && die "Invalid mark '$sha1'"
-
-		git rev-parse --verify "$mark" > /dev/null 2>&1 && \
-			warn "mark $sha1 already exist; overwriting it"
-
-		git update-ref "$mark" HEAD || die "update-ref failed"
-		;;
-	merge|m)
-		comment_for_reflog merge
-
-		if ! git rev-parse --verify $sha1 > /dev/null
-		then
-			die "Invalid reference merge '$sha1' in"
-					"$command $sha1 $rest"
-		fi
-
-		new_parents=
-		for p in $rest
-		do
-			new_parents="$new_parents $(mark_to_ref $p)"
-		done
-		new_parents="${new_parents# }"
-		test -n "$new_parents" || \
-			die "You forgot to give the parents for the" \
-				"merge $sha1. Please fix it in $TODO"
-
-		mark_action_done
-		redo_merge $sha1 $new_parents
-		;;
-	reset|r)
-		comment_for_reflog reset
-
-		tmp=$(git rev-parse --verify "$(mark_to_ref $sha1)") ||
-			die "Invalid parent '$sha1' in $command $sha1 $rest"
-
-		mark_action_done
-		output git reset --hard $tmp
-		;;
-	tag|t)
-		comment_for_reflog tag
-
-		mark_action_done
-		output git tag -f "$sha1"
-		;;
-	*)
-		warn "Unknown command: $command $sha1 $rest"
-		die_with_patch $sha1 "Please fix this in the file $TODO."
-		;;
-	esac
-	test -s "$TODO" && return
-
-	comment_for_reflog finish &&
+update_refs () {
 	HEADNAME=$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=$(cat "$DOTEST"/head) &&
-	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
 	NEWHEAD=$(git rev-parse HEAD) &&
 	case $HEADNAME in
 	refs/*)
-		message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
+		message="$GIT_REFLOG_ACTION: $HEADNAME)" &&
 		git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
 		git symbolic-ref HEAD $HEADNAME
 		;;
@@ -369,15 +98,30 @@ do_next () {
 	cleanup_before_quit &&
 	git gc --auto &&
 	warn "Successfully rebased and updated $HEADNAME."
+}
 
-	exit
+run_sequencer () {
+	git sequencer --caller='git rebase -i|--abort|--continue|--skip' "$@"
+	case "$?" in
+	0)
+		update_refs
+		exit 0
+		;;
+	2)
+		warn 'git-sequencer needs continuation (by edit).'
+		exit 0
+		;;
+	3)
+		die 'git-sequencer needs continuation (by conflict).'
+		;;
+	*)
+		die_abort 'git-sequencer died.'
+		;;
+	esac
 }
 
-do_rest () {
-	while :
-	do
-		do_next
-	done
+has_action () {
+	grep '^[^#]' "$1" >/dev/null
 }
 
 get_value_from_list () {
@@ -418,7 +162,6 @@ create_extended_todo_list () {
 			(
 			while read sha1 tag
 			do
-				tag=${tag#refs/tags/}
 				if test ${last_sha1:-0000} = $sha1
 				then
 					saved_tags="$saved_tags:$tag"
@@ -457,7 +200,7 @@ create_extended_todo_list () {
 		then
 			for t in $(echo $tmp | tr : ' ')
 			do
-				echo tag $t
+				echo ref $t
 			done
 		fi
 
@@ -477,18 +220,18 @@ create_extended_todo_list () {
 				fi
 			done
 			unset p
-			echo merge $commit $new_parents
+			echo "merge $STRATEGY --reuse-commit=$commit $new_parents"
 			unset new_parents
 			;;
 		*)
-			echo "pick $commit $subject"
+			echo "pick $commit # $subject"
 			;;
 		esac
 	done
 	test -n "${last_parent:-}" -a "${last_parent:-}" != $SHORTUPSTREAM && \
-		echo reset $last_parent
+		echo "reset $last_parent"
 	) | \
-	perl -e 'print reverse <>' | \
+	@@PERL@@ -e 'print reverse <>' | \
 	while read cmd args
 	do
 		: ${commit_mark_list:=} ${last_commit:=000}
@@ -515,6 +258,7 @@ create_extended_todo_list () {
 			fi
 			;;
 		merge)
+			args="${args#*--reuse-commit=}"
 			new_args=
 			for i in ${args#* }
 			do
@@ -527,7 +271,7 @@ create_extended_todo_list () {
 				fi
 			done
 			last_commit="${args%% *}"
-			args="$last_commit ${new_args# }"
+			args="$STRATEGY --reuse-commit=$last_commit ${new_args# }"
 			;;
 		esac
 		echo "$cmd $args"
@@ -545,65 +289,9 @@ is_standalone () {
 while test $# != 0
 do
 	case "$1" in
-	--continue)
-		is_standalone "$@" || usage
-		comment_for_reflog continue
-
-		test -d "$DOTEST" || die "No interactive rebase running"
-
-		# Sanity check
-		git rev-parse --verify HEAD >/dev/null ||
-			die "Cannot read HEAD"
-		git update-index --ignore-submodules --refresh &&
-			git diff-files --quiet --ignore-submodules ||
-			die "Working tree is dirty"
-
-		# do we have anything to commit?
-		if git diff-index --cached --quiet --ignore-submodules HEAD --
-		then
-			: Nothing to commit -- skip this
-		else
-			. "$DOTEST"/author-script ||
-				die "Cannot find the author identity"
-			if test -f "$DOTEST"/amend
-			then
-				git reset --soft HEAD^ ||
-				die "Cannot rewind the HEAD"
-			fi
-			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-			git commit --no-verify -F "$DOTEST"/message -e ||
-			die "Could not commit staged changes."
-		fi
-
-		require_clean_work_tree
-		do_rest
-		;;
-	--abort)
+	--continue|--abort|--skip)
 		is_standalone "$@" || usage
-		comment_for_reflog abort
-
-		git rerere clear
-		test -d "$DOTEST" || die "No interactive rebase running"
-
-		HEADNAME=$(cat "$DOTEST"/head-name)
-		HEAD=$(cat "$DOTEST"/head)
-		case $HEADNAME in
-		refs/*)
-			git symbolic-ref HEAD $HEADNAME
-			;;
-		esac &&
-		output git reset --hard $HEAD &&
-		cleanup_before_quit
-		exit
-		;;
-	--skip)
-		is_standalone "$@" || usage
-		comment_for_reflog skip
-
-		git rerere clear
-		test -d "$DOTEST" || die "No interactive rebase running"
-
-		output git reset --hard && do_rest
+		run_sequencer "$1"
 		;;
 	-s)
 		case "$#,$1" in
@@ -620,7 +308,7 @@ do
 		# we use merge anyway
 		;;
 	-v)
-		VERBOSE=t
+		VERBOSE=--verbose
 		;;
 	-p)
 		PRESERVE_MERGES=t
@@ -633,7 +321,7 @@ do
 		PRESERVE_TAGS=t
 		;;
 	-i)
-		# yeah, we know
+		INTERACTIVE=t
 		;;
 	--onto)
 		shift
@@ -649,14 +337,12 @@ do
 		git var GIT_COMMITTER_IDENT >/dev/null ||
 			die "You need to set your committer info first"
 
-		comment_for_reflog start
-
 		require_clean_work_tree
 
 		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
 		test -z "$ONTO" && ONTO=$UPSTREAM
 
-		if test ! -z "$2"
+		if test -n "$2"
 		then
 			output git show-ref --verify --quiet "refs/heads/$2" ||
 				die "Invalid branchname: $2"
@@ -674,8 +360,7 @@ do
 		echo $HEAD > "$DOTEST"/head
 		echo $UPSTREAM > "$DOTEST"/upstream
 		echo $ONTO > "$DOTEST"/onto
-		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
-		test t = "$VERBOSE" && : > "$DOTEST"/verbose
+		test -n "$VERBOSE" && : > "$DOTEST"/verbose
 
 		SHORTUPSTREAM=$(git rev-parse --short=7 $UPSTREAM)
 		SHORTHEAD=$(git rev-parse --short=7 $HEAD)
@@ -696,7 +381,8 @@ do
 				create_extended_todo_list
 		else
 			git rev-list --no-merges --reverse --pretty=oneline \
-				 $common_rev_list_opts | sed -n "s/^>/pick /p"
+				 $common_rev_list_opts |
+				 sed -n -e "s/^>\([0-9a-f]\+\)/pick \1\t#/p"
 		fi > "$TODO"
 
 		cat >> "$TODO" << EOF
@@ -713,26 +399,29 @@ do
 #  squash = use commit, but meld into previous commit
 #  mark :mark = mark the current HEAD for later reference
 #  reset commit = reset HEAD to the commit
-#  merge commit-M commit-P ... = redo merge commit-M with the
-#         current HEAD and the parents commit-P
-#  tag = reset tag to the current HEAD
+#  merge [--reuse-commit=commit-M] remote ... =
+#     * merge the remotes into HEAD
+#     * can use the author and commit message from commit-M
+#  ref = update ref to the current HEAD
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #
 EOF
-
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
-		cp "$TODO" "$TODO".backup
-		git_editor "$TODO" ||
-			die "Could not execute editor"
+		if test -n "$INTERACTIVE"
+		then
+			cp "$TODO" "$TODO".backup
+			git_editor "$TODO" ||
+				die_abort "Could not execute editor"
 
-		has_action "$TODO" ||
-			die_abort "Nothing to do"
+			has_action "$TODO" ||
+				die_abort "Nothing to do"
+		fi
 
-		output git checkout $ONTO && do_rest
+		run_sequencer $VERBOSE --onto "$ONTO" "$TODO"
 		;;
 	esac
 	shift
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 940eb24..8b0781d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -89,11 +89,11 @@ for line in $FAKE_LINES; do
 		echo "reset ${line#reset}"
 		echo "reset ${line#reset}" >> "$1";;
 	merge*)
-		echo "merge ${line#merge}" | tr / ' '
-		echo "merge ${line#merge}" | tr / ' ' >> "$1";;
+		echo "merge --reuse-commit=${line#merge}" | tr / ' '
+		echo "merge --reuse-commit=${line#merge}" | tr / ' ' >> "$1";;
 	tag*)
-		echo "tag ${line#tag}"
-		echo "tag ${line#tag}" >> "$1";;
+		echo "ref refs/tags/${line#tag}"
+		echo "ref refs/tags/${line#tag}" >> "$1";;
 	*)
 		sed -n "${line}{s/^pick/$action/; p;}" < "$1".tmp
 		sed -n "${line}{s/^pick/$action/; p;}" < "$1".tmp >> "$1"
@@ -170,19 +170,20 @@ test_expect_success 'stop on conflicting pick' '
 	git tag new-branch1 &&
 	test_must_fail git rebase -i master &&
 	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
-	test_cmp expect .git/.dotest-merge/patch &&
+	test_cmp expect .git/sequencer/patch &&
 	test_cmp expect2 file1 &&
 	test "$(git-diff --name-status |
 		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
-	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
-	test 0 = $(grep -c "^[^#]" < .git/.dotest-merge/git-rebase-todo)
+	test 4 = $(grep -v "^#" < .git/sequencer/done | wc -l) &&
+	test 0 = $(grep -c "^[^#]" < .git/sequencer/todo) &&
+	test -d .git/.dotest-merge
 '
 
 test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
-	! test -d .git/.dotest-merge
+	! test -d .git/sequencer
 '
 
 test_expect_success 'retain authorship' '
@@ -219,13 +220,13 @@ test_expect_success '-p handles "no changes" gracefully' '
 test_expect_success 'setting marks works' '
 	git checkout master &&
 	FAKE_LINES="mark:0 2 1 mark:42 3 edit 4" git rebase -i HEAD~4 &&
-	marks_dir=.git/refs/rebase-marks &&
+	marks_dir=.git/refs/sequencer-marks &&
 	test -d $marks_dir &&
 	test $(ls $marks_dir | wc -l) -eq 2 &&
 	test "$(git rev-parse HEAD~4)" = \
-		"$(git rev-parse refs/rebase-marks/0)" &&
+		"$(git rev-parse refs/sequencer-marks/0)" &&
 	test "$(git rev-parse HEAD~2)" = \
-		"$(git rev-parse refs/rebase-marks/42)" &&
+		"$(git rev-parse refs/sequencer-marks/42)" &&
 	git rebase --abort &&
 	test 0 = $(ls $marks_dir | wc -l)
 '
@@ -233,8 +234,8 @@ test_expect_success 'setting marks works' '
 test_expect_success 'reset with nonexistent mark fails' '
 	export FAKE_LINES="reset:0 1" &&
 	test_must_fail git rebase -i HEAD~1 &&
-	unset FAKE_LINES &&
-	git rebase --abort
+	git rebase --abort &&
+	unset FAKE_LINES
 '
 
 test_expect_success 'reset to HEAD is a nop' '
@@ -325,7 +326,7 @@ test_expect_success 'interactive --first-parent gives a linear list' '
 	test "$head" = "$(git rev-parse HEAD)"
 '
 
-test_expect_success 'tag sets tags' '
+test_expect_success 'ref can set tags' '
 	head=$(git rev-parse HEAD) &&
 	FAKE_LINES="1 2 3 4 5 tagbb-tag1 6 7 8 9 10 11 12 13 14 15 \
 		tagbb-tag2 16 tagbb-tag3a tagbb-tag3b 17 18 19 20 21 22" \
-- 
1.5.6.334.gdaf0
