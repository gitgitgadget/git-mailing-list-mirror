Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183491F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbdKJTGC (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:02 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51722 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753578AbdKJTGB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:01 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ31Fr017725;
        Fri, 10 Nov 2017 11:05:59 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cd8-1;
        Fri, 10 Nov 2017 11:05:59 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B992122F6281;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id ABF262CDE6A;
        Fri, 10 Nov 2017 11:05:59 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 01/30] Tighten and correct a few testcases for merging and cherry-picking
Date:   Fri, 10 Nov 2017 11:05:21 -0800
Message-Id: <20171110190550.27059-2-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t3501 had a testcase originally added to ensure cherry-pick wouldn't
segfault when working with a dirty file involved in a rename.  While
the segfault was fixed, there was another problem this test demonstrated:
namely, that git would overwrite a dirty file involved in a rename.
Further, the test encoded a "successful merge" and overwriting of this
file as correct behavior.  Modify the test so that it would still catch
the segfault, but to require the correct behavior.

t7607 had a test specific to looking for a merge overwriting a dirty file
involved in a rename, but it too actually encoded what I would term
incorrect behavior: it expected the merge to succeed.  Fix that, and add
a few more checks to make sure that the merge really does produce the
expected results.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3501-revert-cherry-pick.sh | 7 +++++--
 t/t7607-merge-overwrite.sh    | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 4f2a263b63..783bdbf59d 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
-test_expect_success 'cherry-pick works with dirty renamed file' '
+test_expect_failure 'cherry-pick works with dirty renamed file' '
 	test_commit to-rename &&
 	git checkout -b unrelated &&
 	test_commit unrelated &&
@@ -150,7 +150,10 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
 	test_tick &&
 	git commit -m renamed &&
 	echo modified >renamed &&
-	git cherry-pick refs/heads/unrelated
+	test_must_fail git cherry-pick refs/heads/unrelated >out &&
+	test_i18ngrep "Refusing to lose dirty file at renamed" out &&
+	test $(git rev-parse :0:renamed) = $(git rev-parse HEAD^:to-rename.t) &&
+	grep -q "^modified$" renamed
 '
 
 test_done
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 9444d6a9b9..00617dadf8 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -97,7 +97,10 @@ test_expect_failure 'will not overwrite unstaged changes in renamed file' '
 	git mv c1.c other.c &&
 	git commit -m rename &&
 	cp important other.c &&
-	git merge c1a &&
+	test_must_fail git merge c1a >out &&
+	test_i18ngrep "Refusing to lose dirty file at other.c" out &&
+	test -f other.c~HEAD &&
+	test $(git hash-object other.c~HEAD) = $(git rev-parse c1a:c1.c) &&
 	test_cmp important other.c
 '
 
-- 
2.15.0.5.g9567be9905

