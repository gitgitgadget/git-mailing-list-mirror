Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA9C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7168820B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKMFGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 00:06:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:56906 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgKMFGu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 00:06:50 -0500
Received: (qmail 23756 invoked by uid 109); 13 Nov 2020 05:06:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 05:06:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6163 invoked by uid 111); 13 Nov 2020 05:06:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 00:06:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 00:06:48 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] compute pack .idx byte offsets using size_t
Message-ID: <20201113050648.GA744691@coredump.intra.peff.net>
References: <20201113050631.GA744608@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113050631.GA744608@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A pack and its matching .idx file are limited to 2^32 objects, because
the pack format contains a 32-bit field to store the number of objects.
Hence we use uint32_t in the code.

But the byte count of even a .idx file can be much larger than that,
because it stores at least a hash and an offset for each object. So
using SHA-1, a v2 .idx file will cross the 4GB boundary at 153,391,650
objects. This confuses load_idx(), which computes the minimum size like
this:

  unsigned long min_size = 8 + 4*256 + nr*(hashsz + 4 + 4) + hashsz + hashsz;

Even though min_size will be big enough on most 64-bit platforms, the
actual arithmetic is done as a uint32_t, resulting in a truncation. We
actually exceed that min_size, but then we do:

  unsigned long max_size = min_size;
  if (nr)
          max_size += (nr - 1)*8;

to account for the variable-sized table. That computation doesn't
overflow quite so low, but with the truncation for min_size, we end up
with a max_size that is much smaller than our actual size. So we
complain that the idx is invalid, and can't find any of its objects.

We can fix this case by casting "nr" to a size_t, which will do the
multiplication in 64-bits (assuming you're on a 64-bit platform; this
will never work on a 32-bit system since we couldn't map the whole .idx
anyway). Likewise, we don't have to worry about further additions,
because adding a smaller number to a size_t will convert the other side
to a size_t.

A few notes:

  - obviously we could just declare "nr" as a size_t in the first place
    (and likewise, packed_git.num_objects).  But it's conceptually a
    uint32_t because of the on-disk format, and we correctly treat it
    that way in other contexts that don't need to compute byte offsets
    (e.g., iterating over the set of objects should and generally does
    use a uint32_t). Switching to size_t would make all of those other
    cases look wrong.

  - it could be argued that the proper type is off_t to represent the
    file offset. But in practice the .idx file must fit within memory,
    because we mmap the whole thing. And the rest of the code (including
    the idx_size variable we're comparing against) uses size_t.

  - we'll add the same cast to the max_size arithmetic line. Even though
    we're adding to a larger type, which will convert our result, the
    multiplication is still done as a 32-bit value and can itself
    overflow. I didn't check this with my test case, since it would need
    an even larger pack (~530M objects), but looking at compiler output
    shows that it works this way. The standard should agree, but I
    couldn't find anything explicit in 6.3.1.8 ("usual arithmetic
    conversions").

The case in load_idx() was the most immediate one that I was able to
trigger. After fixing it, looking up actual objects (including the very
last one in sha1 order) works in a test repo with 153,725,110 objects.
That's because bsearch_hash() works with uint32_t entry indices, and the
actual byte access:

  int cmp = hashcmp(table + mi * stride, sha1);

is done with "stride" as a size_t, causing the uint32_t "mi" to be
promoted to a size_t. This is the way most code will access the index
data.

However, I audited all of the other byte-wise accesses of
packed_git.index_data, and many of the others are suspect (they are
similar to the max_size one, where we are adding to a properly sized
offset or directly to a pointer, but the multiplication in the
sub-expression can overflow). I didn't trigger any of these in practice,
but I believe they're potential problems, and certainly adding in the
cast is not going to hurt anything here.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c |  2 +-
 pack-check.c         |  2 +-
 pack-revindex.c      |  2 +-
 packfile.c           | 12 ++++++------
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0d03cb442d..4b8d86e0ad 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1597,7 +1597,7 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 
 	/* The address of the 4-byte offset table */
 	idx1 = (((const uint32_t *)((const uint8_t *)p->index_data + p->crc_offset))
-		+ p->num_objects /* CRC32 table */
+		+ (size_t)p->num_objects /* CRC32 table */
 		);
 
 	/* The address of the 8-byte offset table */
diff --git a/pack-check.c b/pack-check.c
index dad6d8ae7f..db3adf8781 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -39,7 +39,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	} while (len);
 
 	index_crc = p->index_data;
-	index_crc += 2 + 256 + p->num_objects * (the_hash_algo->rawsz/4) + nr;
+	index_crc += 2 + 256 + (size_t)p->num_objects * (the_hash_algo->rawsz/4) + nr;
 
 	return data_crc != ntohl(*index_crc);
 }
diff --git a/pack-revindex.c b/pack-revindex.c
index d28a7e43d0..ecdde39cf4 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -130,7 +130,7 @@ static void create_pack_revindex(struct packed_git *p)
 
 	if (p->index_version > 1) {
 		const uint32_t *off_32 =
-			(uint32_t *)(index + 8 + p->num_objects * (hashsz + 4));
+			(uint32_t *)(index + 8 + (size_t)p->num_objects * (hashsz + 4));
 		const uint32_t *off_64 = off_32 + p->num_objects;
 		for (i = 0; i < num_ent; i++) {
 			const uint32_t off = ntohl(*off_32++);
diff --git a/packfile.c b/packfile.c
index 0929ebe4fc..a72c2a261f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -148,7 +148,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		 *  - hash of the packfile
 		 *  - file checksum
 		 */
-		if (idx_size != 4 * 256 + nr * (hashsz + 4) + hashsz + hashsz)
+		if (idx_size != 4 * 256 + (size_t)nr * (hashsz + 4) + hashsz + hashsz)
 			return error("wrong index v1 file size in %s", path);
 	} else if (version == 2) {
 		/*
@@ -164,10 +164,10 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		 * variable sized table containing 8-byte entries
 		 * for offsets larger than 2^31.
 		 */
-		unsigned long min_size = 8 + 4*256 + nr*(hashsz + 4 + 4) + hashsz + hashsz;
+		unsigned long min_size = 8 + 4*256 + (size_t)nr*(hashsz + 4 + 4) + hashsz + hashsz;
 		unsigned long max_size = min_size;
 		if (nr)
-			max_size += (nr - 1)*8;
+			max_size += ((size_t)nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size)
 			return error("wrong index v2 file size in %s", path);
 		if (idx_size != min_size &&
@@ -1933,14 +1933,14 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	const unsigned int hashsz = the_hash_algo->rawsz;
 	index += 4 * 256;
 	if (p->index_version == 1) {
-		return ntohl(*((uint32_t *)(index + (hashsz + 4) * n)));
+		return ntohl(*((uint32_t *)(index + (hashsz + 4) * (size_t)n)));
 	} else {
 		uint32_t off;
-		index += 8 + p->num_objects * (hashsz + 4);
+		index += 8 + (size_t)p->num_objects * (hashsz + 4);
 		off = ntohl(*((uint32_t *)(index + 4 * n)));
 		if (!(off & 0x80000000))
 			return off;
-		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
+		index += (size_t)p->num_objects * 4 + (off & 0x7fffffff) * 8;
 		check_pack_index_ptr(p, index);
 		return get_be64(index);
 	}
-- 
2.29.2.705.g306f91dc4e

