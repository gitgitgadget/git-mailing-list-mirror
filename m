Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B83D1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 22:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756524AbcHVWAM (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 18:00:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:59302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756518AbcHVWAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 18:00:10 -0400
Received: (qmail 29653 invoked by uid 109); 22 Aug 2016 22:00:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 22:00:10 +0000
Received: (qmail 17583 invoked by uid 111); 22 Aug 2016 22:00:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 18:00:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 18:00:07 -0400
Date:   Mon, 22 Aug 2016 18:00:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/7] delta_base_cache: use hashmap.h
Message-ID: <20160822220007.lh3wzv6orlupfjmr@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fundamental data structure of the delta base cache is a
hash table mapping pairs of "(packfile, offset)" into
structs containing the actual object data. The hash table
implementation dates back to e5e0161 (Implement a simple
delta_base cache, 2007-03-17), and uses a fixed-size table.
The current size is a hard-coded 256 entries.

Because we need to be able to remove objects from the hash
table, entry lookup does not do any kind of probing to
handle collisions. Colliding items simply replace whatever
is in their slot.  As a result, we have fewer usable slots
than even the 256 we allocate. At half full, each new item
has a 50% chance of displacing another one. Or another way
to think about it: every item has a 1/256 chance of being
ejected due to hash collision, without regard to our LRU
strategy.

So it would be interesting to see the effect of increasing
the cache size on the runtime for some common operations. As
with the previous patch, we'll measure "git log --raw" for
tree-only operations, and "git log -Sfoo --raw" for
operations that touch trees and blobs. All times are
wall-clock best-of-3, done against fully packed repos with
--depth=50, and the default core.deltaBaseCacheLimit of
96MB.

Here are timings for various values of MAX_DELTA_CACHE
against git.git (the asterisk marks the minimum time for
each operation):

    MAX_DELTA_CACHE    log-raw      log-S
    ---------------   ---------   ---------
                256   0m02.227s   0m12.821s
                512   0m02.143s   0m10.602s
               1024   0m02.127s   0m08.642s
               2048   0m02.148s   0m07.123s
               4096   0m02.194s   0m06.448s*
               8192   0m02.239s   0m06.504s
              16384   0m02.144s*  0m06.502s
              32768   0m02.202s   0m06.622s
              65536   0m02.230s   0m06.677s

The log-raw case isn't changed much at all here (probably
because our trees just aren't that big in the first place,
or possibly because we have so _few_ trees in git.git that
the 256-entry cache is enough). But once we start putting
blobs in the cache, too, we see a big improvement (almost
50%). The curve levels off around 4096, which means that we
can hold about that many entries before hitting the 96MB
memory limit (or possibly that the workload is small enough
that there is simply no more work to be optimized out by
caching more).

(As a side note, I initially timed my existing git.git pack,
which was a base of --aggressive combined with some pulls on
top. So it had quite a few deeper delta chains. The
256-cache case was more like 15s, and it still dropped to
~6.5s in the same way).

Here are the timings for linux.git:

    MAX_DELTA_CACHE    log-raw      log-S
    ---------------   ---------   ---------
                256   0m41.661s   5m12.410s
                512   0m39.547s   5m07.920s
               1024   0m37.054s   4m54.666s
               2048   0m35.871s   4m41.194s*
               4096   0m34.646s   4m51.648s
               8192   0m33.881s   4m55.342s
              16384   0m35.190s   5m00.122s
              32768   0m35.060s   4m58.851s
              65536   0m33.311s*  4m51.420s

As we grow we see a nice 20% speedup in the tree traversal,
and more modest 10% in the log-S. This is probably an
indication that we are bound less by the number of entries,
and more by the memory limit (more on that below). What is
interesting is that the numbers bounce around a bit;
increasing the number of entries isn't always a strict
improvement.

