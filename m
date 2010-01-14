From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/18] rebase -i: For fixup commands without squashes, do not start editor
Date: Thu, 14 Jan 2010 06:54:55 +0100
Message-ID: <6f72a672c95fd955508d9efa483cd4fa742a137e.1263447038.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgg-0002Vo-4P
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731Ab0ANFzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755591Ab0ANFze
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:34 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58645 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab0ANFzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:33 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bV001912;
	Thu, 14 Jan 2010 06:55:28 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136940>

If the "rebase -i" commands include a series of fixup commands without
any squash commands, then commit the combined commit using the commit
message of the corresponding "pick" without starting up the
commit-message editor.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh    |   81 +++++++++++++++++++++++++++--------------
 t/t3404-rebase-interactive.sh |    7 ++--
 2 files changed, 57 insertions(+), 31 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5a48fbf..c9390cd 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -66,6 +66,13 @@ MSG="$DOTEST"/message
 # updated.  It is deleted just before the combined commit is made.
 SQUASH_MSG="$DOTEST"/message-squash
 
+# If the current series of squash/fixups has not yet included a squash
+# command, then this file exists and holds the commit message of the
+# original "pick" commit.  (If the series ends without a "squash"
+# command, then this can be used as the commit message of the combined
+# commit without opening the editor.)
+FIXUP_MSG="$DOTEST"/message-fixup
+
 # $REWRITTEN is the name of a directory containing files for each
 # commit that is reachable by at least one merge base of $HEAD and
 # $UPSTREAM. They are not necessarily rewritten, but their children
@@ -360,7 +367,7 @@ nth_string () {
 	esac
 }
 
-update_squash_message () {
+update_squash_messages () {
 	if test -f "$SQUASH_MSG"; then
 		mv "$SQUASH_MSG" "$SQUASH_MSG".bak || exit
 		COUNT=$(($(sed -n \
@@ -373,16 +380,18 @@ update_squash_message () {
 			}' <"$SQUASH_MSG".bak
 		} >$SQUASH_MSG
 	else
+		commit_message HEAD > "$FIXUP_MSG" || die "Cannot write $FIXUP_MSG"
 		COUNT=2
 		{
 			echo "# This is a combination of 2 commits."
 			echo "# The first commit's message is:"
 			echo
-			commit_message HEAD
+			cat "$FIXUP_MSG"
 		} >$SQUASH_MSG
 	fi
 	case $1 in
 	squash)
+		rm -f "$FIXUP_MSG"
 		echo
 		echo "# This is the $(nth_string $COUNT) commit message:"
 		echo
@@ -457,7 +466,7 @@ do_next () {
 			die "Cannot '$squash_style' without a previous commit"
 
 		mark_action_done
-		update_squash_message $squash_style $sha1
+		update_squash_messages $squash_style $sha1
 		failed=f
 		author_script=$(get_author_ident_from_commit HEAD)
 		echo "$author_script" > "$AUTHOR_SCRIPT"
@@ -466,34 +475,52 @@ do_next () {
 		pick_one -n $sha1 || failed=t
 		case "$(peek_next_command)" in
 		squash|s|fixup|f)
-			USE_OUTPUT=output
-			cp "$SQUASH_MSG" "$MSG" || exit
-			MSG_OPT=-F
-			EDIT_OR_FILE="$MSG"
+			# This is an intermediate commit; its message will only be
+			# used in case of trouble.  So use the long version:
+			if test $failed = f
+			then
+				do_with_author output git commit --no-verify -F "$SQUASH_MSG" ||
+					failed=t
+			fi
+			if test $failed = t
+			then
+				cp "$SQUASH_MSG" "$MSG" || exit
+				# After any kind of hiccup, prevent committing without
+				# opening the commit message editor:
+				rm -f "$FIXUP_MSG"
+				cp "$MSG" "$GIT_DIR"/MERGE_MSG || exit
+				warn
+				warn "Could not apply $sha1... $rest"
+				die_with_patch $sha1 ""
+			fi
 			;;
 		*)
-			USE_OUTPUT=
-			MSG_OPT=
-			EDIT_OR_FILE=-e
-			cp "$SQUASH_MSG" "$MSG" || exit
-			mv "$SQUASH_MSG" "$GIT_DIR"/SQUASH_MSG || exit
-			rm -f "$GIT_DIR"/MERGE_MSG || exit
+			# This is the final command of this squash/fixup group
+			if test $failed = f
+			then
+				if test -f "$FIXUP_MSG"
+				then
+					do_with_author git commit --no-verify -F "$FIXUP_MSG" ||
+						failed=t
+				else
+					cp "$SQUASH_MSG" "$GIT_DIR"/SQUASH_MSG || exit
+					rm -f "$GIT_DIR"/MERGE_MSG
+					do_with_author git commit --no-verify -e ||
+						failed=t
+				fi
+			fi
+			rm -f "$FIXUP_MSG"
+			if test $failed = t
+			then
+				mv "$SQUASH_MSG" "$MSG" || exit
+				cp "$MSG" "$GIT_DIR"/MERGE_MSG || exit
+				warn
+				warn "Could not apply $sha1... $rest"
+				die_with_patch $sha1 ""
+			fi
+			rm -f "$SQUASH_MSG"
 			;;
 		esac
-		if test $failed = f
-		then
-			# This is like --amend, but with a different message
-			do_with_author $USE_OUTPUT git commit --no-verify \
-				$MSG_OPT "$EDIT_OR_FILE" ||
-				failed=t
-		fi
-		if test $failed = t
-		then
-			cp "$MSG" "$GIT_DIR"/MERGE_MSG
-			warn
-			warn "Could not apply $sha1... $rest"
-			die_with_patch $sha1 ""
-		fi
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 0511709..175a86c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -237,14 +237,13 @@ test_expect_success 'multi-squash only fires up editor once' '
 	test 1 = $(git show | grep ONCE | wc -l)
 '
 
-test_expect_success 'multi-fixup only fires up editor once' '
+test_expect_success 'multi-fixup does not fire up editor' '
 	git checkout -b multi-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
-	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 fixup 2 fixup 3 fixup 4" \
-		EXPECT_HEADER_COUNT=4 \
+	FAKE_COMMIT_AMEND="NEVER" FAKE_LINES="1 fixup 2 fixup 3 fixup 4" \
 		git rebase -i $base &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 1 = $(git show | grep ONCE | wc -l) &&
+	test 0 = $(git show | grep NEVER | wc -l) &&
 	git checkout to-be-rebased &&
 	git branch -D multi-fixup
 '
-- 
1.6.6
