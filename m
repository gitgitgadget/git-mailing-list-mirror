Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2281F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbdKJTGU (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:20 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48750 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753758AbdKJTGC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:02 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ4HCx002784;
        Fri, 10 Nov 2017 11:06:01 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631bgr-3;
        Fri, 10 Nov 2017 11:06:00 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id DA72422F6280;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id D14992CDEB4;
        Fri, 10 Nov 2017 11:06:00 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 15/30] merge-recursive: Move the get_renames() function
Date:   Fri, 10 Nov 2017 11:05:35 -0800
Message-Id: <20171110190550.27059-16-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to re-use some other functions in the file without moving those other
functions or dealing with a handful of annoying split function declarations
and definitions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 138 +++++++++++++++++++++++++++---------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3526c8d0b8..382016508b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -540,75 +540,6 @@ struct rename {
 	unsigned processed:1;
 };
 
-/*
- * Get information of all renames which occurred between 'o_tree' and
- * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
- * 'b_tree') to be able to associate the correct cache entries with
- * the rename information. 'tree' is always equal to either a_tree or b_tree.
- */
-static struct string_list *get_renames(struct merge_options *o,
-				       struct tree *tree,
-				       struct tree *o_tree,
-				       struct tree *a_tree,
-				       struct tree *b_tree,
-				       struct string_list *entries)
-{
-	int i;
-	struct string_list *renames;
-	struct diff_options opts;
-
-	renames = xcalloc(1, sizeof(struct string_list));
-	if (!o->detect_rename)
-		return renames;
-
-	diff_setup(&opts);
-	DIFF_OPT_SET(&opts, RECURSIVE);
-	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
-	opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
-			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
-			    1000;
-	opts.rename_score = o->rename_score;
-	opts.show_rename_progress = o->show_rename_progress;
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_setup_done(&opts);
-	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
-	diffcore_std(&opts);
-	if (opts.needed_rename_limit > o->needed_rename_limit)
-		o->needed_rename_limit = opts.needed_rename_limit;
-	for (i = 0; i < diff_queued_diff.nr; ++i) {
-		struct string_list_item *item;
-		struct rename *re;
-		struct diff_filepair *pair = diff_queued_diff.queue[i];
-		if (pair->status != 'R') {
-			diff_free_filepair(pair);
-			continue;
-		}
-		re = xmalloc(sizeof(*re));
-		re->processed = 0;
-		re->pair = pair;
-		item = string_list_lookup(entries, re->pair->one->path);
-		if (!item)
-			re->src_entry = insert_stage_data(re->pair->one->path,
-					o_tree, a_tree, b_tree, entries);
-		else
-			re->src_entry = item->util;
-
-		item = string_list_lookup(entries, re->pair->two->path);
-		if (!item)
-			re->dst_entry = insert_stage_data(re->pair->two->path,
-					o_tree, a_tree, b_tree, entries);
-		else
-			re->dst_entry = item->util;
-		item = string_list_insert(renames, pair->one->path);
-		item->util = re;
-	}
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_queued_diff.nr = 0;
-	diff_flush(&opts);
-	return renames;
-}
-
 static int update_stages(struct merge_options *opt, const char *path,
 			 const struct diff_filespec *o,
 			 const struct diff_filespec *a,
@@ -1383,6 +1314,75 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	return ret;
 }
 
+/*
+ * Get information of all renames which occurred between 'o_tree' and
+ * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
+ * 'b_tree') to be able to associate the correct cache entries with
+ * the rename information. 'tree' is always equal to either a_tree or b_tree.
+ */
+static struct string_list *get_renames(struct merge_options *o,
+				       struct tree *tree,
+				       struct tree *o_tree,
+				       struct tree *a_tree,
+				       struct tree *b_tree,
+				       struct string_list *entries)
+{
+	int i;
+	struct string_list *renames;
+	struct diff_options opts;
+
+	renames = xcalloc(1, sizeof(struct string_list));
+	if (!o->detect_rename)
+		return renames;
+
+	diff_setup(&opts);
+	DIFF_OPT_SET(&opts, RECURSIVE);
+	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
+	opts.detect_rename = DIFF_DETECT_RENAME;
+	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
+			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
+			    1000;
+	opts.rename_score = o->rename_score;
+	opts.show_rename_progress = o->show_rename_progress;
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&opts);
+	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
+	diffcore_std(&opts);
+	if (opts.needed_rename_limit > o->needed_rename_limit)
+		o->needed_rename_limit = opts.needed_rename_limit;
+	for (i = 0; i < diff_queued_diff.nr; ++i) {
+		struct string_list_item *item;
+		struct rename *re;
+		struct diff_filepair *pair = diff_queued_diff.queue[i];
+		if (pair->status != 'R') {
+			diff_free_filepair(pair);
+			continue;
+		}
+		re = xmalloc(sizeof(*re));
+		re->processed = 0;
+		re->pair = pair;
+		item = string_list_lookup(entries, re->pair->one->path);
+		if (!item)
+			re->src_entry = insert_stage_data(re->pair->one->path,
+					o_tree, a_tree, b_tree, entries);
+		else
+			re->src_entry = item->util;
+
+		item = string_list_lookup(entries, re->pair->two->path);
+		if (!item)
+			re->dst_entry = insert_stage_data(re->pair->two->path,
+					o_tree, a_tree, b_tree, entries);
+		else
+			re->dst_entry = item->util;
+		item = string_list_insert(renames, pair->one->path);
+		item->util = re;
+	}
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_flush(&opts);
+	return renames;
+}
+
 static int process_renames(struct merge_options *o,
 			   struct string_list *a_renames,
 			   struct string_list *b_renames)
-- 
2.15.0.5.g9567be9905

