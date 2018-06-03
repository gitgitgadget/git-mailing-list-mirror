Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2063C1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeFCG6S (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:58:18 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41278 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750983AbeFCG6Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 02:58:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w536w4tW027372;
        Sat, 2 Jun 2018 23:58:13 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbr4js7rv-1;
        Sat, 02 Jun 2018 23:58:13 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 78CDC228A266;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6FD422CDE66;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 3/7] merge-recursive: make sure when we say we abort that we actually abort
Date:   Sat,  2 Jun 2018 23:58:06 -0700
Message-Id: <20180603065810.23841-4-newren@gmail.com>
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

In commit 65170c07d4 ("merge-recursive: avoid incorporating uncommitted
changes in a merge", 2017-12-21), it was noted that there was a special
case when merge-recursive didn't rely on unpack_trees() to enforce the
index == HEAD requirement, and thus that it needed to do that enforcement
itself.  Unfortunately, it returned the wrong exit status, signalling that
the merge completed but had conflicts, rather than that it was aborted.
Fix the return code, and while we're at it, change the error message to
match what unpack_trees() would have printed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                        | 4 ++--
 t/t6044-merge-unrelated-index-changes.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ac27abbd4c..b3deb7b182 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3264,9 +3264,9 @@ int merge_trees(struct merge_options *o,
 		struct strbuf sb = STRBUF_INIT;
 
 		if (!o->call_depth && index_has_changes(&sb)) {
-			err(o, _("Dirty index: cannot merge (dirty: %s)"),
+			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 			    sb.buf);
-			return 0;
+			return -1;
 		}
 		output(o, 0, _("Already up to date!"));
 		*result = head;
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 92ec552558..3876cfa4fa 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -116,7 +116,7 @@ test_expect_success 'recursive' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
-test_expect_failure 'recursive, when merge branch matches merge base' '
+test_expect_success 'recursive, when merge branch matches merge base' '
 	git reset --hard &&
 	git checkout B^0 &&
 
-- 
2.18.0.rc0.49.g3c08dc0fef

