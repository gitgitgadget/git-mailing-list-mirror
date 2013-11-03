From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 8/8] rebase: add the --gpg-sign option
Date: Sun,  3 Nov 2013 16:54:24 +0100
Message-ID: <1383494064-5653-9-git-send-email-boklm@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:55:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd01N-0008GH-LU
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab3KCPzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:55:16 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35800 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab3KCPyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 5C53648C9
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:55:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yLZ4l-PCV2lT; Sun,  3 Nov 2013 16:55:07 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 8A8EA4E62;
	Sun,  3 Nov 2013 16:55:06 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 2F2FF43934; Sun,  3 Nov 2013 16:54:50 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237269>

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/git-rebase.txt |  4 ++++
 git-rebase--am.sh            |  8 +++++---
 git-rebase--interactive.sh   | 32 ++++++++++++++++++++------------
 git-rebase--merge.sh         |  2 +-
 git-rebase.sh                | 11 +++++++++++
 5 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 94e07fdab550..ed25bc3e41d1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -281,6 +281,10 @@ which makes little sense.
 	specified, `-s recursive`.  Note the reversal of 'ours' and
 	'theirs' as noted above for the `-m` option.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign commits.
+
 -q::
 --quiet::
 	Be quiet. Implies --no-stat.
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 34e3102fcbfa..82ed63dd7874 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -5,7 +5,8 @@
 
 case "$action" in
 continue)
-	git am --resolved --resolvemsg="$resolvemsg" &&
+	git am --resolved --resolvemsg="$resolvemsg" \
+		${gpg_sign_opt:+"$gpg_sign_opt"} &&
 	move_to_original_branch
 	return
 	;;
@@ -25,7 +26,7 @@ then
 	# empty commits and even if it didn't the format doesn't really lend
 	# itself well to recording empty patches.  fortunately, cherry-pick
 	# makes this easy
-	git cherry-pick --allow-empty "$revisions"
+	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty "$revisions"
 	ret=$?
 else
 	rm -f "$GIT_DIR/rebased-patches"
@@ -59,7 +60,8 @@ else
 		return $?
 	fi
 
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
+	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
+		${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
 	ret=$?
 
 	rm -f "$GIT_DIR/rebased-patches"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3c6bed9a28f7..8aac6a85b192 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -184,7 +184,7 @@ exit_with_patch () {
 	git rev-parse --verify HEAD > "$amend"
 	warn "You can amend the commit now, with"
 	warn
-	warn "	git commit --amend"
+	warn "	git commit --amend $gpg_sign_opt"
 	warn
 	warn "Once you are satisfied with your changes, run"
 	warn
@@ -251,7 +251,8 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
+	output eval git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} \
+			"$strategy_args" $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -362,7 +363,8 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output eval git cherry-pick "$strategy_args" "$@" ||
+			output eval git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} \
+				"$strategy_args" "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
@@ -473,7 +475,8 @@ do_pick () {
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
 			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $1 ||
+				   --amend --no-post-rewrite -n -q -C $1 \
+				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
 		pick_one $1 ||
@@ -500,7 +503,7 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --amend --no-post-rewrite || {
+		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			warn "This is most likely due to an empty commit message, or the pre-commit hook"
 			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
@@ -545,19 +548,22 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			do_with_author output git commit --amend --no-verify -F "$squash_msg" ||
+			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
+				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die_failed_squash $sha1 "$rest"
 			;;
 		*)
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				do_with_author git commit --amend --no-verify -F "$fixup_msg" ||
+				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
+					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
-				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e ||
+				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
+					${gpg_sign_opt:+"$gpg_sign_opt"} ||
 					die_failed_squash $sha1 "$rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
@@ -825,11 +831,11 @@ continue)
 			die "You have staged changes in your working tree. If these changes are meant to be
 squashed into the previous commit, run:
 
-  git commit --amend
+  git commit --amend $gpg_sign_opt
 
 If they are meant to go into a new commit, run:
 
-  git commit
+  git commit $gpg_sign_opt
 
 In both case, once you're done, continue with:
 
@@ -845,10 +851,12 @@ In both case, once you're done, continue with:
 			die "\
 You have uncommitted changes in your working tree. Please, commit them
 first and then run 'git rebase --continue' again."
-			do_with_author git commit --amend --no-verify -F "$msg" -e ||
+			do_with_author git commit --amend --no-verify -F "$msg" -e \
+				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
 		else
-			do_with_author git commit --no-verify -F "$msg" -e ||
+			do_with_author git commit --no-verify -F "$msg" -e \
+				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
 		fi
 	fi
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 16d18176ece5..1e747424c22e 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -25,7 +25,7 @@ continue_merge () {
 	cmt=`cat "$state_dir/current"`
 	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
-		if ! git commit --no-verify -C "$cmt"
+		if ! git commit ${gpg_sign_opt:+"$gpg_sign_opt"} --no-verify -C "$cmt"
 		then
 			echo "Commit failed, please do not call \"git commit\""
 			echo "directly, but instead do one of the following: "
diff --git a/git-rebase.sh b/git-rebase.sh
index a6c294b2289b..a2c0ea3cf4ba 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -36,6 +36,7 @@ ignore-date!       passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
+S,gpg-sign?        GPG-sign commits
  Actions:
 continue!          continue
 abort!             abort and check out the original branch
@@ -83,6 +84,7 @@ preserve_merges=
 autosquash=
 keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+gpg_sign_opt=
 
 read_basic_state () {
 	test -f "$state_dir/head-name" &&
@@ -105,6 +107,8 @@ read_basic_state () {
 		strategy_opts="$(cat "$state_dir"/strategy_opts)"
 	test -f "$state_dir"/allow_rerere_autoupdate &&
 		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
+	test -f "$state_dir"/gpg_sign_opt &&
+		gpg_sign_opt="$(cat "$state_dir"/gpg_sign_opt)"
 }
 
 write_basic_state () {
@@ -118,6 +122,7 @@ write_basic_state () {
 		"$state_dir"/strategy_opts
 	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
 		"$state_dir"/allow_rerere_autoupdate
+	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
 }
 
 output () {
@@ -316,6 +321,12 @@ do
 	--rerere-autoupdate|--no-rerere-autoupdate)
 		allow_rerere_autoupdate="$1"
 		;;
+	--gpg-sign)
+		gpg_sign_opt=-S
+		;;
+	--gpg-sign=*)
+		gpg_sign_opt="-S${1#--gpg-sign=}"
+		;;
 	--)
 		shift
 		break
-- 
1.8.4.2
