From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 8/9] rebase: add the --gpg-sign option
Date: Mon, 10 Feb 2014 01:03:37 +0000
Message-ID: <1391994218-639101-9-git-send-email-sandals@crustytoothpaste.net>
References: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 10 02:04:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCfI2-0001Gz-RJ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 02:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbaBJBDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 20:03:52 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51750 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752166AbaBJBDr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Feb 2014 20:03:47 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5B65C2807A;
	Mon, 10 Feb 2014 01:03:46 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
In-Reply-To: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241888>

From: Nicolas Vigier <boklm@mars-attacks.org>

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-rebase.txt |  4 ++++
 git-rebase--am.sh            |  8 +++++---
 git-rebase--interactive.sh   | 39 ++++++++++++++++++++++++++-------------
 git-rebase--merge.sh         |  2 +-
 git-rebase.sh                | 11 +++++++++++
 5 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2889be6..2a93c64 100644
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
index a4f683a..df46f4c 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -6,7 +6,8 @@
 
 case "$action" in
 continue)
-	git am --resolved --resolvemsg="$resolvemsg" &&
+	git am --resolved --resolvemsg="$resolvemsg" \
+		${gpg_sign_opt:+"$gpg_sign_opt"} &&
 	move_to_original_branch
 	return
 	;;
@@ -26,7 +27,7 @@ then
 	# empty commits and even if it didn't the format doesn't really lend
 	# itself well to recording empty patches.  fortunately, cherry-pick
 	# makes this easy
-	git cherry-pick --allow-empty "$revisions"
+	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty "$revisions"
 	ret=$?
 else
 	rm -f "$GIT_DIR/rebased-patches"
@@ -60,7 +61,8 @@ else
 		return $?
 	fi
 
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
+	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
+		${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
 	ret=$?
 
 	rm -f "$GIT_DIR/rebased-patches"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 43c19e0..a1adae8 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -179,9 +179,10 @@ exit_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
 	make_patch $1
 	git rev-parse --verify HEAD > "$amend"
+	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
 	warn "You can amend the commit now, with"
 	warn
-	warn "	git commit --amend"
+	warn "	git commit --amend $gpg_sign_opt_quoted"
 	warn
 	warn "Once you are satisfied with your changes, run"
 	warn
@@ -248,7 +249,9 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
+	output eval git cherry-pick \
+			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
+			"$strategy_args" $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -351,7 +354,8 @@ pick_one_preserving_merges () {
 			new_parents=${new_parents# $first_parent}
 			merge_args="--no-log --no-ff"
 			if ! do_with_author output eval \
-			'git merge $merge_args $strategy_args -m "$msg_content" $new_parents'
+			'git merge ${gpg_sign_opt:+"$gpg_sign_opt"} \
+				$merge_args $strategy_args -m "$msg_content" $new_parents'
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
@@ -359,7 +363,9 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output eval git cherry-pick "$strategy_args" "$@" ||
+			output eval git cherry-pick \
+				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
+				"$strategy_args" "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
@@ -470,7 +476,8 @@ do_pick () {
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
 			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $1 ||
+				   --amend --no-post-rewrite -n -q -C $1 \
+				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
 		pick_one $1 ||
@@ -497,7 +504,7 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		git commit --amend --no-post-rewrite || {
+		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
 			warn "Could not amend commit after successfully picking $sha1... $rest"
 			warn "This is most likely due to an empty commit message, or the pre-commit hook"
 			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
@@ -542,19 +549,22 @@ do_next () {
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
@@ -819,14 +829,15 @@ continue)
 	else
 		if ! test -f "$author_script"
 		then
+			gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
 			die "You have staged changes in your working tree. If these changes are meant to be
 squashed into the previous commit, run:
 
-  git commit --amend
+  git commit --amend $gpg_sign_opt_quoted
 
 If they are meant to go into a new commit, run:
 
-  git commit
+  git commit $gpg_sign_opt_quoted
 
 In both case, once you're done, continue with:
 
@@ -842,10 +853,12 @@ In both case, once you're done, continue with:
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
index e7d96de..5381857 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -27,7 +27,7 @@ continue_merge () {
 	cmt=`cat "$state_dir/current"`
 	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
-		if ! git commit --no-verify -C "$cmt"
+		if ! git commit ${gpg_sign_opt:+"$gpg_sign_opt"} --no-verify -C "$cmt"
 		then
 			echo "Commit failed, please do not call \"git commit\""
 			echo "directly, but instead do one of the following: "
diff --git a/git-rebase.sh b/git-rebase.sh
index 842d7d4..5f6732b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -37,6 +37,7 @@ ignore-date!       passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
+S,gpg-sign?        GPG-sign commits
  Actions:
 continue!          continue
 abort!             abort and check out the original branch
@@ -85,6 +86,7 @@ preserve_merges=
 autosquash=
 keep_empty=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+gpg_sign_opt=
 
 read_basic_state () {
 	test -f "$state_dir/head-name" &&
@@ -107,6 +109,8 @@ read_basic_state () {
 		strategy_opts="$(cat "$state_dir"/strategy_opts)"
 	test -f "$state_dir"/allow_rerere_autoupdate &&
 		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
+	test -f "$state_dir"/gpg_sign_opt &&
+		gpg_sign_opt="$(cat "$state_dir"/gpg_sign_opt)"
 }
 
 write_basic_state () {
@@ -120,6 +124,7 @@ write_basic_state () {
 		"$state_dir"/strategy_opts
 	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
 		"$state_dir"/allow_rerere_autoupdate
+	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
 }
 
 output () {
@@ -324,6 +329,12 @@ do
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
1.9.0.rc3.1008.gd08b47c.dirty
