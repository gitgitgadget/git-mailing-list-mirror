From: Jeff King <peff@peff.net>
Subject: [PATCH v2 22/25] reachable: use revision machinery's --index-objects
 code
Date: Wed, 15 Oct 2014 18:44:51 -0400
Message-ID: <20141015224451.GV25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:44:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXJR-0001fv-NJ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbaJOWoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:44:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:59027 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbaJOWox (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:44:53 -0400
Received: (qmail 2716 invoked by uid 102); 15 Oct 2014 22:44:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:44:53 -0500
Received: (qmail 28275 invoked by uid 107); 15 Oct 2014 22:44:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:44:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:44:51 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does the same thing as our custom code, so let's not
repeat ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 reachable.c | 52 +---------------------------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/reachable.c b/reachable.c
index 0176a88..a647267 100644
--- a/reachable.c
+++ b/reachable.c
@@ -32,56 +32,6 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
-static void add_one_tree(const unsigned char *sha1, struct rev_info *revs)
-{
-	struct tree *tree = lookup_tree(sha1);
-	if (tree)
-		add_pending_object(revs, &tree->object, "");
-}
-
-static void add_cache_tree(struct cache_tree *it, struct rev_info *revs)
-{
-	int i;
-
-	if (it->entry_count >= 0)
-		add_one_tree(it->sha1, revs);
-	for (i = 0; i < it->subtree_nr; i++)
-		add_cache_tree(it->down[i]->cache_tree, revs);
-}
-
-static void add_cache_refs(struct rev_info *revs)
-{
-	int i;
-
-	read_cache();
-	for (i = 0; i < active_nr; i++) {
-		struct blob *blob;
-
-		/*
-		 * The index can contain blobs and GITLINKs, GITLINKs are hashes
-		 * that don't actually point to objects in the repository, it's
-		 * almost guaranteed that they are NOT blobs, so we don't call
-		 * lookup_blob() on them, to avoid populating the hash table
-		 * with invalid information
-		 */
-		if (S_ISGITLINK(active_cache[i]->ce_mode))
-			continue;
-
-		blob = lookup_blob(active_cache[i]->sha1);
-		if (blob)
-			blob->object.flags |= SEEN;
-
-		/*
-		 * We could add the blobs to the pending list, but quite
-		 * frankly, we don't care. Once we've looked them up, and
-		 * added them as objects, we've really done everything
-		 * there is to do for a blob
-		 */
-	}
-	if (active_cache_tree)
-		add_cache_tree(active_cache_tree, revs);
-}
-
 /*
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
@@ -213,7 +163,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	revs->tree_objects = 1;
 
 	/* Add all refs from the index file */
-	add_cache_refs(revs);
+	add_index_objects_to_pending(revs, 0);
 
 	/* Add all external refs */
 	for_each_ref(add_one_ref, revs);
-- 
2.1.2.596.g7379948
