Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AB9C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 12:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FC920737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 12:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403883AbgDCMPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:15:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:60450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2403836AbgDCMPK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 08:15:10 -0400
Received: (qmail 27084 invoked by uid 109); 3 Apr 2020 12:15:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 12:15:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18696 invoked by uid 111); 3 Apr 2020 12:25:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 08:25:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 08:15:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH] fast-import: replace custom hash with hashmap.c
Message-ID: <20200403121508.GA638328@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use a custom hash in fast-import to store the set of objects we've
imported so far. It has a fixed set of 2^16 buckets and chains any
collisions with a linked list. As the number of objects grows larger
than that, the load factor increases and we degrade to O(n) lookups and
O(n^2) insertions.

We can scale better by using our hashmap.c implementation, which will
resize the bucket count as we grow. This does incur an extra memory cost
of 8 bytes per object, as hashmap stores the integer hash value for each
entry in its hashmap_entry struct (which we really don't care about
here, because we're just reusing the embedded object hash). But I think
the numbers below justify this (and our per-object memory cost is
already much higher).

I also looked at using khash, but it seemed to perform slightly worse
than hashmap at all sizes, and worse even than the existing code for
small sizes. It's also awkward to use here, because we want to look up a
"struct object_entry" from a "struct object_id", and it doesn't handle
mismatched keys as well. Making a mapping of object_id to object_entry
would be more natural, but that would require pulling the embedded oid
out of the object_entry or incurring an extra 32 bytes per object.

In a synthetic test creating as many cheap, tiny objects as possible

  perl -e '
      my $bits = shift;
      my $nr = 2**$bits;

      for (my $i = 0; $i < $nr; $i++) {
              print "blob\n";
              print "data 4\n";
              print pack("N", $i);
      }
  ' $bits | git fast-import

I got these results:

  nr_objects   master       khash      hashmap
  2^20         0m4.317s     0m5.109s   0m3.890s
  2^21         0m10.204s    0m9.702s   0m7.933s
  2^22         0m27.159s    0m17.911s  0m16.751s
  2^23         1m19.038s    0m35.080s  0m31.963s
  2^24         4m18.766s    1m10.233s  1m6.793s

which points to hashmap as the winner. We didn't have any perf tests for
fast-export or fast-import, so I added one as a more real-world case.
It uses an export without blobs since that's significantly cheaper than
a full one, but still is an interesting case people might use (e.g., for
rewriting history). It will emphasize this change in some ways (as a
percentage we spend more time making objects and less shuffling blob
bytes around) and less in others (the total object count is lower).

Here are the results for linux.git:

  Test                        HEAD^                 HEAD
  ----------------------------------------------------------------------------
  9300.1: export (no-blobs)   67.64(66.96+0.67)     67.81(67.06+0.75) +0.3%
  9300.2: import (no-blobs)   284.04(283.34+0.69)   198.09(196.01+0.92) -30.3%

It only has ~5.2M commits and trees, so this is a larger effect than I
expected (the 2^23 case above only improved by 50s or so, but here we
gained almost 90s). This is probably due to actually performing more
object lookups in a real import with trees and commits, as opposed to
just dumping a bunch of blobs into a pack.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c                      | 62 +++++++++++++++++++-----------
 t/perf/p9300-fast-import-export.sh | 23 +++++++++++
 2 files changed, 62 insertions(+), 23 deletions(-)
 create mode 100755 t/perf/p9300-fast-import-export.sh

diff --git a/fast-import.c b/fast-import.c
index 202dda11a6..0ef6defc10 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -39,12 +39,28 @@
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	struct object_entry *next;
+	struct hashmap_entry ent;
 	uint32_t type : TYPE_BITS,
 		pack_id : PACK_ID_BITS,
 		depth : DEPTH_BITS;
 };
 
