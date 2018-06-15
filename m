Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694871F403
	for <e@80x24.org>; Fri, 15 Jun 2018 03:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965463AbeFODcA (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 23:32:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:45320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965120AbeFODcA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 23:32:00 -0400
Received: (qmail 17529 invoked by uid 109); 15 Jun 2018 03:32:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 03:32:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18138 invoked by uid 111); 15 Jun 2018 03:32:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 23:32:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 23:31:58 -0400
Date:   Thu, 14 Jun 2018 23:31:58 -0400
From:   Jeff King <peff@peff.net>
To:     Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/3] ewah: drop ewah_deserialize function
Message-ID: <20180615033157.GB20390@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615032850.GA23241@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't call this function, and in fact never have since it
was added (at least not in iterations of the ewah patches
that got merged). Instead we use ewah_read_mmap().

Let's drop the unused code.

Note to anybody who later wants to resurrect this: it does
not check for integer overflow in the ewah data size,
meaning it may be possible to convince the code to allocate
a too-small buffer and read() into it.

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/ewah_io.c | 55 --------------------------------------------------
 ewah/ewok.h    |  1 -
 2 files changed, 56 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 33c08c40f8..97c74266da 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -168,58 +168,3 @@ ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 
 	return ptr - (const uint8_t *)map;
 }
-
-int ewah_deserialize(struct ewah_bitmap *self, int fd)
-{
-	size_t i;
-	eword_t dump[2048];
-	const size_t words_per_dump = sizeof(dump) / sizeof(eword_t);
-	uint32_t bitsize, word_count, rlw_pos;
-
-	eword_t *buffer = NULL;
-	size_t words_left;
-
-	ewah_clear(self);
-
-	/* 32 bit -- bit size for the map */
-	if (read(fd, &bitsize, 4) != 4)
-		return -1;
-
-	self->bit_size = (size_t)ntohl(bitsize);
-
-	/** 32 bit -- number of compressed 64-bit words */
-	if (read(fd, &word_count, 4) != 4)
-		return -1;
-
-	self->buffer_size = self->alloc_size = (size_t)ntohl(word_count);
-	REALLOC_ARRAY(self->buffer, self->alloc_size);
-
-	/** 64 bit x N -- compressed words */
-	buffer = self->buffer;
-	words_left = self->buffer_size;
-
-	while (words_left >= words_per_dump) {
-		if (read(fd, dump, sizeof(dump)) != sizeof(dump))
-			return -1;
-
-		for (i = 0; i < words_per_dump; ++i, ++buffer)
-			*buffer = ntohll(dump[i]);
-
-		words_left -= words_per_dump;
-	}
-
-	if (words_left) {
-		if (read(fd, dump, words_left * 8) != words_left * 8)
-			return -1;
-
-		for (i = 0; i < words_left; ++i, ++buffer)
-			*buffer = ntohll(dump[i]);
-	}
-
-	/** 32 bit -- position for the RLW */
-	if (read(fd, &rlw_pos, 4) != 4)
-		return -1;
-
-	self->rlw = self->buffer + ntohl(rlw_pos);
-	return 0;
-}
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 357fd93c84..7e25ca2e61 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -90,7 +90,6 @@ int ewah_serialize(struct ewah_bitmap *self, int fd);
 int ewah_serialize_native(struct ewah_bitmap *self, int fd);
 int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *);
 
-int ewah_deserialize(struct ewah_bitmap *self, int fd);
 ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);
 
 uint32_t ewah_checksum(struct ewah_bitmap *self);
-- 
2.18.0.rc2.534.g53d976aeb8

