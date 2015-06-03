From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] ewah: use less generic macro name
Date: Wed, 3 Jun 2015 02:39:37 -0400
Message-ID: <20150603063937.GB29008@peff.net>
References: <20150603063812.GA21319@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:39:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02L2-000552-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbbFCGjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:39:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:40206 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753006AbbFCGjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:39:39 -0400
Received: (qmail 7327 invoked by uid 102); 3 Jun 2015 06:39:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 01:39:39 -0500
Received: (qmail 16721 invoked by uid 107); 3 Jun 2015 06:39:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 02:39:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 02:39:37 -0400
Content-Disposition: inline
In-Reply-To: <20150603063812.GA21319@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270634>

The ewah/ewok.h header pollutes the global namespace with
"BITS_IN_WORD", without any specific notion that we are
talking about the bits in an eword_t. We can give this the
more specific name "BITS_IN_EWORD".

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/bitmap.c      | 12 ++++++------
 ewah/ewah_bitmap.c | 22 +++++++++++-----------
 ewah/ewok.h        |  2 +-
 pack-bitmap.c      | 10 +++++-----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 2af94f6..47ad674 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -20,8 +20,8 @@
 #include "git-compat-util.h"
 #include "ewok.h"
 
-#define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
-#define EWAH_BLOCK(x) (x / BITS_IN_WORD)
+#define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
+#define EWAH_BLOCK(x) (x / BITS_IN_EWORD)
 
 struct bitmap *bitmap_new(void)
 {
@@ -127,7 +127,7 @@ void bitmap_and_not(struct bitmap *self, struct bitmap *other)
 void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 {
 	size_t original_size = self->word_alloc;
-	size_t other_final = (other->bit_size / BITS_IN_WORD) + 1;
+	size_t other_final = (other->bit_size / BITS_IN_EWORD) + 1;
 	size_t i = 0;
 	struct ewah_iterator it;
 	eword_t word;
@@ -155,17 +155,17 @@ void bitmap_each_bit(struct bitmap *self, ewah_callback callback, void *data)
 		uint32_t offset;
 
 		if (word == (eword_t)~0) {
-			for (offset = 0; offset < BITS_IN_WORD; ++offset)
+			for (offset = 0; offset < BITS_IN_EWORD; ++offset)
 				callback(pos++, data);
 		} else {
-			for (offset = 0; offset < BITS_IN_WORD; ++offset) {
+			for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 				if ((word >> offset) == 0)
 					break;
 
 				offset += ewah_bit_ctz64(word >> offset);
 				callback(pos + offset, data);
 			}
-			pos += BITS_IN_WORD;
+			pos += BITS_IN_EWORD;
 		}
 	}
 }
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index fccb42b..b522437 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -102,7 +102,7 @@ size_t ewah_add_empty_words(struct ewah_bitmap *self, int v, size_t number)
 	if (number == 0)
 		return 0;
 
-	self->bit_size += number * BITS_IN_WORD;
+	self->bit_size += number * BITS_IN_EWORD;
 	return add_empty_words(self, v, number);
 }
 
@@ -152,7 +152,7 @@ void ewah_add_dirty_words(
 			self->buffer_size += can_add;
 		}
 
-		self->bit_size += can_add * BITS_IN_WORD;
+		self->bit_size += can_add * BITS_IN_EWORD;
 
 		if (number - can_add == 0)
 			break;
