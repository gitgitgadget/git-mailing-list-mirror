From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH/RFC 10/10] Do rebase with preserve merges with advanced TODO list
Date: Thu, 10 Apr 2008 01:58:41 +0200
Message-ID: <1207785521-27742-11-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-6-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-7-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-8-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-9-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-10-git-send-email-joerg@alea.gnuu.de>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 02:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkGz-0004V7-Su
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbYDJADO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbYDJADO
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:03:14 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3452 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800AbYDJADF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:03:05 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 00210488051; Thu, 10 Apr 2008 02:03:01 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBf-0004mD-P7; Thu, 10 Apr 2008 01:58:44 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JjkBf-0007Ew-0W; Thu, 10 Apr 2008 01:58:43 +0200
X-Mailer: git-send-email 1.5.4.5
In-Reply-To: <1207785521-27742-10-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79149>

---
 git-rebase--interactive.sh    |  248 ++++++++++++++++++++++++-----------------
 t/t3404-rebase-interactive.sh |   34 ++++++
 2 files changed, 181 insertions(+), 101 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 060b40f..27bd87e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -22,12 +22,10 @@ TODO="$DOTEST"/git-rebase-todo
 DONE="$DOTEST"/done
 MSG="$DOTEST"/message
 SQUASH_MSG="$DOTEST"/message-squash
-REWRITTEN="$DOTEST"/rewritten
 MARKS="$DOTEST"/marks
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
-test -d "$REWRITTEN" && PRESERVE_MERGES=t
 test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=t
 
@@ -137,8 +135,6 @@ pick_one () {
 	no_ff=
 	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
-	test -d "$REWRITTEN" &&
-		pick_one_preserving_merges "$@" && return
 	parent_sha1=$(git rev-parse --verify $sha1^) ||
 		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
@@ -152,66 +148,6 @@ pick_one () {
 	fi
 }
 
-pick_one_preserving_merges () {
-	case "$1" in -n) sha1=$2 ;; *) sha1=$1 ;; esac
-	sha1=$(git rev-parse $sha1)
-
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
-	preserve=t
-	new_parents=
-	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
-	do
-		if test -f "$REWRITTEN"/$p
-		then
-			preserve=f
-			new_p=$(cat "$REWRITTEN"/$p)
-			test $p != $new_p && fast_forward=f
-			case "$new_parents" in
-			*$new_p*)
-				;; # do nothing; that parent is already there
-			*)
-				new_parents="$new_parents $new_p"
-				;;
-			esac
-		fi
-	done
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
-			# No point in merging the first parent, that's HEAD
-			redo_merge $sha1 ${new_parents# $first_parent}
-			;;
-		*)
-			output git cherry-pick "$@" ||
-				die_with_patch $sha1 "Could not pick $sha1"
-			;;
-		esac
-		;;
-	esac
-}
-
 nth_string () {
 	case "$1" in
 	*1[0-9]|*[04-9]) echo "$1"th;;
