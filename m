Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500A31F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeHNEni (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:43:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:54186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729055AbeHNEni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:43:38 -0400
Received: (qmail 26764 invoked by uid 109); 14 Aug 2018 01:58:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 01:58:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15834 invoked by uid 111); 14 Aug 2018 01:58:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 21:58:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 21:58:42 -0400
Date:   Mon, 13 Aug 2018 21:58:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
Message-ID: <20180814015842.GA27055@sigill.intra.peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
 <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
 <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6065f3e5-f831-802f-9adc-099de99405fc@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 07:15:23PM +0200, René Scharfe wrote:

> Am 11.08.2018 um 22:59 schrieb René Scharfe:
> > If the current oidset implementation is so bad, why not replace it with
> > one based on oid_array? ;-)
> > 
> > Intuitively I'd try a hashmap with no payload and open addressing via
> > sha1hash(), which should reduce memory allocations quite a bit -- no
> > need to store hash codes and next pointers, only an array of object IDs
> > with a fill rate of 50% or so.  Deletions are a bit awkward with that
> > scheme, though; they could perhaps be implemented as insertions into a
> > second hashmap.
> 
> Here's roughly what I had in mind, only with a free/occupied bitmap (or
> a one-bit payload, if you will).  I tried a variant that encoded empty
> slots as null_oid first, which has lower memory usage, but isn't any
> faster than the current code.

Hmph, I thought I had sent my version out last night, but it looks like
I didn't. I got similarly mediocre results.

Your suggestion can be implemented using khash (my patch below).

> Before:
> Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'
> 
>   Time (mean ± σ):     269.5 ms ±  26.7 ms    [User: 247.7 ms, System: 21.4 ms]
> 
>   Range (min … max):   240.3 ms … 339.3 ms
> 
> After:
> Benchmark #1: ./git-cat-file --batch-all-objects --buffer --unordered --batch-check='%(objectname)'
> 
>   Time (mean ± σ):     224.2 ms ±  18.2 ms    [User: 201.7 ms, System: 22.1 ms]
> 
>   Range (min … max):   205.0 ms … 259.0 ms

Yeah. My best-of-five dropped from 300ms to 247ms. That 300 was using
the memory pool, though khash's deletion strategy isn't all that
different (the wasted memory hangs around until the next hash resize,
but if you're evenly dropping and adding, you likely won't need to
resize).

Applying your patch, I get 337ms, worse than the hashmap with a memory
pool. I'm not sure why.

>  builtin/cat-file.c | 93 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 88 insertions(+), 5 deletions(-)

By the way, your patch seemed damaged (wouldn't apply, and "am -3"
complained of hand-editing). It looks like maybe there's an extra space
inserted in the context lines?

Anyway, here's the khash patch for reference.

diff --git a/fetch-pack.c b/fetch-pack.c
index 5714bcbddd..5a86b10a5e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -534,7 +534,7 @@ static int tip_oids_contain(struct oidset *tip_oids,
 	 * add to "newlist" between calls, the additions will always be for
 	 * oids that are already in the set.
 	 */
-	if (!tip_oids->map.map.tablesize) {
+	if (!tip_oids->map) {
 		add_refs_to_oidset(tip_oids, unmatched);
 		add_refs_to_oidset(tip_oids, newlist);
 	}
diff --git a/oidset.c b/oidset.c
index 454c54f933..2964b43b2d 100644
--- a/oidset.c
+++ b/oidset.c
@@ -3,38 +3,44 @@
 
 int oidset_contains(const struct oidset *set, const struct object_id *oid)
 {
-	if (!set->map.map.tablesize)
+	khiter_t pos;
+
+	if (!set->map)
 		return 0;
-	return !!oidmap_get(&set->map, oid);
+
+	pos = kh_get_oid(set->map, *oid);
+	return pos < kh_end(set->map);
 }
 
 int oidset_insert(struct oidset *set, const struct object_id *oid)
 {
-	struct oidmap_entry *entry;
+	int hash_ret;
 
-	if (!set->map.map.tablesize)
-		oidmap_init(&set->map, 0);
-	else if (oidset_contains(set, oid))
-		return 1;
+	if (!set->map)
+		set->map = kh_init_oid();
 
-	entry = xmalloc(sizeof(*entry));
-	oidcpy(&entry->oid, oid);
-
-	oidmap_put(&set->map, entry);
-	return 0;
+	kh_put_oid(set->map, *oid, &hash_ret);
+	return !hash_ret;
 }
 
 int oidset_remove(struct oidset *set, const struct object_id *oid)
 {
-	struct oidmap_entry *entry;
+	khiter_t pos;
 
-	entry = oidmap_remove(&set->map, oid);
-	free(entry);
+	if (!set->map)
+		return 0;
+
+	pos = kh_get_oid(set->map, *oid);
+	if (pos < kh_end(set->map)) {
+		kh_del_oid(set->map, pos);
+		return 1;
+	}
 
-	return (entry != NULL);
+	return 0;
 }
 
 void oidset_clear(struct oidset *set)
 {
-	oidmap_free(&set->map, 1);
+	kh_destroy_oid(set->map);
+	set->map = NULL;
 }
diff --git a/oidset.h b/oidset.h
index 40ec5f87fe..4c4c5a42fe 100644
--- a/oidset.h
+++ b/oidset.h
@@ -2,6 +2,7 @@
 #define OIDSET_H
 
 #include "oidmap.h"
+#include "khash.h"
 
 /**
  * This API is similar to sha1-array, in that it maintains a set of object ids
@@ -15,19 +16,34 @@
  *      table overhead.
  */
 
+static inline unsigned int oid_hash(const struct object_id oid)
+{
+	unsigned int hash;
+	memcpy(&hash, oid.hash, sizeof(hash));
+	return hash;
+}
+
+static inline int oid_equal(const struct object_id a,
+			    const struct object_id b)
+{
+	return !oidcmp(&a, &b);
+}
+
+KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)
+
+
 /**
  * A single oidset; should be zero-initialized (or use OIDSET_INIT).
  */
 struct oidset {
-	struct oidmap map;
+	kh_oid_t *map;
 };
 
-#define OIDSET_INIT { OIDMAP_INIT }
-
+#define OIDSET_INIT { NULL }
 
 static inline void oidset_init(struct oidset *set, size_t initial_size)
 {
-	oidmap_init(&set->map, initial_size);
+	set->map = NULL;
 }
 
 /**
@@ -58,19 +74,25 @@ int oidset_remove(struct oidset *set, const struct object_id *oid);
 void oidset_clear(struct oidset *set);
 
 struct oidset_iter {
-	struct oidmap_iter m_iter;
+	kh_oid_t *map;
+	khiter_t iter;
 };
 
 static inline void oidset_iter_init(struct oidset *set,
 				    struct oidset_iter *iter)
 {
-	oidmap_iter_init(&set->map, &iter->m_iter);
+	iter->map = set->map;
+	iter->iter = kh_begin(iter->map);
 }
 
 static inline struct object_id *oidset_iter_next(struct oidset_iter *iter)
 {
-	struct oidmap_entry *e = oidmap_iter_next(&iter->m_iter);
-	return e ? &e->oid : NULL;
+	for (; iter->iter != kh_end(iter->map); iter->iter++) {
+		if (!kh_exist(iter->map, iter->iter))
+			continue;
+		return &kh_key(iter->map, iter->iter);
+	}
+	return NULL;
 }
 
 static inline struct object_id *oidset_iter_first(struct oidset *set,
