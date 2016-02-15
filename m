From: Jeff King <peff@peff.net>
Subject: [PATCH 17/18] convert ewah/bitmap code to use xmalloc
Date: Mon, 15 Feb 2016 16:57:10 -0500
Message-ID: <20160215215710.GQ10287@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:57:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR8v-0004f3-7h
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbcBOV5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:57:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:42521 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752608AbcBOV5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:57:12 -0500
Received: (qmail 2775 invoked by uid 102); 15 Feb 2016 21:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:57:12 -0500
Received: (qmail 12650 invoked by uid 107); 15 Feb 2016 21:57:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:57:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:57:10 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286273>

This code was originally written with the idea that it could
be spun off into its own ewah library, and uses the
overrideable ewah_malloc to do allocations.

We plug in xmalloc as our ewah_malloc, of course. But over
the years the ewah code itself has become more entangled
with git, and the return value of many ewah_malloc sites is
not checked.

Let's just drop the level of indirection and use xmalloc and
friends directly. This saves a few lines, and will let us
adapt these sites to our more advanced malloc helpers.

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/bitmap.c      | 12 ++++++------
 ewah/ewah_bitmap.c |  9 +++------
 ewah/ewah_io.c     | 10 ++--------
 ewah/ewok.h        | 10 ----------
 4 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 47ad674..c88daa0 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -25,8 +25,8 @@
 
 struct bitmap *bitmap_new(void)
 {
-	struct bitmap *bitmap = ewah_malloc(sizeof(struct bitmap));
-	bitmap->words = ewah_calloc(32, sizeof(eword_t));
+	struct bitmap *bitmap = xmalloc(sizeof(struct bitmap));
+	bitmap->words = xcalloc(32, sizeof(eword_t));
 	bitmap->word_alloc = 32;
 	return bitmap;
 }
@@ -38,8 +38,8 @@ void bitmap_set(struct bitmap *self, size_t pos)
 	if (block >= self->word_alloc) {
 		size_t old_size = self->word_alloc;
 		self->word_alloc = block * 2;
-		self->words = ewah_realloc(self->words,
-			self->word_alloc * sizeof(eword_t));
+		self->words = xrealloc(self->words,
+				      self->word_alloc * sizeof(eword_t));
 
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
@@ -102,7 +102,7 @@ struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah)
 	while (ewah_iterator_next(&blowup, &it)) {
 		if (i >= bitmap->word_alloc) {
 			bitmap->word_alloc *= 1.5;
-			bitmap->words = ewah_realloc(
+			bitmap->words = xrealloc(
 				bitmap->words, bitmap->word_alloc * sizeof(eword_t));
 		}
 
@@ -134,7 +134,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 
 	if (self->word_alloc < other_final) {
 		self->word_alloc = other_final;
-		self->words = ewah_realloc(self->words,
+		self->words = xrealloc(self->words,
 			self->word_alloc * sizeof(eword_t));
 		memset(self->words + original_size, 0x0,
 			(self->word_alloc - original_size) * sizeof(eword_t));
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index b522437..fcd465e 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -39,7 +39,7 @@ static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
 		return;
 
 	self->alloc_size = new_size;
-	self->buffer = ewah_realloc(self->buffer,
+	self->buffer = xrealloc(self->buffer,
 		self->alloc_size * sizeof(eword_t));
 	self->rlw = self->buffer + (rlw_offset / sizeof(eword_t));
 }
@@ -282,11 +282,8 @@ struct ewah_bitmap *ewah_new(void)
 {
 	struct ewah_bitmap *self;
 
-	self = ewah_malloc(sizeof(struct ewah_bitmap));
-	if (self == NULL)
-		return NULL;
-
-	self->buffer = ewah_malloc(32 * sizeof(eword_t));
+	self = xmalloc(sizeof(struct ewah_bitmap));
+	self->buffer = xmalloc(32 * sizeof(eword_t));
 	self->alloc_size = 32;
 
 	ewah_clear(self);
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 43481b9..4acff97 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -134,12 +134,9 @@ int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 	self->buffer_size = self->alloc_size = get_be32(ptr);
 	ptr += sizeof(uint32_t);
 
-	self->buffer = ewah_realloc(self->buffer,
+	self->buffer = xrealloc(self->buffer,
 		self->alloc_size * sizeof(eword_t));
 
-	if (!self->buffer)
-		return -1;
-
 	/*
 	 * Copy the raw data for the bitmap as a whole chunk;
 	 * if we're in a little-endian platform, we'll perform
@@ -180,12 +177,9 @@ int ewah_deserialize(struct ewah_bitmap *self, int fd)
 		return -1;
 
 	self->buffer_size = self->alloc_size = (size_t)ntohl(word_count);
-	self->buffer = ewah_realloc(self->buffer,
+	self->buffer = xrealloc(self->buffer,
 		self->alloc_size * sizeof(eword_t));
 
-	if (!self->buffer)
-		return -1;
-
 	/** 64 bit x N -- compressed words */
 	buffer = self->buffer;
 	words_left = self->buffer_size;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 6e2c5e1..269a1a8 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -20,16 +20,6 @@
 #ifndef __EWOK_BITMAP_H__
 #define __EWOK_BITMAP_H__
 
-#ifndef ewah_malloc
-#	define ewah_malloc xmalloc
-#endif
-#ifndef ewah_realloc
-#	define ewah_realloc xrealloc
-#endif
-#ifndef ewah_calloc
-#	define ewah_calloc xcalloc
-#endif
-
 struct strbuf;
 typedef uint64_t eword_t;
 #define BITS_IN_EWORD (sizeof(eword_t) * 8)
-- 
2.7.1.572.gf718037
