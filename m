From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 5/6] rebase -i: invoke post-rewrite hook
Date: Sun, 14 Feb 2010 17:17:10 +0100
Message-ID: <b32eedebe7dceced1f1714d4a3ffd064fe74ef36.1266164150.git.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:17:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NghAP-0003W2-Eq
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab0BNQRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:17:39 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:1994 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab0BNQRg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:17:36 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:33 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:13 +0100
X-Mailer: git-send-email 1.7.0.216.g74d8e
In-Reply-To: <cover.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139921>

Aside from the same issue that rebase also has (remembering the
original commit across a conflict resolution), rebase -i brings an
extra twist: We need to defer writing the rewritten list in the case
of {squash,fixup} because their rewritten result should be the last
commit in the squashed group.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-rebase--interactive.sh   |   39 +++++++++++++++++++++
 t/t5407-post-rewrite-hook.sh |   78 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5735859..fc4f7e9 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -96,6 +96,13 @@ AUTHOR_SCRIPT="$DOTEST"/author-script
 # command is processed, this file is deleted.
 AMEND="$DOTEST"/amend
 
+# For the post-rewrite hook, we make a list of rewritten commits and
+# their new sha1s.  The rewritten-pending list keeps the sha1s of
+# commits that have been processed, but not committed yet,
+# e.g. because they are waiting for a 'squash' command.
+REWRITTEN_LIST="$DOTEST"/rewritten-list
+REWRITTEN_PENDING="$DOTEST"/rewritten-pending
+
 PRESERVE_MERGES=
 STRATEGY=
 ONTO=
@@ -198,6 +205,7 @@ make_patch () {
 }
 
 die_with_patch () {
+	echo "$1" > "$DOTEST"/conflicted-sha
 	make_patch "$1"
 	git rerere
 	die "$2"
@@ -348,6 +356,7 @@ pick_one_preserving_merges () {
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
 			fi
+			echo "$sha1 $(git rev-parse HEAD^0)" >> "$REWRITTEN_LIST"
 			;;
 		*)
 			output git cherry-pick "$@" ||
@@ -425,6 +434,26 @@ die_failed_squash() {
 	die_with_patch $1 ""
 }
 
+flush_rewritten_pending() {
+	test -s "$REWRITTEN_PENDING" || return
+	newsha1="$(git rev-parse HEAD^0)"
+	sed "s/$/ $newsha1/" < "$REWRITTEN_PENDING" >> "$REWRITTEN_LIST"
+	rm -f "$REWRITTEN_PENDING"
+}
+
+record_in_rewritten() {
+	oldsha1="$(git rev-parse $1)"
+	echo "$oldsha1" >> "$REWRITTEN_PENDING"
+
+	case "$(peek_next_command)" in
+	    squash|s|fixup|f)
+		;;
+	    *)
+		flush_rewritten_pending
+		;;
+	esac
+}
+
 do_next () {
 	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
 	read command sha1 rest < "$TODO"
@@ -438,6 +467,7 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
+		record_in_rewritten $sha1
 		;;
 	reword|r)
 		comment_for_reflog reword
@@ -446,6 +476,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		git commit --amend --no-post-rewrite
+		record_in_rewritten $sha1
 		;;
 	edit|e)
 		comment_for_reflog edit
@@ -454,6 +485,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
+		record_in_rewritten "$sha1"
 		git rev-parse --verify HEAD > "$AMEND"
 		warn "Stopped at $sha1... $rest"
 		warn "You can amend the commit now, with"
@@ -509,6 +541,7 @@ do_next () {
 			rm -f "$SQUASH_MSG" "$FIXUP_MSG"
 			;;
 		esac
+		record_in_rewritten $sha1
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
@@ -537,6 +570,11 @@ do_next () {
 		test ! -f "$DOTEST"/verbose ||
 			git diff-tree --stat $(cat "$DOTEST"/head)..HEAD
 	} &&
+	if test -x "$GIT_DIR"/hooks/post-rewrite &&
+		test -s "$REWRITTEN_LIST"; then
+		"$GIT_DIR"/hooks/post-rewrite rebase < "$REWRITTEN_LIST"
+		true # we don't care if this hook failed
+	fi &&
 	rm -rf "$DOTEST" &&
 	git gc --auto &&
 	warn "Successfully rebased and updated $HEADNAME."
@@ -685,6 +723,7 @@ first and then run 'git rebase --continue' again."
 				test -n "$amend" && git reset --soft $amend
 				die "Could not commit staged changes."
 			}
+			record_in_rewritten "$(cat "$DOTEST"/conflicted-sha)"
 		fi
 
 		require_clean_work_tree
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index d6438a7..d3ac469 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -99,4 +99,82 @@ EOF
 	verify_hook_input
 '
 
+test_expect_success 'git rebase -m' '
+	git reset --hard D &&
+	clear_hook_input &&
+	test_must_fail git rebase -m --onto A B &&
+	echo C > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD^)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
+test_expect_success 'git rebase -m --skip' '
+	git reset --hard D &&
+	clear_hook_input &&
+	test_must_fail git rebase --onto A B &&
+	test_must_fail git rebase --skip &&
+	echo D > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+test_expect_success 'git rebase -i (unchanged)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="1 2" test_must_fail git rebase -i --onto A B &&
+	echo C > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD^)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
+test_expect_success 'git rebase -i (skip)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="2" test_must_fail git rebase -i --onto A B &&
+	echo D > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
+test_expect_success 'git rebase -i (squash)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="1 squash 2" test_must_fail git rebase -i --onto A B &&
+	echo C > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
 test_done
-- 
1.7.0.216.g74d8e