+static int object_entry_hashcmp(const void *map_data,
+				const struct hashmap_entry *eptr,
+				const struct hashmap_entry *entry_or_key,
+				const void *keydata)
+{
+	const struct object_id *oid = keydata;
+	const struct object_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct object_entry, ent);
+	if (oid)
+		return oidcmp(&e1->idx.oid, oid);
+
+	e2 = container_of(entry_or_key, const struct object_entry, ent);
+	return oidcmp(&e1->idx.oid, &e2->idx.oid);
+}
+
 struct object_entry_pool {
 	struct object_entry_pool *next_pool;
 	struct object_entry *next_free;
@@ -178,7 +194,7 @@ static off_t pack_size;
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
-static struct object_entry *object_table[1 << 16];
+static struct hashmap object_table;
 static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
@@ -455,44 +471,42 @@ static struct object_entry *new_object(struct object_id *oid)
 
 static struct object_entry *find_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e;
-	for (e = object_table[h]; e; e = e->next)
-		if (oideq(oid, &e->idx.oid))
-			return e;
+	struct hashmap_entry lookup_entry, *e;
+
+	hashmap_entry_init(&lookup_entry, oidhash(oid));
+	e = hashmap_get(&object_table, &lookup_entry, oid);
+	if (e)
+		return container_of(e, struct object_entry, ent);
 	return NULL;
 }
 
 static struct object_entry *insert_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e = object_table[h];
+	struct object_entry *e;
+	struct hashmap_entry lookup_entry, *hashent;
 
-	while (e) {
-		if (oideq(oid, &e->idx.oid))
-			return e;
-		e = e->next;
-	}
+	hashmap_entry_init(&lookup_entry, oidhash(oid));
+	hashent = hashmap_get(&object_table, &lookup_entry, oid);
+	if (hashent)
+		return container_of(hashent, struct object_entry, ent);
 
 	e = new_object(oid);
-	e->next = object_table[h];
 	e->idx.offset = 0;
-	object_table[h] = e;
+	e->ent.hash = lookup_entry.hash;
+	hashmap_add(&object_table, &e->ent);
 	return e;
 }
 
 static void invalidate_pack_id(unsigned int id)
 {
-	unsigned int h;
 	unsigned long lu;
 	struct tag *t;
+	struct hashmap_iter iter;
+	struct object_entry *e;
 
-	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
-		struct object_entry *e;
-
-		for (e = object_table[h]; e; e = e->next)
-			if (e->pack_id == id)
-				e->pack_id = MAX_PACK_ID;
+	hashmap_for_each_entry(&object_table, &iter, e, ent) {
+		if (e->pack_id == id)
+			e->pack_id = MAX_PACK_ID;
 	}
 
 	for (lu = 0; lu < branch_table_sz; lu++) {
@@ -3511,6 +3525,8 @@ int cmd_main(int argc, const char **argv)
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
 	marks = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 
+	hashmap_init(&object_table, object_entry_hashcmp, NULL, 0);
+
 	/*
 	 * We don't parse most options until after we've seen the set of
 	 * "feature" lines at the start of the stream (which allows the command
diff --git a/t/perf/p9300-fast-import-export.sh b/t/perf/p9300-fast-import-export.sh
new file mode 100755
index 0000000000..c3c743d04a
--- /dev/null
+++ b/t/perf/p9300-fast-import-export.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='test fast-import and fast-export performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# Use --no-data here to produce a vastly smaller export file.
+# This is much cheaper to work with but should still exercise
+# fast-import pretty well (we'll still process all commits and
+# trees, which account for 60% or more of objects in most repos).
+#
+# Use --rencode to avoid the default of aborting on non-utf8 commits,
+# which lets this test run against a wider variety of sample repos.
+test_perf 'export (no-blobs)' '
+	git fast-export --reencode=yes --no-data HEAD >export
+'
+
+test_perf 'import (no-blobs)' '
+	git fast-import --force <export
+'
+
+test_done
-- 
2.26.0.410.gc279fb3cbd
