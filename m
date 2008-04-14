From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 10/13] Do rebase with preserve merges with advanced TODO list
Date: Mon, 14 Apr 2008 02:21:06 +0200
Message-ID: <1208132469-26471-10-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-6-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-7-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-8-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-9-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 09:39:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJHY-0000vb-7B
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbYDNHia convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 03:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbYDNHia
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:38:30 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4087 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755637AbYDNHi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 03:38:29 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 9BFE1488042; Mon, 14 Apr 2008 09:38:26 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlJFL-0000mP-Ao; Mon, 14 Apr 2008 09:36:59 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006uF-9L; Mon, 14 Apr 2008 02:21:10 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-9-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79479>

The current algorithmus used to rebase a branch with merges on top of
another has some drawbacks: it's not possible to squash commits, it's n=
ot
possible to change the order of commits, particularly the tip of the
branch can't change.

This new algorithmus uses the idea from Junio to create a TODO list wit=
h
the commands mark, merge and reset to represent the nonlinear structure
of merges.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh    |  239 ++++++++++++++++++++++++---------=
--------
 t/t3404-rebase-interactive.sh |   37 +++++++
 2 files changed, 175 insertions(+), 101 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d0a7e5c..d3327a8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -22,11 +22,9 @@ TODO=3D"$DOTEST"/git-rebase-todo
 DONE=3D"$DOTEST"/done
 MSG=3D"$DOTEST"/message
 SQUASH_MSG=3D"$DOTEST"/message-squash
-REWRITTEN=3D"$DOTEST"/rewritten
 PRESERVE_MERGES=3D
 STRATEGY=3D
 VERBOSE=3D
-test -d "$REWRITTEN" && PRESERVE_MERGES=3Dt
 test -f "$DOTEST"/strategy && STRATEGY=3D"$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=3Dt
=20
@@ -148,8 +146,6 @@ pick_one () {
 	no_ff=3D
 	case "$1" in -n) sha1=3D$2; no_ff=3Dt ;; *) sha1=3D$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha=
1"
-	test -d "$REWRITTEN" &&
-		pick_one_preserving_merges "$@" && return
 	parent_sha1=3D$(git rev-parse --verify $sha1^) ||
 		die "Could not get the parent of $sha1"
 	current_sha1=3D$(git rev-parse --verify HEAD)
@@ -163,66 +159,6 @@ pick_one () {
 	fi
 }
