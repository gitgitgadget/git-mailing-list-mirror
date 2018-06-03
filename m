Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB901F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeFCG63 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:58:29 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48616 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751005AbeFCG6Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 02:58:16 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w536sM52018663;
        Sat, 2 Jun 2018 23:58:13 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbs3g93kg-1;
        Sat, 02 Jun 2018 23:58:13 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 65801228A264;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 5CE312CDEEA;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/7] t6044: verify that merges expected to abort actually abort
Date:   Sat,  2 Jun 2018 23:58:04 -0700
Message-Id: <20180603065810.23841-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.49.g3c08dc0fef
In-Reply-To: <20180603065810.23841-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806030083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t6044 has lots of tests for verifying that merge will abort as expected
when there are changes staged before the merge starts.  However, it only
checked for non-zero exit code, which could mean that the merge ran to
completion with conflicts.  Check that the merge was actually correctly
aborted, i.e. that .git/MERGE_HEAD is not present.

This changes one of the tests from expect_success to expect_failure.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 32 ++++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 23b86fb977..f9c2f8179e 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -82,7 +82,8 @@ test_expect_success 'ff update, important file modified' '
 	touch subdir/e &&
 	git add subdir/e &&
 
-	test_must_fail git merge E^0
+	test_must_fail git merge E^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'resolve, trivial' '
@@ -91,7 +92,8 @@ test_expect_success 'resolve, trivial' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s resolve C^0
+	test_must_fail git merge -s resolve C^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'resolve, non-trivial' '
@@ -100,7 +102,8 @@ test_expect_success 'resolve, non-trivial' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s resolve D^0
+	test_must_fail git merge -s resolve D^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'recursive' '
@@ -109,16 +112,18 @@ test_expect_success 'recursive' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s recursive C^0
+	test_must_fail git merge -s recursive C^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
-test_expect_success 'recursive, when merge branch matches merge base' '
+test_expect_failure 'recursive, when merge branch matches merge base' '
 	git reset --hard &&
 	git checkout B^0 &&
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s recursive F^0
+	test_must_fail git merge -s recursive F^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'octopus, unrelated file touched' '
@@ -127,7 +132,8 @@ test_expect_success 'octopus, unrelated file touched' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge C^0 D^0
+	test_must_fail git merge C^0 D^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'octopus, related file removed' '
@@ -136,7 +142,8 @@ test_expect_success 'octopus, related file removed' '
 
 	git rm b &&
 
-	test_must_fail git merge C^0 D^0
+	test_must_fail git merge C^0 D^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'octopus, related file modified' '
@@ -145,7 +152,8 @@ test_expect_success 'octopus, related file modified' '
 
 	echo 12 >>a && git add a &&
 
-	test_must_fail git merge C^0 D^0
+	test_must_fail git merge C^0 D^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'ours' '
@@ -154,7 +162,8 @@ test_expect_success 'ours' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s ours C^0
+	test_must_fail git merge -s ours C^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'subtree' '
@@ -163,7 +172,8 @@ test_expect_success 'subtree' '
 
 	touch random_file && git add random_file &&
 
-	test_must_fail git merge -s subtree E^0
+	test_must_fail git merge -s subtree E^0 &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_done
-- 
2.18.0.rc0.49.g3c08dc0fef

