From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/10] t3510 (cherry-pick-sequencer): use exit status
Date: Wed, 14 Dec 2011 22:24:32 +0530
Message-ID: <1323881677-11117-6-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras7B-0004kJ-L0
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617Ab1LNQzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:55:08 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53875 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604Ab1LNQzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:55:07 -0500
Received: by mail-vw0-f46.google.com with SMTP id fc26so774122vbb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ip9YkNrzJprfyygDt8tNiroUquR/MuWUHxQ5JlPAdjQ=;
        b=MkQPpSQ1U4ERvuG7FLfo+CJ2NmmDvMCx9hduxy5P2MmNyYX84T4059k+j0JU13nlPk
         6dmIFKsXK+IA7JtZlwnteDFw3CkNte4p3GdFizBVtPbhS2N5XNbalqkXe0E+KDWMBad7
         KM2gq8beCfnz5OP2nTrqesrJgB6TzK99W77xQ=
Received: by 10.52.65.52 with SMTP id u20mr5417987vds.68.1323881706991;
        Wed, 14 Dec 2011 08:55:06 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.55.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:55:06 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187149>

All the tests asserting failure use 'test_must_fail', which simply
checks for a non-zero exit status, potentially hiding underlying bugs.
So, replace instances of 'test_must_fail' with 'test_expect_code' to
check the exit status explicitly, where appropriate.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3510-cherry-pick-sequence.sh |   58 +++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 781c5ac..b6e822e 100755
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
@@ -93,7 +93,7 @@ test_expect_success '--abort requires cherry-pick in progress' '
 
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
@@ -179,7 +179,7 @@ test_expect_success '--abort keeps unrelated change, easy case' '
 test_expect_success '--abort refuses to clobber unrelated change, harder case' '
 	pristine_detach initial &&
 	echo changed >expect &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo changed >unrelated &&
 	test_must_fail git cherry-pick --abort &&
 	test_cmp expect unrelated &&
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
1.7.4.1
