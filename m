From: Jeff King <peff@peff.net>
Subject: [PATCH v2 07/19] compat: add endianness helpers
Date: Fri, 25 Oct 2013 02:03:26 -0400
Message-ID: <20131025060326.GE23098@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 08:03:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZaUn-0006Ed-17
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab3JYGDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:03:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:55295 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751218Ab3JYGD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:03:29 -0400
Received: (qmail 3357 invoked by uid 102); 25 Oct 2013 06:03:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:03:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:03:26 -0400
Content-Disposition: inline
In-Reply-To: <20131025055521.GD11810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236669>

From: Vicent Marti <tanoku@gmail.com>

The POSIX standard doesn't currently define a `nothll`/`htonll`
function pair to perform network-to-host and host-to-network
swaps of 64-bit data. These 64-bit swaps are necessary for the on-disk
storage of EWAH bitmaps if they are not in native byte order.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 compat/bswap.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index 5061214..ea1a9ed 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -47,4 +47,39 @@ static inline uint32_t git_bswap32(uint32_t x)
 #define ntohl(x) bswap32(x)
 #define htonl(x) bswap32(x)
 
+#ifndef __BYTE_ORDER
+#	if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
+#		define __BYTE_ORDER BYTE_ORDER
+#		define __LITTLE_ENDIAN LITTLE_ENDIAN
+#		define __BIG_ENDIAN BIG_ENDIAN
+#	else
+#		error "Cannot determine endianness"
+#	endif
+#endif
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+# define ntohll(n) (n)
+# define htonll(n) (n)
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+#	if defined(__GNUC__) && defined(__GLIBC__)
+#		include <byteswap.h>
+#	else /* GNUC & GLIBC */
+static inline uint64_t bswap_64(uint64_t val)
+{
+	return ((val & (uint64_t)0x00000000000000ffULL) << 56)
+		| ((val & (uint64_t)0x000000000000ff00ULL) << 40)
+		| ((val & (uint64_t)0x0000000000ff0000ULL) << 24)
+		| ((val & (uint64_t)0x00000000ff000000ULL) <<  8)
+		| ((val & (uint64_t)0x000000ff00000000ULL) >>  8)
+		| ((val & (uint64_t)0x0000ff0000000000ULL) >> 24)
+		| ((val & (uint64_t)0x00ff000000000000ULL) >> 40)
+		| ((val & (uint64_t)0xff00000000000000ULL) >> 56);
+}
+#	endif /* GNUC & GLIBC */
+#	define ntohll(n) bswap_64(n)
+#	define htonll(n) bswap_64(n)
+#else /* __BYTE_ORDER */
+#	error "Can't define htonll or ntohll!"
+#endif
+
 #endif
-- 
1.8.4.1.898.g8bf8a41.dirty
