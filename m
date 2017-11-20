Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DF8202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdKTWDd (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:03:33 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38048 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751390AbdKTWCO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:14 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLxAQj020070;
        Mon, 20 Nov 2017 14:02:10 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eakkpb8qq-1;
        Mon, 20 Nov 2017 14:02:10 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id D7A8D22F41A3;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id D1AE82CDEB1;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 16/33] merge-recursive: introduce new functions to handle rename logic
Date:   Mon, 20 Nov 2017 14:01:52 -0800
Message-Id: <20171120220209.15111-17-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
In-Reply-To: <20171120220209.15111-1-newren@gmail.com>
References: <20171120220209.15111-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200295
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The amount of logic in merge_trees() relative to renames was just a few
lines, but split it out into new handle_renames() and cleanup_renames()
functions to prepare for additional logic to be added to each.  No code or
logic changes, just a new place to put stuff for when the rename detection
gains additional checks.

Note that process_renames() records pointers to various information (such
as diff_filepairs) into rename_conflict_info structs.  Even though the
rename string_lists are not directly used once handle_renames() completes,
we should not immediately free the lists at the end of that function
because they store the information referenced in the rename_conflict_info,
which is used later in process_entry().  Thus the reason for a separate
cleanup_renames().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 91bc354bec..4249caad4d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1636,6 +1636,32 @@ static int process_renames(struct merge_options *o,
 	return clean_merge;
 }
 
+struct rename_info {
+	struct string_list *head_renames;
+	struct string_list *merge_renames;
+};
+
+static int handle_renames(struct merge_options *o,
+			  struct tree *common,
+			  struct tree *head,
+			  struct tree *merge,
+			  struct string_list *entries,
+			  struct rename_info *ri)
+{
+	ri->head_renames  = get_renames(o, head, common, head, merge, entries);
+	ri->merge_renames = get_renames(o, merge, common, head, merge, entries);
+	return process_renames(o, ri->head_renames, ri->merge_renames);
+}
+
+static void cleanup_renames(struct rename_info *re_info)
+{
+	string_list_clear(re_info->head_renames, 0);
+	string_list_clear(re_info->merge_renames, 0);
+
+	free(re_info->head_renames);
+	free(re_info->merge_renames);
+}
+
 static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
 {
 	return (is_null_oid(oid) || mode == 0) ? NULL: (struct object_id *)oid;
@@ -1987,7 +2013,8 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (unmerged_cache()) {
-		struct string_list *entries, *re_head, *re_merge;
+		struct string_list *entries;
+		struct rename_info re_info;
 		int i;
 		/*
 		 * Only need the hashmap while processing entries, so
@@ -2001,9 +2028,8 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
-		re_head  = get_renames(o, head, common, head, merge, entries);
-		re_merge = get_renames(o, merge, common, head, merge, entries);
-		clean = process_renames(o, re_head, re_merge);
+		clean = handle_renames(o, common, head, merge, entries,
+				       &re_info);
 		record_df_conflict_files(o, entries);
 		if (clean < 0)
 			goto cleanup;
@@ -2028,16 +2054,13 @@ int merge_trees(struct merge_options *o,
 		}
 
 cleanup:
-		string_list_clear(re_merge, 0);
-		string_list_clear(re_head, 0);
+		cleanup_renames(&re_info);
+
 		string_list_clear(entries, 1);
+		free(entries);
 
 		hashmap_free(&o->current_file_dir_set, 1);
 
-		free(re_merge);
-		free(re_head);
-		free(entries);
-
 		if (clean < 0)
 			return clean;
 	}
-- 
2.15.0.309.g00c152f825

