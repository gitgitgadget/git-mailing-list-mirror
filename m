From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/19] pack bitmaps
Date: Thu, 24 Oct 2013 20:07:14 -0700
Message-ID: <xmqq38nqkpzx.fsf@gitster.dls.corp.google.com>
References: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 05:07:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZXkO-0000bz-0s
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 05:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab3JYDHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 23:07:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056Ab3JYDHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 23:07:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58A7345420;
	Fri, 25 Oct 2013 03:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jc70/s1TPfAPzXF4r4QNZDYSpwk=; b=Ttyv3s
	59u4hHHiFQtNivhSQY56O4p8Eh7pkRytHD92EH3FMozGHuhsxsKLmKYcc/QZIGkP
	SMBl8tqnWQ5p6JL9rUwce3aVpdOnvn4+F9MX+d+yFONcDxyeJ+GV4GO2lR83du4w
	JFYk33gIGfrc1fdbGdQksJ6BabC6/XCEdXSZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eUOXwHDUNP/JWKbBWMIe3dN3XBx3bZa8
	SOzzjjMV6KotROVMuD6IC+E9blQ/rIeMNUfHHC8CRmt8dnMHBt9emwIYYnJQSfNb
	AKR3QIs16JtbW3+p0Ir6JxZr+50Yl/PZXgZ5d1coAOrm+8kCILQ/wn7iqPP2qRL1
	4ZDetSYLC74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4980A4541D;
	Fri, 25 Oct 2013 03:07:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 649F74541B;
	Fri, 25 Oct 2013 03:07:16 +0000 (UTC)
In-Reply-To: <20131024175915.GA23398@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Oct 2013 13:59:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D8C2D92-3D22-11E3-9D80-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236644>

This is only to tentatively work-around the compilation breakages;
the fixes need to be split into the respective patches that
introduce breakages when the series is rerolled (the one I sent for
pack-bitmap.c separately is also included in this message).

