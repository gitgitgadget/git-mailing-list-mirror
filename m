From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] ewah: support platforms that require aligned reads
Date: Thu, 23 Jan 2014 13:35:43 -0500
Message-ID: <20140123183543.GB26447@sigill.intra.peff.net>
References: <20140123183320.GA22995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 19:35:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6P80-00046e-LP
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 19:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbaAWSfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 13:35:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:37651 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752002AbaAWSfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 13:35:44 -0500
Received: (qmail 22728 invoked by uid 102); 23 Jan 2014 18:35:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 12:35:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 13:35:43 -0500
Content-Disposition: inline
In-Reply-To: <20140123183320.GA22995@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240926>

From: Vicent Marti <tanoku@gmail.com>

The caller may hand us an unaligned buffer (e.g., because it
is an mmap of a file with many ewah bitmaps). On some
platforms (like SPARC) this can cause a bus error. We can
fix it with a combination of force-align macros and moving
the data into an aligned buffer (which we would do anyway,
but we can move it before fixing the endianness).

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/ewah_io.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/ewah/ewah_io.c b/ewah/ewah_io.c
index aed0da6..1948ba5 100644
--- a/ewah/ewah_io.c
+++ b/ewah/ewah_io.c
@@ -112,23 +112,38 @@ int ewah_serialize(struct ewah_bitmap *self, int fd)
 
 int ewah_read_mmap(struct ewah_bitmap *self, void *map, size_t len)
 {
-	uint32_t *read32 = map;
-	eword_t *read64;
-	size_t i;
+	uint8_t *ptr = map;
+
+	self->bit_size = align_ntohl(*(uint32_t *)ptr);
+	ptr += sizeof(uint32_t);
+
+	self->buffer_size = self->alloc_size = align_ntohl(*(uint32_t *)ptr);
+	ptr += sizeof(uint32_t);
 
-	self->bit_size = ntohl(*read32++);
-	self->buffer_size = self->alloc_size = ntohl(*read32++);
 	self->buffer = ewah_realloc(self->buffer,
 		self->alloc_size * sizeof(eword_t));
 
 	if (!self->buffer)
 		return -1;
 
-	for (i = 0, read64 = (void *)read32; i < self->buffer_size; ++i)
-		self->buffer[i] = ntohll(*read64++);
+	/*
+	 * Copy the raw data for the bitmap as a whole chunk;
+	 * if we're in a little-endian platform, we'll perform
+	 * the endianness conversion in a separate pass to ensure
+	 * we're loading 8-byte aligned words.
+	 */
+	memcpy(self->buffer, ptr, self->buffer_size * sizeof(uint64_t));
+	ptr += self->buffer_size * sizeof(uint64_t);
+
+#if __BYTE_ORDER != __BIG_ENDIAN
+	{
+		size_t i;
+		for (i = 0; i < self->buffer_size; ++i)
+			self->buffer[i] = ntohll(self->buffer[i]);
+	}
+#endif
 
-	read32 = (void *)read64;
-	self->rlw = self->buffer + ntohl(*read32++);
+	self->rlw = self->buffer + align_ntohl(*(uint32_t *)ptr);
 
 	return (3 * 4) + (self->buffer_size * 8);
 }
-- 
1.8.5.2.500.g8060133
