From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 14:55:41 -0500
Message-ID: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 30 21:02:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8xp1-0002xr-RY
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 21:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbaA3UCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 15:02:43 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50521 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaA3UCm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 15:02:42 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2014 15:02:42 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id D5CB42736448; Thu, 30 Jan 2014 19:55:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_20
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (u-of-rochester-128-151-150-17.wireless.rochester.edu [128.151.150.17])
	by silverinsanity.com (Postfix) with ESMTPA id 234782736189;
	Thu, 30 Jan 2014 19:55:53 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc0.256.gbc3fa69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241278>

a201c20 (ewah: support platforms that require aligned reads) added a
reliance on the existence of __BYTE_ORDER and __BIG_ENDIAN.  However,
these macros are spelled without the leading __ on some platforms (OS
X at least).  In this case, the endian-swapping code was added even
when unnecessary, which caused assertion failures in
t5310-pack-bitmaps.sh as the code that used the bitmap would read past
the end.

We already had code to handle this case in compat/bswap.h, but it was
only used if we couldn't already find a reasonable version of bswap64.
Move the macro-defining and checking code out of a conditional so that
either __BYTE_ORDER is defined or we get a compilation error instead
of a runtime error in the bitmap code.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 compat/bswap.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 120c6c1..7db09d6 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -80,6 +80,18 @@ static inline uint64_t git_bswap64(uint64_t x)
 
 #endif
 
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
+#endif
+
 #if defined(bswap32)
 
 #undef ntohl
@@ -101,18 +113,6 @@ static inline uint64_t git_bswap64(uint64_t x)
 #undef ntohll
 #undef htonll
 
-#if !defined(__BYTE_ORDER)
-# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
-#  define __BYTE_ORDER BYTE_ORDER
-#  define __LITTLE_ENDIAN LITTLE_ENDIAN
-#  define __BIG_ENDIAN BIG_ENDIAN
-# endif
-#endif
-
-#if !defined(__BYTE_ORDER)
-# error "Cannot determine endianness"
-#endif
-
 #if __BYTE_ORDER == __BIG_ENDIAN
 # define ntohll(n) (n)
 # define htonll(n) (n)
-- 
1.9.rc0.256.gbc3fa69
