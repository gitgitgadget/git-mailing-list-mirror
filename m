From: Jeff King <peff@peff.net>
Subject: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Sat, 21 Dec 2013 08:59:54 -0500
Message-ID: <20131221135953.GH21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:00:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN61-00053L-DH
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141Ab3LUN75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:59:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:48480 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755102Ab3LUN7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:59:55 -0500
Received: (qmail 7368 invoked by uid 102); 21 Dec 2013 13:59:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:59:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:59:54 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239601>

From: Vicent Marti <tanoku@gmail.com>

EWAH is a word-aligned compressed variant of a bitset (i.e. a data
structure that acts as a 0-indexed boolean array for many entries).

It uses a 64-bit run-length encoding (RLE) compression scheme,
trading some compression for better processing speed.

The goal of this word-aligned implementation is not to achieve
the best compression, but rather to improve query processing time.
As it stands right now, this EWAH implementation will always be more
efficient storage-wise than its uncompressed alternative.

EWAH arrays will be used as the on-disk format to store reachability
bitmaps for all objects in a repository while keeping reasonable sizes,
in the same way that JGit does.

This EWAH implementation is a mostly straightforward port of the
original `javaewah` library that JGit currently uses. The library is
self-contained and has been embedded whole (4 files) inside the `ewah`
folder to ease redistribution.

The library is re-licensed under the GPLv2 with the permission of Daniel
Lemire, the original author. The source code for the C version can
be found on GitHub:

	https://github.com/vmg/libewok

The original Java implementation can also be found on GitHub:

	https://github.com/lemire/javaewah

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile           |  11 +-
 ewah/bitmap.c      | 221 ++++++++++++++++
 ewah/ewah_bitmap.c | 726 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 ewah/ewah_io.c     | 193 ++++++++++++++
 ewah/ewah_rlw.c    | 115 +++++++++
 ewah/ewok.h        | 235 +++++++++++++++++
 ewah/ewok_rlw.h    | 114 +++++++++
 7 files changed, 1613 insertions(+), 2 deletions(-)
 create mode 100644 ewah/bitmap.c
 create mode 100644 ewah/ewah_bitmap.c
 create mode 100644 ewah/ewah_io.c
 create mode 100644 ewah/ewah_rlw.c
 create mode 100644 ewah/ewok.h
 create mode 100644 ewah/ewok_rlw.h

diff --git a/Makefile b/Makefile
index 48ff0bd..64a1ed7 100644
--- a/Makefile
+++ b/Makefile
@@ -667,6 +667,8 @@ LIB_H += diff.h
 LIB_H += diffcore.h
 LIB_H += dir.h
 LIB_H += exec_cmd.h
+LIB_H += ewah/ewok.h
+LIB_H += ewah/ewok_rlw.h
 LIB_H += fetch-pack.h
 LIB_H += fmt-merge-msg.h
 LIB_H += fsck.h
@@ -800,6 +802,10 @@ LIB_OBJS += dir.o
 LIB_OBJS += editor.o
 LIB_OBJS += entry.o
 LIB_OBJS += environment.o
