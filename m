Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D464BC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD5B6146D
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhA1GVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:21:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:41646 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhA1GVG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:21:06 -0500
Received: (qmail 9678 invoked by uid 109); 28 Jan 2021 06:20:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:20:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25377 invoked by uid 111); 28 Jan 2021 06:20:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:20:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:20:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] oid_pos(): access table through const pointers
Message-ID: <YBJXp9Tr9kHrgYsp@coredump.intra.peff.net>
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBJVuckmbGriVa//@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are looking up an oid in an array, we obviously don't need to
write to the array. Let's mark it as const in the function interfaces,
as well as in the local variables we use to derference the void pointer
(note a few cases use pointers-to-pointers, so we mark everything
const).

Signed-off-by: Jeff King <peff@peff.net>
---
This is just a hygiene thing. I think it's pretty unlikely for one of
these 2-line access functions to somehow forget that the table is
supposed to be const.

 builtin/name-rev.c  | 4 ++--
 commit-graph.c      | 4 ++--
 commit.c            | 4 ++--
 hash-lookup.c       | 2 +-
 hash-lookup.h       | 4 ++--
 oid-array.c         | 4 ++--
 pack-bitmap-write.c | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 27138fdce4..b221d30014 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -390,9 +390,9 @@ static void name_tips(void)
 	}
 }
 
-static const struct object_id *nth_tip_table_ent(size_t ix, void *table_)
+static const struct object_id *nth_tip_table_ent(size_t ix, const void *table_)
 {
-	struct tip_table_entry *table = table_;
+	const struct tip_table_entry *table = table_;
 	return &table[ix].oid;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 248f1efb73..b09fce5f57 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1012,9 +1012,9 @@ static int write_graph_chunk_oids(struct hashfile *f,
 	return 0;
 }
 
-static const struct object_id *commit_to_oid(size_t index, void *table)
+static const struct object_id *commit_to_oid(size_t index, const void *table)
 {
-	struct commit **commits = table;
+	const struct commit * const *commits = table;
 	return &commits[index]->object.oid;
 }
 
diff --git a/commit.c b/commit.c
index 39eab5b36b..fd2831dad3 100644
--- a/commit.c
+++ b/commit.c
@@ -105,9 +105,9 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
-static const struct object_id *commit_graft_oid_access(size_t index, void *table)
+static const struct object_id *commit_graft_oid_access(size_t index, const void *table)
 {
-	struct commit_graft **commit_graft_table = table;
+	const struct commit_graft * const *commit_graft_table = table;
 	return &commit_graft_table[index]->oid;
 }
 
diff --git a/hash-lookup.c b/hash-lookup.c
index d15bb34574..b98ed5e11e 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -50,7 +50,7 @@ static uint32_t take2(const struct object_id *oid, size_t ofs)
  * The oid of element i (between 0 and nr - 1) should be returned
  * by "fn(i, table)".
  */
-int oid_pos(const struct object_id *oid, void *table, size_t nr,
+int oid_pos(const struct object_id *oid, const void *table, size_t nr,
 	    oid_access_fn fn)
 {
 	size_t hi = nr;
diff --git a/hash-lookup.h b/hash-lookup.h
index 7b3ecad1f0..dbd71ebaf7 100644
--- a/hash-lookup.h
+++ b/hash-lookup.h
@@ -1,10 +1,10 @@
 #ifndef HASH_LOOKUP_H
 #define HASH_LOOKUP_H
 
-typedef const struct object_id *oid_access_fn(size_t index, void *table);
+typedef const struct object_id *oid_access_fn(size_t index, const void *table);
 
 int oid_pos(const struct object_id *oid,
-	    void *table,
+	    const void *table,
 	    size_t nr,
 	    oid_access_fn fn);
 
diff --git a/oid-array.c b/oid-array.c
index a19235afbf..73ba76e9e9 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -22,9 +22,9 @@ void oid_array_sort(struct oid_array *array)
 	array->sorted = 1;
 }
 
-static const struct object_id *oid_access(size_t index, void *table)
+static const struct object_id *oid_access(size_t index, const void *table)
 {
-	struct object_id *array = table;
+	const struct object_id *array = table;
 	return &array[index];
 }
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f21259dfc8..88d9e696a5 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -610,9 +610,9 @@ static inline void dump_bitmap(struct hashfile *f, struct ewah_bitmap *bitmap)
 		die("Failed to write bitmap index");
 }
 
-static const struct object_id *oid_access(size_t pos, void *table)
+static const struct object_id *oid_access(size_t pos, const void *table)
 {
-	struct pack_idx_entry **index = table;
+	const struct pack_idx_entry * const *index = table;
 	return &index[pos]->oid;
 }
 
-- 
2.30.0.758.gfe500d6872
