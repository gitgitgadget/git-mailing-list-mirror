Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2B71F403
	for <e@80x24.org>; Fri, 15 Jun 2018 03:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965483AbeFODbP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 23:31:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:45312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965441AbeFODbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 23:31:15 -0400
Received: (qmail 17486 invoked by uid 109); 15 Jun 2018 03:31:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 03:31:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18121 invoked by uid 111); 15 Jun 2018 03:31:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 23:31:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 23:31:13 -0400
Date:   Thu, 14 Jun 2018 23:31:13 -0400
From:   Jeff King <peff@peff.net>
To:     Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
Message-ID: <20180615033112.GA20390@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615032850.GA23241@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The on-disk ewah format tells us how big the ewah data is,
and we blindly read that much from the buffer without
considering whether the mmap'd data is long enough, which
can lead to out-of-bound reads.

Let's make sure we have data available before reading it,
both for the ewah header/footer as well as for the bit data
itself. In particular:

  - keep our ptr/len pair in sync as we move through the
    buffer, and check it before each read

  - check the size for integer overflow (this should be
    impossible on 64-bit, as the size is given as a 32-bit
    count of 8-byte words, but is possible on a 32-bit
    system)

  - return the number of bytes read as an ssize_t instead of
    an int, again to prevent integer overflow

  - compute the return value using a pointer difference;
    this should yield the same result as the existing code,
    but makes it more obvious that we got our computations
    right

The included test is far from comprehensive, as it just
picks a static point at which to truncate the generated
bitmap. But in practice this will hit in the middle of an
ewah and make sure we're at least exercising this code.

Reported-by: Luat Nguyen <root@l4w.io>
Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/ewah_io.c          | 25 +++++++++++++++++++++----
 ewah/ewok.h             |  2 +-
 t/t5310-pack-bitmaps.sh | 13 +++++++++++++
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index bed1994551..33c08c40f8 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -122,16 +122,23 @@ int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *sb)
 	return ewah_serialize_to(self, write_strbuf, sb);
 }
 
-int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
+ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 {
 	const uint8_t *ptr = map;
+	size_t data_len;
 	size_t i;
 
+	if (len < sizeof(uint32_t))
+		return error("corrupt ewah bitmap: eof before bit size");
 	self->bit_size = get_be32(ptr);
 	ptr += sizeof(uint32_t);
+	len -= sizeof(uint32_t);
 
+	if (len < sizeof(uint32_t))
+		return error("corrupt ewah bitmap: eof before length");
 	self->buffer_size = self->alloc_size = get_be32(ptr);
 	ptr += sizeof(uint32_t);
+	len -= sizeof(uint32_t);
 
 	REALLOC_ARRAY(self->buffer, self->alloc_size);
 
@@ -141,15 +148,25 @@ int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 	 * the endianness conversion in a separate pass to ensure
 	 * we're loading 8-byte aligned words.
 	 */
-	memcpy(self->buffer, ptr, self->buffer_size * sizeof(eword_t));
-	ptr += self->buffer_size * sizeof(eword_t);
+	data_len = st_mult(self->buffer_size, sizeof(eword_t));
+	if (len < data_len)
+		return error("corrupt ewah bitmap: eof in data "
+			     "(%"PRIuMAX" bytes short)",
+			     (uintmax_t)(data_len - len));
+	memcpy(self->buffer, ptr, data_len);
+	ptr += data_len;
+	len -= data_len;
 
 	for (i = 0; i < self->buffer_size; ++i)
 		self->buffer[i] = ntohll(self->buffer[i]);
 
+	if (len < sizeof(uint32_t))
+		return error("corrupt ewah bitmap: eof before rlw");
 	self->rlw = self->buffer + get_be32(ptr);
+	ptr += sizeof(uint32_t);
+	len -= sizeof(uint32_t);
 
-	return (3 * 4) + (self->buffer_size * 8);
+	return ptr - (const uint8_t *)map;
 }
 
 int ewah_deserialize(struct ewah_bitmap *self, int fd)
diff --git a/ewah/ewok.h b/ewah/ewok.h
index dc43d05b64..357fd93c84 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -91,7 +91,7 @@ int ewah_serialize_native(struct ewah_bitmap *self, int fd);
 int ewah_serialize_strbuf(struct ewah_bitmap *self, struct strbuf *);
 
 int ewah_deserialize(struct ewah_bitmap *self, int fd);
-int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);
+ssize_t ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len);
 
 uint32_t ewah_checksum(struct ewah_bitmap *self);
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 423c0a475f..237ee6e5fc 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -331,4 +331,17 @@ test_expect_success 'pack reuse respects --incremental' '
 	git show-index <empty.idx >actual &&
 	test_cmp expect actual
 '
+
+test_expect_success 'truncated bitmap fails gracefully' '
+	git repack -ad &&
+	git rev-list --use-bitmap-index --count --all >expect &&
+	bitmap=$(ls .git/objects/pack/*.bitmap) &&
+	test_when_finished "rm -f $bitmap" &&
+	head -c 512 <$bitmap >$bitmap.tmp &&
+	mv $bitmap.tmp $bitmap &&
+	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
+	test_cmp expect actual &&
+	test_i18ngrep corrupt stderr
+'
+
 test_done
-- 
2.18.0.rc2.534.g53d976aeb8

