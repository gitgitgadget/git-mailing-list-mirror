Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AAB1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162353AbeBNSwl (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:52:41 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37040 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162329AbeBNSwf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Feb 2018 13:52:35 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EIm5f6011989;
        Wed, 14 Feb 2018 10:52:08 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2g1xgry8ka-2;
        Wed, 14 Feb 2018 10:52:07 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 667AD225EBBB;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 4EC002CDEB4;
        Wed, 14 Feb 2018 10:52:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v8 17/29] merge-recursive: make a helper function for cleanup for handle_renames
Date:   Wed, 14 Feb 2018 10:51:54 -0800
Message-Id: <20180214185206.15492-18-newren@gmail.com>
X-Mailer: git-send-email 2.16.1.232.g28d5be9217
In-Reply-To: <20180214185206.15492-1-newren@gmail.com>
References: <20180214185206.15492-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802140219
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of more involved cleanup to come, make a helper function
for doing the cleanup at the end of handle_renames.  Rename the already
existing cleanup_rename[s]() to final_cleanup_rename[s](), name the new
helper initial_cleanup_rename(), and leave the big comment in the code
about why we can't do all the cleanup at once.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index db8833675e..be20660527 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1667,6 +1667,12 @@ struct rename_info {
 	struct string_list *merge_renames;
 };
=20
+static void initial_cleanup_rename(struct diff_queue_struct *pairs)
+{
+	free(pairs->queue);
+	free(pairs);
+}
+
 static int handle_renames(struct merge_options *o,
 			  struct tree *common,
 			  struct tree *head,
@@ -1697,16 +1703,13 @@ static int handle_renames(struct merge_options *o=
,
 	 * data structures are still needed and referenced in
 	 * process_entry().  But there are a few things we can free now.
 	 */
-
-	free(head_pairs->queue);
-	free(head_pairs);
-	free(merge_pairs->queue);
-	free(merge_pairs);
+	initial_cleanup_rename(head_pairs);
+	initial_cleanup_rename(merge_pairs);
=20
 	return clean;
 }
=20
-static void cleanup_rename(struct string_list *rename)
+static void final_cleanup_rename(struct string_list *rename)
 {
 	const struct rename *re;
 	int i;
@@ -1722,10 +1725,10 @@ static void cleanup_rename(struct string_list *re=
name)
 	free(rename);
 }
=20
-static void cleanup_renames(struct rename_info *re_info)
+static void final_cleanup_renames(struct rename_info *re_info)
 {
-	cleanup_rename(re_info->head_renames);
-	cleanup_rename(re_info->merge_renames);
+	final_cleanup_rename(re_info->head_renames);
+	final_cleanup_rename(re_info->merge_renames);
 }
=20
 static struct object_id *stage_oid(const struct object_id *oid, unsigned=
 mode)
@@ -2128,7 +2131,7 @@ int merge_trees(struct merge_options *o,
 		}
=20
 cleanup:
-		cleanup_renames(&re_info);
+		final_cleanup_renames(&re_info);
=20
 		string_list_clear(entries, 1);
 		free(entries);
--=20
2.16.1.232.g28d5be9217

