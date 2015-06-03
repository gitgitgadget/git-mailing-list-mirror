From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] ewah/bitmap: silence warning about MASK macro
 redefinition
Date: Wed, 3 Jun 2015 00:51:18 -0400
Message-ID: <20150603045117.GC15989@peff.net>
References: <1433281675-24893-1-git-send-email-sunshine@sunshineco.com>
 <xmqqegltzriq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 06:51:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z00eI-0007rE-MN
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 06:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbbFCEvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 00:51:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:40174 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750736AbbFCEvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 00:51:20 -0400
Received: (qmail 30251 invoked by uid 102); 3 Jun 2015 04:51:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 23:51:20 -0500
Received: (qmail 15952 invoked by uid 107); 3 Jun 2015 04:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 00:51:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 00:51:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegltzriq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270627>

On Tue, Jun 02, 2015 at 03:15:09PM -0700, Junio C Hamano wrote:

> > The alternative is to rename MASK in ewah/bitmap.c to something less
> > generic, resulting in a slightly more noisy patch. I chose the #undef
> > approach since it's a relatively common idiom to #undef a macro before
> > #defining it in order to avoid exactly this sort of redefinition
> > problem.
> 
> I agree that there is nothing controversial against this use of
> #undef; I however wonder if we are stomping on _their_ use of MASK
> and breaking whatever Mac OS X wants to express with that macro,
> though (in which case, hiding collision like this may not be
> sufficient and we have to live with the poor implementation choice
> made by the header file and change the macro _we_ use).

Yeah. It looks like we only use the macros a few times. I would not be
opposed to s/(BLOCK|MASK)/EWAH_&/. We also use BITS_IN_WORD, which is
rather generic, and is actually defined in a header file (so it affects
the rest of git). Probably BITS_IN_EWORD would be better.

The resulting patch is rather noisy, but I don't think there's any
ongoing work in that area (actually, I have a few things that need
cleaned up and submitted, but the conflicts are not a big deal).

-- >8 --
Subject: [PATCH] ewah: use less generic macro names

The ewah/ewok.h header pollutes the global namespace with
"BITS_IN_WORD", without any specific notion that we are
talking about the bits in an eword_t. We can give this the
more specific name "BITS_IN_EWORD".

Likewise, ewah/bitmap.c uses the generic MASK and BLOCK
macro names. These are local to the .c file, but we have the
opposite problem: on PowerPC Mac OS X (10.5.8 "Leopard" with
Xcode 3.1), system header /usr/include/ppc/param.h[1]
pollutes the preprocessor namespace with a macro generically
named MASK. We can give these macros more specific names, as
well, to avoid this conflict.

Reported-and-analyzed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I'm also happy to split it into two patches, and make Eric the author on
the MASK part.

 ewah/bitmap.c      | 24 ++++++++++++------------
 ewah/ewah_bitmap.c | 22 +++++++++++-----------
 ewah/ewok.h        |  2 +-
 pack-bitmap.c      | 10 +++++-----
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 710e58c..47ad674 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -20,8 +20,8 @@
 #include "git-compat-util.h"
 #include "ewok.h"
 
-#define MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
-#define BLOCK(x) (x / BITS_IN_WORD)
+#define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
+#define EWAH_BLOCK(x) (x / BITS_IN_EWORD)
 
 struct bitmap *bitmap_new(void)
 {
@@ -33,7 +33,7 @@ struct bitmap *bitmap_new(void)
 
 void bitmap_set(struct bitmap *self, size_t pos)
 {
-	size_t block = BLOCK(pos);
+	size_t block = EWAH_BLOCK(pos);
 
 	if (block >= self->word_alloc) {
 		size_t old_size = self->word_alloc;
@@ -45,22 +45,22 @@ void bitmap_set(struct bitmap *self, size_t pos)
 			(self->word_alloc - old_size) * sizeof(eword_t));
 	}
 
-	self->words[block] |= MASK(pos);
+	self->words[block] |= EWAH_MASK(pos);
 }
 
 void bitmap_clear(struct bitmap *self, size_t pos)
 {
-	size_t block = BLOCK(pos);
+	size_t block = EWAH_BLOCK(pos);
 
 	if (block < self->word_alloc)
-		self->words[block] &= ~MASK(pos);
+		self->words[block] &= ~EWAH_MASK(pos);
 }
 
 int bitmap_get(struct bitmap *self, size_t pos)
 {
-	size_t block = BLOCK(pos);
+	size_t block = EWAH_BLOCK(pos);
 	return block < self->word_alloc &&
-		(self->words[block] & MASK(pos)) != 0;
+		(self->words[block] & EWAH_MASK(pos)) != 0;
 }
 
 struct ewah_bitmap *bitmap_to_ewah(struct bitmap *bitmap)
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