Partially this is due to noise in the measurement. But it
may also be an indication that our LRU ejection scheme is
not optimal. The smaller cache sizes introduce some
randomness into the ejection (due to collisions), which may
sometimes work in our favor (and sometimes not!).

So what is the optimal setting of MAX_DELTA_CACHE? The
"bouncing" in the linux.git log-S numbers notwithstanding,
it mostly seems like bigger is better. And even if we were
to try to find a "sweet spot", these are just two
repositories, that are not necessarily representative. The
shape of history, the size of trees and blobs, the memory
limit configuration, etc, all will affect the outcome.

Rather than trying to find the "right" number, another
strategy is to just switch to a hash table that can actually
store collisions: namely our hashmap.h implementation.

Here are numbers for that compared to the "best" we saw from
adjusting MAX_DELTA_CACHE:

        |       log-raw        |       log-S
        | best       hashmap   | best       hashmap
	| ---------  --------- | ---------  ---------
  git   | 0m02.144s  0m02.144s | 0m06.448s  0m06.688s
  linux | 0m33.311s  0m33.092s | 4m41.194s  4m57.172s

We can see the results are similar in most cases, which is
what we'd expect. We're not ejecting due to collisions at
all, so this is purely representing the LRU. So really, we'd
expect this to model most closely the larger values of the
static MAX_DELTA_CACHE limit. And that does seem to be
what's happening, including the "bounce" in the linux log-S
case.

So while the value for that case _isn't_ as good as the
optimal one measured above (which was 2048 entries), given
the bouncing I'm hesitant to suggest that 2048 is any kind
of optimum (not even for linux.git, let alone as a general
rule). The generic hashmap has the appeal that it drops the
number of tweakable numbers by one, which means we can focus
on tuning other elements, like the LRU strategy or the
core.deltaBaseCacheLimit setting.

And indeed, if we bump the cache limit to 1G (which is
probably silly for general use, but maybe something people
with big workstations would want to do), the linux.git log-S
time drops to 3m32s. That's something you really _can't_ do
easily with the static hash table, because the number of
entries needs to grow in proportion to the memory limit (so
2048 is almost certainly not going to be the right value
there).

This patch takes that direction, and drops the static hash
table entirely in favor of using the hashmap.h API.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 94 +++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 34 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 33564d6..a57b71d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2074,48 +2074,69 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	return buffer;
 }
 
-#define MAX_DELTA_CACHE (256)
-
+static struct hashmap delta_base_cache;
 static size_t delta_base_cached;
 
 static LIST_HEAD(delta_base_cache_lru);
 
-static struct delta_base_cache_entry {
-	struct list_head lru;
-	void *data;
+struct delta_base_cache_key {
 	struct packed_git *p;
 	off_t base_offset;
+};
+
+struct delta_base_cache_entry {
+	struct hashmap hash;
+	struct delta_base_cache_key key;
+	struct list_head lru;
+	void *data;
 	unsigned long size;
 	enum object_type type;
-} delta_base_cache[MAX_DELTA_CACHE];
+};
 
-static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
+static unsigned int pack_entry_hash(struct packed_git *p, off_t base_offset)
 {
-	unsigned long hash;
+	unsigned int hash;
 
-	hash = (unsigned long)(intptr_t)p + (unsigned long)base_offset;
+	hash = (unsigned int)(intptr_t)p + (unsigned int)base_offset;
 	hash += (hash >> 8) + (hash >> 16);
-	return hash % MAX_DELTA_CACHE;
+	return hash;
 }
 
 static struct delta_base_cache_entry *
 get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
 {
-	unsigned long hash = pack_entry_hash(p, base_offset);
-	return delta_base_cache + hash;
+	struct hashmap_entry entry;
+	struct delta_base_cache_key key;
+
+	if (!delta_base_cache.cmpfn)
+		return NULL;
+
+	hashmap_entry_init(&entry, pack_entry_hash(p, base_offset));
+	key.p = p;
+	key.base_offset = base_offset;
+	return hashmap_get(&delta_base_cache, &entry, &key);
 }
 
