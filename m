Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC971F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405431AbfBNFuE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:50:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:43742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726155AbfBNFuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:50:04 -0500
Received: (qmail 840 invoked by uid 109); 14 Feb 2019 05:50:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:50:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6909 invoked by uid 111); 14 Feb 2019 05:50:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:50:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:50:02 -0500
Date:   Thu, 14 Feb 2019 00:50:02 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 05/10] merge-recursive: drop several unused parameters
Message-ID: <20190214055002.GE20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few functions related to directory renames that have unused
parameters. After consulting with the author in [1], these seem to be
leftover cruft from the development process, and not signs of any bug.
Let's drop them.

[1] https://public-inbox.org/git/CABPp-BHobf8wbBsXF97scNQCzkxQukziODRXq6JOOWq61cAd9g@mail.gmail.com/

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 merge-recursive.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4851825aeb..f270fa66f3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1402,8 +1402,7 @@ static int merge_mode_and_contents(struct merge_options *o,
 
 static int handle_rename_via_dir(struct merge_options *o,
 				 struct diff_filepair *pair,
-				 const char *rename_branch,
-				 const char *other_branch)
+				 const char *rename_branch)
 {
 	/*
 	 * Handle file adds that need to be renamed due to directory rename
@@ -2213,8 +2212,7 @@ static void handle_directory_level_conflicts(struct merge_options *o,
 	remove_hashmap_entries(dir_re_merge, &remove_from_merge);
 }
 
-static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
-					     struct tree *tree)
+static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs)
 {
 	struct hashmap *dir_renames;
 	struct hashmap_iter iter;
@@ -2460,8 +2458,7 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 						 struct tree *o_tree,
 						 struct tree *a_tree,
 						 struct tree *b_tree,
-						 struct string_list *entries,
-						 int *clean)
+						 struct string_list *entries)
 {
 	struct string_list_item *item;
 	int stage = (tree == a_tree ? 2 : 3);
@@ -2632,8 +2629,7 @@ static struct string_list *get_renames(struct merge_options *o,
 			apply_directory_rename_modifications(o, pair, new_path,
 							     re, tree, o_tree,
 							     a_tree, b_tree,
-							     entries,
-							     clean_merge);
+							     entries);
 	}
 
 	hashmap_iter_init(&collisions, &iter);
@@ -2944,8 +2940,8 @@ static int detect_and_process_renames(struct merge_options *o,
 	merge_pairs = get_diffpairs(o, common, merge);
 
 	if (o->detect_directory_renames) {
-		dir_re_head = get_directory_renames(head_pairs, head);
-		dir_re_merge = get_directory_renames(merge_pairs, merge);
+		dir_re_head = get_directory_renames(head_pairs);
+		dir_re_merge = get_directory_renames(merge_pairs);
 
 		handle_directory_level_conflicts(o,
 						 dir_re_head, head,
@@ -3268,8 +3264,7 @@ static int process_entry(struct merge_options *o,
 			clean_merge = 1;
 			if (handle_rename_via_dir(o,
 						  conflict_info->pair1,
-						  conflict_info->branch1,
-						  conflict_info->branch2))
+						  conflict_info->branch1))
 				clean_merge = -1;
 			break;
 		case RENAME_ADD:
-- 
2.21.0.rc1.567.g648f076c3f

