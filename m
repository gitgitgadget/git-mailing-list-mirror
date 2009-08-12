From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/3] block-sha1: support for architectures with memory
 alignment restrictions
Date: Wed, 12 Aug 2009 15:47:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908121546480.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:48:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJo8-0002os-LA
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbZHLTsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 15:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbZHLTsP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:48:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26257 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbZHLTsO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:48:14 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOA00FEX4BV4X10@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Aug 2009 15:47:55 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125737>


This is needed on architectures with poor or non-existent unaligned memory
support and/or no fast byte swap instruction (such as ARM) by using byte
accesses to memory and shifting the result together.

This also makes the code portable, therefore the byte access methods are
the defaults.  Any architecture that properly supports unaligned word
accesses in hardware simply has to enable the alternative methods.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 block-sha1/sha1.c |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 67c9bd0..d3121f7 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -60,6 +60,34 @@
   #define setW(x, val) (W(x) = (val))
 #endif
 
+/*
+ * Performance might be improved if the CPU architecture is OK with
+ * unaligned 32-bit loads and a fast ntohl() is available.
+ * Otherwise fall back to byte loads and shifts which is portable,
+ * and is faster on architectures with memory alignment issues.
+ */
+
+#if defined(__i386__) || defined(__x86_64__)
+
+#define get_be32(p)	ntohl(*(unsigned int *)(p))
+#define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
+
+#else
+
+#define get_be32(p)	( \
+	(*((unsigned char *)(p) + 0) << 24) | \
+	(*((unsigned char *)(p) + 1) << 16) | \
+	(*((unsigned char *)(p) + 2) <<  8) | \
+	(*((unsigned char *)(p) + 3) <<  0) )
+#define put_be32(p, v)	do { \
+	unsigned int __v = (v); \
+	*((unsigned char *)(p) + 0) = __v >> 24; \
+	*((unsigned char *)(p) + 1) = __v >> 16; \
+	*((unsigned char *)(p) + 2) = __v >>  8; \
+	*((unsigned char *)(p) + 3) = __v >>  0; } while (0)
+
+#endif
+
 /* This "rolls" over the 512-bit array */
 #define W(x) (array[(x)&15])
 
@@ -67,7 +95,7 @@
  * Where do we get the source from? The first 16 iterations get it from
  * the input data, the next mix it from the 512-bit array.
  */
-#define SHA_SRC(t) htonl(data[t])
+#define SHA_SRC(t) get_be32(data + t)
 #define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
 
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
@@ -245,5 +273,5 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 	/* Output hash */
 	for (i = 0; i < 5; i++)
-		((unsigned int *)hashout)[i] = htonl(ctx->H[i]);
+		put_be32(hashout + i*4, ctx->H[i]);
 }
-- 
1.6.4.189.g282fa
