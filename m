Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210161FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 21:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdBHVBY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 16:01:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:51786 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdBHVBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 16:01:23 -0500
Received: (qmail 28440 invoked by uid 109); 8 Feb 2017 20:53:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:53:06 +0000
Received: (qmail 6377 invoked by uid 111); 8 Feb 2017 20:53:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:53:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:53:03 -0500
Date:   Wed, 8 Feb 2017 15:53:03 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/11] fetch-pack: cache results of for_each_alternate_ref
Message-ID: <20170208205303.wb2myafalz5vpdpl@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We may run for_each_alternate_ref() twice, once in
find_common() and once in everything_local(). This operation
can be expensive, because it involves running a sub-process
which must freshly load all of the alternate's refs from
disk.

Let's cache and reuse the results between the two calls. We
can make some optimizations based on the particular use
pattern in fetch-pack to keep our memory usage down.

The first is that we only care about the sha1s, not the refs
themselves. So it's OK to store only the sha1s, and to
suppress duplicates. The natural fit would therefore be a
sha1_array.

However, sha1_array's de-duplication happens only after it
has read and sorted all entries. It still stores each
duplicate. For an alternate with a large number of refs
pointing to the same commits, this is a needless expense.

Instead, we'd prefer to eliminate duplicates before putting
them in the cache, which implies using a hash. We can
further note that fetch-pack will call parse_object() on
each alternate sha1. We can therefore keep our cache as a
set of pointers to "struct object". That gives us a place to
put our "already seen" bit with an optimized hash lookup.
And as a bonus, the object stores the sha1 for us, so
pointer-to-object is all we need.

There are two extra optimizations I didn't do here:

  - we actually store an array of pointer-to-object.
    Technically we could just walk the obj_hash table
    looking for entries with the ALTERNATE flag set (because
    our use case doesn't care about the order here).

    But that hash table may be mostly composed of
    non-ALTERNATE entries, so we'd waste time walking over
    them. So it would be a slight win in memory use, but a
    loss in CPU.

  - the items we pull out of the cache are actual "struct
    object"s, but then we feed "obj->sha1" to our
    sub-functions, which promptly call parse_object().

    This second parse is cheap, because it starts with
    lookup_object() and will bail immediately when it sees
    we've already parsed the object. We could save the extra
    hash lookup, but it would involve refactoring the
    functions we call. It may or may not be worth the
    trouble.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 52 ++++++++++++++++++++++++++++++++++++++++++----------
 object.h     |  2 +-
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 54f84c573..e0f5d5ce8 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -35,6 +35,7 @@ static const char *alternate_shallow_file;
 #define COMMON_REF	(1U << 2)
 #define SEEN		(1U << 3)
 #define POPPED		(1U << 4)
+#define ALTERNATE	(1U << 5)
 
 static int marked;
 
@@ -67,6 +68,41 @@ static inline void print_verbose(const struct fetch_pack_args *args,
 	fputc('\n', stderr);
 }
 
+struct alternate_object_cache {
+	struct object **items;
+	size_t nr, alloc;
+};
+
+static void cache_one_alternate(const char *refname,
+				const struct object_id *oid,
+				void *vcache)
+{
+	struct alternate_object_cache *cache = vcache;
+	struct object *obj = parse_object(oid->hash);
+
+	if (!obj || (obj->flags & ALTERNATE))
+		return;
+
+	obj->flags |= ALTERNATE;
+	ALLOC_GROW(cache->items, cache->nr + 1, cache->alloc);
+	cache->items[cache->nr++] = obj;
+}
+
+static void for_each_cached_alternate(void (*cb)(struct object *))
+{
+	static int initialized;
+	static struct alternate_object_cache cache;
+	size_t i;
+
+	if (!initialized) {
+		for_each_alternate_ref(cache_one_alternate, &cache);
+		initialized = 1;
+	}
+
+	for (i = 0; i < cache.nr; i++)
+		cb(cache.items[i]);
+}
+
 static void rev_list_push(struct commit *commit, int mark)
 {
 	if (!(commit->object.flags & mark)) {
@@ -253,11 +289,9 @@ static void send_request(struct fetch_pack_args *args,
 		write_or_die(fd, buf->buf, buf->len);
 }
 
-static void insert_one_alternate_ref(const char *refname,
-				     const struct object_id *oid,
-				     void *unused)
+static void insert_one_alternate_object(struct object *obj)
 {
-	rev_list_insert_ref(NULL, oid->hash);
+	rev_list_insert_ref(NULL, obj->oid.hash);
 }
 
 #define INITIAL_FLUSH 16
@@ -300,7 +334,7 @@ static int find_common(struct fetch_pack_args *args,
 	marked = 1;
 
 	for_each_ref(rev_list_insert_ref_oid, NULL);
-	for_each_alternate_ref(insert_one_alternate_ref, NULL);
+	for_each_cached_alternate(insert_one_alternate_object);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -621,11 +655,9 @@ static void filter_refs(struct fetch_pack_args *args,
 	*refs = newlist;
 }
 
-static void mark_alternate_complete(const char *refname,
-				    const struct object_id *oid,
-				    void *unused)
+static void mark_alternate_complete(struct object *obj)
 {
-	mark_complete(oid->hash);
+	mark_complete(obj->oid.hash);
 }
 
 static int everything_local(struct fetch_pack_args *args,
@@ -661,7 +693,7 @@ static int everything_local(struct fetch_pack_args *args,
 
 	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
-		for_each_alternate_ref(mark_alternate_complete, NULL);
+		for_each_cached_alternate(mark_alternate_complete);
 		commit_list_sort_by_date(&complete);
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
diff --git a/object.h b/object.h
index 614a00675..f52957dcb 100644
--- a/object.h
+++ b/object.h
@@ -29,7 +29,7 @@ struct object_array {
 /*
  * object flag allocation:
  * revision.h:      0---------10                                26
- * fetch-pack.c:    0---4
+ * fetch-pack.c:    0---5
  * walker.c:        0-2
  * upload-pack.c:       4       11----------------19
  * builtin/blame.c:               12-13
-- 
2.12.0.rc0.371.ga6cf8653b