@@ -197,7 +197,7 @@ static size_t add_empty_word(struct ewah_bitmap *self, int v)
 
 size_t ewah_add(struct ewah_bitmap *self, eword_t word)
 {
-	self->bit_size += BITS_IN_WORD;
+	self->bit_size += BITS_IN_EWORD;
 
 	if (word == 0)
 		return add_empty_word(self, 0);
@@ -211,8 +211,8 @@ size_t ewah_add(struct ewah_bitmap *self, eword_t word)
 void ewah_set(struct ewah_bitmap *self, size_t i)
 {
 	const size_t dist =
-		(i + BITS_IN_WORD) / BITS_IN_WORD -
-		(self->bit_size + BITS_IN_WORD - 1) / BITS_IN_WORD;
+		(i + BITS_IN_EWORD) / BITS_IN_EWORD -
+		(self->bit_size + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
 
 	assert(i >= self->bit_size);
 
@@ -222,19 +222,19 @@ void ewah_set(struct ewah_bitmap *self, size_t i)
 		if (dist > 1)
 			add_empty_words(self, 0, dist - 1);
 
-		add_literal(self, (eword_t)1 << (i % BITS_IN_WORD));
+		add_literal(self, (eword_t)1 << (i % BITS_IN_EWORD));
 		return;
 	}
 
 	if (rlw_get_literal_words(self->rlw) == 0) {
 		rlw_set_running_len(self->rlw,
 			rlw_get_running_len(self->rlw) - 1);
-		add_literal(self, (eword_t)1 << (i % BITS_IN_WORD));
+		add_literal(self, (eword_t)1 << (i % BITS_IN_EWORD));
 		return;
 	}
 
 	self->buffer[self->buffer_size - 1] |=
-		((eword_t)1 << (i % BITS_IN_WORD));
+		((eword_t)1 << (i % BITS_IN_EWORD));
 
 	/* check if we just completed a stream of 1s */
 	if (self->buffer[self->buffer_size - 1] == (eword_t)(~0)) {
@@ -255,11 +255,11 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
 		eword_t *word = &self->buffer[pointer];
 
 		if (rlw_get_run_bit(word)) {
-			size_t len = rlw_get_running_len(word) * BITS_IN_WORD;
+			size_t len = rlw_get_running_len(word) * BITS_IN_EWORD;
 			for (k = 0; k < len; ++k, ++pos)
 				callback(pos, payload);
 		} else {
-			pos += rlw_get_running_len(word) * BITS_IN_WORD;
+			pos += rlw_get_running_len(word) * BITS_IN_EWORD;
 		}
 
 		++pointer;
@@ -268,7 +268,7 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
 			int c;
 
 			/* todo: zero count optimization */
-			for (c = 0; c < BITS_IN_WORD; ++c, ++pos) {
+			for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
 				if ((self->buffer[pointer] & ((eword_t)1 << c)) != 0)
 					callback(pos, payload);
 			}
diff --git a/ewah/ewok.h b/ewah/ewok.h
index e732525..6e2c5e1 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -32,7 +32,7 @@
 
 struct strbuf;
 typedef uint64_t eword_t;
-#define BITS_IN_WORD (sizeof(eword_t) * 8)
+#define BITS_IN_EWORD (sizeof(eword_t) * 8)
 
 /**
  * Do not use __builtin_popcountll. The GCC implementation
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2b3ff23..637770a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -622,7 +622,7 @@ static void show_objects_for_type(
 	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
 		eword_t word = objects->words[i] & filter;
 
-		for (offset = 0; offset < BITS_IN_WORD; ++offset) {
+		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			const unsigned char *sha1;
 			struct revindex_entry *entry;
 			uint32_t hash = 0;
@@ -644,7 +644,7 @@ static void show_objects_for_type(
 			show_reach(sha1, object_type, 0, hash, bitmap_git.pack, entry->offset);
 		}
 
-		pos += BITS_IN_WORD;
+		pos += BITS_IN_EWORD;
 		i++;
 	}
 }
@@ -776,7 +776,7 @@ int reuse_partial_packfile_from_bitmap(struct packed_git **packfile,
 			break;
 		}
 
-		reuse_objects += BITS_IN_WORD;
+		reuse_objects += BITS_IN_EWORD;
 	}
 
 #ifdef GIT_BITMAP_DEBUG
@@ -1001,7 +1001,7 @@ static int rebuild_bitmap(uint32_t *reposition,
 	while (ewah_iterator_next(&word, &it)) {
 		uint32_t offset, bit_pos;
 
-		for (offset = 0; offset < BITS_IN_WORD; ++offset) {
+		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			if ((word >> offset) == 0)
 				break;
 
@@ -1014,7 +1014,7 @@ static int rebuild_bitmap(uint32_t *reposition,
 				return -1;
 		}
 
-		pos += BITS_IN_WORD;
+		pos += BITS_IN_EWORD;
 	}
 	return 0;
 }
-- 
2.4.2.745.g0aa058d
