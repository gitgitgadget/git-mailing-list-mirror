From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] git-stash: fix flag parsing
Date: Fri, 24 Sep 2010 18:15:34 -0400
Message-ID: <1285366534-10490-1-git-send-email-brian@gernhardtsoftware.com>
References: <953B8952-8928-43B3-A05D-6AEDC5D4B565@gernhardtsoftware.com>
Cc: jon.seymour@gmail.com, robbat2@gentoo.org,
	Brandon Casey <drafnel@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:15:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGYd-0006t1-LH
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240Ab0IXWPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:15:41 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:57378 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290Ab0IXWPj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:15:39 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E70691FFC6B6; Fri, 24 Sep 2010 22:15:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id BD57D1FFC544;
	Fri, 24 Sep 2010 22:15:28 +0000 (UTC)
X-Mailer: git-send-email 1.7.3.234.g7bba3
In-Reply-To: <953B8952-8928-43B3-A05D-6AEDC5D4B565@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157071>

Currently git-stash uses `git rev-parse --no-revs -- "$@"` to set its
FLAGS variable.  This is the same as `FLAGS="-- $@"`.  It should use
`git rev-parse --no-revs --flags "$@"`, but that eats any "-q" or
"--quiet" argument.  So move the check for quiet before rev-parse.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Not the most elegant solution, but it works.

 I think we want to add the ability for git rev-parse to understand
 `git rev-parse --no-revs --flags -- "$@"`, but I'm not sure if that
 would break anything else and don't have the time to do it right now.

 (This time with the right CC list.)

 git-stash.sh     |   15 +++++++++++----
 t/t3903-stash.sh |    8 ++++----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7ce818b..b44da41 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -264,8 +264,18 @@ parse_flags_and_rev()
 	b_tree=
 	i_tree=
 
+	# Work around rev-parse --flags eating -q
+	for opt
+	do
+		case "$opt" in
+			-q|--quiet)
+				GIT_QUIET=t
+			;;
+		esac
+	done
+
 	REV=$(git rev-parse --no-flags --symbolic "$@" 2>/dev/null)
-	FLAGS=$(git rev-parse --no-revs -- "$@" 2>/dev/null)
+	FLAGS=$(git rev-parse --no-revs --flags "$@" 2>/dev/null)
 
 	set -- $FLAGS
 
@@ -273,9 +283,6 @@ parse_flags_and_rev()
 	while test $# -ne 0
 	do
 		case "$1" in
-			-q|--quiet)
-				GIT_QUIET=-t
-			;;
 			--index)
 				INDEX_OPTION=--index
 			;;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index e8a7338..9ed2396 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -406,7 +406,7 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
-test_expect_failure 'stash show - stashes on stack, stash-like argument' '
+test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
@@ -424,7 +424,7 @@ test_expect_failure 'stash show - stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'stash show -p - stashes on stack, stash-like argument' '
+test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
@@ -447,7 +447,7 @@ test_expect_failure 'stash show -p - stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'stash show - no stashes on stack, stash-like argument' '
+test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
@@ -462,7 +462,7 @@ test_expect_failure 'stash show - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'stash show -p - no stashes on stack, stash-like argument' '
+test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
-- 
1.7.3.234.g7bba3
