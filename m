From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Migrate rebase-i to sequencer
Date: Wed, 16 Jul 2008 22:45:22 +0200
Message-ID: <7ab7e9bf8e40a5317045ee44497422a29c43c61c.1216233922.git.s-beyer@gmx.net>
References: <cover.1216233918.git.s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDtT-0004T8-F5
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679AbYGPUph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756776AbYGPUpg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:45:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:34578 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756289AbYGPUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:45:32 -0400
Received: (qmail invoked by alias); 16 Jul 2008 20:45:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp003) with SMTP; 16 Jul 2008 22:45:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WDHk2UWaWkOTGtPsdKHADoIvf0opaqx0EAHC5yq
	BnPmTe/B6PUJHc
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJDsI-0005o5-Hb; Wed, 16 Jul 2008 22:45:22 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <cover.1216233918.git.s-beyer@gmx.net> 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88749>

The migration of pure rebase-i to sequencer is simply done by
generating the todo list, but with a comment marker (`#')
before the description, and then feed it to git sequencer.

For git-rebase-i -p (preserving merges) merges should be
rewritten. For this, the sequencer instructions "mark", "merge"
and "reset" are used.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 git-rebase--interactive.sh    |  438 ++++++++++-------------------------------
 t/t3404-rebase-interactive.sh |    9 +-
 2 files changed, 113 insertions(+), 334 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index da79a24..2136e02 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -42,11 +42,6 @@ STRATEGY=
 ONTO=
 VERBOSE=
 
-GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
-mark the corrected paths with 'git add <paths>', and
-run 'git rebase --continue'"
-export GIT_CHERRY_PICK_HELP
-
 warn () {
 	echo "$*" >&2
 }
@@ -74,48 +69,6 @@ require_clean_work_tree () {
 	die "Working tree is dirty"
 }
 
-ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
-
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
-}
-
 die_abort () {
 	rm -rf "$DOTEST"
 	die "$1"
@@ -125,48 +78,20 @@ has_action () {
 	grep '^[^#]' "$1" >/dev/null
 }
 
-pick_one () {
-	no_ff=
-	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
-	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
-	test -d "$REWRITTEN" &&
-		pick_one_preserving_merges "$@" && return
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
-pick_one_preserving_merges () {
-	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
+create_todo_preserving_merges () {
+	shortsha1=$sha1
 	sha1=$(git rev-parse $sha1)
 
-	if test -f "$DOTEST"/current-commit
-	then
-		current_commit=$(cat "$DOTEST"/current-commit) &&
-		git rev-parse HEAD > "$REWRITTEN"/$current_commit &&
-		rm "$DOTEST"/current-commit ||
-		die "Cannot write current commit's replacement sha1"
-	fi
-
-	# rewrite parents; if none were rewritten, we can fast-forward.
-	fast_forward=t
 	preserve=t
 	new_parents=
+	first_parent=
 	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
 	do
+		# check if we've already seen this parent
 		if test -f "$REWRITTEN"/$p
 		then
 			preserve=f
 			new_p=$(cat "$REWRITTEN"/$p)
-			test $p != $new_p && fast_forward=f
 			case "$new_parents" in
 			*$new_p*)
 				;; # do nothing; that parent is already there
@@ -174,186 +99,49 @@ pick_one_preserving_merges () {
 				new_parents="$new_parents $new_p"
 				;;
 			esac
+		else
+			new_parents="$new_parents $p"
 		fi
+		test -n "$first_parent" || first_parent=$p
 	done
-	case $fast_forward in
-	t)
-		output warn "Fast forward to $sha1"
-		test $preserve = f || echo $sha1 > "$REWRITTEN"/$sha1
-		;;
-	f)
-		test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
-
-		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
-		# detach HEAD to current parent
-		output git checkout $first_parent 2> /dev/null ||
-			die "Cannot move HEAD to $first_parent"
-
-		echo $sha1 > "$DOTEST"/current-commit
-		case "$new_parents" in
-		' '*' '*)
-			# redo merge
-			author_script=$(get_author_ident_from_commit $sha1)
-			eval "$author_script"
-			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
-			# No point in merging the first parent, that's HEAD
-			new_parents=${new_parents# $first_parent}
-			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-				output git merge $STRATEGY -m "$msg" \
-					$new_parents
-			then
-				git rerere
-				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
-				die Error redoing merge $sha1
-			fi
-			;;
-		*)
-			output git cherry-pick "$@" ||
-				die_with_patch $sha1 "Could not pick $sha1"
-			;;
-		esac
-		;;
-	esac
-}
+	# We do not have parent, so ignore this commit
+	test t = $preserve && return
 
-nth_string () {
-	case "$1" in
-	*1[0-9]|*[04-9]) echo "$1"th;;
-	*1) echo "$1"st;;
-	*2) echo "$1"nd;;
-	*3) echo "$1"rd;;
-	esac
-}
+	# We always write a mark, because we do not know if there will
+	# be a "reset" or "merge"
+	# Filter the unneeded marks out afterwards.
+	echo "mark :$mark"
+	mark=$(($mark+1))
 
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
+	new_first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
 
-peek_next_command () {
-	sed -n "1s/ .*$//p" < "$TODO"
-}
+	# Reset if needed
+	test -z "$first_parent" -o "$first_parent" = $lastsha1 ||
+		echo "reset $new_first_parent"
 
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
+	echo ":$mark" > "$REWRITTEN"/$sha1
 
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
+	# Merge or pick
+	case "$new_parents" in
+	' '*' '*)
+		new_parents=${new_parents# $new_first_parent}
+		printf 'merge%s -C %s%s\t%s\n' "$STRATEGY" \
+			"$shortsha1" "$new_parents" "$rest"
 		;;
 	*)
-		warn "Unknown command: $command $sha1 $rest"
-		die_with_patch $sha1 "Please fix this in the file $TODO."
+		printf 'pick %s\t%s\n' "$shortsha1" "$rest"
 		;;
 	esac
-	test -s "$TODO" && return
 
-	comment_for_reflog finish &&
+	lastsha1="$sha1"
+	return 0
+}
+
+update_refs_and_exit () {
 	HEADNAME=$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=$(cat "$DOTEST"/head) &&
 	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
-	if test -d "$REWRITTEN"
-	then
-		test -f "$DOTEST"/current-commit &&
-			current_commit=$(cat "$DOTEST"/current-commit) &&
-			git rev-parse HEAD > "$REWRITTEN"/$current_commit
-		if test -f "$REWRITTEN"/$OLDHEAD
-		then
-			NEWHEAD=$(cat "$REWRITTEN"/$OLDHEAD)
-		else
-			NEWHEAD=$OLDHEAD
-		fi
-	else
-		NEWHEAD=$(git rev-parse HEAD)
-	fi &&
+	NEWHEAD=$(git rev-parse HEAD) &&
 	case $HEADNAME in
 	refs/*)
 		message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
@@ -371,13 +159,6 @@ do_next () {
 	exit
 }
 
-do_rest () {
-	while :
-	do
-		do_next
-	done
-}
-
 # check if no other options are set
 is_standalone () {
 	test $# -eq 2 -a "$2" = '--' &&
@@ -393,80 +174,47 @@ get_saved_options () {
 	test -f "$DOTEST"/verbose && VERBOSE=t
 }
 
-while test $# != 0
-do
-	case "$1" in
-	--continue)
-		is_standalone "$@" || usage
-		get_saved_options
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
+run_sequencer () {
+	git sequencer --caller='git rebase -i|--abort|--continue|--skip' "$@"
+	case "$?" in
+	0)
+		if test "$1" = --abort
 		then
-			: Nothing to commit -- skip this
+			rm -rf "$DOTEST"
+			exit
 		else
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
+			update_refs_and_exit
 		fi
-
-		require_clean_work_tree
-		do_rest
 		;;
-	--abort)
-		is_standalone "$@" || usage
-		get_saved_options
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
-		rm -rf "$DOTEST"
-		exit
+	2)
+		# pause
+		exit 0
 		;;
-	--skip)
-		is_standalone "$@" || usage
-		get_saved_options
-		comment_for_reflog skip
-
-		git rerere clear
-		test -d "$DOTEST" || die "No interactive rebase running"
+	3)
+		# conflict
+		exit 1
+		;;
+	*)
+		die_abort 'git-sequencer died unexpected.'
+		;;
+	esac
+}
 
-		output git reset --hard && do_rest
+while test $# != 0
+do
+	case "$1" in
+	--abort|--continue|--skip)
+		is_standalone "$@" || usage
+		run_sequencer "$1"
 		;;
 	-s)
 		case "$#,$1" in
 		*,*=*)
-			STRATEGY="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
+			STRATEGY=" -s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
 		1,*)
 			usage ;;
 		*)
-			STRATEGY="-s $2"
+			STRATEGY=" -s $2"
 			shift ;;
 		esac
 		;;
@@ -492,12 +240,12 @@ do
 		test $# -eq 1 -o $# -eq 2 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
+		git sequencer --status >/dev/null 2>&1 &&
+			die "Sequencer already started. Cannot run rebase."
 
 		git var GIT_COMMITTER_IDENT >/dev/null ||
 			die "You need to set your committer info first"
 
-		comment_for_reflog start
-
 		require_clean_work_tree
 
 		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
@@ -514,42 +262,72 @@ do
 		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
 		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 
-		: > "$DOTEST"/interactive || die "Could not mark as interactive"
+		: > "$DOTEST"/interactive || die_abort "Could not mark as interactive"
 		git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
 			echo "detached HEAD" > "$DOTEST"/head-name
 
 		echo $HEAD > "$DOTEST"/head
-		echo $UPSTREAM > "$DOTEST"/upstream
 		echo $ONTO > "$DOTEST"/onto
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
 		if test t = "$PRESERVE_MERGES"
 		then
+			lastsha1=
 			# $REWRITTEN contains files for each commit that is
-			# reachable by at least one merge base of $HEAD and
-			# $UPSTREAM. They are not necessarily rewritten, but
-			# their children might be.
-			# This ensures that commits on merged, but otherwise
-			# unrelated side branches are left alone. (Think "X"
-			# in the man page's example.)
+			# reachable on the way between $UPSTREAM and $HEAD.
+			# The filename is the SHA1 of the old value and the
+			# content is the SHA1 or :mark of the new one.
 			mkdir "$REWRITTEN" &&
 			for c in $(git merge-base --all $HEAD $UPSTREAM)
 			do
+				test -n "$lastsha1" || lastsha1=$c
 				echo $ONTO > "$REWRITTEN"/$c ||
 					die "Could not init rewritten commits"
 			done
-			MERGES_OPTION=
-		else
-			MERGES_OPTION=--no-merges
+			git rev-list --abbrev-commit --abbrev=7 \
+				--pretty=format:"%m%h	# %s" --topo-order \
+				--reverse --cherry-pick $UPSTREAM...$HEAD | \
+				sed -n -e "s/^>//p" > "$DOTEST"/commit-list
+
+			mark=0
+			while read -r sha1 rest
+			do
+				create_todo_preserving_merges
+			done < "$DOTEST"/commit-list > "$TODO"
+
+			# We now have more "mark :..." lines than needed.
+			# Remove the unused.  This is just a step to keep
+			# the list clean.
+			keep_marks=$(sed -e "/^mark :/d" <"$TODO" |
+				sed -n -e 's/^[^#]* :\([0-9][0-9]*\).*$/:\1:/p')
+			while read -r line
+			do
+				case "$line" in
+				'mark :'*)
+					case "$keep_marks " in
+					*${line#mark }:*)
+						echo "$line"
+						;;
+					esac
+					;;
+				*)
+					printf '%s\n' "$line"
+					;;
+				esac
+			done < "$TODO" > "$TODO".new
+			mv "$TODO".new "$TODO"
+		fi
+		if test -z "$PRESERVE_MERGES"
+		then
+			git rev-list --no-merges --abbrev-commit --abbrev=7 \
+				--pretty=format:"%mpick %h	# %s" \
+				--reverse --cherry-pick $UPSTREAM...$HEAD | \
+				sed -n -e "s/^>//p" > "$TODO"
 		fi
 
 		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
 		SHORTHEAD=$(git rev-parse --short $HEAD)
 		SHORTONTO=$(git rev-parse --short $ONTO)
-		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --cherry-pick \
-			$UPSTREAM...$HEAD | \
-			sed -n "s/^>/pick /p" > "$TODO"
 		cat >> "$TODO" << EOF
 
 # Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
@@ -575,7 +353,7 @@ EOF
 			die_abort "Nothing to do"
 
 		git update-ref ORIG_HEAD $HEAD
-		output git checkout $ONTO && do_rest
+		run_sequencer --onto "$ONTO" "$TODO"
 		;;
 	esac
 	shift
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ffe3dd9..64a28ef 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -159,19 +159,20 @@ test_expect_success 'stop on conflicting pick' '
 	git tag new-branch1 &&
 	test_must_fail git rebase -i master &&
 	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
-	test_cmp expect .git/rebase-merge/patch &&
+	test_cmp expect .git/sequencer/patch &&
 	test_cmp expect2 file1 &&
 	test "$(git-diff --name-status |
 		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
-	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
-	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
+	test 4 = $(grep -v "^#" < .git/sequencer/done | wc -l) &&
+	test 0 = $(grep -c "^[^#]" < .git/sequencer/todo) &&
+	test -d .git/rebase-merge
 '
 
 test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
-	! test -d .git/rebase-merge
+	! test -d .git/sequencer
 '
 
 test_expect_success 'retain authorship' '
-- 
1.5.6.3.391.ge45b
