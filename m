Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1928C1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeDSR7C (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:59:02 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42136 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752695AbeDSR6h (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:37 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw4P3014666;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au87-3;
        Thu, 19 Apr 2018 10:58:30 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 970DE22175C3;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 8DF742CDE6F;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 33/36] merge-recursive: fix was_tracked() to quit lying with some renamed paths
Date:   Thu, 19 Apr 2018 10:58:20 -0700
Message-Id: <20180419175823.7946-34-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=12 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190157
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

This will also affect was_dirty(), helping it to return better results
since it can base answers off the original index rather than an index that
possibly only copied over some of the stat information.  However,
was_dirty() will need an additional change that will be made in a
subsequent patch.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

This patch is nearly identical to one I sent out as an RFC and which
was previously reviewed by Junio at

  https://public-inbox.org/git/CABPp-BFPTJsTUVoPxxN=2u5jEqn1ngdDvMNhp+VLZKTgZaUkvw@mail.gmail.com/

It is not clear whether my responses in that thread were sufficient, but
I did make the two changes I mentioned there:
  - Fix the broken comment in git_merge_trees()
  - Add a note to the comment in would_lose_untracked() about the
    annoying worktree-first-then-index requirement

 merge-recursive.c | 91 ++++++++++++++++++++++++++++++++++-------------
 merge-recursive.h |  1 +
 2 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b32e8d817a..097de7e5a7 100644
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
@@ -362,13 +363,18 @@ static int git_merge_trees(struct merge_options *o,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &o->unpack_opts);
+	cache_tree_free(&active_cache_tree);
+
 	/*
-	 * unpack_trees NULLifies src_index, but it's used in verify_uptodate,
-	 * so set to the new index which will usually have modification
-	 * timestamp info copied over.
+	 * Update the_index to match the new results, AFTER saving a copy
+	 * in o->orig_index.  Update src_index to point to the saved copy.
+	 * (verify_uptodate() checks src_index, and the original index is
+	 * the one that had the necessary modification timestamps.)
 	 */
-	o->unpack_opts.src_index = &the_index;
-	cache_tree_free(&active_cache_tree);
+	o->orig_index = the_index;
+	the_index = tmp_index;
+	o->unpack_opts.src_index = &o->orig_index;
+
 	return rc;
 }
 
@@ -773,31 +779,59 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
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
+	 * but it can't.  This function needs to know whether path was in
+	 * the working tree due to EITHER having been tracked in the index
+	 * before the merge OR having been put into the working copy and
+	 * index by unpack_trees().  Due to that either-or requirement, we
+	 * check the current index instead of the original one.
+	 *
+	 * Note that we do not need to worry about merge-recursive itself
+	 * updating the index after unpack_trees() and before calling this
+	 * function, because we strictly require all code paths in
+	 * merge-recursive to update the working tree first and the index
+	 * second.  Doing otherwise would break
+	 * update_file()/would_lose_untracked(); see every comment in this
+	 * file which mentions "update_stages".
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
@@ -805,7 +839,7 @@ static int was_dirty(struct merge_options *o, const char *path)
 	struct cache_entry *ce;
 	int dirty = 1;
 
-	if (o->call_depth || !was_tracked(path))
+	if (o->call_depth || !was_tracked(o, path))
 		return !dirty;
 
 	ce = cache_file_exists(path, strlen(path), ignore_case);
@@ -2419,7 +2453,7 @@ static int process_renames(struct merge_options *o,
 			 * add-source case).
 			 */
 			remove_file(o, 1, ren1_src,
-				    renamed_stage == 2 || !was_tracked(ren1_src));
+				    renamed_stage == 2 || !was_tracked(o, ren1_src));
 
 			oidcpy(&src_other.oid,
 			       &ren1->src_entry->stages[other_stage].oid);
@@ -2812,7 +2846,7 @@ static int merge_content(struct merge_options *o,
 				if (update_stages(o, path, &one, &a, &b))
 					return -1;
 			} else {
-				int file_from_stage2 = was_tracked(path);
+				int file_from_stage2 = was_tracked(o, path);
 				struct diff_filespec merged;
 				oidcpy(&merged.oid, &mfi.oid);
 				merged.mode = mfi.mode;
@@ -3081,6 +3115,15 @@ int merge_trees(struct merge_options *o,
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
2.17.0.290.ge988e9ce2a

