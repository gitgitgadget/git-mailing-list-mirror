From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] ewah/bitmap: silence warning about MASK macro
 redefinition
Date: Wed, 3 Jun 2015 02:39:17 -0400
Message-ID: <20150603063917.GA29008@peff.net>
References: <20150603063812.GA21319@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:39:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Ki-0004pB-P2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbbFCGjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:39:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:40200 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751945AbbFCGjU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:39:20 -0400
Received: (qmail 7301 invoked by uid 102); 3 Jun 2015 06:39:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 01:39:20 -0500
Received: (qmail 16703 invoked by uid 107); 3 Jun 2015 06:39:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 02:39:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 02:39:17 -0400
Content-Disposition: inline
In-Reply-To: <20150603063812.GA21319@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270633>

From: Eric Sunshine <sunshine@sunshineco.com>

On PowerPC Mac OS X (10.5.8 "Leopard" with Xcode 3.1),
system header /usr/include/ppc/param.h[1] pollutes the
preprocessor namespace with a macro generically named MASK.
This conflicts with the same-named macro in ewah/bitmap.c.
We can avoid this conflict by using a more specific name.

[1]: Included indirectly via:
     git-compat-util.h ->
     sys/sysctl.h ->
     sys/ucred.h ->
     sys/param.h ->
     machine/param.h ->
     ppc/param.h

Signed-off-by: Jeff King <peff@peff.net>
---
 ewah/bitmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 710e58c..2af94f6 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -20,8 +20,8 @@
 #include "git-compat-util.h"
 #include "ewok.h"
 
-#define MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
-#define BLOCK(x) (x / BITS_IN_WORD)
+#define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_WORD))
+#define EWAH_BLOCK(x) (x / BITS_IN_WORD)
 
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
-- 
2.4.2.745.g0aa058d