Thanks.

 ewah/ewah_bitmap.c  | 22 ++++++++++++++++------
 ewah/ewah_io.c      | 44 ++++++++++++++++++++++++++------------------
 pack-bitmap-write.c |  2 --
 pack-bitmap.c       | 13 ++++++-------
 4 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index b74a1eb..7986720 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -65,6 +65,8 @@ static void buffer_push_rlw(struct ewah_bitmap *self, eword_t value)
 
 static size_t add_empty_words(struct ewah_bitmap *self, int v, size_t number)
 {
+	eword_t runlen;
+	eword_t can_add;
 	size_t added = 0;
 
 	if (rlw_get_run_bit(self->rlw) != v && rlw_size(self->rlw) == 0) {
@@ -76,8 +78,8 @@ static size_t add_empty_words(struct ewah_bitmap *self, int v, size_t number)
 		added++;
 	}
 
-	eword_t runlen = rlw_get_running_len(self->rlw);
-	eword_t can_add = min_size(number, RLW_LARGEST_RUNNING_COUNT - runlen);
+	runlen = rlw_get_running_len(self->rlw);
+	can_add = min_size(number, RLW_LARGEST_RUNNING_COUNT - runlen);
 
 	rlw_set_running_len(self->rlw, runlen + can_add);
 	number -= can_add;
@@ -426,6 +428,8 @@ void ewah_xor(
 	rlwit_init(&rlw_j, ewah_j);
 
 	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
+		size_t literals;
+
 		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
 			struct rlw_iterator *prey, *predator;
 			size_t index;
@@ -446,7 +450,7 @@ void ewah_xor(
 			rlwit_discard_first_words(predator, predator->rlw.running_len);
 		}
 
-		size_t literals = min_size(rlw_i.rlw.literal_words, rlw_j.rlw.literal_words);
+		literals = min_size(rlw_i.rlw.literal_words, rlw_j.rlw.literal_words);
 
 		if (literals) {
 			size_t k;
@@ -484,6 +488,8 @@ void ewah_and(
 	rlwit_init(&rlw_j, ewah_j);
 
 	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
+		size_t literals;
+
 		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
 			struct rlw_iterator *prey, *predator;
 
@@ -507,7 +513,7 @@ void ewah_and(
 			}
 		}
 
-		size_t literals = min_size(rlw_i.rlw.literal_words, rlw_j.rlw.literal_words);
+		literals = min_size(rlw_i.rlw.literal_words, rlw_j.rlw.literal_words);
 
 		if (literals) {
 			size_t k;
@@ -545,6 +551,8 @@ void ewah_and_not(
 	rlwit_init(&rlw_j, ewah_j);
 
 	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
+		size_t literals;
+
 		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
 			struct rlw_iterator *prey, *predator;
 
@@ -572,7 +580,7 @@ void ewah_and_not(
 			}
 		}
 
-		size_t literals = min_size(rlw_i.rlw.literal_words, rlw_j.rlw.literal_words);
+		literals = min_size(rlw_i.rlw.literal_words, rlw_j.rlw.literal_words);
 
 		if (literals) {
 			size_t k;
@@ -610,6 +618,8 @@ void ewah_or(
 	rlwit_init(&rlw_j, ewah_j);
 
 	while (rlwit_word_size(&rlw_i) > 0 && rlwit_word_size(&rlw_j) > 0) {
+		size_t literals;
+
 		while (rlw_i.rlw.running_len > 0 || rlw_j.rlw.running_len > 0) {
 			struct rlw_iterator *prey, *predator;
 
@@ -634,7 +644,7 @@ void ewah_or(
 			}
 		}
 
-		size_t literals = min_size(rlw_i.rlw.literal_words, rlw_j.rlw.literal_words);
+		literals = min_size(rlw_i.rlw.literal_words, rlw_j.rlw.literal_words);
 
 		if (literals) {
 			size_t k;
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index db6c062..05c51d9 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -58,19 +58,26 @@ int ewah_serialize_to(struct ewah_bitmap *self,
 	eword_t dump[2048];
 	const size_t words_per_dump = sizeof(dump) / sizeof(eword_t);
 
-	/* 32 bit -- bit size fr the map */
-	uint32_t bitsize =  htonl((uint32_t)self->bit_size);
+	/* 32 bit -- bit size for the map */
+	uint32_t bitsize;
+	/* 32 bit -- number of compressed 64-bit words */
+	uint32_t word_count;
+	/* 64 bit x N -- compressed words */
+	const eword_t *buffer = self->buffer;
+	size_t words_left;
+
+	/* 32 bit -- position for the RLW */
+	uint32_t rlw_pos;
+
+	bitsize =  htonl((uint32_t)self->bit_size);
 	if (write_fun(data, &bitsize, 4) != 4)
 		return -1;
 
-	/** 32 bit -- number of compressed 64-bit words */
-	uint32_t word_count =  htonl((uint32_t)self->buffer_size);
+	word_count =  htonl((uint32_t)self->buffer_size);
 	if (write_fun(data, &word_count, 4) != 4)
 		return -1;
 
-	/** 64 bit x N -- compressed words */
-	const eword_t *buffer = self->buffer;
-	size_t words_left = self->buffer_size;
+	words_left = self->buffer_size;
 
 	while (words_left >= words_per_dump) {
 		for (i = 0; i < words_per_dump; ++i, ++buffer)
@@ -90,8 +97,7 @@ int ewah_serialize_to(struct ewah_bitmap *self,
 			return -1;
 	}
 
-	/** 32 bit -- position for the RLW */
-	uint32_t rlw_pos = (uint8_t*)self->rlw - (uint8_t *)self->buffer;
+	rlw_pos = (uint8_t*)self->rlw - (uint8_t *)self->buffer;
 	rlw_pos = htonl(rlw_pos / sizeof(eword_t));
 
 	if (write_fun(data, &rlw_pos, 4) != 4)
@@ -138,18 +144,23 @@ int ewah_deserialize(struct ewah_bitmap *self, int fd)
 	size_t i;
 	eword_t dump[2048];
 	const size_t words_per_dump = sizeof(dump) / sizeof(eword_t);
+	/* 32 bit -- bit size for the map */
+	uint32_t bitsize;
+	/* 32 bit -- number of compressed 64-bit words */
+	uint32_t word_count;
+	/* 64 bit x N -- compressed words */
+	eword_t *buffer;
+	size_t words_left;
+	/** 32 bit -- position for the RLW */
+	uint32_t rlw_pos;
 
 	ewah_clear(self);
 
-	/* 32 bit -- bit size fr the map */
-	uint32_t bitsize;
 	if (read(fd, &bitsize, 4) != 4)
 		return -1;
 
 	self->bit_size = (size_t)ntohl(bitsize);
 
-	/** 32 bit -- number of compressed 64-bit words */
-	uint32_t word_count;
 	if (read(fd, &word_count, 4) != 4)
 		return -1;
 
@@ -159,9 +170,8 @@ int ewah_deserialize(struct ewah_bitmap *self, int fd)
 	if (!self->buffer)
 		return -1;
 
-	/** 64 bit x N -- compressed words */
-	eword_t *buffer = self->buffer;
-	size_t words_left = self->buffer_size;
+	buffer = self->buffer;
+	words_left = self->buffer_size;
 
 	while (words_left >= words_per_dump) {
 		if (read(fd, dump, sizeof(dump)) != sizeof(dump))
@@ -181,8 +191,6 @@ int ewah_deserialize(struct ewah_bitmap *self, int fd)
 			*buffer = ntohll(dump[i]);
 	}
 
-	/** 32 bit -- position for the RLW */
-	uint32_t rlw_pos;
 	if (read(fd, &rlw_pos, 4) != 4)
 		return -1;
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c44874a..48087f1 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,5 +1,3 @@
-#include <stdlib.h>
-
 #include "cache.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index a7c553d..3f1d369 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,5 +1,3 @@
-#include <stdlib.h>
-
 #include "cache.h"
 #include "commit.h"
 #include "tag.h"
@@ -123,8 +121,8 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 	struct ewah_bitmap *b = ewah_pool_new();
 
 	int bitmap_size = ewah_read_mmap(b,
-		index->map + index->map_pos,
-		index->map_size - index->map_pos);
+					 (unsigned char *)index->map + index->map_pos,
+					 index->map_size - index->map_pos);
 
 	if (bitmap_size < 0) {
 		error("Failed to load bitmap index (corrupted?)");
@@ -159,8 +157,9 @@ static int load_bitmap_header(struct bitmap_index *index)
 				"(Git requires BITMAP_OPT_FULL_DAG)");
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
-			index->hashes = index->map + index->map_size - 20 -
-				(sizeof(uint32_t) * index->pack->num_objects);
+			index->hashes = (uint32_t *)((unsigned char *)index->map +
+						     index->map_size - 20 -
+						     (sizeof(uint32_t) * index->pack->num_objects));
 		}
 	}
 
@@ -216,7 +215,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		uint32_t commit_idx_pos;
 		const unsigned char *sha1;
 
-		entry = index->map + index->map_pos;
+		entry = (struct bitmap_disk_entry *)((unsigned char *)index->map + index->map_pos);
 		index->map_pos += sizeof(struct bitmap_disk_entry);
 
 		commit_idx_pos = ntohl(entry->object_pos);
