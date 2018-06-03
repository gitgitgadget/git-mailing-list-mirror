Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D20F1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbeFCG6T (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:58:19 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41280 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750992AbeFCG6Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 02:58:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w536w6La027377;
        Sat, 2 Jun 2018 23:58:13 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbr4js7ru-1;
        Sat, 02 Jun 2018 23:58:13 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 6F1A6228A265;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 660982CDE66;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/7] t6044: add a testcase for index matching head, when head doesn't match HEAD
Date:   Sat,  2 Jun 2018 23:58:05 -0700
Message-Id: <20180603065810.23841-3-newren@gmail.com>
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
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806030084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git merge-recursive` command allows the user to directly specify
three commits to merge -- base, head, and remote.  (More than three can be
specified in the case of multiple merge bases.)  Note that since the user
is allowed to specify head, it need not match HEAD.

Virtually every test and script in the current git.git codebase calls `git
merge-recursive` with head=HEAD, and likely external callers do as well,
which is why this has gone unnoticed.  There is one notable
counter-example: git-stash.sh.  However, git-stash called `git
merge-recursive` with an index that matches the expected merge result,
which happens to be a currently allowed exception to the "index must match
head" rule, so this never triggered an error previously.

Since we would like to tighten up the "index must match head" rule, we
need to make sure we are comparing to the correct head.  Add a testcase
that demonstrates the failure when we check the wrong HEAD.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index f9c2f8179e..92ec552558 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -126,6 +126,17 @@ test_expect_failure 'recursive, when merge branch matches merge base' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_failure 'merge-recursive, when index==head but head!=HEAD' '
+	git reset --hard &&
+	git checkout C^0 &&
+
+	# Make index match B
+	git diff C B | git apply --cached &&
+	# Merge B & F, with B as "head"
+	git merge-recursive A -- B F > out &&
+	test_i18ngrep "Already up to date" out
+'
+
 test_expect_success 'octopus, unrelated file touched' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
2.18.0.rc0.49.g3c08dc0fef

