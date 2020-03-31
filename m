Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B4C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 09:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E606F2073B
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 09:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgCaJpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:45:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729997AbgCaJpy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 05:45:54 -0400
Received: (qmail 23604 invoked by uid 109); 31 Mar 2020 09:45:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Mar 2020 09:45:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28199 invoked by uid 111); 31 Mar 2020 09:55:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2020 05:55:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Mar 2020 05:45:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: fast-import's hash table is slow
Message-ID: <20200331094553.GB7274@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[breaking thread, since this is really an independent topic]

On Mon, Mar 30, 2020 at 10:09:30AM -0400, Jeff King wrote:

> So I arrived at this fast-import solution, which was...not super fast.
> Profiling showed that we were spending 80% of the time inserting into
> our custom hashtable, which is fixed at 2^16 entries and then chains
> beyond that. Swapping it out for a khash proved much faster, but I'm not
> sure if the memory games are too gross (see the comment in find_object
> below).
> 
> I also didn't look into whether we could get rid of the extra allocating
> pool (and store the structs right in the hash), or if it's necessary for
> their pointers to be stable.

I briefly tried to get rid of the pool. I _think_ it should be possible,
but I did see some test failures. It's entirely possible I screwed it
up. However, I did generate a few interesting measurements showing how
the current hash table behaves on this test:

  git init repo
  cd repo
  perl -e '
      my $bits = shift;
      my $nr = 2**$bits;

      for (my $i = 0; $i < $nr; $i++) {
              print "blob\n";
              print "data 4\n";
              print pack("N", $i);
      }
  ' "$@" | git fast-import

Here are wall-clock timings for the current tip of master, versus with
the patch below applied:

nr_objects   master       patch
2^20         0m04.317s    0m5.109s
2^21         0m10.204s    0m9.702s
2^22         0m27.159s    0m17.911s
2^23         1m19.038s    0m35.080s
2^24         4m18.766s    1m10.233s

The curve on master is quadratic-ish (each line has double the number of
objects of the previous one; the times don't multiply by 4, but that's
because the hash table is only part of the work we're doing). With my
patch, it's pretty linear.

But I'm still disappointed that the smallest case is actually _slower_
with the patch. The existing hash table is so simple I can imagine using
khash has a little overhead. But I'm surprised it would be so much (or
that the existing hash table does OK at 2^20; it only has 2^16 buckets).

Maybe this email will nerd-snipe René into poking at it.

The patch I tested is below (it's slightly different than what I showed
before, in that it handles duplicate insertions). Maybe using hashmap.c
would be better?

---
diff --git a/fast-import.c b/fast-import.c
index 202dda11a6..6ebac665a0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -39,12 +39,25 @@
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	struct object_entry *next;
 	uint32_t type : TYPE_BITS,
 		pack_id : PACK_ID_BITS,
 		depth : DEPTH_BITS;
 };
 
+static inline unsigned int object_entry_hash(struct object_entry *oe)
+{
+	return oidhash(&oe->idx.oid);
+}
+
+static inline int object_entry_equal(struct object_entry *a,
+				     struct object_entry *b)
+{
+	return oideq(&a->idx.oid, &b->idx.oid);
+}
+
+KHASH_INIT(object_entry_set, struct object_entry *, int, 0,
+	   object_entry_hash, object_entry_equal);
+
 struct object_entry_pool {
 	struct object_entry_pool *next_pool;
 	struct object_entry *next_free;
@@ -178,7 +191,7 @@ static off_t pack_size;
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
-static struct object_entry *object_table[1 << 16];
+static kh_object_entry_set_t object_table;
 static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
@@ -455,44 +468,45 @@ static struct object_entry *new_object(struct object_id *oid)
 
 static struct object_entry *find_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e;
-	for (e = object_table[h]; e; e = e->next)
-		if (oideq(oid, &e->idx.oid))
-			return e;
+	/*
+	 * this cast works because we only look at the oid part of the entry,
+	 * and it comes first in the struct
+	 */
+	khiter_t pos = kh_get_object_entry_set(&object_table,
+					       (struct object_entry *)oid);
+	if (pos != kh_end(&object_table))
+		return kh_key(&object_table, pos);
 	return NULL;
 }
 
 static struct object_entry *insert_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e = object_table[h];
+	struct object_entry *e;
+	int was_empty;
+	khiter_t pos;
 
-	while (e) {
-		if (oideq(oid, &e->idx.oid))
-			return e;
-		e = e->next;
-	}
+	pos = kh_put_object_entry_set(&object_table, (struct object_entry *)oid, &was_empty);
+	if (!was_empty)
+		return kh_key(&object_table, pos);
 
 	e = new_object(oid);
-	e->next = object_table[h];
 	e->idx.offset = 0;
-	object_table[h] = e;
+	kh_key(&object_table, pos) = e;
 	return e;
 }
 
 static void invalidate_pack_id(unsigned int id)
 {
-	unsigned int h;
 	unsigned long lu;
 	struct tag *t;
+	khiter_t iter;
 
-	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
-		struct object_entry *e;
-
-		for (e = object_table[h]; e; e = e->next)
+	for (iter = kh_begin(&object_table); iter != kh_end(&object_table); iter++) {
+		if (kh_exist(&object_table, iter)) {
+			struct object_entry *e = kh_key(&object_table, iter);
 			if (e->pack_id == id)
 				e->pack_id = MAX_PACK_ID;
+		}
 	}
 
 	for (lu = 0; lu < branch_table_sz; lu++) {
