From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-rebase--interactive.sh: use printf instead of echo to print commit message
Date: Thu, 22 Jul 2010 14:15:11 -0500
Message-ID: <MoU2SrLLcYS4J28tNBJjfxYnqoLoX04XwHLgciB5KCUnhqJoXifmNFbSGHS4r8pboBurx-NhZWs@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 22 21:16:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc1G6-0001mF-P7
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 21:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab0GVTQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 15:16:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43544 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab0GVTQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 15:16:36 -0400
Received: by mail.nrlssc.navy.mil id o6MJFK2P028675; Thu, 22 Jul 2010 14:15:20 -0500
X-OriginalArrivalTime: 22 Jul 2010 19:15:20.0440 (UTC) FILETIME=[3A133780:01CB29D2]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151472>

From: Brandon Casey <drafnel@gmail.com>

On systems with an echo which defaults to the XSI-conformant behavior
(Solaris, or others using Ksh), echo will interpret certain backslashed
characters as control sequences.  This can cause a problem for interactive
rebase when it is used to rebase commits whose commit "subject" (the first
line) contains any of these backslashed sequences.  In this case, echo will
substitute the control sequence for the backslashed characters and either
the rebased commit message will differ from the original, or the rebase
process will fail.  Neither is desirable.

So work around this issue by replacing the echo statements used to print
out portions of the commit message, with printf.

Also, add a test to test for this breakage.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-rebase--interactive.sh    |   12 ++++++------
 t/t3404-rebase-interactive.sh |    8 +++++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 31e6860..b94c2a0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -119,7 +119,7 @@ run 'git rebase --continue'"
 export GIT_CHERRY_PICK_HELP
 
 warn () {
-	echo "$*" >&2
+	printf '%s\n' "$*" >&2
 }
 
 output () {
@@ -606,7 +606,7 @@ skip_unnecessary_picks () {
 			fd=1
 			;;
 		esac
-		echo "$command${sha1:+ }$sha1${rest:+ }$rest" >&$fd
+		printf '%s\n' "$command${sha1:+ }$sha1${rest:+ }$rest" >&$fd
 	done <"$TODO" >"$TODO.new" 3>>"$DONE" &&
 	mv -f "$TODO".new "$TODO" &&
 	case "$(peek_next_command)" in
@@ -649,12 +649,12 @@ rearrange_squash () {
 		case " $used" in
 		*" $sha1 "*) continue ;;
 		esac
-		echo "$pick $sha1 $message"
+		printf '%s\n' "$pick $sha1 $message"
 		while read -r squash action msg
 		do
 			case "$message" in
 			"$msg"*)
-				echo "$action $squash $action! $msg"
+				printf '%s\n' "$action $squash $action! $msg"
 				used="$used$squash "
 				;;
 			esac
@@ -895,7 +895,7 @@ first and then run 'git rebase --continue' again."
 		do
 			if test t != "$PRESERVE_MERGES"
 			then
-				echo "pick $shortsha1 $rest" >> "$TODO"
+				printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
 			else
 				sha1=$(git rev-parse $shortsha1)
 				if test -z "$REBASE_ROOT"
@@ -914,7 +914,7 @@ first and then run 'git rebase --continue' again."
 				if test f = "$preserve"
 				then
 					touch "$REWRITTEN"/$sha1
-					echo "pick $shortsha1 $rest" >> "$TODO"
+					printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
 				fi
 			fi
 		done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 47ca88f..9f03ce6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -637,13 +637,19 @@ test_expect_success 'set up commits with funny messages' '
 	git commit -a -m "end with slash\\" &&
 	echo >>file1 &&
 	test_tick &&
+	git commit -a -m "something (\000) that looks like octal" &&
+	echo >>file1 &&
+	test_tick &&
+	git commit -a -m "something (\n) that looks like a newline" &&
+	echo >>file1 &&
+	test_tick &&
 	git commit -a -m "another commit"
 '
 
 test_expect_success 'rebase-i history with funny messages' '
 	git rev-list A..funny >expect &&
 	test_tick &&
-	FAKE_LINES="1 2" git rebase -i A &&
+	FAKE_LINES="1 2 3 4" git rebase -i A &&
 	git rev-list A.. >actual &&
 	test_cmp expect actual
 '
-- 
1.7.2.1.g1787a
