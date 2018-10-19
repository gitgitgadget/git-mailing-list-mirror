Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99E11F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJTBZ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:25:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:46630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727508AbeJTBZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:25:29 -0400
Received: (qmail 26696 invoked by uid 109); 19 Oct 2018 17:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 17:18:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13294 invoked by uid 111); 19 Oct 2018 17:17:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 13:17:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 13:18:28 -0400
Date:   Fri, 19 Oct 2018 13:18:28 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: unused parameters in merge-recursive.c
Message-ID: <20181019171827.GA21091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Playing with -Wunused-parameters, I notice there are several functions
with unused parameters in merge-recursive.c. The patch below drops them
all. We know they're not being used, so it can't make anything _worse_,
but this is a good opportunity to confirm that they don't represent some
latent bug.

In most cases I've been trying to determine the "bug versus cruft" thing
myself, but I fear that merge-recursive exceeds my abilities here. ;)

---
 merge-recursive.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c0fb83d285..f6d634c3a2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1369,8 +1369,7 @@ static int merge_mode_and_contents(struct merge_options *o,
 
 static int handle_rename_via_dir(struct merge_options *o,
 				 struct diff_filepair *pair,
-				 const char *rename_branch,
-				 const char *other_branch)
+				 const char *rename_branch)
 {
 	/*
 	 * Handle file adds that need to be renamed due to directory rename
@@ -2071,8 +2070,7 @@ static void handle_directory_level_conflicts(struct merge_options *o,
 	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
 }
 
-static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
-					     struct tree *tree)
+static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs)
 {
 	struct hashmap *dir_renames;
 	struct hashmap_iter iter;
@@ -2318,8 +2316,7 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 						 struct tree *o_tree,
 						 struct tree *a_tree,
 						 struct tree *b_tree,
-						 struct string_list *entries,
-						 int *clean)
+						 struct string_list *entries)
 {
 	struct string_list_item *item;
 	int stage = (tree == a_tree ? 2 : 3);
@@ -2490,8 +2487,7 @@ static struct string_list *get_renames(struct merge_options *o,
 			apply_directory_rename_modifications(o, pair, new_path,
 							     re, tree, o_tree,
 							     a_tree, b_tree,
-							     entries,
-							     clean_merge);
+							     entries);
 	}
 
 	hashmap_iter_init(&collisions, &iter);
@@ -2826,8 +2822,8 @@ static int detect_and_process_renames(struct merge_options *o,
 	merge_pairs = get_diffpairs(o, common, merge);
 
 	if (o->detect_directory_renames) {
-		dir_re_head = get_directory_renames(head_pairs, head);
-		dir_re_merge = get_directory_renames(merge_pairs, merge);
+		dir_re_head = get_directory_renames(head_pairs);
+		dir_re_merge = get_directory_renames(merge_pairs);
 
 		handle_directory_level_conflicts(o,
 						 dir_re_head, head,
@@ -3149,8 +3145,7 @@ static int process_entry(struct merge_options *o,
 			clean_merge = 1;
 			if (handle_rename_via_dir(o,
 						  conflict_info->pair1,
-						  conflict_info->branch1,
-						  conflict_info->branch2))
+						  conflict_info->branch1))
 				clean_merge = -1;
 			break;
 		case RENAME_DELETE:
-- 
2.19.1.1089.g69f65ee796

