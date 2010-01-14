From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 18/18] rebase -i: Retain user-edited commit messages after squash/fixup conflicts
Date: Thu, 14 Jan 2010 06:54:57 +0100
Message-ID: <41c3e65ab43be6b2f98f3c162e34c160c059bb5c.1263447038.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgf-0002Vo-Ii
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691Ab0ANFzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755607Ab0ANFzg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:36 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58648 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab0ANFze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:34 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bX001912;
	Thu, 14 Jan 2010 06:55:30 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136938>

When a squash/fixup fails due to a conflict, the user is required to
edit the commit message.  Previously, if further squash/fixup commands
followed the conflicting squash/fixup, this user-edited message was
discarded and a new automatically-generated commit message was
suggested.

Change the handling of conflicts within squash/fixup command series:
Whenever the user is required to intervene, consider the resulting
commit to be a new basis for the following squash/fixups and use its
commit message in later suggested combined commit messages.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh    |   66 +++++++++++++++++------------------------
 t/t3404-rebase-interactive.sh |   36 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c9390cd..e551906 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -410,6 +410,21 @@ peek_next_command () {
 	sed -n -e "/^#/d" -e "/^$/d" -e "s/ .*//p" -e "q" < "$TODO"
 }
 
+# A squash/fixup has failed.  Prepare the long version of the squash
+# commit message, then die_with_patch.  This code path requires the
+# user to edit the combined commit message for all commits that have
+# been squashed/fixedup so far.  So also erase the old squash
+# messages, effectively causing the combined commit to be used as the
+# new basis for any further squash/fixups.  Args: sha1 rest
+die_failed_squash() {
+	mv "$SQUASH_MSG" "$MSG" || exit
+	rm -f "$FIXUP_MSG"
+	cp "$MSG" "$GIT_DIR"/MERGE_MSG || exit
+	warn
+	warn "Could not apply $1... $2"
+	die_with_patch $1 ""
+}
+
 do_next () {
 	rm -f "$MSG" "$AUTHOR_SCRIPT" "$AMEND" || exit
 	read command sha1 rest < "$TODO"
@@ -467,58 +482,31 @@ do_next () {
 
 		mark_action_done
 		update_squash_messages $squash_style $sha1
-		failed=f
 		author_script=$(get_author_ident_from_commit HEAD)
 		echo "$author_script" > "$AUTHOR_SCRIPT"
 		eval "$author_script"
 		output git reset --soft HEAD^
-		pick_one -n $sha1 || failed=t
+		pick_one -n $sha1 || die_failed_squash $sha1 "$rest"
 		case "$(peek_next_command)" in
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			if test $failed = f
-			then
-				do_with_author output git commit --no-verify -F "$SQUASH_MSG" ||
-					failed=t
-			fi
-			if test $failed = t
-			then
-				cp "$SQUASH_MSG" "$MSG" || exit
-				# After any kind of hiccup, prevent committing without
-				# opening the commit message editor:
-				rm -f "$FIXUP_MSG"
-				cp "$MSG" "$GIT_DIR"/MERGE_MSG || exit
-				warn
-				warn "Could not apply $sha1... $rest"
-				die_with_patch $sha1 ""
-			fi
+			do_with_author output git commit --no-verify -F "$SQUASH_MSG" ||
+				die_failed_squash $sha1 "$rest"
 			;;
 		*)
 			# This is the final command of this squash/fixup group
-			if test $failed = f
+			if test -f "$FIXUP_MSG"
 			then
-				if test -f "$FIXUP_MSG"
-				then
-					do_with_author git commit --no-verify -F "$FIXUP_MSG" ||
-						failed=t
-				else
-					cp "$SQUASH_MSG" "$GIT_DIR"/SQUASH_MSG || exit
-					rm -f "$GIT_DIR"/MERGE_MSG
-					do_with_author git commit --no-verify -e ||
-						failed=t
-				fi
-			fi
-			rm -f "$FIXUP_MSG"
-			if test $failed = t
-			then
-				mv "$SQUASH_MSG" "$MSG" || exit
-				cp "$MSG" "$GIT_DIR"/MERGE_MSG || exit
-				warn
-				warn "Could not apply $sha1... $rest"
-				die_with_patch $sha1 ""
+				do_with_author git commit --no-verify -F "$FIXUP_MSG" ||
+					die_failed_squash $sha1 "$rest"
+			else
+				cp "$SQUASH_MSG" "$GIT_DIR"/SQUASH_MSG || exit
+				rm -f "$GIT_DIR"/MERGE_MSG
+				do_with_author git commit --no-verify -e ||
+					die_failed_squash $sha1 "$rest"
 			fi
-			rm -f "$SQUASH_MSG"
+			rm -f "$SQUASH_MSG" "$FIXUP_MSG"
 			;;
 		esac
 		;;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a119ce0..4e35137 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -264,6 +264,42 @@ test_expect_success 'multi-fixup does not fire up editor' '
 	git branch -D multi-fixup
 '
 
+test_expect_success 'commit message used after conflict' '
+	git checkout -b conflict-fixup conflict-branch &&
+	base=$(git rev-parse HEAD~4) &&
+	(
+		FAKE_LINES="1 fixup 3 fixup 4" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i $base
+	) &&
+	echo three > conflict &&
+	git add conflict &&
+	FAKE_COMMIT_AMEND="ONCE" EXPECT_HEADER_COUNT=2 \
+		git rebase --continue &&
+	test $base = $(git rev-parse HEAD^) &&
+	test 1 = $(git show | grep ONCE | wc -l) &&
+	git checkout to-be-rebased &&
+	git branch -D conflict-fixup
+'
+
+test_expect_success 'commit message retained after conflict' '
+	git checkout -b conflict-squash conflict-branch &&
+	base=$(git rev-parse HEAD~4) &&
+	(
+		FAKE_LINES="1 fixup 3 squash 4" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i $base
+	) &&
+	echo three > conflict &&
+	git add conflict &&
+	FAKE_COMMIT_AMEND="TWICE" EXPECT_HEADER_COUNT=2 \
+		git rebase --continue &&
+	test $base = $(git rev-parse HEAD^) &&
+	test 2 = $(git show | grep TWICE | wc -l) &&
+	git checkout to-be-rebased &&
+	git branch -D conflict-squash
+'
+
 cat > expect-squash-fixup << EOF
 B
 
-- 
1.6.6
