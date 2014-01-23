From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] block-sha1: factor out get_be and put_be wrappers
Date: Thu, 23 Jan 2014 16:23:09 -0500
Message-ID: <20140123212308.GA21705@sigill.intra.peff.net>
References: <20140123212036.GA21299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Rk3-0002Aw-NM
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbaAWVXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 16:23:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:37789 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751141AbaAWVXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 16:23:10 -0500
Received: (qmail 1081 invoked by uid 102); 23 Jan 2014 21:23:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 15:23:10 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 16:23:09 -0500
Content-Disposition: inline
In-Reply-To: <20140123212036.GA21299@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240957>

The BLK_SHA1 code has optimized wrappers for doing endian
conversions on memory that may not be aligned. Let's pull
them out so that we can use them elsewhere, especially the
time-tested list of platforms that prefer each strategy.

Signed-off-by: Jeff King <peff@peff.net>
---
These short names might not be descriptive enough now that they are
globals. However, they make sense to me. I'm open to suggestions if
somebody disagrees.

 block-sha1/sha1.c | 32 --------------------------------
 compat/bswap.h    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index e1a1eb6..22b125c 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -62,38 +62,6 @@
   #define setW(x, val) (W(x) = (val))
 #endif
 
-/*
- * Performance might be improved if the CPU architecture is OK with
- * unaligned 32-bit loads and a fast ntohl() is available.
- * Otherwise fall back to byte loads and shifts which is portable,
- * and is faster on architectures with memory alignment issues.
- */
-
-#if defined(__i386__) || defined(__x86_64__) || \
-    defined(_M_IX86) || defined(_M_X64) || \
-    defined(__ppc__) || defined(__ppc64__) || \
-    defined(__powerpc__) || defined(__powerpc64__) || \
-    defined(__s390__) || defined(__s390x__)
-
-#define get_be32(p)	ntohl(*(unsigned int *)(p))
-#define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
-
-#else
-
-#define get_be32(p)	( \
-	(*((unsigned char *)(p) + 0) << 24) | \
-	(*((unsigned char *)(p) + 1) << 16) | \
-	(*((unsigned char *)(p) + 2) <<  8) | \
-	(*((unsigned char *)(p) + 3) <<  0) )
-#define put_be32(p, v)	do { \
-	unsigned int __v = (v); \
-	*((unsigned char *)(p) + 0) = __v >> 24; \
-	*((unsigned char *)(p) + 1) = __v >> 16; \
-	*((unsigned char *)(p) + 2) = __v >>  8; \
-	*((unsigned char *)(p) + 3) = __v >>  0; } while (0)
-
-#endif
-
 /* This "rolls" over the 512-bit array */
 #define W(x) (array[(x)&15])
 
diff --git a/compat/bswap.h b/compat/bswap.h
index c18a78e..7d17953 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -122,3 +122,35 @@ static inline uint64_t git_bswap64(uint64_t x)
 #endif
 
 #endif
+
+/*
+ * Performance might be improved if the CPU architecture is OK with
+ * unaligned 32-bit loads and a fast ntohl() is available.
+ * Otherwise fall back to byte loads and shifts which is portable,
+ * and is faster on architectures with memory alignment issues.
+ */
+
+#if defined(__i386__) || defined(__x86_64__) || \
+    defined(_M_IX86) || defined(_M_X64) || \
+    defined(__ppc__) || defined(__ppc64__) || \
+    defined(__powerpc__) || defined(__powerpc64__) || \
+    defined(__s390__) || defined(__s390x__)
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
-- 
1.8.5.2.500.g8060133