-static int eq_delta_base_cache_entry(struct delta_base_cache_entry *ent,
-				     struct packed_git *p, off_t base_offset)
+static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
+				   const struct delta_base_cache_key *b)
 {
-	return (ent->data && ent->p == p && ent->base_offset == base_offset);
+	return a->p == b->p && a->base_offset == b->base_offset;
+}
+
+static int delta_base_cache_hash_cmp(const void *va, const void *vb,
+				     const void *vkey)
+{
+	const struct delta_base_cache_entry *a = va, *b = vb;
+	const struct delta_base_cache_key *key = vkey;
+	if (key)
+		return !delta_base_cache_key_eq(&a->key, key);
+	else
+		return !delta_base_cache_key_eq(&a->key, &b->key);
 }
 
 static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
 {
-	struct delta_base_cache_entry *ent;
-	ent = get_delta_base_cache_entry(p, base_offset);
-	return eq_delta_base_cache_entry(ent, p, base_offset);
+	return !!get_delta_base_cache_entry(p, base_offset);
 }
 
 /*
@@ -2125,9 +2146,10 @@ static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
  */
 static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 {
-	ent->data = NULL;
+	hashmap_remove(&delta_base_cache, ent, &ent->key);
 	list_del(&ent->lru);
 	delta_base_cached -= ent->size;
+	free(ent);
 }
 
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
@@ -2136,8 +2158,7 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	struct delta_base_cache_entry *ent;
 
 	ent = get_delta_base_cache_entry(p, base_offset);
-
-	if (!eq_delta_base_cache_entry(ent, p, base_offset))
+	if (!ent)
 		return unpack_entry(p, base_offset, type, base_size);
 
 	*type = ent->type;
@@ -2147,27 +2168,27 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 
 static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 {
-	if (ent->data) {
-		free(ent->data);
-		detach_delta_base_cache_entry(ent);
-	}
+	free(ent->data);
+	detach_delta_base_cache_entry(ent);
 }
 
 void clear_delta_base_cache(void)
 {
-	unsigned long p;
-	for (p = 0; p < MAX_DELTA_CACHE; p++)
-		release_delta_base_cache(&delta_base_cache[p]);
+	struct hashmap_iter iter;
+	struct delta_base_cache_entry *entry;
+	for (entry = hashmap_iter_first(&delta_base_cache, &iter);
+	     entry;
+	     entry = hashmap_iter_next(&iter)) {
+		release_delta_base_cache(entry);
+	}
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
-	unsigned long hash = pack_entry_hash(p, base_offset);
-	struct delta_base_cache_entry *ent = delta_base_cache + hash;
+	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
 	struct list_head *lru;
 
-	release_delta_base_cache(ent);
 	delta_base_cached += base_size;
 
 	list_for_each(lru, &delta_base_cache_lru) {
@@ -2178,12 +2199,17 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 		release_delta_base_cache(f);
 	}
 
-	ent->p = p;
-	ent->base_offset = base_offset;
+	ent->key.p = p;
+	ent->key.base_offset = base_offset;
 	ent->type = type;
 	ent->data = base;
 	ent->size = base_size;
 	list_add_tail(&ent->lru, &delta_base_cache_lru);
+
+	if (!delta_base_cache.cmpfn)
+		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, 0);
+	hashmap_entry_init(ent, pack_entry_hash(p, base_offset));
+	hashmap_add(&delta_base_cache, ent);
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,
@@ -2227,7 +2253,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		struct delta_base_cache_entry *ent;
 
 		ent = get_delta_base_cache_entry(p, curpos);
-		if (eq_delta_base_cache_entry(ent, p, curpos)) {
+		if (ent) {
 			type = ent->type;
 			data = ent->data;
 			size = ent->size;
-- 
2.10.0.rc1.118.ge2299eb

