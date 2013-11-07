From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/5] compat/bswap.h: Fix build on cygwin, MinGW and msvc
Date: Thu, 07 Nov 2013 21:59:38 +0000
Message-ID: <527C0D4A.7070101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXrQ-0000TZ-I3
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab3KGWPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:15:10 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:47322 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755367Ab3KGWPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:15:06 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 5142D401484;
	Thu,  7 Nov 2013 22:15:04 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 4388740146D;
	Thu,  7 Nov 2013 22:15:01 +0000 (GMT)
Received: from [192.168.254.4] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu,  7 Nov 2013 22:15:00 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237439>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/bswap.h | 97 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 29 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index ea1a9ed..c18a78e 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -17,7 +17,20 @@ static inline uint32_t default_swab32(uint32_t val)
 		((val & 0x000000ff) << 24));
 }
 
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
 
 #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
 
@@ -32,54 +45,80 @@ static inline uint32_t git_bswap32(uint32_t x)
 	return result;
 }
 
+#define bswap64 git_bswap64
+#if defined(__x86_64__)
+static inline uint64_t git_bswap64(uint64_t x)
+{
+	uint64_t result;
+	if (__builtin_constant_p(x))
+		result = default_bswap64(x);
+	else
+		__asm__("bswap %q0" : "=r" (result) : "0" (x));
+	return result;
+}
+#else
+static inline uint64_t git_bswap64(uint64_t x)
+{
+	union { uint64_t i64; uint32_t i32[2]; } tmp, result;
+	if (__builtin_constant_p(x))
+		result.i64 = default_bswap64(x);
+	else {
+		tmp.i64 = x;
+		result.i32[0] = git_bswap32(tmp.i32[1]);
+		result.i32[1] = git_bswap32(tmp.i32[0]);
+	}
+	return result.i64;
+}
+#endif
+
 #elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
 
 #include <stdlib.h>
 
 #define bswap32(x) _byteswap_ulong(x)
+#define bswap64(x) _byteswap_uint64(x)
 
 #endif
 
-#ifdef bswap32
+#if defined(bswap32)
 
 #undef ntohl
 #undef htonl
 #define ntohl(x) bswap32(x)
 #define htonl(x) bswap32(x)
 
-#ifndef __BYTE_ORDER
-#	if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
-#		define __BYTE_ORDER BYTE_ORDER
-#		define __LITTLE_ENDIAN LITTLE_ENDIAN
-#		define __BIG_ENDIAN BIG_ENDIAN
-#	else
-#		error "Cannot determine endianness"
-#	endif
+#endif
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
+# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
+#  define __BYTE_ORDER BYTE_ORDER
+#  define __LITTLE_ENDIAN LITTLE_ENDIAN
+#  define __BIG_ENDIAN BIG_ENDIAN
+# endif
+#endif
+
+#if !defined(__BYTE_ORDER)
+# error "Cannot determine endianness"
 #endif
 
 #if __BYTE_ORDER == __BIG_ENDIAN
 # define ntohll(n) (n)
 # define htonll(n) (n)
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-#	if defined(__GNUC__) && defined(__GLIBC__)
-#		include <byteswap.h>
-#	else /* GNUC & GLIBC */
-static inline uint64_t bswap_64(uint64_t val)
-{
-	return ((val & (uint64_t)0x00000000000000ffULL) << 56)
-		| ((val & (uint64_t)0x000000000000ff00ULL) << 40)
-		| ((val & (uint64_t)0x0000000000ff0000ULL) << 24)
-		| ((val & (uint64_t)0x00000000ff000000ULL) <<  8)
-		| ((val & (uint64_t)0x000000ff00000000ULL) >>  8)
-		| ((val & (uint64_t)0x0000ff0000000000ULL) >> 24)
-		| ((val & (uint64_t)0x00ff000000000000ULL) >> 40)
-		| ((val & (uint64_t)0xff00000000000000ULL) >> 56);
-}
-#	endif /* GNUC & GLIBC */
-#	define ntohll(n) bswap_64(n)
-#	define htonll(n) bswap_64(n)
-#else /* __BYTE_ORDER */
-#	error "Can't define htonll or ntohll!"
+#else
+# define ntohll(n) default_bswap64(n)
+# define htonll(n) default_bswap64(n)
 #endif
 
 #endif
-- 
1.8.4
