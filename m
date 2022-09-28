Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D949EC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 04:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiI1EX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 00:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiI1EX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 00:23:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E181F01AB
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 21:23:55 -0700 (PDT)
Received: (qmail 3223 invoked by uid 109); 28 Sep 2022 04:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Sep 2022 04:23:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25755 invoked by uid 111); 28 Sep 2022 04:23:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Sep 2022 00:23:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Sep 2022 00:23:54 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/3] read-cache: use read_be32() in create_from_disk()
Message-ID: <YzPMWnx1wJlpICHr@coredump.intra.peff.net>
References: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the previous patch put our parsing in byte order, we can simplify
the function by keeping a "pos" variable with our current offset into
the on-disk data. That lets us use read_be32() to read and advance the
pos, rather than calculating an offset for each field. This is easier to
read and harder to get wrong.

Likewise, we no longer need the "flagsp" pointer; by the time we read
the flags, our "pos" index has advanced there. And we no longer need a
separate "name" pointer. After parsing the flags, "pos" points there
(and we increment as expected if CE_EXTENDED asks us to read extra
flags).

We can also drop the local "hashsz", as its value is used in only one
place now.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess you could argue that dropping "name" reduces readability, as now
we just say "ondisk + pos". It is nice having only one position pointer,
but we lose the human-readable word "name" which tells what we expect
there. I dunno.

 read-cache.c | 53 ++++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index efb9efa5ee..a277836ee2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1884,11 +1884,9 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	struct object_id oid;
 	struct cache_entry *ce;
 	size_t len;
-	const char *name;
-	const unsigned hashsz = the_hash_algo->rawsz;
-	const char *flagsp;
 	unsigned int flags;
 	size_t copy_len = 0;
+	size_t pos = 0;
 	/*
 	 * Adjacent cache entries tend to share the leading paths, so it makes
 	 * sense to only store the differences in later entries.  In the v4
@@ -1898,42 +1896,35 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	 */
 	int expand_name_field = version == 4;
 
-	sd.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
-							+ offsetof(struct cache_time, sec));
-	sd.sd_ctime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
-							 + offsetof(struct cache_time, nsec));
-	sd.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
-							+ offsetof(struct cache_time, sec));
-	sd.sd_mtime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
-							 + offsetof(struct cache_time, nsec));
-	sd.sd_dev   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, dev));
-	sd.sd_ino   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ino));
-	mode        = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mode));
-	sd.sd_uid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, uid));
-	sd.sd_gid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, gid));
-	sd.sd_size  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, size));
-
-	oidread(&oid, (const unsigned char *)ondisk + offsetof(struct ondisk_cache_entry, data));
-	flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
+	sd.sd_ctime.sec = read_be32(ondisk, &pos);
+	sd.sd_ctime.nsec = read_be32(ondisk, &pos);
+	sd.sd_mtime.sec = read_be32(ondisk, &pos);
+	sd.sd_mtime.nsec = read_be32(ondisk, &pos);
+	sd.sd_dev   = read_be32(ondisk, &pos);
+	sd.sd_ino   = read_be32(ondisk, &pos);
+	mode        = read_be32(ondisk, &pos);
+	sd.sd_uid   = read_be32(ondisk, &pos);
+	sd.sd_gid   = read_be32(ondisk, &pos);
+	sd.sd_size  = read_be32(ondisk, &pos);
+
+	oidread(&oid, (const unsigned char *)ondisk + pos);
+	pos += the_hash_algo->rawsz;
 
 	/* On-disk flags are just 16 bits */
-	flags = get_be16(flagsp);
+	flags = read_be16(ondisk, &pos);
 	len = flags & CE_NAMEMASK;
 
 	if (flags & CE_EXTENDED) {
 		int extended_flags;
-		extended_flags = get_be16(flagsp + sizeof(uint16_t)) << 16;
+		extended_flags = read_be16(ondisk, &pos) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
 			die(_("unknown index entry format 0x%08x"), extended_flags);
 		flags |= extended_flags;
-		name = (const char *)(flagsp + 2 * sizeof(uint16_t));
 	}
-	else
-		name = (const char *)(flagsp + sizeof(uint16_t));
 
 	if (expand_name_field) {
-		const unsigned char *cp = (const unsigned char *)name;
+		const unsigned char *cp = (const unsigned char *)ondisk + pos;
 		size_t strip_len, previous_len;
 
 		/* If we're at the beginning of a block, ignore the previous name */
@@ -1945,11 +1936,11 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					previous_ce->name);
 			copy_len = previous_len - strip_len;
 		}
-		name = (const char *)cp;
+		pos = (const char *)cp - ondisk;
 	}
 
 	if (len == CE_NAMEMASK) {
-		len = strlen(name);
+		len = strlen(ondisk + pos);
 		if (expand_name_field)
 			len += copy_len;
 	}
@@ -1965,10 +1956,10 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	if (expand_name_field) {
 		if (copy_len)
 			memcpy(ce->name, previous_ce->name, copy_len);
-		memcpy(ce->name + copy_len, name, len + 1 - copy_len);
-		*ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
+		memcpy(ce->name + copy_len, ondisk + pos, len + 1 - copy_len);
+		*ent_size = pos + len + 1 - copy_len;
 	} else {
-		memcpy(ce->name, name, len + 1);
+		memcpy(ce->name, ondisk + pos, len + 1);
 		*ent_size = ondisk_ce_size(ce);
 	}
 	return ce;
-- 
2.38.0.rc2.615.g4fac75f9e3
