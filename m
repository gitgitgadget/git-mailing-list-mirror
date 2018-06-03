Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7F1F1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeFCG6S (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:58:18 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41282 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751000AbeFCG6Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 02:58:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w536vSIh026810;
        Sat, 2 Jun 2018 23:58:13 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbr4js7rw-1;
        Sat, 02 Jun 2018 23:58:13 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 91981228A268;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 8B0AA2CDEEA;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 5/7] t6044: add more testcases with staged changes before a merge is invoked
Date:   Sat,  2 Jun 2018 23:58:08 -0700
Message-Id: <20180603065810.23841-6-newren@gmail.com>
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
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806030084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/git-merge.txt,

    ...[merge will] abort if there are any changes registered in the index
    relative to the `HEAD` commit.  (One exception is when the changed index
    entries are in the state that would result from the merge already.)

Add some tests showing that this exception, while it does accurately state
what would be a safe condition under which we could allow the merge to
proceed, is not what is actually implemented.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 1d43712c52..e609f14f87 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -137,6 +137,35 @@ test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 	test_i18ngrep "Already up to date" out
 '
 
+test_expect_failure 'recursive, when file has staged changes not matching HEAD nor what a merge would give' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	mkdir subdir &&
+	test_seq 1 10 >subdir/a &&
+	git add subdir/a &&
+
+	# HEAD has no subdir/a; merge would write 1..11 to subdir/a;
+	# Since subdir/a matches neither HEAD nor what the merge would write
+	# to that file, the merge should fail to avoid overwriting what is
+	# currently found in subdir/a
+	test_must_fail git merge -s recursive E^0
+'
+
+test_expect_failure 'recursive, when file has staged changes matching what a merge would give' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	mkdir subdir &&
+	test_seq 1 11 >subdir/a &&
+	git add subdir/a &&
+
+	# HEAD has no subdir/a; merge would write 1..11 to subdir/a;
+	# Since subdir/a matches what the merge would write to that file,
+	# the merge should be safe to proceed
+	git merge -s recursive E^0
+'
+
 test_expect_success 'octopus, unrelated file touched' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
2.18.0.rc0.49.g3c08dc0fef