@@ -410,20 +346,7 @@ do_next () {
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
@@ -448,6 +371,138 @@ do_rest () {
 	done
 }
 
+sha1_to_mark() {
+	# args: "sha1" " sha1#mark sha1#mark"
+	local tmp
+	case "$2" in
+	*" $1#"*)
+		tmp="${2#* $1#}"
+		echo "${tmp%% *}"
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
+insert_sha1_with_mark_in_list() {
+	# args: "sha1" "mark" " sha1#mark sha1#mark"
+	case "$3" in
+	*" $1#"*)
+		echo "$3"
+		return 1
+		;;
+	*)
+		echo "$3 $1#$2"
+		;;
+	esac
+}
+
+create_extended_todo_list() {
+	(
+	while IFS=_ read commit parents subject
+	do
+		if test "${last_parent:-$commit}" != "$commit"
+		then
+			if test t = "${delayed_mark:-f}"
+			then
+				case "${marked_commits:-} " in
+				*" $last_parent ")
+					;;
+				*)
+					marked_commits="${marked_commits:-} $last_parent"
+					;;
+				esac
+				delayed_mark=f
+			fi
+			test "$last_parent" = $SHORTUPSTREAM && \
+				last_parent=$SHORTONTO
+			echo "reset $last_parent"
+		fi
+		last_parent="${parents%% *}"
+
+		case "${marked_commits:-} " in
+		*" $commit "*)
+			echo mark
+			;;
+		esac
+
+		case "$parents" in
+		*' '*)
+			delayed_mark=t
+			new_parents=
+			for p in ${parents#* }
+			do
+				case "${marked_commits:-} " in
+				*" $p ")
+					;;
+				*)
+					marked_commits="${marked_commits:-} $p"
+					;;
+				esac
+				if test "$p" = $SHORTUPSTREAM
+				then
+					new_parents="$new_parents $SHORTONTO"
+				else
+					new_parents="$new_parents $p"
+				fi
+			done
+			unset p
+			echo merge $commit $new_parents
+			unset new_parents
+			;;
+		*)
+			echo "pick $commit $subject"
+			;;
+		esac
+	done
+	test -n "${last_parent:-}" -a "${last_parent:-}" != $SHORTUPSTREAM && \
+		echo reset $last_parent
+	) | \
+	tac | \
+	while read cmd args
+	do
+		: ${commit_mark_list:=} ${last_commit:=000}
+		case "$cmd" in
+		pick)
+			last_commit="${args%% *}"
+			;;
+		mark)
+			: ${next_mark:=0}
+			if commit_mark_list=$(insert_sha1_with_mark_in_list \
+				$last_commit $next_mark "$commit_mark_list")
+			then
+				args="#$next_mark"
+				next_mark=$(($next_mark + 1))
+			else
+				die "Internal error: two marks for the same commit"
+			fi
+			;;
+		reset)
+			if tmp=$(sha1_to_mark $args "$commit_mark_list")
+			then
+				args="#$tmp"
+			fi
+			;;
+		merge)
+			new_args=
+			for i in ${args#* }
+			do
+				if tmp=$(sha1_to_mark $i "$commit_mark_list")
+				then
+					new_args="$new_args #$tmp"
+				else
+					new_args="$new_args $i"
+				fi
+			done
+			last_commit="${args%% *}"
+			args="$last_commit ${new_args# }"
+			;;
+		esac
+		echo "$cmd $args"
+	done
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -580,33 +635,24 @@ do
 		echo $ONTO > "$DOTEST"/onto
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
-		if test t = "$PRESERVE_MERGES"
-		then
-			# $REWRITTEN contains files for each commit that is
-			# reachable by at least one merge base of $HEAD and
-			# $UPSTREAM. They are not necessarily rewritten, but
-			# their children might be.
-			# This ensures that commits on merged, but otherwise
-			# unrelated side branches are left alone. (Think "X"
-			# in the man page's example.)
-			mkdir "$REWRITTEN" &&
-			for c in $(git merge-base --all $HEAD $UPSTREAM)
-			do
-				echo $ONTO > "$REWRITTEN"/$c ||
-					die "Could not init rewritten commits"
-			done
-			MERGES_OPTION=
-		else
-			MERGES_OPTION=--no-merges
-		fi
 
 		SHORTUPSTREAM=$(git rev-parse --short=7 $UPSTREAM)
 		SHORTHEAD=$(git rev-parse --short=7 $HEAD)
 		SHORTONTO=$(git rev-parse --short=7 $ONTO)
-		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --cherry-pick \
-			$UPSTREAM...$HEAD | \
-			sed -n "s/^>/pick /p" > "$TODO"
+		common_rev_parse_opts="--abbrev-commit
+			--abbrev=7 --left-right --cherry-pick
+			$UPSTREAM...$HEAD"
+		if test t = "$PRESERVE_MERGES"
+		then
+			git rev-list --pretty='format:%h_%p_%s' \
+				--topo-order $common_rev_parse_opts | \
+				grep -v ^commit | \
+				create_extended_todo_list
+		else
+			git rev-list --no-merges --reverse --pretty=oneline \
+				$common_rev_parse_opts | sed -n "s/^>/pick /p"
+		fi > "$TODO"
+
 		cat >> "$TODO" << EOF
 
 # Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index be26a78..af7d818 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -245,7 +245,41 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD~2:file1) = B
 '
 
+test_expect_success 'rebase with preserve merge forth and back is a noop' '
+	git checkout -b big-branch-1 master &&
+	: > bb1a &&
+	git add bb1a &&
+	git commit -m "big branch commit 1" &&
+	: > bb1b &&
+	git add bb1b &&
+	git commit -m "big branch commit 2" &&
+	: > bb1c &&
+	git add bb1c &&
+	git commit -m "big branch commit 3" &&
+	git checkout -b big-branch-2 master &&
+	: > bb2a &&
+	git add bb2a &&
+	git commit -m "big branch commit 4" &&
+	: > bb2b &&
+	git add bb2b &&
+	git commit -m "big branch commit 5" &&
+	git merge big-branch-1~1 &&
+	git merge to-be-preserved &&
+	tbp_merge=$(git rev-parse HEAD) &&
+	: > bb2c &&
+	git add bb2c &&
+	git commit -m "big branch commit 6" &&
+	git merge big-branch-1 &&
+	head=$(git rev-parse HEAD) &&
+	FAKE_LINES="16 6 19 20 4 1 2 5 22" \
+		git rebase -i -p --onto dead-end master &&
+	FAKE_LINES="3 7 mark#10 8 9 5 1 2 merge$tbp_merge~1/#10 merge$tbp_merge/to-be-preserved 6 11" \
+	git rebase -i -p --onto master dead-end &&
+	test "$head" = "$(git rev-parse HEAD)"
+'
+
 test_expect_success '--continue tries to commit' '
+	git checkout to-be-rebased &&
 	test_tick &&
 	! git rebase -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
-- 
1.5.4.5
