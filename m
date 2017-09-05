Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37541208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbdIEMOK (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:57124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750766AbdIEMOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:09 -0400
Received: (qmail 31245 invoked by uid 109); 5 Sep 2017 12:14:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12172 invoked by uid 111); 5 Sep 2017 12:14:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:14:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:07 -0400
Date:   Tue, 5 Sep 2017 08:14:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/20] write_index_as_tree: cleanup tempfile on error
Message-ID: <20170905121407.4hom32etywlzaa26@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we failed to write our new index file, we rollback our
lockfile to remove the temporary index. But if we fail
before we even get to the write step (because reading the
old index failed), we leave the lockfile in place, which
makes no sense.

In practice this hasn't been a big deal because failing at
write_index_as_tree() typically results in the whole program
exiting (and thus the tempfile handler kicking in and
cleaning up the files). But this function should
consistently take responsibility for the resources it
allocates.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache-tree.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 2440d1dc89..2690113a6a 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -604,6 +604,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 {
 	int entries, was_valid, newfd;
 	struct lock_file *lock_file;
+	int ret = 0;
 
 	/*
 	 * We can't free this memory, it becomes part of a linked list
@@ -614,8 +615,10 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 	newfd = hold_lock_file_for_update(lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	entries = read_index_from(index_state, index_path);
-	if (entries < 0)
-		return WRITE_TREE_UNREADABLE_INDEX;
+	if (entries < 0) {
+		ret = WRITE_TREE_UNREADABLE_INDEX;
+		goto out;
+	}
 	if (flags & WRITE_TREE_IGNORE_CACHE_TREE)
 		cache_tree_free(&index_state->cache_tree);
 
@@ -624,8 +627,10 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 
 	was_valid = cache_tree_fully_valid(index_state->cache_tree);
 	if (!was_valid) {
-		if (cache_tree_update(index_state, flags) < 0)
-			return WRITE_TREE_UNMERGED_INDEX;
+		if (cache_tree_update(index_state, flags) < 0) {
+			ret = WRITE_TREE_UNMERGED_INDEX;
+			goto out;
+		}
 		if (0 <= newfd) {
 			if (!write_locked_index(index_state, lock_file, COMMIT_LOCK))
 				newfd = -1;
@@ -641,17 +646,19 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 	if (prefix) {
 		struct cache_tree *subtree;
 		subtree = cache_tree_find(index_state->cache_tree, prefix);
-		if (!subtree)
-			return WRITE_TREE_PREFIX_ERROR;
+		if (!subtree) {
+			ret = WRITE_TREE_PREFIX_ERROR;
+			goto out;
+		}
 		hashcpy(sha1, subtree->oid.hash);
 	}
 	else
 		hashcpy(sha1, index_state->cache_tree->oid.hash);
 
+out:
 	if (0 <= newfd)
 		rollback_lock_file(lock_file);
-
-	return 0;
+	return ret;
 }
 
 int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
-- 
2.14.1.721.gc5bc1565f1

