Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C7FC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 04:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiI1EUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 00:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI1ET4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 00:19:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A3A00F2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 21:19:53 -0700 (PDT)
Received: (qmail 3197 invoked by uid 109); 28 Sep 2022 04:19:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Sep 2022 04:19:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25718 invoked by uid 111); 28 Sep 2022 04:19:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Sep 2022 00:19:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Sep 2022 00:19:51 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/3] pack-bitmap: make read_be32() public
Message-ID: <YzPLZ3J+FDibgF7o@coredump.intra.peff.net>
References: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a handy shortcut for other in-order parsers of binary formats.
We'll drag along read_be8(), as well, for consistency, and add
read_be16() to round out the set.

We'll also switch the signature to take a void pointer. This lets it be
used equally well with either signed or unsigned byte strings (the
get_be functions all cast to unsigned under the hood, so we don't care
either way at this level).

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/bswap.h | 22 ++++++++++++++++++++++
 pack-bitmap.c  | 12 ------------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 512f6f4b99..6cda2cc50d 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -190,4 +190,26 @@ static inline void put_be64(void *ptr, uint64_t value)
 	p[7] = value >>  0;
 }
 
+static inline uint32_t read_be32(const void *vbuffer, size_t *pos)
+{
+	const unsigned char *buffer = vbuffer;
+	uint32_t result = get_be32(buffer + *pos);
+	(*pos) += sizeof(result);
+	return result;
+}
+
+static inline uint16_t read_be16(const void *vbuffer, size_t *pos)
+{
+	const unsigned char *buffer = vbuffer;
+	uint16_t result = get_be16(buffer + *pos);
+	(*pos) += sizeof(result);
+	return result;
+}
+
+static inline uint8_t read_u8(const void *vbuffer, size_t *pos)
+{
+	const unsigned char *buffer = vbuffer;
+	return buffer[(*pos)++];
+}
+
 #endif /* COMPAT_BSWAP_H */
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 440407f1be..51d1e79b70 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -242,18 +242,6 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	return stored;
 }
 
-static inline uint32_t read_be32(const unsigned char *buffer, size_t *pos)
-{
-	uint32_t result = get_be32(buffer + *pos);
-	(*pos) += sizeof(result);
-	return result;
-}
-
-static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
-{
-	return buffer[(*pos)++];
-}
-
 #define MAX_XOR_OFFSET 160
 
 static int nth_bitmap_object_oid(struct bitmap_index *index,
-- 
2.38.0.rc2.615.g4fac75f9e3

