From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/9] t3510 (cherry-pick-sequencer): use exit status
Date: Fri,  9 Dec 2011 21:12:02 +0530
Message-ID: <1323445326-24637-6-git-send-email-artagnon@gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2bi-00013I-Pz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab1LIPn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45239 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab1LIPn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:26 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so4391329iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=22UhNW7HglCn2ir85h38ZDKw5htQ951LJ9uiQ50C7B8=;
        b=eHDyPU5qyl2IqYAwZ/GUKkomFMF8leKqX/BcuQqVvDYHAHEgEPUVM5lIbMd5HCbMeu
         GTqDU3I5+oBZ0FGfzUxndQs0MIVRuxZhzbZblJ6AlAphY21n22/OSfvqLdq+TCm9oACy
         tcm+ysrmPoPP4+0sgjvwqK7A4FarVQ+EyQgV4=
Received: by 10.42.159.72 with SMTP id k8mr3033179icx.14.1323445406508;
        Fri, 09 Dec 2011 07:43:26 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:25 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186643>

Since cf3e2486 (revert: Propagate errors upwards from do_pick_commit,
2011-08-04), 'git cherry-pick' has three different ways of failing:

1. die() with the exit status 128.
3. error() out with exit status -1.
2. exit with positive exit status to indicate a conflict.

However, all the tests asserting its failure use 'test_must_fail',
which simply checks for a non-zero exit status, potentially hiding
underlying bugs.  So, replace all instances of 'test_must_fail' with
'test_expect_code' to check the exit status explicitly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3510-cherry-pick-sequence.sh |   62 +++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 781c5ac..9ffc085 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -44,7 +44,7 @@ test_expect_success setup '
 
 test_expect_success 'cherry-pick persists data on failure' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick -s base..anotherpick &&
+	test_expect_code 1 git cherry-pick -s base..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
@@ -53,7 +53,7 @@ test_expect_success 'cherry-pick persists data on failure' '
 
 test_expect_success 'cherry-pick persists opts correctly' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
+	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
@@ -88,12 +88,12 @@ test_expect_success '--quit does not complain when no cherry-pick is in progress
 
 test_expect_success '--abort requires cherry-pick in progress' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick --abort
+	test_expect_code 128 git cherry-pick --abort
 '
 
 test_expect_success '--quit cleans up sequencer state' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..picked &&
+	test_expect_code 1 git cherry-pick base..picked &&
 	git cherry-pick --quit &&
 	test_path_is_missing .git/sequencer
 '
@@ -107,7 +107,7 @@ test_expect_success '--quit keeps HEAD and conflicted index intact' '
 	:000000 100644 OBJID OBJID A	foo
 	:000000 100644 OBJID OBJID A	unrelated
 	EOF
-	test_must_fail git cherry-pick base..picked &&
+	test_expect_code 1 git cherry-pick base..picked &&
 	git cherry-pick --quit &&
 	test_path_is_missing .git/sequencer &&
 	test_must_fail git update-index --refresh &&
@@ -121,7 +121,7 @@ test_expect_success '--quit keeps HEAD and conflicted index intact' '
 
 test_expect_success '--abort to cancel multiple cherry-pick' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	git cherry-pick --abort &&
 	test_path_is_missing .git/sequencer &&
 	test_cmp_rev initial HEAD &&
@@ -131,7 +131,7 @@ test_expect_success '--abort to cancel multiple cherry-pick' '
 
 test_expect_success '--abort to cancel single cherry-pick' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick picked &&
+	test_expect_code 1 git cherry-pick picked &&
 	git cherry-pick --abort &&
 	test_path_is_missing .git/sequencer &&
 	test_cmp_rev initial HEAD &&
@@ -141,7 +141,7 @@ test_expect_success '--abort to cancel single cherry-pick' '
 
 test_expect_success 'cherry-pick --abort to cancel multiple revert' '
 	pristine_detach anotherpick &&
-	test_must_fail git revert base..picked &&
+	test_expect_code 1 git revert base..picked &&
 	git cherry-pick --abort &&
 	test_path_is_missing .git/sequencer &&
 	test_cmp_rev anotherpick HEAD &&
@@ -151,7 +151,7 @@ test_expect_success 'cherry-pick --abort to cancel multiple revert' '
 
 test_expect_success 'revert --abort works, too' '
 	pristine_detach anotherpick &&
-	test_must_fail git revert base..picked &&
+	test_expect_code 1 git revert base..picked &&
 	git revert --abort &&
 	test_path_is_missing .git/sequencer &&
 	test_cmp_rev anotherpick HEAD
@@ -159,7 +159,7 @@ test_expect_success 'revert --abort works, too' '
 
 test_expect_success '--abort to cancel single revert' '
 	pristine_detach anotherpick &&
-	test_must_fail git revert picked &&
+	test_expect_code 1 git revert picked &&
 	git revert --abort &&
 	test_path_is_missing .git/sequencer &&
 	test_cmp_rev anotherpick HEAD &&
