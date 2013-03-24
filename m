From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 13/15] t7600: use test_config to set/unset git config variables
Date: Sun, 24 Mar 2013 22:06:12 +0100
Message-ID: <48e5b9a14fdebd7257d859eda05477dc2956d525.1364158574.git.ydroneaud@opteya.com>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJsRX-00088J-L9
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab3CXV0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:26:39 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:43921 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026Ab3CXV0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:26:38 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:c8b1:2f86:54cb:a84a])
	by smtp1-g21.free.fr (Postfix) with ESMTP id CAB4D9401D1;
	Sun, 24 Mar 2013 22:26:28 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2OL6obL007315;
	Sun, 24 Mar 2013 22:06:50 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2OL6ogX007314;
	Sun, 24 Mar 2013 22:06:50 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1364158574.git.ydroneaud@opteya.com>
References: <cover.1364158574.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218998>

Instead of using construct such as:
    test_when_finished "git config --unset <key>"
    git config <key> <value>
uses
    test_config <key> <value>
The latter takes care of removing <key> at the end of the test.

Tests are modified to assume default configuration at entry,
and to reset the modified configuration variables at the end.

Test 'merge log message' was relying on the presence of option `--no-ff`
in the configuration. With the option, git show -s --pretty=format:%b HEAD
produces an empty line and without the option, it produces an empty file.
The test is modified to check with and without `--no-ff` option.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t7600-merge.sh | 60 ++++++++++++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5e19598..2f70433 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -56,7 +56,8 @@ create_merge_msgs () {
 		echo &&
 		git log --no-merges ^HEAD c2 c3
 	} >squash.1-5-9 &&
