From: Jeff King <peff@peff.net>
Subject: [PATCH 18/18] ewah: convert to REALLOC_ARRAY, etc
Date: Mon, 15 Feb 2016 16:57:18 -0500
Message-ID: <20160215215717.GR10287@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:57:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR92-0004n3-Bf
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbcBOV5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:57:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:42524 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752608AbcBOV5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:57:20 -0500
Received: (qmail 2781 invoked by uid 102); 15 Feb 2016 21:57:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:57:20 -0500
Received: (qmail 12666 invoked by uid 107); 15 Feb 2016 21:57:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:57:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:57:18 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286274>

Now that we're built around xmalloc and friends, we can use
helpers like REALLOC_ARRAY, ALLOC_GROW, and so on to make
the code shorter and protect against integer overflow.

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/bitmap.c      | 16 ++++------------
 ewah/ewah_bitmap.c |  5 ++---
 ewah/ewah_io.c     |  6 ++----
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index c88daa0..7103cee 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -17,7 +17,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
-#include "git-compat-util.h"
+#include "cache.h"
 #include "ewok.h"
 
 #define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
@@ -38,9 +38,7 @@ void bitmap_set(struct bitmap *self, size_t pos)
 	if (block >= self->word_alloc) {
 		size_t old_size = self->word_alloc;
 		self->word_alloc = block * 2;
-		self->words = xrealloc(self->words,
-				      self->word_alloc * sizeof(eword_t));
-
+		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
 	}
@@ -100,12 +98,7 @@ struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah)
 	ewah_iterator_init(&it, ewah);
 
 	while (ewah_iterator_next(&blowup, &it)) {
-		if (i >= bitmap->word_alloc) {
-			bitmap->word_alloc *= 1.5;
-			bitmap->words = xrealloc(
-				bitmap->words, bitmap->word_alloc * sizeof(eword_t));
-		}
-
+		ALLOC_GROW(bitmap->words, i + 1, bitmap->word_alloc);
 		bitmap->words[i++] = blowup;
 	}
 
@@ -134,8 +127,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 
 	if (self->word_alloc < other_final) {
 		self->word_alloc = other_final;
-		self->words = xrealloc(self->words,
-			self->word_alloc * sizeof(eword_t));
+		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + original_size, 0x0,
 			(self->word_alloc - original_size) * sizeof(eword_t));
 	}
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index fcd465e..2dc9c82 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -39,8 +39,7 @@ static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
 		return;
 
 	self->alloc_size = new_size;
-	self->buffer = xrealloc(self->buffer,
-		self->alloc_size * sizeof(eword_t));
+	REALLOC_ARRAY(self->buffer, self->alloc_size);
 	self->rlw = self->buffer + (rlw_offset / sizeof(eword_t));
 }
 
@@ -283,8 +282,8 @@ struct ewah_bitmap *ewah_new(void)
 	struct ewah_bitmap *self;
 
 	self = xmalloc(sizeof(struct ewah_bitmap));
-	self->buffer = xmalloc(32 * sizeof(eword_t));
 	self->alloc_size = 32;
+	ALLOC_ARRAY(self->buffer, self->alloc_size);
 
 	ewah_clear(self);
 	return self;
diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index 4acff97..61f6a43 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -134,8 +134,7 @@ int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t len)
 	self->buffer_size = self->alloc_size = get_be32(ptr);
 	ptr += sizeof(uint32_t);
 
-	self->buffer = xrealloc(self->buffer,
-		self->alloc_size * sizeof(eword_t));
+	REALLOC_ARRAY(self->buffer, self->alloc_size);
 
 	/*
 	 * Copy the raw data for the bitmap as a whole chunk;
@@ -177,8 +176,7 @@ int ewah_deserialize(struct ewah_bitmap *self, int fd)
 		return -1;
 
 	self->buffer_size = self->alloc_size = (size_t)ntohl(word_count);
-	self->buffer = xrealloc(self->buffer,
-		self->alloc_size * sizeof(eword_t));
+	REALLOC_ARRAY(self->buffer, self->alloc_size);
 
 	/** 64 bit x N -- compressed words */
 	buffer = self->buffer;
-- 
2.7.1.572.gf718037
