Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C98D1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 21:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeJCEEm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 00:04:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:39122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725832AbeJCEEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 00:04:42 -0400
Received: (qmail 16663 invoked by uid 109); 2 Oct 2018 21:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 21:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6710 invoked by uid 111); 2 Oct 2018 21:18:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 17:18:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 17:19:21 -0400
Date:   Tue, 2 Oct 2018 17:19:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] more oideq/hasheq conversions
Message-ID: <20181002211921.GA3322@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We added faster equality-comparison functions for hashes in
14438c4497 (introduce hasheq() and oideq(), 2018-08-28). A
few topics were in-flight at the time, and can now be
converted. This covers all spots found by "make coccicheck"
in master (the coccicheck results were tweaked by hand for
style).

Signed-off-by: Jeff King <peff@peff.net>
---
Jake: I was surprised that this was not a "patch 2" on top of your
earlier coccicheck patch. Apologies if you were planning to send it out.

This doesn't conflict with anything in "pu", so it's a reasonable time
to apply it. There are a few lingering cases in pu, so another option is
to wait a week or two and see if they get merged.

 builtin/checkout.c | 3 ++-
 cache-tree.c       | 2 +-
 commit-reach.c     | 2 +-
 midx.c             | 8 ++++----
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b30b48767e..902c06702c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -497,7 +497,8 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	 * We must do the merge if we are actually moving to a new commit.
 	 */
 	if (!old_branch_info->commit || !new_branch_info->commit ||
-		oidcmp(&old_branch_info->commit->object.oid, &new_branch_info->commit->object.oid))
+		!oideq(&old_branch_info->commit->object.oid,
+		       &new_branch_info->commit->object.oid))
 		return 0;
 
 	/*
diff --git a/cache-tree.c b/cache-tree.c
index 5ce51468f0..9c5cf2cc4f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -781,7 +781,7 @@ static void verify_one(struct index_state *istate,
 		strbuf_add(&tree_buf, oid->hash, the_hash_algo->rawsz);
 	}
 	hash_object_file(tree_buf.buf, tree_buf.len, tree_type, &new_oid);
-	if (oidcmp(&new_oid, &it->oid))
+	if (!oideq(&new_oid, &it->oid))
 		BUG("cache-tree for path %.*s does not match. "
 		    "Expected %s got %s", len, path->buf,
 		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
diff --git a/commit-reach.c b/commit-reach.c
index 00e5ceee6f..a7808430e1 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -426,7 +426,7 @@ struct contains_stack {
 static int in_commit_list(const struct commit_list *want, struct commit *c)
 {
 	for (; want; want = want->next)
-		if (!oidcmp(&want->item->object.oid, &c->object.oid))
+		if (oideq(&want->item->object.oid, &c->object.oid))
 			return 1;
 	return 0;
 }
diff --git a/midx.c b/midx.c
index f3e8dbc108..06aef56400 100644
--- a/midx.c
+++ b/midx.c
@@ -285,8 +285,8 @@ static int nth_midxed_pack_entry(struct multi_pack_index *m, struct pack_entry *
 		struct object_id oid;
 		nth_midxed_object_oid(&oid, m, pos);
 		for (i = 0; i < p->num_bad_objects; i++)
-			if (!hashcmp(oid.hash,
-				     p->bad_object_sha1 + the_hash_algo->rawsz * i))
+			if (hasheq(oid.hash,
+				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
 				return 0;
 	}
 
@@ -583,8 +583,8 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 		 * Take only the first duplicate.
 		 */
 		for (cur_object = 0; cur_object < nr_fanout; cur_object++) {
-			if (cur_object && !oidcmp(&entries_by_fanout[cur_object - 1].oid,
-						  &entries_by_fanout[cur_object].oid))
+			if (cur_object && oideq(&entries_by_fanout[cur_object - 1].oid,
+						&entries_by_fanout[cur_object].oid))
 				continue;
 
 			ALLOC_GROW(deduplicated_entries, *nr_objects + 1, alloc_objects);
-- 
2.19.0.489.g7c40b6af8e
