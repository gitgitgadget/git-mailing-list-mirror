From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 16:50:03 -0500
Message-ID: <20140130215002.GB1130@sigill.intra.peff.net>
References: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
 <20140130204538.GA1130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 22:50:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8zVc-0004iv-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 22:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbaA3Vus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 16:50:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:41761 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753401AbaA3VuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 16:50:04 -0500
Received: (qmail 11167 invoked by uid 102); 30 Jan 2014 21:50:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Jan 2014 15:50:04 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jan 2014 16:50:03 -0500
Content-Disposition: inline
In-Reply-To: <20140130204538.GA1130@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241281>

On Thu, Jan 30, 2014 at 03:45:38PM -0500, Jeff King wrote:

> Either way, we should perhaps be more careful in the bitmap code, too,
> that the values we get are sensible. It's better to die("your bitmap is
> broken") than to read off the end of the array. I can't seem to trigger
> the same failure mode, though. On my x86 system, turning off the
> endian-swap (i.e., the opposite of what should happen) makes t5310 fail,
> but it is because we end up trying to set the bit very far into a
> dynamic bitfield, and die allocating memory.

I think we could do this with something like the patch below, which
checks two things:

  1. When we expand the ewah, it has the same number of bits we claimed
     in the on-disk header.

  2. The ewah header matches the number of objects in the packfile.

The first catches a corruption in the ewah data itself, and the latter
when the header is corrupted. You can test either by breaking the
endian-swapping. :)

Vicent, can you confirm my assumptions about the round-to-nearest-64 in
the patch below? I assume that the bit_size on-disk may be rounded in
some cases (and it is -- if you take out the rounding, this breaks
things). Is that sane? Or should the on-disk ewah bit_size header always
match the number of objects in the pack, and our writer is just being
sloppy?

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 9ced2da..a8f77cf 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -343,6 +343,18 @@ int ewah_iterator_next(eword_t *next, struct ewah_iterator *it)
 	if (it->pointer >= it->buffer_size)
 		return 0;
 
+	/*
+	 * If we return more bits than the ewah advertised, then either
+	 * our data bits or the bit_size field was corrupted, and we
+	 * risk a caller overwriting their own buffer (if they used
+	 * bit_size to size their buffer in the first place).
+	 *
+	 * We don't have a good way of returning an error here, so let's
+	 * just die.
+	 */
+	if (!it->words_remaining--)
+		die("ewah bitmap contains more bits than it claims");
+
 	if (it->compressed < it->rl) {
 		it->compressed++;
 		*next = it->b ? (eword_t)(~0) : 0;
@@ -371,6 +383,8 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
 	it->buffer_size = parent->buffer_size;
 	it->pointer = 0;
 
+	it->words_remaining = (parent->bit_size + 63) / 64;
+
 	it->lw = 0;
 	it->rl = 0;
 	it->compressed = 0;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 43adeb5..a3f49de 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -144,6 +144,7 @@ struct ewah_iterator {
 	size_t buffer_size;
 
 	size_t pointer;
+	size_t words_remaining;
 	eword_t compressed, literals;
 	eword_t rl, lw;
 	int b;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ae0b57b..a31e529 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -118,6 +118,7 @@ static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
  */
 static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 {
+	size_t expected_bits;
 	struct ewah_bitmap *b = ewah_pool_new();
 
 	int bitmap_size = ewah_read_mmap(b,
@@ -130,6 +131,31 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 		return NULL;
 	}
 
+	/*
+	 * It's OK for us to have too fewer bits than objects, as the EWAH
+	 * writer may have simply left off an ending that is all-zeroes.
+	 *
+	 * However it's not OK for us to have too many bits, as that would
+	 * entail touching objects that we don't have. We are careful
+	 * enough to avoid doing so in later code, but in the case of
+	 * nonsensical values, we would want to avoid even allocating
+	 * memory to hold the expanded bitmap.
+	 *
+	 * There is one exception: we may "go over" to round up to the next
+	 * 64-bit ewah word, since the storage comes in chunks of that size.
+	 */
+	expected_bits = index->pack->num_objects;
+	if (expected_bits & 63) {
+		expected_bits &= ~63;
+		expected_bits += 64;
+	}
+	if (b->bit_size > expected_bits) {
+		error("unexpected number of bits in bitmap: %"PRIuMAX" > %"PRIuMAX,
+		      (uintmax_t)b->bit_size, (uintmax_t)expected_bits);
+		ewah_pool_free(b);
+		return NULL;
+	}
+
 	index->map_pos += bitmap_size;
 	return b;
 }