-	echo >msg.nolog &&
+	: >msg.nologff &&
+	echo >msg.nolognoff &&
 	{
 		echo "* tag 'c3':" &&
 		echo "  commit 3" &&
@@ -244,8 +245,7 @@ test_expect_success 'merges with --ff-only' '
 test_expect_success 'merges with merge.ff=only' '
 	git reset --hard c1 &&
 	test_tick &&
-	test_when_finished "git config --unset merge.ff" &&
-	git config merge.ff only &&
+	test_config merge.ff "only" &&
 	test_must_fail git merge c2 &&
 	test_must_fail git merge c3 &&
 	test_must_fail git merge c2 c3 &&
@@ -336,7 +336,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (no-commit in config)' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--no-commit" &&
+	test_config branch.master.mergeoptions "--no-commit" &&
 	git merge c2 &&
 	verify_merge file result.1-5 &&
 	verify_head $c1 &&
@@ -346,12 +346,11 @@ test_expect_success 'merge c1 with c2 (no-commit in config)' '
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (log in config)' '
-	git config branch.master.mergeoptions "" &&
 	git reset --hard c1 &&
 	git merge --log c2 &&
 	git show -s --pretty=tformat:%s%n%b >expect &&
 
-	git config branch.master.mergeoptions --log &&
+	test_config branch.master.mergeoptions "--log" &&
 	git reset --hard c1 &&
 	git merge c2 &&
 	git show -s --pretty=tformat:%s%n%b >actual &&
@@ -360,17 +359,12 @@ test_expect_success 'merge c1 with c2 (log in config)' '
 '
 
 test_expect_success 'merge c1 with c2 (log in config gets overridden)' '
-	test_when_finished "git config --remove-section branch.master" &&
-	test_when_finished "git config --remove-section merge" &&
-	test_might_fail git config --remove-section branch.master &&
-	test_might_fail git config --remove-section merge &&
-
 	git reset --hard c1 &&
 	git merge c2 &&
 	git show -s --pretty=tformat:%s%n%b >expect &&
 
-	git config branch.master.mergeoptions "--no-log" &&
-	git config merge.log true &&
+	test_config branch.master.mergeoptions "--no-log" &&
+	test_config merge.log "true" &&
 	git reset --hard c1 &&
 	git merge c2 &&
 	git show -s --pretty=tformat:%s%n%b >actual &&
@@ -380,7 +374,7 @@ test_expect_success 'merge c1 with c2 (log in config gets overridden)' '
 
 test_expect_success 'merge c1 with c2 (squash in config)' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--squash" &&
+	test_config branch.master.mergeoptions "--squash" &&
 	git merge c2 &&
 	verify_merge file result.1-5 &&
 	verify_head $c1 &&
@@ -392,7 +386,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option -n with --summary' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "-n" &&
+	test_config branch.master.mergeoptions "-n" &&
 	test_tick &&
 	git merge --summary c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -406,7 +400,7 @@ test_expect_success 'override config option -n with --summary' '
 
 test_expect_success 'override config option -n with --stat' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "-n" &&
+	test_config branch.master.mergeoptions "-n" &&
 	test_tick &&
 	git merge --stat c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -422,7 +416,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option --stat' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--stat" &&
+	test_config branch.master.mergeoptions "--stat" &&
 	test_tick &&
 	git merge -n c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -438,7 +432,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (override --no-commit)' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--no-commit" &&
+	test_config branch.master.mergeoptions "--no-commit" &&
 	test_tick &&
 	git merge --commit c2 &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -449,7 +443,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (override --squash)' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--squash" &&
+	test_config branch.master.mergeoptions "--squash" &&
 	test_tick &&
 	git merge --no-squash c2 &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -460,7 +454,6 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c0 with c1 (no-ff)' '
 	git reset --hard c0 &&
-	git config branch.master.mergeoptions "" &&
 	test_tick &&
 	git merge --no-ff c1 &&
 	verify_merge file result.1 &&
@@ -471,10 +464,9 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c0 with c1 (merge.ff=false)' '
 	git reset --hard c0 &&
-	git config merge.ff false &&
+	test_config merge.ff "false" &&
 	test_tick &&
 	git merge c1 &&
-	git config --remove-section merge &&
 	verify_merge file result.1 &&
 	verify_parents $c0 $c1
 '
@@ -482,22 +474,19 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'combine branch.master.mergeoptions with merge.ff' '
 	git reset --hard c0 &&
-	git config branch.master.mergeoptions --ff &&
-	git config merge.ff false &&
+	test_config branch.master.mergeoptions "--ff" &&
+	test_config merge.ff "false" &&
 	test_tick &&
 	git merge c1 &&
-	git config --remove-section "branch.master" &&
-	git config --remove-section "merge" &&
 	verify_merge file result.1 &&
 	verify_parents "$c0"
 '
 
 test_expect_success 'tolerate unknown values for merge.ff' '
 	git reset --hard c0 &&
-	git config merge.ff something-new &&
+	test_config merge.ff "something-new" &&
 	test_tick &&
 	git merge c1 2>message &&
-	git config --remove-section "merge" &&
 	verify_head "$c1" &&
 	test_cmp empty message
 '
@@ -515,7 +504,7 @@ test_expect_success 'combining --ff-only and --no-ff is refused' '
 
 test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
 	git reset --hard c0 &&
-	git config branch.master.mergeoptions "--no-ff" &&
+	test_config branch.master.mergeoptions "--no-ff" &&
 	git merge --ff c1 &&
 	verify_merge file result.1 &&
 	verify_head $c1
@@ -525,14 +514,20 @@ test_expect_success 'merge log message' '
 	git reset --hard c0 &&
 	git merge --no-log c2 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
-	test_cmp msg.nolog msg.act &&
+	test_cmp msg.nologff msg.act &&
+
+	git reset --hard c0 &&
+	test_config branch.master.mergeoptions "--no-ff" &&
+	git merge --no-log c2 &&
+	git show -s --pretty=format:%b HEAD >msg.act &&
+	test_cmp msg.nolognoff msg.act &&
 
 	git merge --log c3 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
 	test_cmp msg.log msg.act &&
 
 	git reset --hard HEAD^ &&
-	git config merge.log yes &&
+	test_config merge.log "yes" &&
 	git merge c3 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
 	test_cmp msg.log msg.act
@@ -542,7 +537,6 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        git reset --hard c1 &&
-       git config branch.master.mergeoptions "" &&
        test_tick &&
        git merge c0 c2 c0 c1 &&
        verify_merge file result.1-5 &&
@@ -553,7 +547,6 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        git reset --hard c1 &&
-       git config branch.master.mergeoptions "" &&
        test_tick &&
        git merge c0 c2 c0 c1 &&
        verify_merge file result.1-5 &&
@@ -564,7 +557,6 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c1 and c2' '
        git reset --hard c1 &&
-       git config branch.master.mergeoptions "" &&
        test_tick &&
        git merge c1 c2 &&
        verify_merge file result.1-5 &&
-- 
1.7.11.7
