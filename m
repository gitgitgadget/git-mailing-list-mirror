Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811D51F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeHKBrt (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:47:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:50702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726774AbeHKBrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:47:48 -0400
Received: (qmail 28228 invoked by uid 109); 10 Aug 2018 23:15:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 23:15:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24773 invoked by uid 111); 10 Aug 2018 23:15:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 19:15:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 19:15:49 -0400
Date:   Fri, 10 Aug 2018 19:15:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 4/7] for_each_packed_object: support iterating in pack-order
Message-ID: <20180810231549.GD19875@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently iterate over objects within a pack in .idx
order, which uses the object hashes. That means that it
is effectively random with respect to the location of the
object within the pack. If you're going to access the actual
object data, there are two reasons to move linearly through
the pack itself:

  1. It improves the locality of access in the packfile. In
     the cold-cache case, this may mean fewer disk seeks, or
     better usage of disk cache.

  2. We store related deltas together in the packfile. Which
     means that the delta base cache can operate much more
     efficiently if we visit all of those related deltas in
     sequence, as the earlier items are likely to still be
     in the cache.  Whereas if we visit the objects in
     random order, our cache entries are much more likely to
     have been evicted by unrelated deltas in the meantime.

So in general, if you're going to access the object contents
pack order is generally going to end up more efficient.

But if you're simply generating a list of object names, or
if you're going to end up sorting the result anyway, you're
better off just using the .idx order, as finding the pack
order means generating the in-memory pack-revindex.
According to the numbers in 8b8dfd5132 (pack-revindex:
radix-sort the revindex, 2013-07-11), that takes about 200ms
for linux.git, and 20ms for git.git (those numbers are a few
years old but are still a good ballpark).

That makes it a good optimization for some cases (we can
save tens of seconds in git.git by having good locality of
delta access, for a 20ms cost), but a bad one for others
(e.g., right now "cat-file --batch-all-objects
--batch-check="%(objectname)" is 170ms in git.git, so adding
20ms to that is noticeable).

Hence this patch makes it an optional flag. You can't
actually do any interesting timings yet, as it's not plumbed
through to any user-facing tools like cat-file. That will
come in a later patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h        |  5 +++++
 commit-graph.c |  2 +-
 packfile.c     | 21 ++++++++++++++++-----
 packfile.h     |  8 +++++---
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index f438540f9b..6d14702df2 100644
--- a/cache.h
+++ b/cache.h
@@ -1633,6 +1633,11 @@ enum for_each_object_flags {
 
 	/* Only iterate over packs obtained from the promisor remote. */
 	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
+
+	/*
+	 * Visit objects within a pack in packfile order rather than .idx order
+	 */
+	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
 };
 
 /*
diff --git a/commit-graph.c b/commit-graph.c
index b0a55ad128..69a0d1c203 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -730,7 +730,7 @@ void write_commit_graph(const char *obj_dir,
 				die("error adding pack %s", packname.buf);
 			if (open_pack_index(p))
 				die("error opening index for %s", packname.buf);
-			for_each_object_in_pack(p, add_packed_commits, &oids);
+			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
 			close_pack(p);
 		}
 		strbuf_release(&packname);
diff --git a/packfile.c b/packfile.c
index 9da8f6d728..ebcb5742ec 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1885,19 +1885,30 @@ int has_pack_index(const unsigned char *sha1)
 	return 1;
 }
 
-int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
+int for_each_object_in_pack(struct packed_git *p,
+			    each_packed_object_fn cb, void *data,
+			    enum for_each_object_flags flags)
 {
 	uint32_t i;
 	int r = 0;
 
+	if (flags & FOR_EACH_OBJECT_PACK_ORDER)
+		load_pack_revindex(p);
+
 	for (i = 0; i < p->num_objects; i++) {
+		uint32_t pos;
 		struct object_id oid;
 
-		if (!nth_packed_object_oid(&oid, p, i))
+		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
+			pos = p->revindex[i].nr;
+		else
+			pos = i;
+
+		if (!nth_packed_object_oid(&oid, p, pos))
 			return error("unable to get sha1 of object %u in %s",
-				     i, p->pack_name);
+				     pos, p->pack_name);
 
-		r = cb(&oid, p, i, data);
+		r = cb(&oid, p, pos, data);
 		if (r)
 			break;
 	}
@@ -1922,7 +1933,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 			pack_errors = 1;
 			continue;
 		}
-		r = for_each_object_in_pack(p, cb, data);
+		r = for_each_object_in_pack(p, cb, data, flags);
 		if (r)
 			break;
 	}
diff --git a/packfile.h b/packfile.h
index c86a8c2716..99411bdd85 100644
--- a/packfile.h
+++ b/packfile.h
@@ -153,8 +153,8 @@ extern int has_pack_index(const unsigned char *sha1);
  * By default, this includes both local and alternate packs.
  *
  * Note that some objects may appear twice if they are found in multiple packs.
- * Each pack is visited in an unspecified order. Objects within a pack are
- * visited in pack-idx order (i.e., sorted by oid).
+ * Each pack is visited in an unspecified order. By default, objects within a
+ * pack are visited in pack-idx order (i.e., sorted by oid).
  *
  * The list of flags can be found in cache.h.
  */
@@ -162,7 +162,9 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
-int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
+int for_each_object_in_pack(struct packed_git *p,
+			    each_packed_object_fn, void *data,
+			    enum for_each_object_flags flags);
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
-- 
2.18.0.1058.g7433f71063

