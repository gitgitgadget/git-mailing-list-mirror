Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F5F1F51C
	for <e@80x24.org>; Sat, 19 May 2018 02:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeESCHK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 22:07:10 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:57636 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752214AbeESCHG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 22:07:06 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4J272w7032112;
        Fri, 18 May 2018 19:07:03 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hwx4kv2nf-1;
        Fri, 18 May 2018 19:07:03 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 21969229B0ED;
        Fri, 18 May 2018 19:07:03 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 187D82CDE79;
        Fri, 18 May 2018 19:07:03 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/5] merge-recursive: simplify handle_change_delete
Date:   Fri, 18 May 2018 19:07:00 -0700
Message-Id: <20180519020700.2241-6-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.847.g20b8963732
In-Reply-To: <20180519020700.2241-1-newren@gmail.com>
References: <20180519020700.2241-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=873 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805190021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is really no need for four branches of nearly identical messages
when we can store the differences into small variables before printing.
It does require a few allocations this way, but makes the code much
easier to parse for human readers.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 273ee79afa..3bd727995b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1290,31 +1290,17 @@ static int handle_change_delete(struct merge_options *o,
 		if (!ret)
 			ret = update_file(o, 0, o_oid, o_mode, update_path);
 	} else {
-		if (!alt_path) {
-			if (!old_path) {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-				       "and %s in %s. Version %s of %s left in tree."),
-				       change, path, delete_branch, change_past,
-				       change_branch, change_branch, path);
-			} else {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-				       "and %s to %s in %s. Version %s of %s left in tree."),
-				       change, old_path, delete_branch, change_past, path,
-				       change_branch, change_branch, path);
-			}
-		} else {
-			if (!old_path) {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-				       "and %s in %s. Version %s of %s left in tree at %s."),
-				       change, path, delete_branch, change_past,
-				       change_branch, change_branch, path, alt_path);
-			} else {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-				       "and %s to %s in %s. Version %s of %s left in tree at %s."),
-				       change, old_path, delete_branch, change_past, path,
-				       change_branch, change_branch, path, alt_path);
-			}
-		}
+		const char *deleted_path = old_path ? old_path : path;
+		char *supp1 = xstrfmt(old_path ? " to %s" : "", path);
+		char *supp2 = xstrfmt(alt_path ? " at %s" : "", alt_path);
+
+		output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+		       "and %s%s in %s. Version %s of %s left in tree%s."),
+		       change, deleted_path, delete_branch, change_past,
+		       supp1, change_branch, change_branch, path, supp2);
+		free(supp1);
+		free(supp2);
+
 		/*
 		 * No need to call update_file() on path when change_branch ==
 		 * o->branch1 && !alt_path, since that would needlessly touch
-- 
2.17.0.847.g20b8963732