+LIB_OBJS += ewah/bitmap.o
+LIB_OBJS += ewah/ewah_bitmap.o
+LIB_OBJS += ewah/ewah_io.o
+LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
@@ -2474,8 +2480,9 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 clean: profile-clean coverage-clean
-	$(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
-		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
+	$(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o
+	$(RM) xdiff/*.o vcs-svn/*.o ewah/*.o builtin/*.o
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
 	$(RM) -r bin-wrappers $(dep_dirs)
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
new file mode 100644
index 0000000..710e58c
--- /dev/null
+++ b/ewah/bitmap.c
@@ -0,0 +1,221 @@
+/**
+ * Copyright 2013, GitHub, Inc
+ * Copyright 2009-2013, Daniel Lemire, Cliff Moon,
+ *	David McIntosh, Robert Becho, Google Inc. and Veronika Zenz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include "git-compat-util.h"
+#include "ewok.h"
+
+#define MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
+#define BLOCK(x) (x / BITS_IN_WORD)
+
+struct bitmap *bitmap_new(void)
+{
+	struct bitmap *bitmap = ewah_malloc(sizeof(struct bitmap));
+	bitmap->words = ewah_calloc(32, sizeof(eword_t));
+	bitmap->word_alloc = 32;
+	return bitmap;
+}
+
+void bitmap_set(struct bitmap *self, size_t pos)
+{
+	size_t block = BLOCK(pos);
+
+	if (block >= self->word_alloc) {
+		size_t old_size = self->word_alloc;
+		self->word_alloc = block * 2;
+		self->words = ewah_realloc(self->words,
+			self->word_alloc * sizeof(eword_t));
+
+		memset(self->words + old_size, 0x0,
+			(self->word_alloc - old_size) * sizeof(eword_t));
+	}
+
+	self->words[block] |= MASK(pos);
+}
+
+void bitmap_clear(struct bitmap *self, size_t pos)
+{
+	size_t block = BLOCK(pos);
+
+	if (block < self->word_alloc)
+		self->words[block] &= ~MASK(pos);
+}
+
+int bitmap_get(struct bitmap *self, size_t pos)
+{
+	size_t block = BLOCK(pos);
+	return block < self->word_alloc &&
+		(self->words[block] & MASK(pos)) != 0;
+}
+
+struct ewah_bitmap *bitmap_to_ewah(struct bitmap *bitmap)
+{
+	struct ewah_bitmap *ewah = ewah_new();
+	size_t i, running_empty_words = 0;
+	eword_t last_word = 0;
+
+	for (i = 0; i < bitmap->word_alloc; ++i) {
+		if (bitmap->words[i] == 0) {
+			running_empty_words++;
+			continue;
+		}
+
+		if (last_word != 0)
+			ewah_add(ewah, last_word);
+
+		if (running_empty_words > 0) {
+			ewah_add_empty_words(ewah, 0, running_empty_words);
+			running_empty_words = 0;
+		}
+
+		last_word = bitmap->words[i];
+	}
+
+	ewah_add(ewah, last_word);
+	return ewah;
+}
+
+struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah)
+{
+	struct bitmap *bitmap = bitmap_new();
+	struct ewah_iterator it;
+	eword_t blowup;
+	size_t i = 0;
+
+	ewah_iterator_init(&it, ewah);
+
+	while (ewah_iterator_next(&blowup, &it)) {
+		if (i >= bitmap->word_alloc) {
+			bitmap->word_alloc *= 1.5;
+			bitmap->words = ewah_realloc(
+				bitmap->words, bitmap->word_alloc * sizeof(eword_t));
+		}
+
+		bitmap->words[i++] = blowup;
+	}
+
+	bitmap->word_alloc = i;
+	return bitmap;
+}
+
+void bitmap_and_not(struct bitmap *self, struct bitmap *other)
+{
+	const size_t count = (self->word_alloc < other->word_alloc) ?
+		self->word_alloc : other->word_alloc;
+
+	size_t i;
+
+	for (i = 0; i < count; ++i)
+		self->words[i] &= ~other->words[i];
+}
+
+void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
+{
+	size_t original_size = self->word_alloc;
+	size_t other_final = (other->bit_size / BITS_IN_WORD) + 1;
+	size_t i = 0;
+	struct ewah_iterator it;
+	eword_t word;
+
+	if (self->word_alloc < other_final) {
+		self->word_alloc = other_final;
+		self->words = ewah_realloc(self->words,
+			self->word_alloc * sizeof(eword_t));
+		memset(self->words + original_size, 0x0,
+			(self->word_alloc - original_size) * sizeof(eword_t));
+	}
+
+	ewah_iterator_init(&it, other);
+
+	while (ewah_iterator_next(&word, &it))
+		self->words[i++] |= word;
+}
+
+void bitmap_each_bit(struct bitmap *self, ewah_callback callback, void *data)
+{
+	size_t pos = 0, i;
+
+	for (i = 0; i < self->word_alloc; ++i) {
+		eword_t word = self->words[i];
+		uint32_t offset;
+
+		if (word == (eword_t)~0) {
+			for (offset = 0; offset < BITS_IN_WORD; ++offset)
+				callback(pos++, data);
+		} else {
+			for (offset = 0; offset < BITS_IN_WORD; ++offset) {
+				if ((word >> offset) == 0)
+					break;
+
+				offset += ewah_bit_ctz64(word >> offset);
+				callback(pos + offset, data);
+			}
+			pos += BITS_IN_WORD;
+		}
+	}
+}
+
+size_t bitmap_popcount(struct bitmap *self)
+{
+	size_t i, count = 0;
+
+	for (i = 0; i < self->word_alloc; ++i)
+		count += ewah_bit_popcount64(self->words[i]);
+
+	return count;
+}
+
+int bitmap_equals(struct bitmap *self, struct bitmap *other)
+{
+	struct bitmap *big, *small;
+	size_t i;
+
+	if (self->word_alloc < other->word_alloc) {
+		small = self;
+		big = other;
+	} else {
+		small = other;
+		big = self;
+	}
+
+	for (i = 0; i < small->word_alloc; ++i) {
+		if (small->words[i] != big->words[i])
+			return 0;
+	}
+
+	for (; i < big->word_alloc; ++i) {
+		if (big->words[i] != 0)
+			return 0;
+	}
+
+	return 1;
+}
+
+void bitmap_reset(struct bitmap *bitmap)
+{
+	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
+}
+
+void bitmap_free(struct bitmap *bitmap)
+{
+	if (bitmap == NULL)
+		return;
+
+	free(bitmap->words);
+	free(bitmap);
+}
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
new file mode 100644
index 0000000..f104b87
--- /dev/null
+++ b/ewah/ewah_bitmap.c
@@ -0,0 +1,726 @@
+/**
+ * Copyright 2013, GitHub, Inc
+ * Copyright 2009-2013, Daniel Lemire, Cliff Moon,
+ *	David McIntosh, Robert Becho, Google Inc. and Veronika Zenz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include "git-compat-util.h"
+#include "ewok.h"
+#include "ewok_rlw.h"
+
+static inline size_t min_size(size_t a, size_t b)
+{
+	return a < b ? a : b;
+}
+
+static inline size_t max_size(size_t a, size_t b)
+{
+	return a > b ? a : b;
+}
+
+static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
+{
+	size_t rlw_offset = (uint8_t *)self->rlw - (uint8_t *)self->buffer;
+
+	if (self->alloc_size >= new_size)
+		return;
+
+	self->alloc_size = new_size;
+	self->buffer = ewah_realloc(self->buffer,
+		self->alloc_size * sizeof(eword_t));
+	self->rlw = self->buffer + (rlw_offset / sizeof(size_t));
+}
+
+static inline void buffer_push(struct ewah_bitmap *self, eword_t value)
+{
+	if (self->buffer_size + 1 >= self->alloc_size)
+		buffer_grow(self, self->buffer_size * 3 / 2);
+
+	self->buffer[self->buffer_size++] = value;
+}
+
+static void buffer_push_rlw(struct ewah_bitmap *self, eword_t value)
+{
+	buffer_push(self, value);
+	self->rlw = self->buffer + self->buffer_size - 1;
+}
+
+static size_t add_empty_words(struct ewah_bitmap *self, int v, size_t number)
+{
+	size_t added = 0;
+	eword_t runlen, can_add;
+
+	if (rlw_get_run_bit(self->rlw) != v && rlw_size(self->rlw) == 0) {
+		rlw_set_run_bit(self->rlw, v);
+	} else if (rlw_get_literal_words(self->rlw) != 0 ||
+			rlw_get_run_bit(self->rlw) != v) {
+		buffer_push_rlw(self, 0);
+		if (v) rlw_set_run_bit(self->rlw, v);
+		added++;
+	}
+
+	runlen = rlw_get_running_len(self->rlw);
+	can_add = min_size(number, RLW_LARGEST_RUNNING_COUNT - runlen);
+
+	rlw_set_running_len(self->rlw, runlen + can_add);
+	number -= can_add;
+
+	while (number >= RLW_LARGEST_RUNNING_COUNT) {
+		buffer_push_rlw(self, 0);
+		added++;
+		if (v) rlw_set_run_bit(self->rlw, v);
+		rlw_set_running_len(self->rlw, RLW_LARGEST_RUNNING_COUNT);
+		number -= RLW_LARGEST_RUNNING_COUNT;
+	}
+
+	if (number > 0) {
+		buffer_push_rlw(self, 0);
+		added++;
+
+		if (v) rlw_set_run_bit(self->rlw, v);
+		rlw_set_running_len(self->rlw, number);
+	}
+
+	return added;
+}
+
+size_t ewah_add_empty_words(struct ewah_bitmap *self, int v, size_t number)
+{
+	if (number == 0)
+		return 0;
+
+	self->bit_size += number * BITS_IN_WORD;
+	return add_empty_words(self, v, number);
+}
+
+static size_t add_literal(struct ewah_bitmap *self, eword_t new_data)
+{
+	eword_t current_num = rlw_get_literal_words(self->rlw);
+
+	if (current_num >= RLW_LARGEST_LITERAL_COUNT) {
+		buffer_push_rlw(self, 0);
+
+		rlw_set_literal_words(self->rlw, 1);
+		buffer_push(self, new_data);
+		return 2;
+	}
+
+	rlw_set_literal_words(self->rlw, current_num + 1);
+
+	/* sanity check */
+	assert(rlw_get_literal_words(self->rlw) == current_num + 1);
+
+	buffer_push(self, new_data);
+	return 1;
+}
+
+void ewah_add_dirty_words(
+	struct ewah_bitmap *self, const eword_t *buffer,
+	size_t number, int negate)
+{
+	size_t literals, can_add;
+
+	while (1) {
+		literals = rlw_get_literal_words(self->rlw);
+		can_add = min_size(number, RLW_LARGEST_LITERAL_COUNT - literals);
+
+		rlw_set_literal_words(self->rlw, literals + can_add);
+
+		if (self->buffer_size + can_add >= self->alloc_size)
+			buffer_grow(self, (self->buffer_size + can_add) * 3 / 2);
+
+		if (negate) {
+			size_t i;
+			for (i = 0; i < can_add; ++i)
+				self->buffer[self->buffer_size++] = ~buffer[i];
+		} else {
+			memcpy(self->buffer + self->buffer_size,
+				buffer, can_add * sizeof(eword_t));
+			self->buffer_size += can_add;
+		}
+
+		self->bit_size += can_add * BITS_IN_WORD;
+
+		if (number - can_add == 0)
+			break;
+
+		buffer_push_rlw(self, 0);
+		buffer += can_add;
+		number -= can_add;
+	}
+}
+
+static size_t add_empty_word(struct ewah_bitmap *self, int v)
+{
+	int no_literal = (rlw_get_literal_words(self->rlw) == 0);
+	eword_t run_len = rlw_get_running_len(self->rlw);
+
+	if (no_literal && run_len == 0) {
+		rlw_set_run_bit(self->rlw, v);
+		assert(rlw_get_run_bit(self->rlw) == v);
+	}
+
+	if (no_literal && rlw_get_run_bit(self->rlw) == v &&
+		run_len < RLW_LARGEST_RUNNING_COUNT) {
+		rlw_set_running_len(self->rlw, run_len + 1);
+		assert(rlw_get_running_len(self->rlw) == run_len + 1);
+		return 0;
+	} else {
+		buffer_push_rlw(self, 0);
+
+		assert(rlw_get_running_len(self->rlw) == 0);
+		assert(rlw_get_run_bit(self->rlw) == 0);
+		assert(rlw_get_literal_words(self->rlw) == 0);
+
+		rlw_set_run_bit(self->rlw, v);
+		assert(rlw_get_run_bit(self->rlw) == v);
+
+		rlw_set_running_len(self->rlw, 1);
+		assert(rlw_get_running_len(self->rlw) == 1);
+		assert(rlw_get_literal_words(self->rlw) == 0);
+		return 1;
+	}
+}
+
+size_t ewah_add(struct ewah_bitmap *self, eword_t word)
+{
+	self->bit_size += BITS_IN_WORD;
+
+	if (word == 0)
+		return add_empty_word(self, 0);
+
+	if (word == (eword_t)(~0))
+		return add_empty_word(self, 1);
+
+	return add_literal(self, word);
+}
+
+void ewah_set(struct ewah_bitmap *self, size_t i)
+{
+	const size_t dist =
+		(i + BITS_IN_WORD) / BITS_IN_WORD -
+		(self->bit_size + BITS_IN_WORD - 1) / BITS_IN_WORD;
+
+	assert(i >= self->bit_size);
+
+	self->bit_size = i + 1;
+
+	if (dist > 0) {
+		if (dist > 1)
+			add_empty_words(self, 0, dist - 1);
+
+		add_literal(self, (eword_t)1 << (i % BITS_IN_WORD));
+		return;
+	}
+
+	if (rlw_get_literal_words(self->rlw) == 0) {
+		rlw_set_running_len(self->rlw,
+			rlw_get_running_len(self->rlw) - 1);
+		add_literal(self, (eword_t)1 << (i % BITS_IN_WORD));
+		return;
+	}
+
+	self->buffer[self->buffer_size - 1] |=
+		((eword_t)1 << (i % BITS_IN_WORD));
+
+	/* check if we just completed a stream of 1s */
+	if (self->buffer[self->buffer_size - 1] == (eword_t)(~0)) {
+		self->buffer[--self->buffer_size] = 0;
+		rlw_set_literal_words(self->rlw,
+			rlw_get_literal_words(self->rlw) - 1);
+		add_empty_word(self, 1);
+	}
+}
+
+void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), void *payload)
+{
+	size_t pos = 0;
+	size_t pointer = 0;
+	size_t k;
+
+	while (pointer < self->buffer_size) {
+		eword_t *word = &self->buffer[pointer];
+
+		if (rlw_get_run_bit(word)) {
+			size_t len = rlw_get_running_len(word) * BITS_IN_WORD;
+			for (k = 0; k < len; ++k, ++pos)
+				callback(pos, payload);
+		} else {
+			pos += rlw_get_running_len(word) * BITS_IN_WORD;
+		}
+
+		++pointer;
+
+		for (k = 0; k < rlw_get_literal_words(word); ++k) {
+			int c;
+
+			/* todo: zero count optimization */
+			for (c = 0; c < BITS_IN_WORD; ++c, ++pos) {
+				if ((self->buffer[pointer] & ((eword_t)1 << c)) != 0)
+					callback(pos, payload);
+			}
+
+			++pointer;
+		}
+	}
+}
+
+struct ewah_bitmap *ewah_new(void)
+{
+	struct ewah_bitmap *self;
+
+	self = ewah_malloc(sizeof(struct ewah_bitmap));
+	if (self == NULL)
+		return NULL;
+
+	self->buffer = ewah_malloc(32 * sizeof(eword_t));
+	self->alloc_size = 32;
+
+	ewah_clear(self);
+	return self;
+}
+
+void ewah_clear(struct ewah_bitmap *self)
+{
+	self->buffer_size = 1;
+	self->buffer[0] = 0;
+	self->bit_size = 0;
+	self->rlw = self->buffer;
+}
+
+void ewah_free(struct ewah_bitmap *self)
+{
+	if (!self)
+		return;
+
+	if (self->alloc_size)
+		free(self->buffer);
+
+	free(self);
+}
+
+static void read_new_rlw(struct ewah_iterator *it)
+{
+	const eword_t *word = NULL;
+
+	it->literals = 0;
+	it->compressed = 0;
+
+	while (1) {
+		word = &it->buffer[it->pointer];
+
+		it->rl = rlw_get_running_len(word);
+		it->lw = rlw_get_literal_words(word);
+		it->b = rlw_get_run_bit(word);
+
+		if (it->rl || it->lw)
+			return;
+
+		if (it->pointer < it->buffer_size - 1) {
+			it->pointer++;
+		} else {
+			it->pointer = it->buffer_size;
+			return;
+		}
+	}
+}
+
+int ewah_iterator_next(eword_t *next, struct ewah_iterator *it)
+{
+	if (it->pointer >= it->buffer_size)
+		return 0;
+
+	if (it->compressed < it->rl) {
+		it->compressed++;
+		*next = it->b ? (eword_t)(~0) : 0;
+	} else {
+		assert(it->literals < it->lw);
+
+		it->literals++;
+		it->pointer++;
+
+		assert(it->pointer < it->buffer_size);
+
+		*next = it->buffer[it->pointer];
+	}
+
+	if (it->compressed == it->rl && it->literals == it->lw) {
+		if (++it->pointer < it->buffer_size)
+			read_new_rlw(it);
+	}
+
+	return 1;
+}
+
+void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
+{
+	it->buffer = parent->buffer;
+	it->buffer_size = parent->buffer_size;
+	it->pointer = 0;
+
+	it->lw = 0;
+	it->rl = 0;
+	it->compressed = 0;
+	it->literals = 0;
+	it->b = 0;
+
+	if (it->pointer < it->buffer_size)
+		read_new_rlw(it);
+}
+
+void ewah_dump(struct ewah_bitmap *self)
+{
+	size_t i;
+	fprintf(stderr, "%"PRIuMAX" bits | %"PRIuMAX" words | ",
+		(uintmax_t)self->bit_size, (uintmax_t)self->buffer_size);
+
+	for (i = 0; i < self->buffer_size; ++i)
+		fprintf(stderr, "%016"PRIx64" ", (uint64_t)self->buffer[i]);
+
+	fprintf(stderr, "\n");
+}
+
+void ewah_not(struct ewah_bitmap *self)
+{
+	size_t pointer = 0;
+
+	while (pointer < self->buffer_size) {
+		eword_t *word = &self->buffer[pointer];
+		size_t literals, k;
+
+		rlw_xor_run_bit(word);
+		++pointer;
+
+		literals = rlw_get_literal_words(word);
+		for (k = 0; k < literals; ++k) {
+			self->buffer[pointer] = ~self->buffer[pointer];
+			++pointer;
+		}
+	}
+}
+
+void ewah_xor(
+	struct ewah_bitmap *ewah_i,
+	struct ewah_bitmap *ewah_j,
+	struct ewah_bitmap *out)
+{
+	struct rlw_iterator rlw_i;
+	struct rlw_iterator rlw_j;
+	size_t literals;
+
+	rlwit_init(&rlw_i, ewah_i);
+	rlwit_init(&rlw_j, ewah_j);
+
+	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
+		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
+			struct rlw_iterator *prey, *predator;
+			size_t index;
+			int negate_words;
+
+			if (rlw_i.rlw.running_len < rlw_j.rlw.running_len) {
+				prey = &rlw_i;
+				predator = &rlw_j;
+			} else {
+				prey = &rlw_j;
+				predator = &rlw_i;
+			}
+
+			negate_words = !!predator->rlw.running_bit;
+			index = rlwit_discharge(prey, out,
+				predator->rlw.running_len, negate_words);
+
+			ewah_add_empty_words(out, negate_words,
+				predator->rlw.running_len - index);
+
+			rlwit_discard_first_words(predator,
+				predator->rlw.running_len);
+		}
+
+		literals = min_size(
+			rlw_i.rlw.literal_words,
+			rlw_j.rlw.literal_words);
+
+		if (literals) {
+			size_t k;
+
+			for (k = 0; k < literals; ++k) {
+				ewah_add(out,
+					rlw_i.buffer[rlw_i.literal_word_start + k] ^
+					rlw_j.buffer[rlw_j.literal_word_start + k]
+				);
+			}
+
+			rlwit_discard_first_words(&rlw_i, literals);
+			rlwit_discard_first_words(&rlw_j, literals);
+		}
+	}
+
+	if (rlwit_word_size(&rlw_i) > 0)
+		rlwit_discharge(&rlw_i, out, ~0, 0);
+	else
+		rlwit_discharge(&rlw_j, out, ~0, 0);
+
+	out->bit_size = max_size(ewah_i->bit_size, ewah_j->bit_size);
+}
+
+void ewah_and(
+	struct ewah_bitmap *ewah_i,
+	struct ewah_bitmap *ewah_j,
+	struct ewah_bitmap *out)
+{
+	struct rlw_iterator rlw_i;
+	struct rlw_iterator rlw_j;
+	size_t literals;
+
+	rlwit_init(&rlw_i, ewah_i);
+	rlwit_init(&rlw_j, ewah_j);
+
+	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
+		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
+			struct rlw_iterator *prey, *predator;
+
+			if (rlw_i.rlw.running_len < rlw_j.rlw.running_len) {
+				prey = &rlw_i;
+				predator = &rlw_j;
+			} else {
+				prey = &rlw_j;
+				predator = &rlw_i;
+			}
+
+			if (predator->rlw.running_bit == 0) {
+				ewah_add_empty_words(out, 0,
+					predator->rlw.running_len);
+				rlwit_discard_first_words(prey,
+					predator->rlw.running_len);
+				rlwit_discard_first_words(predator,
+					predator->rlw.running_len);
+			} else {
+				size_t index = rlwit_discharge(prey, out,
+					predator->rlw.running_len, 0);
+				ewah_add_empty_words(out, 0,
+					predator->rlw.running_len - index);
+				rlwit_discard_first_words(predator,
+					predator->rlw.running_len);
+			}
+		}
+
+		literals = min_size(
+			rlw_i.rlw.literal_words,
+			rlw_j.rlw.literal_words);
+
+		if (literals) {
+			size_t k;
+
+			for (k = 0; k < literals; ++k) {
+				ewah_add(out,
+					rlw_i.buffer[rlw_i.literal_word_start + k] &
+					rlw_j.buffer[rlw_j.literal_word_start + k]
+				);
+			}
+
+			rlwit_discard_first_words(&rlw_i, literals);
+			rlwit_discard_first_words(&rlw_j, literals);
+		}
+	}
+
+	if (rlwit_word_size(&rlw_i) > 0)
+		rlwit_discharge_empty(&rlw_i, out);
+	else
+		rlwit_discharge_empty(&rlw_j, out);
+
+	out->bit_size = max_size(ewah_i->bit_size, ewah_j->bit_size);
+}
+
+void ewah_and_not(
+	struct ewah_bitmap *ewah_i,
+	struct ewah_bitmap *ewah_j,
+	struct ewah_bitmap *out)
+{
+	struct rlw_iterator rlw_i;
+	struct rlw_iterator rlw_j;
+	size_t literals;
+
+	rlwit_init(&rlw_i, ewah_i);
+	rlwit_init(&rlw_j, ewah_j);
+
+	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
+		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
+			struct rlw_iterator *prey, *predator;
+
+			if (rlw_i.rlw.running_len < rlw_j.rlw.running_len) {
+				prey = &rlw_i;
+				predator = &rlw_j;
+			} else {
+				prey = &rlw_j;
+				predator = &rlw_i;
+			}
+
+			if ((predator->rlw.running_bit && prey == &rlw_i) ||
+				(!predator->rlw.running_bit && prey != &rlw_i)) {
+				ewah_add_empty_words(out, 0,
+					predator->rlw.running_len);
+				rlwit_discard_first_words(prey,
+					predator->rlw.running_len);
+				rlwit_discard_first_words(predator,
+					predator->rlw.running_len);
+			} else {
+				size_t index;
+				int negate_words;
+
+				negate_words = (&rlw_i != prey);
+				index = rlwit_discharge(prey, out,
+					predator->rlw.running_len, negate_words);
+				ewah_add_empty_words(out, negate_words,
+					predator->rlw.running_len - index);
+				rlwit_discard_first_words(predator,
+					predator->rlw.running_len);
+			}
+		}
+
+		literals = min_size(
+			rlw_i.rlw.literal_words,
+			rlw_j.rlw.literal_words);
+
+		if (literals) {
+			size_t k;
+
+			for (k = 0; k < literals; ++k) {
+				ewah_add(out,
+					rlw_i.buffer[rlw_i.literal_word_start + k] &
+					~(rlw_j.buffer[rlw_j.literal_word_start + k])
+				);
+			}
+
+			rlwit_discard_first_words(&rlw_i, literals);
+			rlwit_discard_first_words(&rlw_j, literals);
+		}
+	}
+
+	if (rlwit_word_size(&rlw_i) > 0)
+		rlwit_discharge(&rlw_i, out, ~0, 0);
+	else
+		rlwit_discharge_empty(&rlw_j, out);
+
+	out->bit_size = max_size(ewah_i->bit_size, ewah_j->bit_size);
+}
+
+void ewah_or(
+	struct ewah_bitmap *ewah_i,
+	struct ewah_bitmap *ewah_j,
+	struct ewah_bitmap *out)
+{
+	struct rlw_iterator rlw_i;
+	struct rlw_iterator rlw_j;
+	size_t literals;
+
+	rlwit_init(&rlw_i, ewah_i);
+	rlwit_init(&rlw_j, ewah_j);
+
+	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
+		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
+			struct rlw_iterator *prey, *predator;
+
+			if (rlw_i.rlw.running_len < rlw_j.rlw.running_len) {
+				prey = &rlw_i;
+				predator = &rlw_j;
+			} else {
+				prey = &rlw_j;
+				predator = &rlw_i;
+			}
+
+			if (predator->rlw.running_bit) {
+				ewah_add_empty_words(out, 0,
+					predator->rlw.running_len);
+				rlwit_discard_first_words(prey,
+					predator->rlw.running_len);
+				rlwit_discard_first_words(predator,
+					predator->rlw.running_len);
+			} else {
+				size_t index = rlwit_discharge(prey, out,
+					predator->rlw.running_len, 0);
+				ewah_add_empty_words(out, 0,
+					predator->rlw.running_len - index);
+				rlwit_discard_first_words(predator,
+					predator->rlw.running_len);
+			}
+		}
+
+		literals = min_size(
+			rlw_i.rlw.literal_words,
+			rlw_j.rlw.literal_words);
+
+		if (literals) {
+			size_t k;
+
+			for (k = 0; k < literals; ++k) {
+				ewah_add(out,
+					rlw_i.buffer[rlw_i.literal_word_start + k] |
+					rlw_j.buffer[rlw_j.literal_word_start + k]
+				);
+			}
+
+			rlwit_discard_first_words(&rlw_i, literals);
+			rlwit_discard_first_words(&rlw_j, literals);
+		}
+	}
+
+	if (rlwit_word_size(&rlw_i) > 0)
+		rlwit_discharge(&rlw_i, out, ~0, 0);
+	else
+		rlwit_discharge(&rlw_j, out, ~0, 0);
+
+	out->bit_size = max_size(ewah_i->bit_size, ewah_j->bit_size);
+}
+
+
+#define BITMAP_POOL_MAX 16
+static struct ewah_bitmap *bitmap_pool[BITMAP_POOL_MAX];
+static size_t bitmap_pool_size;
+
+struct ewah_bitmap *ewah_pool_new(void)
+{
+	if (bitmap_pool_size)
+		return bitmap_pool[--bitmap_pool_size];
+
+	return ewah_new();
+}
+
+void ewah_pool_free(struct ewah_bitmap *self)
+{
+	if (self == NULL)
+		return;
+
+	if (bitmap_pool_size == BITMAP_POOL_MAX ||
+		self->alloc_size == 0) {
+		ewah_free(self);
+		return;
+	}
+
+	ewah_clear(self);
+	bitmap_pool[bitmap_pool_size++] = self;
+}
+
+uint32_t ewah_checksum(struct ewah_bitmap *self)
+{
+	const uint8_t *p = (uint8_t *)self->buffer;
+	uint32_t crc = (uint32_t)self->bit_size;
+	size_t size = self->buffer_size * sizeof(eword_t);
+
+	while (size--)
+		crc = (crc << 5) - crc + (uint32_t)*p++;
+
+	return crc;
+}
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
new file mode 100644
index 0000000..aed0da6
--- /dev/null
+++ b/ewah/ewah_io.c
@@ -0,0 +1,193 @@
+/**
+ * Copyright 2013, GitHub, Inc
+ * Copyright 2009-2013, Daniel Lemire, Cliff Moon,
+ *	David McIntosh, Robert Becho, Google Inc. and Veronika Zenz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include "git-compat-util.h"
+#include "ewok.h"
+
+int ewah_serialize_native(struct ewah_bitmap *self, int fd)
+{
+	uint32_t write32;
+	size_t to_write = self->buffer_size * 8;
+
+	/* 32 bit -- bit size for the map */
+	write32 = (uint32_t)self->bit_size;
+	if (write(fd, &write32, 4) != 4)
+		return -1;
+
+	/** 32 bit -- number of compressed 64-bit words */
+	write32 = (uint32_t)self->buffer_size;
+	if (write(fd, &write32, 4) != 4)
+		return -1;
+
+	if (write(fd, self->buffer, to_write) != to_write)
+		return -1;
+
+	/** 32 bit -- position for the RLW */
+	write32 = self->rlw - self->buffer;
+	if (write(fd, &write32, 4) != 4)
+		return -1;
+
+	return (3 * 4) + to_write;
+}
+
+int ewah_serialize_to(struct ewah_bitmap *self,
+		      int (*write_fun)(void *, const void *, size_t),
+		      void *data)
+{
+	size_t i;
+	eword_t dump[2048];
+	const size_t words_per_dump = sizeof(dump) / sizeof(eword_t);
+	uint32_t bitsize, word_count, rlw_pos;
+
+	const eword_t *buffer;
+	size_t words_left;
+
+	/* 32 bit -- bit size for the map */
+	bitsize =  htonl((uint32_t)self->bit_size);
+	if (write_fun(data, &bitsize, 4) != 4)
+		return -1;
+
+	/** 32 bit -- number of compressed 64-bit words */
+	word_count =  htonl((uint32_t)self->buffer_size);
+	if (write_fun(data, &word_count, 4) != 4)
+		return -1;
+
+	/** 64 bit x N -- compressed words */
+	buffer = self->buffer;
+	words_left = self->buffer_size;
+
+	while (words_left >= words_per_dump) {
+		for (i = 0; i < words_per_dump; ++i, ++buffer)
+			dump[i] = htonll(*buffer);
+
+		if (write_fun(data, dump, sizeof(dump)) != sizeof(dump))
+			return -1;
+
+		words_left -= words_per_dump;
+	}
+
+	if (words_left) {
+		for (i = 0; i < words_left; ++i, ++buffer)
+			dump[i] = htonll(*buffer);
+
+		if (write_fun(data, dump, words_left * 8) != words_left * 8)
+			return -1;
+	}
+
+	/** 32 bit -- position for the RLW */
+	rlw_pos = (uint8_t*)self->rlw - (uint8_t *)self->buffer;
+	rlw_pos = htonl(rlw_pos / sizeof(eword_t));
+
+	if (write_fun(data, &rlw_pos, 4) != 4)
+		return -1;
+
+	return (3 * 4) + (self->buffer_size * 8);
+}
+
+static int write_helper(void *fd, const void *buf, size_t len)
+{
+	return write((intptr_t)fd, buf, len);
+}
+
+int ewah_serialize(struct ewah_bitmap *self, int fd)
+{
+	return ewah_serialize_to(self, write_helper, (void *)(intptr_t)fd);
+}
+
+int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
+{
+	uint32_t *read32 = map;
+	eword_t *read64;
+	size_t i;
+
+	self->bit_size = ntohl(*read32++);
+	self->buffer_size = self->alloc_size = ntohl(*read32++);
+	self->buffer = ewah_realloc(self->buffer,
+		self->alloc_size * sizeof(eword_t));
+
+	if (!self->buffer)
+		return -1;
+
+	for (i = 0, read64 = (void *)read32; i < self->buffer_size; ++i)
+		self->buffer[i] = ntohll(*read64++);
+
+	read32 = (void *)read64;
+	self->rlw = self->buffer + ntohl(*read32++);
+
+	return (3 * 4) + (self->buffer_size * 8);
+}
+
+int ewah_deserialize(struct ewah_bitmap *self, int fd)
+{
+	size_t i;
+	eword_t dump[2048];
+	const size_t words_per_dump = sizeof(dump) / sizeof(eword_t);
+	uint32_t bitsize, word_count, rlw_pos;
+
+	eword_t *buffer = NULL;
+	size_t words_left;
+
+	ewah_clear(self);
+
+	/* 32 bit -- bit size for the map */
+	if (read(fd, &bitsize, 4) != 4)
+		return -1;
+
+	self->bit_size = (size_t)ntohl(bitsize);
+
+	/** 32 bit -- number of compressed 64-bit words */
+	if (read(fd, &word_count, 4) != 4)
+		return -1;
+
+	self->buffer_size = self->alloc_size = (size_t)ntohl(word_count);
+	self->buffer = ewah_realloc(self->buffer,
+		self->alloc_size * sizeof(eword_t));
+
+	if (!self->buffer)
+		return -1;
+
+	/** 64 bit x N -- compressed words */
+	buffer = self->buffer;
+	words_left = self->buffer_size;
+
+	while (words_left >= words_per_dump) {
+		if (read(fd, dump, sizeof(dump)) != sizeof(dump))
+			return -1;
+
+		for (i = 0; i < words_per_dump; ++i, ++buffer)
+			*buffer = ntohll(dump[i]);
+
+		words_left -= words_per_dump;
+	}
+
+	if (words_left) {
+		if (read(fd, dump, words_left * 8) != words_left * 8)
+			return -1;
+
+		for (i = 0; i < words_left; ++i, ++buffer)
+			*buffer = ntohll(dump[i]);
+	}
+
+	/** 32 bit -- position for the RLW */
+	if (read(fd, &rlw_pos, 4) != 4)
+		return -1;
+
+	self->rlw = self->buffer + ntohl(rlw_pos);
+	return 0;
+}
diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
new file mode 100644
index 0000000..c723f1a
--- /dev/null
+++ b/ewah/ewah_rlw.c
@@ -0,0 +1,115 @@
+/**
+ * Copyright 2013, GitHub, Inc
+ * Copyright 2009-2013, Daniel Lemire, Cliff Moon,
+ *	David McIntosh, Robert Becho, Google Inc. and Veronika Zenz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include "git-compat-util.h"
+#include "ewok.h"
+#include "ewok_rlw.h"
+
+static inline int next_word(struct rlw_iterator *it)
+{
+	if (it->pointer >= it->size)
+		return 0;
+
+	it->rlw.word = &it->buffer[it->pointer];
+	it->pointer += rlw_get_literal_words(it->rlw.word) + 1;
+
+	it->rlw.literal_words = rlw_get_literal_words(it->rlw.word);
+	it->rlw.running_len = rlw_get_running_len(it->rlw.word);
+	it->rlw.running_bit = rlw_get_run_bit(it->rlw.word);
+	it->rlw.literal_word_offset = 0;
+
+	return 1;
+}
+
+void rlwit_init(struct rlw_iterator *it, struct ewah_bitmap *from_ewah)
+{
+	it->buffer = from_ewah->buffer;
+	it->size = from_ewah->buffer_size;
+	it->pointer = 0;
+
+	next_word(it);
+
+	it->literal_word_start = rlwit_literal_words(it) +
+		it->rlw.literal_word_offset;
+}
+
+void rlwit_discard_first_words(struct rlw_iterator *it, size_t x)
+{
+	while (x > 0) {
+		size_t discard;
+
+		if (it->rlw.running_len > x) {
+			it->rlw.running_len -= x;
+			return;
+		}
+
+		x -= it->rlw.running_len;
+		it->rlw.running_len = 0;
+
+		discard = (x > it->rlw.literal_words) ? it->rlw.literal_words : x;
+
+		it->literal_word_start += discard;
+		it->rlw.literal_words -= discard;
+		x -= discard;
+
+		if (x > 0 || rlwit_word_size(it) == 0) {
+			if (!next_word(it))
+				break;
+
+			it->literal_word_start =
+				rlwit_literal_words(it) + it->rlw.literal_word_offset;
+		}
+	}
+}
+
+size_t rlwit_discharge(
+	struct rlw_iterator *it, struct ewah_bitmap *out, size_t max, int negate)
+{
+	size_t index = 0;
+
+	while (index < max && rlwit_word_size(it) > 0) {
+		size_t pd, pl = it->rlw.running_len;
+
+		if (index + pl > max)
+			pl = max - index;
+
+		ewah_add_empty_words(out, it->rlw.running_bit ^ negate, pl);
+		index += pl;
+
+		pd = it->rlw.literal_words;
+		if (pd + index > max)
+			pd = max - index;
+
+		ewah_add_dirty_words(out,
+			it->buffer + it->literal_word_start, pd, negate);
+
+		rlwit_discard_first_words(it, pd + pl);
+		index += pd;
+	}
+
+	return index;
+}
+
+void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out)
+{
+	while (rlwit_word_size(it) > 0) {
+		ewah_add_empty_words(out, 0, rlwit_word_size(it));
+		rlwit_discard_first_words(it, rlwit_word_size(it));
+	}
+}
diff --git a/ewah/ewok.h b/ewah/ewok.h
new file mode 100644
index 0000000..619afaa
--- /dev/null
+++ b/ewah/ewok.h
@@ -0,0 +1,235 @@
+/**
+ * Copyright 2013, GitHub, Inc
+ * Copyright 2009-2013, Daniel Lemire, Cliff Moon,
+ *	David McIntosh, Robert Becho, Google Inc. and Veronika Zenz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#ifndef __EWOK_BITMAP_H__
+#define __EWOK_BITMAP_H__
+
+#ifndef ewah_malloc
+#	define ewah_malloc xmalloc
+#endif
+#ifndef ewah_realloc
+#	define ewah_realloc xrealloc
+#endif
+#ifndef ewah_calloc
+#	define ewah_calloc xcalloc
+#endif
+
+typedef uint64_t eword_t;
+#define BITS_IN_WORD (sizeof(eword_t) * 8)
+
+/**
+ * Do not use __builtin_popcountll. The GCC implementation
+ * is notoriously slow on all platforms.
+ *
+ * See: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=36041
+ */
+static inline uint32_t ewah_bit_popcount64(uint64_t x)
+{
+	x = (x & 0x5555555555555555ULL) + ((x >>  1) & 0x5555555555555555ULL);
+	x = (x & 0x3333333333333333ULL) + ((x >>  2) & 0x3333333333333333ULL);
+	x = (x & 0x0F0F0F0F0F0F0F0FULL) + ((x >>  4) & 0x0F0F0F0F0F0F0F0FULL);
+	return (x * 0x0101010101010101ULL) >> 56;
+}
+
+#ifdef __GNUC__
+#define ewah_bit_ctz64(x) __builtin_ctzll(x)
+#else
+static inline int ewah_bit_ctz64(uint64_t x)
+{
+	int n = 0;
+	if ((x & 0xffffffff) == 0) { x >>= 32; n += 32; }
+	if ((x &     0xffff) == 0) { x >>= 16; n += 16; }
+	if ((x &       0xff) == 0) { x >>=  8; n +=  8; }
+	if ((x &        0xf) == 0) { x >>=  4; n +=  4; }
+	if ((x &        0x3) == 0) { x >>=  2; n +=  2; }
+	if ((x &        0x1) == 0) { x >>=  1; n +=  1; }
+	return n + !x;
+}
+#endif
+
+struct ewah_bitmap {
+	eword_t *buffer;
+	size_t buffer_size;
+	size_t alloc_size;
+	size_t bit_size;
+	eword_t *rlw;
+};
+
+typedef void (*ewah_callback)(size_t pos, void *);
+
+struct ewah_bitmap *ewah_pool_new(void);
+void ewah_pool_free(struct ewah_bitmap *self);
+
+/**
+ * Allocate a new EWAH Compressed bitmap
+ */
+struct ewah_bitmap *ewah_new(void);
+
+/**
+ * Clear all the bits in the bitmap. Does not free or resize
+ * memory.
+ */
+void ewah_clear(struct ewah_bitmap *self);
+
+/**
+ * Free all the memory of the bitmap
+ */
+void ewah_free(struct ewah_bitmap *self);
+
+int ewah_serialize_to(struct ewah_bitmap *self,
+		      int (*write_fun)(void *out, const void *buf, size_t len),
+		      void *out);
+int ewah_serialize(struct ewah_bitmap *self, int fd);
+int ewah_serialize_native(struct ewah_bitmap *self, int fd);
+
+int ewah_deserialize(struct ewah_bitmap *self, int fd);
+int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len);
+int ewah_read_mmap_native(struct ewah_bitmap *self, void *map, size_t len);
+
+uint32_t ewah_checksum(struct ewah_bitmap *self);
+
+/**
+ * Logical not (bitwise negation) in-place on the bitmap
+ *
+ * This operation is linear time based on the size of the bitmap.
+ */
+void ewah_not(struct ewah_bitmap *self);
+
+/**
+ * Call the given callback with the position of every single bit
+ * that has been set on the bitmap.
+ *
+ * This is an efficient operation that does not fully decompress
+ * the bitmap.
+ */
+void ewah_each_bit(struct ewah_bitmap *self, ewah_callback callback, void *payload);
+
+/**
+ * Set a given bit on the bitmap.
+ *
+ * The bit at position `pos` will be set to true. Because of the
+ * way that the bitmap is compressed, a set bit cannot be unset
+ * later on.
+ *
+ * Furthermore, since the bitmap uses streaming compression, bits
+ * can only set incrementally.
+ *
+ * E.g.
+ *		ewah_set(bitmap, 1); // ok
+ *		ewah_set(bitmap, 76); // ok
+ *		ewah_set(bitmap, 77); // ok
+ *		ewah_set(bitmap, 8712800127); // ok
+ *		ewah_set(bitmap, 25); // failed, assert raised
+ */
+void ewah_set(struct ewah_bitmap *self, size_t i);
+
+struct ewah_iterator {
+	const eword_t *buffer;
+	size_t buffer_size;
+
+	size_t pointer;
+	eword_t compressed, literals;
+	eword_t rl, lw;
+	int b;
+};
+
+/**
+ * Initialize a new iterator to run through the bitmap in uncompressed form.
+ *
+ * The iterator can be stack allocated. The underlying bitmap must not be freed
+ * before the iteration is over.
+ *
+ * E.g.
+ *
+ *		struct ewah_bitmap *bitmap = ewah_new();
+ *		struct ewah_iterator it;
+ *
+ *		ewah_iterator_init(&it, bitmap);
+ */
+void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent);
+
+/**
+ * Yield every single word in the bitmap in uncompressed form. This is:
+ * yield single words (32-64 bits) where each bit represents an actual
+ * bit from the bitmap.
+ *
+ * Return: true if a word was yield, false if there are no words left
+ */
+int ewah_iterator_next(eword_t *next, struct ewah_iterator *it);
+
+void ewah_or(
+	struct ewah_bitmap *ewah_i,
+	struct ewah_bitmap *ewah_j,
+	struct ewah_bitmap *out);
+
+void ewah_and_not(
+	struct ewah_bitmap *ewah_i,
+	struct ewah_bitmap *ewah_j,
+	struct ewah_bitmap *out);
+
+void ewah_xor(
+	struct ewah_bitmap *ewah_i,
+	struct ewah_bitmap *ewah_j,
+	struct ewah_bitmap *out);
+
+void ewah_and(
+	struct ewah_bitmap *ewah_i,
+	struct ewah_bitmap *ewah_j,
+	struct ewah_bitmap *out);
+
+void ewah_dump(struct ewah_bitmap *self);
+
+/**
+ * Direct word access
+ */
+size_t ewah_add_empty_words(struct ewah_bitmap *self, int v, size_t number);
+void ewah_add_dirty_words(
+	struct ewah_bitmap *self, const eword_t *buffer, size_t number, int negate);
+size_t ewah_add(struct ewah_bitmap *self, eword_t word);
+
+
+/**
+ * Uncompressed, old-school bitmap that can be efficiently compressed
+ * into an `ewah_bitmap`.
+ */
+struct bitmap {
+	eword_t *words;
+	size_t word_alloc;
+};
+
+struct bitmap *bitmap_new(void);
+void bitmap_set(struct bitmap *self, size_t pos);
+void bitmap_clear(struct bitmap *self, size_t pos);
+int bitmap_get(struct bitmap *self, size_t pos);
+void bitmap_reset(struct bitmap *self);
+void bitmap_free(struct bitmap *self);
+int bitmap_equals(struct bitmap *self, struct bitmap *other);
+int bitmap_is_subset(struct bitmap *self, struct bitmap *super);
+
+struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
+struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
+
+void bitmap_and_not(struct bitmap *self, struct bitmap *other);
+void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
+void bitmap_or(struct bitmap *self, const struct bitmap *other);
+
+void bitmap_each_bit(struct bitmap *self, ewah_callback callback, void *data);
+size_t bitmap_popcount(struct bitmap *self);
+
+#endif
diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
new file mode 100644
index 0000000..63efdf9
--- /dev/null
+++ b/ewah/ewok_rlw.h
@@ -0,0 +1,114 @@
+/**
+ * Copyright 2013, GitHub, Inc
+ * Copyright 2009-2013, Daniel Lemire, Cliff Moon,
+ *	David McIntosh, Robert Becho, Google Inc. and Veronika Zenz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#ifndef __EWOK_RLW_H__
+#define __EWOK_RLW_H__
+
+#define RLW_RUNNING_BITS (sizeof(eword_t) * 4)
+#define RLW_LITERAL_BITS (sizeof(eword_t) * 8 - 1 - RLW_RUNNING_BITS)
+
+#define RLW_LARGEST_RUNNING_COUNT (((eword_t)1 << RLW_RUNNING_BITS) - 1)
+#define RLW_LARGEST_LITERAL_COUNT (((eword_t)1 << RLW_LITERAL_BITS) - 1)
+
+#define RLW_LARGEST_RUNNING_COUNT_SHIFT (RLW_LARGEST_RUNNING_COUNT << 1)
+
+#define RLW_RUNNING_LEN_PLUS_BIT (((eword_t)1 << (RLW_RUNNING_BITS + 1)) - 1)
+
+static int rlw_get_run_bit(const eword_t *word)
+{
+	return *word & (eword_t)1;
+}
+
+static inline void rlw_set_run_bit(eword_t *word, int b)
+{
+	if (b) {
+		*word |= (eword_t)1;
+	} else {
+		*word &= (eword_t)(~1);
+	}
+}
+
+static inline void rlw_xor_run_bit(eword_t *word)
+{
+	if (*word & 1) {
+		*word &= (eword_t)(~1);
+	} else {
+		*word |= (eword_t)1;
+	}
+}
+
+static inline void rlw_set_running_len(eword_t *word, eword_t l)
+{
+	*word |= RLW_LARGEST_RUNNING_COUNT_SHIFT;
+	*word &= (l << 1) | (~RLW_LARGEST_RUNNING_COUNT_SHIFT);
+}
+
+static inline eword_t rlw_get_running_len(const eword_t *word)
+{
+	return (*word >> 1) & RLW_LARGEST_RUNNING_COUNT;
+}
+
+static inline eword_t rlw_get_literal_words(const eword_t *word)
+{
+	return *word >> (1 + RLW_RUNNING_BITS);
+}
+
+static inline void rlw_set_literal_words(eword_t *word, eword_t l)
+{
+	*word |= ~RLW_RUNNING_LEN_PLUS_BIT;
+	*word &= (l << (RLW_RUNNING_BITS + 1)) | RLW_RUNNING_LEN_PLUS_BIT;
+}
+
+static inline eword_t rlw_size(const eword_t *self)
+{
+	return rlw_get_running_len(self) + rlw_get_literal_words(self);
+}
+
+struct rlw_iterator {
+	const eword_t *buffer;
+	size_t size;
+	size_t pointer;
+	size_t literal_word_start;
+
+	struct {
+		const eword_t *word;
+		int literal_words;
+		int running_len;
+		int literal_word_offset;
+		int running_bit;
+	} rlw;
+};
+
+void rlwit_init(struct rlw_iterator *it, struct ewah_bitmap *bitmap);
+void rlwit_discard_first_words(struct rlw_iterator *it, size_t x);
+size_t rlwit_discharge(
+	struct rlw_iterator *it, struct ewah_bitmap *out, size_t max, int negate);
+void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out);
+
+static inline size_t rlwit_word_size(struct rlw_iterator *it)
+{
+	return it->rlw.running_len + it->rlw.literal_words;
+}
+
+static inline size_t rlwit_literal_words(struct rlw_iterator *it)
+{
+	return it->pointer - it->rlw.literal_words;
+}
+
+#endif
-- 
1.8.5.1.399.g900e7cd
