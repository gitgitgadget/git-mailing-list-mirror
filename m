From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/3] block-sha1: move code around
Date: Wed, 12 Aug 2009 15:45:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908121542440.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:46:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJm9-0001th-4V
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbZHLTqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 15:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbZHLTqJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:46:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61349 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbZHLTqI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:46:08 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOA00EKT48CO8E0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Aug 2009 15:45:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125734>


Move the code around so specific architecture hacks are defined first.
Also make one line comments actually one line.  No code change.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 block-sha1/sha1.c |  129 ++++++++++++++++++++++++----------------------------
 1 files changed, 60 insertions(+), 69 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 304cd04..c3f1ae5 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -9,74 +9,6 @@
 
 #include "sha1.h"
 
-/* Hash one 64-byte block of data */
-static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data);
-
-void blk_SHA1_Init(blk_SHA_CTX *ctx)
-{
-	ctx->size = 0;
-
-	/* Initialize H with the magic constants (see FIPS180 for constants)
-	 */
-	ctx->H[0] = 0x67452301;
-	ctx->H[1] = 0xefcdab89;
-	ctx->H[2] = 0x98badcfe;
-	ctx->H[3] = 0x10325476;
-	ctx->H[4] = 0xc3d2e1f0;
-}
-
-
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
-{
-	int lenW = ctx->size & 63;
-
-	ctx->size += len;
-
-	/* Read the data into W and process blocks as they get full
-	 */
-	if (lenW) {
-		int left = 64 - lenW;
-		if (len < left)
-			left = len;
-		memcpy(lenW + (char *)ctx->W, data, left);
-		lenW = (lenW + left) & 63;
-		len -= left;
-		data += left;
-		if (lenW)
-			return;
-		blk_SHA1Block(ctx, ctx->W);
-	}
-	while (len >= 64) {
-		blk_SHA1Block(ctx, data);
-		data += 64;
-		len -= 64;
-	}
-	if (len)
-		memcpy(ctx->W, data, len);
-}
-
-
-void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
-{
-	static const unsigned char pad[64] = { 0x80 };
-	unsigned int padlen[2];
-	int i;
-
-	/* Pad with a binary 1 (ie 0x80), then zeroes, then length
-	 */
-	padlen[0] = htonl(ctx->size >> 29);
-	padlen[1] = htonl(ctx->size << 3);
-
-	i = ctx->size & 63;
-	blk_SHA1_Update(ctx, pad, 1+ (63 & (55 - i)));
-	blk_SHA1_Update(ctx, padlen, 8);
-
-	/* Output hash
-	 */
-	for (i = 0; i < 5; i++)
-		((unsigned int *)hashout)[i] = htonl(ctx->H[i]);
-}
-
 #if defined(__i386__) || defined(__x86_64__)
 
 #define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
@@ -136,7 +68,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 #define T_40_59(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc, A, B, C, D, E )
 #define T_60_79(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6, A, B, C, D, E )
 
-static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
+static void blk_SHA1_Block(blk_SHA_CTX *ctx, const unsigned int *data)
 {
 	unsigned int A,B,C,D,E;
 	unsigned int array[16];
@@ -243,3 +175,62 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	ctx->H[3] += D;
 	ctx->H[4] += E;
 }
+
+void blk_SHA1_Init(blk_SHA_CTX *ctx)
+{
+	ctx->size = 0;
+
+	/* Initialize H with the magic constants (see FIPS180 for constants) */
+	ctx->H[0] = 0x67452301;
+	ctx->H[1] = 0xefcdab89;
+	ctx->H[2] = 0x98badcfe;
+	ctx->H[3] = 0x10325476;
+	ctx->H[4] = 0xc3d2e1f0;
+}
+
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
+{
+	int lenW = ctx->size & 63;
+
+	ctx->size += len;
+
+	/* Read the data into W and process blocks as they get full */
+	if (lenW) {
+		int left = 64 - lenW;
+		if (len < left)
+			left = len;
+		memcpy(lenW + (char *)ctx->W, data, left);
+		lenW = (lenW + left) & 63;
+		len -= left;
+		data += left;
+		if (lenW)
+			return;
+		blk_SHA1_Block(ctx, ctx->W);
+	}
+	while (len >= 64) {
+		blk_SHA1_Block(ctx, data);
+		data += 64;
+		len -= 64;
+	}
+	if (len)
+		memcpy(ctx->W, data, len);
+}
+
+void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
+{
+	static const unsigned char pad[64] = { 0x80 };
+	unsigned int padlen[2];
+	int i;
+
+	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
+	padlen[0] = htonl(ctx->size >> 29);
+	padlen[1] = htonl(ctx->size << 3);
+
+	i = ctx->size & 63;
+	blk_SHA1_Update(ctx, pad, 1+ (63 & (55 - i)));
+	blk_SHA1_Update(ctx, padlen, 8);
+
+	/* Output hash */
+	for (i = 0; i < 5; i++)
+		((unsigned int *)hashout)[i] = htonl(ctx->H[i]);
+}
-- 
1.6.4.189.g282fa