=20
-pick_one_preserving_merges () {
-	case "$1" in -n) sha1=3D$2 ;; *) sha1=3D$1 ;; esac
-	sha1=3D$(git rev-parse $sha1)
-
-	if test -f "$DOTEST"/current-commit
-	then
-		current_commit=3D$(cat "$DOTEST"/current-commit) &&
-		git rev-parse HEAD > "$REWRITTEN"/$current_commit &&
-		rm "$DOTEST"/current-commit ||
-		die "Cannot write current commit's replacement sha1"
-	fi
-
-	# rewrite parents; if none were rewritten, we can fast-forward.
-	fast_forward=3Dt
-	preserve=3Dt
-	new_parents=3D
-	for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
-	do
-		if test -f "$REWRITTEN"/$p
-		then
-			preserve=3Df
-			new_p=3D$(cat "$REWRITTEN"/$p)
-			test $p !=3D $new_p && fast_forward=3Df
-			case "$new_parents" in
-			*$new_p*)
-				;; # do nothing; that parent is already there
-			*)
-				new_parents=3D"$new_parents $new_p"
-				;;
-			esac
-		fi
-	done
-	case $fast_forward in
-	t)
-		output warn "Fast forward to $sha1"
-		test $preserve =3D f || echo $sha1 > "$REWRITTEN"/$sha1
-		;;
-	f)
-		test "a$1" =3D a-n && die "Refusing to squash a merge: $sha1"
-
-		first_parent=3D$(expr "$new_parents" : ' \([^ ]*\)')
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
@@ -398,20 +334,7 @@ do_next () {
 	HEADNAME=3D$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=3D$(cat "$DOTEST"/head) &&
 	SHORTONTO=3D$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
-	if test -d "$REWRITTEN"
-	then
-		test -f "$DOTEST"/current-commit &&
-			current_commit=3D$(cat "$DOTEST"/current-commit) &&
-			git rev-parse HEAD > "$REWRITTEN"/$current_commit
-		if test -f "$REWRITTEN"/$OLDHEAD
-		then
-			NEWHEAD=3D$(cat "$REWRITTEN"/$OLDHEAD)
-		else
-			NEWHEAD=3D$OLDHEAD
-		fi
-	else
-		NEWHEAD=3D$(git rev-parse HEAD)
-	fi &&
+	NEWHEAD=3D$(git rev-parse HEAD) &&
 	case $HEADNAME in
 	refs/*)
 		message=3D"$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
@@ -436,6 +359,130 @@ do_rest () {
 	done
 }
=20
+get_value_from_list () {
+	# args: "key" " key1#value1 key2#value2"
+	case "$2" in
+	*" $1#"*)
+		stm_tmp=3D"${2#* $1#}"
+		echo "${stm_tmp%% *}"
+		unset stm_tmp
+		;;
+	*)
+		return 1
+		;;
+	esac
+}
+
+insert_value_at_key_into_list () {
+	# args: "value" "key" " key1#value1 key2#value2"
+	case "$3 " in
+	*" $2#$1 "*)
+		echo "$3"
+		;;
+	*" $2#"*)
+		echo "$3"
+		return 1
+		;;
+	*)
+		echo "$3 $2#$1"
+		;;
+	esac
+}
+
+create_extended_todo_list () {
+	(
+	while IFS=3D_ read commit parents subject
+	do
+		if test "${last_parent:-$commit}" !=3D "$commit"
+		then
+			if test t =3D "${delayed_mark:-f}"
+			then
+				marked_commits=3D$(insert_value_at_key_into_list \
+					dummy $last_parent "${marked_commits:-}")
+				delayed_mark=3Df
+			fi
+			test "$last_parent" =3D $SHORTUPSTREAM && \
+				last_parent=3D$SHORTONTO
+			echo "reset $last_parent"
+		fi
+		last_parent=3D"${parents%% *}"
+
+		get_value_from_list $commit "${marked_commits:-}" \
+			>/dev/null && echo mark
+
+		case "$parents" in
+		*' '*)
+			delayed_mark=3Dt
+			new_parents=3D
+			for p in ${parents#* }
+			do
+				marked_commits=3D$(insert_value_at_key_into_list \
+					dummy "$p" "${marked_commits:-}")
+				if test "$p" =3D $SHORTUPSTREAM
+				then
+					new_parents=3D"$new_parents $SHORTONTO"
+				else
+					new_parents=3D"$new_parents $p"
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
+	test -n "${last_parent:-}" -a "${last_parent:-}" !=3D $SHORTUPSTREAM =
&& \
+		echo reset $last_parent
+	) | \
+	tac | \
+	while read cmd args
+	do
+		: ${commit_mark_list:=3D} ${last_commit:=3D000}
+		case "$cmd" in
+		pick)
+			last_commit=3D"${args%% *}"
+			;;
+		mark)
+			: ${next_mark:=3D0}
+			if commit_mark_list=3D$(insert_value_at_key_into_list \
+				$next_mark $last_commit "$commit_mark_list")
+			then
+				args=3D":$next_mark"
+				next_mark=3D$(($next_mark + 1))
+			else
+				die "Internal error: two marks for" \
+					"the same commit"
+			fi
+			;;
+		reset)
+			if tmp=3D$(get_value_from_list $args "$commit_mark_list")
+			then
+				args=3D":$tmp"
+			fi
+			;;
+		merge)
+			new_args=3D
+			for i in ${args#* }
+			do
+				if tmp=3D$(get_value_from_list $i \
+					"$commit_mark_list")
+				then
+					new_args=3D"$new_args :$tmp"
+				else
+					new_args=3D"$new_args $i"
+				fi
+			done
+			last_commit=3D"${args%% *}"
+			args=3D"$last_commit ${new_args# }"
+			;;
+		esac
+		echo "$cmd $args"
+	done
+}
+
 while test $# !=3D 0
 do
 	case "$1" in
@@ -568,33 +615,23 @@ do
 		echo $ONTO > "$DOTEST"/onto
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t =3D "$VERBOSE" && : > "$DOTEST"/verbose
-		if test t =3D "$PRESERVE_MERGES"
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
-			MERGES_OPTION=3D
-		else
-			MERGES_OPTION=3D--no-merges
-		fi
=20
 		SHORTUPSTREAM=3D$(git rev-parse --short=3D7 $UPSTREAM)
 		SHORTHEAD=3D$(git rev-parse --short=3D7 $HEAD)
 		SHORTONTO=3D$(git rev-parse --short=3D7 $ONTO)
-		git rev-list $MERGES_OPTION --pretty=3Doneline --abbrev-commit \
-			--abbrev=3D7 --reverse --left-right --cherry-pick \
-			$UPSTREAM...$HEAD | \
-			sed -n "s/^>/pick /p" > "$TODO"
+		common_rev_list_opts=3D"--abbrev-commit --abbrev=3D7
+			--left-right --cherry-pick $UPSTREAM...$HEAD"
+		if test t =3D "$PRESERVE_MERGES"
+		then
+			git rev-list --pretty=3D'format:%h_%p_%s' --topo-order \
+				$common_rev_list_opts | \
+				grep -v ^commit | \
+				create_extended_todo_list
+		else
+			git rev-list --no-merges --reverse --pretty=3Doneline \
+				 $common_rev_list_opts | sed -n "s/^>/pick /p"
+		fi > "$TODO"
+
 		cat >> "$TODO" << EOF
=20
 # Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 0a8d065..f919aaf 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -258,7 +258,44 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD~2:file1) =3D B
 '
=20
+test_expect_success 'rebase with preserve merge forth and back is a no=
op' '
+	git checkout -b big-branch-1 master &&
+	test_tick &&
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
+	tbp_merge=3D$(git rev-parse HEAD) &&
+	: > bb2c &&
+	git add bb2c &&
+	git commit -m "big branch commit 6" &&
+	git merge big-branch-1 &&
+	head=3D$(git rev-parse HEAD) &&
+	FAKE_LINES=3D"16 6 19 20 4 1 2 5 22" \
+		git rebase -i -p --onto dead-end master &&
+	test "$head" !=3D "$(git rev-parse HEAD)" &&
+	FAKE_LINES=3D"3 7 mark:10 8 9 5 1 2 merge$tbp_merge~1/:10 \
+		merge$tbp_merge/to-be-preserved 6 11" \
+		git rebase -i -p --onto master dead-end &&
+	test "$head" =3D "$(git rev-parse HEAD)"
+'
+
 test_expect_success '--continue tries to commit' '
+	git checkout to-be-rebased &&
 	test_tick &&
 	! git rebase -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
--=20
1.5.5
