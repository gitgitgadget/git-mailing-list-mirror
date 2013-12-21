From: Jeff King <peff@peff.net>
Subject: [PATCH v4 07/23] compat: add endianness helpers
Date: Sat, 21 Dec 2013 08:59:50 -0500
Message-ID: <20131221135950.GG21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 14:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN5w-00050p-J5
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab3LUN7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Dec 2013 08:59:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:48478 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755018Ab3LUN7v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:59:51 -0500
Received: (qmail 7353 invoked by uid 102); 21 Dec 2013 13:59:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:59:51 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:59:50 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239599>

=46rom: Vicent Marti <tanoku@gmail.com>

The POSIX standard doesn't currently define a `ntohll`/`htonll`
function pair to perform network-to-host and host-to-network
swaps of 64-bit data. These 64-bit swaps are necessary for the on-disk
storage of EWAH bitmaps if they are not in native byte order.

Many thanks to Ramsay Jones <ramsay@ramsay1.demon.co.uk> and
Torsten B=C3=B6gershausen <tboegi@web.de> for cygwin/mingw/msvc
portability fixes.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 compat/bswap.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 5061214..c18a78e 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -17,7 +17,20 @@ static inline uint32_t default_swab32(uint32_t val)
 		((val & 0x000000ff) << 24));
 }
=20
+static inline uint64_t default_bswap64(uint64_t val)
+{
+	return (((val & (uint64_t)0x00000000000000ffULL) << 56) |
+		((val & (uint64_t)0x000000000000ff00ULL) << 40) |
+		((val & (uint64_t)0x0000000000ff0000ULL) << 24) |
+		((val & (uint64_t)0x00000000ff000000ULL) <<  8) |
+		((val & (uint64_t)0x000000ff00000000ULL) >>  8) |
+		((val & (uint64_t)0x0000ff0000000000ULL) >> 24) |
+		((val & (uint64_t)0x00ff000000000000ULL) >> 40) |
+		((val & (uint64_t)0xff00000000000000ULL) >> 56));
+}
+
 #undef bswap32
+#undef bswap64
=20
 #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
=20
@@ -32,15 +45,42 @@ static inline uint32_t git_bswap32(uint32_t x)
 	return result;
 }
=20
+#define bswap64 git_bswap64
+#if defined(__x86_64__)
+static inline uint64_t git_bswap64(uint64_t x)
+{
+	uint64_t result;
+	if (__builtin_constant_p(x))
+		result =3D default_bswap64(x);
+	else
+		__asm__("bswap %q0" : "=3Dr" (result) : "0" (x));
+	return result;
+}
+#else
+static inline uint64_t git_bswap64(uint64_t x)
+{
+	union { uint64_t i64; uint32_t i32[2]; } tmp, result;
+	if (__builtin_constant_p(x))
+		result.i64 =3D default_bswap64(x);
+	else {
+		tmp.i64 =3D x;
+		result.i32[0] =3D git_bswap32(tmp.i32[1]);
+		result.i32[1] =3D git_bswap32(tmp.i32[0]);
+	}
+	return result.i64;
+}
+#endif
+
 #elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
=20
 #include <stdlib.h>
=20
 #define bswap32(x) _byteswap_ulong(x)
+#define bswap64(x) _byteswap_uint64(x)
=20
 #endif
=20
-#ifdef bswap32
+#if defined(bswap32)
=20
 #undef ntohl
 #undef htonl
@@ -48,3 +88,37 @@ static inline uint32_t git_bswap32(uint32_t x)
 #define htonl(x) bswap32(x)
=20
 #endif
+
+#if defined(bswap64)
+
+#undef ntohll
+#undef htonll
+#define ntohll(x) bswap64(x)
+#define htonll(x) bswap64(x)
+
+#else
+
+#undef ntohll
+#undef htonll
+
+#if !defined(__BYTE_ORDER)
+# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDI=
AN)
+#  define __BYTE_ORDER BYTE_ORDER
+#  define __LITTLE_ENDIAN LITTLE_ENDIAN
+#  define __BIG_ENDIAN BIG_ENDIAN
+# endif
+#endif
+
+#if !defined(__BYTE_ORDER)
+# error "Cannot determine endianness"
+#endif
+
+#if __BYTE_ORDER =3D=3D __BIG_ENDIAN
+# define ntohll(n) (n)
+# define htonll(n) (n)
+#else
+# define ntohll(n) default_bswap64(n)
+# define htonll(n) default_bswap64(n)
+#endif
+
+#endif
--=20
1.8.5.1.399.g900e7cd