@@ -170,7 +170,7 @@ test_expect_success '--abort to cancel single revert' '
 test_expect_success '--abort keeps unrelated change, easy case' '
 	pristine_detach unrelatedpick &&
 	echo changed >expect &&
-	test_must_fail git cherry-pick picked..yetanotherpick &&
+	test_expect_code 1 git cherry-pick picked..yetanotherpick &&
 	echo changed >unrelated &&
 	git cherry-pick --abort &&
 	test_cmp expect unrelated
@@ -179,9 +179,9 @@ test_expect_success '--abort keeps unrelated change, easy case' '
 test_expect_success '--abort refuses to clobber unrelated change, harder case' '
 	pristine_detach initial &&
 	echo changed >expect &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo changed >unrelated &&
-	test_must_fail git cherry-pick --abort &&
+	test_expect_code 128 git cherry-pick --abort &&
 	test_cmp expect unrelated &&
 	git rev-list HEAD >log &&
 	test_line_count = 2 log &&
@@ -194,7 +194,7 @@ test_expect_success '--abort refuses to clobber unrelated change, harder case' '
 
 test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..picked &&
+	test_expect_code 1 git cherry-pick base..picked &&
 	test_path_is_missing .git/sequencer &&
 	echo "resolved" >foo &&
 	git add foo &&
@@ -218,7 +218,7 @@ test_expect_success 'cherry-pick cleans up sequencer state when one commit is le
 
 test_expect_failure '--abort after last commit in sequence' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..picked &&
+	test_expect_code 1 git cherry-pick base..picked &&
 	git cherry-pick --abort &&
 	test_path_is_missing .git/sequencer &&
 	test_cmp_rev initial HEAD &&
@@ -228,27 +228,27 @@ test_expect_failure '--abort after last commit in sequence' '
 
 test_expect_success 'cherry-pick does not implicitly stomp an existing operation' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	test-chmtime -v +0 .git/sequencer >expect &&
-	test_must_fail git cherry-pick unrelatedpick &&
+	test_expect_code 128 git cherry-pick unrelatedpick &&
 	test-chmtime -v +0 .git/sequencer >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '--continue complains when no cherry-pick is in progress' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick --continue
+	test_expect_code 128 git cherry-pick --continue
 '
 
 test_expect_success '--continue complains when there are unresolved conflicts' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	test_must_fail git cherry-pick --continue
+	test_expect_code 1 git cherry-pick base..anotherpick &&
+	test_expect_code 128 git cherry-pick --continue
 '
 
 test_expect_success '--continue continues after conflicts are resolved' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "c" >foo &&
 	git add foo &&
 	git commit &&
@@ -275,7 +275,7 @@ test_expect_success '--continue continues after conflicts are resolved' '
 
 test_expect_success '--continue respects opts' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick -x base..anotherpick &&
+	test_expect_code 1 git cherry-pick -x base..anotherpick &&
 	echo "c" >foo &&
 	git add foo &&
 	git commit &&
@@ -293,7 +293,7 @@ test_expect_success '--continue respects opts' '
 
 test_expect_success '--signoff is not automatically propagated to resolved conflict' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick --signoff base..anotherpick &&
+	test_expect_code 1 git cherry-pick --signoff base..anotherpick &&
 	echo "c" >foo &&
 	git add foo &&
 	git commit &&
@@ -311,40 +311,40 @@ test_expect_success '--signoff is not automatically propagated to resolved confl
 
 test_expect_success 'malformed instruction sheet 1' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
 	git add foo &&
 	git commit &&
 	sed "s/pick /pick/" .git/sequencer/todo >new_sheet &&
 	cp new_sheet .git/sequencer/todo &&
-	test_must_fail git cherry-pick --continue
+	test_expect_code 128 git cherry-pick --continue
 '
 
 test_expect_success 'malformed instruction sheet 2' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
 	git add foo &&
 	git commit &&
 	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
 	cp new_sheet .git/sequencer/todo &&
-	test_must_fail git cherry-pick --continue
+	test_expect_code 128 git cherry-pick --continue
 '
 
 test_expect_success 'malformed instruction sheet 3' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
 	git add foo &&
 	git commit &&
 	sed "s/pick \([0-9a-f]*\)/pick $_r10/" .git/sequencer/todo >new_sheet &&
 	cp new_sheet .git/sequencer/todo &&
-	test_must_fail git cherry-pick --continue
+	test_expect_code 128 git cherry-pick --continue
 '
 
 test_expect_success 'instruction sheet, fat-fingers version' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "c" >foo &&
 	git add foo &&
 	git commit &&
@@ -355,7 +355,7 @@ test_expect_success 'instruction sheet, fat-fingers version' '
 
 test_expect_success 'commit descriptions in insn sheet are optional' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "c" >foo &&
 	git add foo &&
 	git commit &&
-- 
1.7.7.3
