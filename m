Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42A21F404
	for <e@80x24.org>; Fri, 13 Apr 2018 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeDMT4S (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 15:56:18 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:57974 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751886AbeDMT4Q (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Apr 2018 15:56:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3DJrCoh030440;
        Fri, 13 Apr 2018 12:56:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h96v3w6yu-1;
        Fri, 13 Apr 2018 12:56:10 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 0749C2215BC0;
        Fri, 13 Apr 2018 12:56:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id F22602CDE68;
        Fri, 13 Apr 2018 12:56:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     torvalds@linux-foundation.org, gitster@pobox.com,
        sbeller@google.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v9 29.75/30] merge-recursive: Fix was_tracked() to quit lying with some renamed paths
Date:   Fri, 13 Apr 2018 12:56:06 -0700
Message-Id: <20180413195607.18091-4-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.35.g6dd7ede834
In-Reply-To: <20180413195607.18091-1-newren@gmail.com>
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
 <20180413195607.18091-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804130184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit aacb82de3ff8 ("merge-recursive: Split was_tracked() out of
would_lose_untracked()", 2011-08-11), was_tracked() was split out of
would_lose_untracked() with the intent to provide a function that could
answer whether a path was tracked in the index before the merge.  Sadly,
it instead returned whether the path was in the working tree due to having
been tracked in the index before the merge OR having been written there by
unpack_trees().  The distinction is important when renames are involved,
e.g. for a merge where:

   HEAD:  modifies path b
   other: renames b->c

In this case, c was not tracked in the index before the merge, but would
have been added to the index at stage 0 and written to the working tree by
unpack_trees().  would_lose_untracked() is more interested in the
in-working-copy-for-either-reason behavior, while all other uses of
was_tracked() want just was-it-tracked-in-index-before-merge behavior.

Unsplit would_lose_untracked() and write a new was_tracked() function
which answers whether a path was tracked in the index before the merge
started.

This will also make was_dirty() return better results, as it will be based
off the original index rather than an index that possibly only copied over
some of the stat information.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 82 +++++++++++++++++++++++++++++++++++++++----------------
 merge-recursive.h |  1 +
 2 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 05250939c7..adc800f188 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -344,6 +344,7 @@ static int git_merge_trees(struct merge_options *o,
 {
 	int rc;
 	struct tree_desc t[3];
+	struct index_state tmp_index = { NULL };
 
 	memset(&o->unpack_opts, 0, sizeof(o->unpack_opts));
 	if (o->call_depth)
@@ -354,7 +355,7 @@ static int git_merge_trees(struct merge_options *o,
 	o->unpack_opts.head_idx = 2;
 	o->unpack_opts.fn = threeway_merge;
 	o->unpack_opts.src_index = &the_index;
-	o->unpack_opts.dst_index = &the_index;
+	o->unpack_opts.dst_index = &tmp_index;
 	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
 
 	init_tree_desc_from_tree(t+0, common);
@@ -362,13 +363,17 @@ static int git_merge_trees(struct merge_options *o,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &o->unpack_opts);
+	cache_tree_free(&active_cache_tree);
+
+	o->orig_index = the_index;
+	the_index = tmp_index;
+
 	/*
-	 * unpack_trees NULLifies src_index, but it's used in verify_uptodate,
-	 * so set to the new index which will usually have modification
-	 * timestamp info copied over.
+	 * src_index is used in verify_uptodate, but was NULLified in
+	 * unpack_trees, so we need to set it back to the original index.
 	 */
-	o->unpack_opts.src_index = &the_index;
-	cache_tree_free(&active_cache_tree);
+	o->unpack_opts.src_index = &o->orig_index;
+
 	return rc;
 }
 
@@ -773,31 +778,51 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 		!(empty_ok && is_empty_dir(path));
 }
 
-static int was_tracked(const char *path)
+/*
+ * Returns whether path was tracked in the index before the merge started
+ */
+static int was_tracked(struct merge_options *o, const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(&o->orig_index, path, strlen(path));
 
 	if (0 <= pos)
-		/* we have been tracking this path */
+		/* we were tracking this path before the merge */
 		return 1;
 
-	/*
-	 * Look for an unmerged entry for the path,
-	 * specifically stage #2, which would indicate
-	 * that "our" side before the merge started
-	 * had the path tracked (and resulted in a conflict).
-	 */
-	for (pos = -1 - pos;
-	     pos < active_nr && !strcmp(path, active_cache[pos]->name);
-	     pos++)
-		if (ce_stage(active_cache[pos]) == 2)
-			return 1;
 	return 0;
 }
 
 static int would_lose_untracked(const char *path)
 {
-	return !was_tracked(path) && file_exists(path);
+	/*
+	 * This may look like it can be simplified to:
+	 *   return !was_tracked(o, path) && file_exists(path)
+	 * but it can't.  This function needs to know whether path was
+	 * in the working tree due to EITHER having been tracked in the
+	 * index before the merge OR having been put into the working copy
+	 * and index by unpack_trees().  Due to that either-or requirement,
+	 * we check the current index instead of the original one.
+	 */
+	int pos = cache_name_pos(path, strlen(path));
+
+	if (pos < 0)
+		pos = -1 - pos;
+	while (pos < active_nr &&
+	       !strcmp(path, active_cache[pos]->name)) {
+		/*
+		 * If stage #0, it is definitely tracked.
+		 * If it has stage #2 then it was tracked
+		 * before this merge started.  All other
+		 * cases the path was not tracked.
+		 */
+		switch (ce_stage(active_cache[pos])) {
+		case 0:
+		case 2:
+			return 0;
+		}
+		pos++;
+	}
+	return file_exists(path);
 }
 
 static int was_dirty(struct merge_options *o, const char *path)
@@ -805,7 +830,7 @@ static int was_dirty(struct merge_options *o, const char *path)
 	struct cache_entry *ce;
 	int dirty = 1;
 
-	if (o->call_depth || !was_tracked(path))
+	if (o->call_depth || !was_tracked(o, path))
 		return !dirty;
 
 	ce = cache_file_exists(path, strlen(path), ignore_case);
@@ -2407,7 +2432,7 @@ static int process_renames(struct merge_options *o,
 			 * add-source case).
 			 */
 			remove_file(o, 1, ren1_src,
-				    renamed_stage == 2 || !was_tracked(ren1_src));
+				    renamed_stage == 2 || !was_tracked(o, ren1_src));
 
 			oidcpy(&src_other.oid,
 			       &ren1->src_entry->stages[other_stage].oid);
@@ -2800,7 +2825,7 @@ static int merge_content(struct merge_options *o,
 				if (update_stages(o, path, &one, &a, &b))
 					return -1;
 			} else {
-				int file_from_stage2 = was_tracked(path);
+				int file_from_stage2 = was_tracked(o, path);
 				struct diff_filespec merged;
 				oidcpy(&merged.oid, &mfi.oid);
 				merged.mode = mfi.mode;
@@ -3075,6 +3100,15 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
+	/* Free the extra index left from git_merge_trees() */
+	/*
+	 * FIXME: Need to also data allocated by setup_unpack_trees_porcelain()
+	 * tucked away in o->unpack_opts.msgs, but the problem is that only
+	 * half of it refers to dynamically allocated data, while the other
+	 * half points at static strings.
+	 */
+	discard_index(&o->orig_index);
+
 	if (o->call_depth && !(*result = write_tree_from_memory(o)))
 		return -1;
 
diff --git a/merge-recursive.h b/merge-recursive.h
index d863cf8867..248093e407 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -29,6 +29,7 @@ struct merge_options {
 	struct hashmap current_file_dir_set;
 	struct string_list df_conflict_file_set;
 	struct unpack_trees_options unpack_opts;
+	struct index_state orig_index;
 };
 
 /*
-- 
2.16.0.35.g6dd7ede834

