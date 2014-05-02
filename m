From: Charles Bailey <cbailey32@bloomberg.net>
Subject: [PATCH] Detect endianness on more platforms that don't use BYTE_ORDER
Date: Fri,  2 May 2014 08:55:29 +0100
Message-ID: <1399017329-25645-1-git-send-email-cbailey32@bloomberg.net>
References: <20140502074917.GA25198@hashpling.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 09:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg8KM-00024C-3a
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 09:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbaEBHz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 03:55:29 -0400
Received: from avasout05.plus.net ([84.93.230.250]:52088 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbaEBHz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 03:55:29 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout05 with smtp
	id wvvT1n0032iA9hg01vvUfq; Fri, 02 May 2014 08:55:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=WIHxXxcR c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=IsHL7CTjgF4A:10 a=N2sEI2mohSIA:10 a=BHUvooL90DcA:10
 a=BNFp--SqAAAA:8 a=C4iWue1sR-8F4M-adjcA:9
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1Wg8Jd-0006gD-3d; Fri, 02 May 2014 08:55:29 +0100
X-Mailer: git-send-email 1.9.0
In-Reply-To: <20140502074917.GA25198@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247929>

---
 compat/bswap.h | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 120c6c1..f08a9fe 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -101,19 +101,34 @@ static inline uint64_t git_bswap64(uint64_t x)
 #undef ntohll
 #undef htonll
 
-#if !defined(__BYTE_ORDER)
-# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
-#  define __BYTE_ORDER BYTE_ORDER
-#  define __LITTLE_ENDIAN LITTLE_ENDIAN
-#  define __BIG_ENDIAN BIG_ENDIAN
+#if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
+
+# define GIT_BYTE_ORDER BYTE_ORDER
+# define GIT_LITTLE_ENDIAN LITTLE_ENDIAN
+# define GIT_BIG_ENDIAN BIG_ENDIAN
+
+#elif defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && defined(__BIG_ENDIAN)
+
+# define GIT_BYTE_ORDER __BYTE_ORDER
+# define GIT_LITTLE_ENDIAN __LITTLE_ENDIAN
+# define GIT_BIG_ENDIAN __BIG_ENDIAN
+
+#else
+
+# define GIT_BIG_ENDIAN 4321
+# define GIT_LITTLE_ENDIAN 1234
+
+# if defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
+#  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
+# elif defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
+#  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
+# else
+#  error "Cannot determine endianness"
 # endif
-#endif
 
-#if !defined(__BYTE_ORDER)
-# error "Cannot determine endianness"
 #endif
 
-#if __BYTE_ORDER == __BIG_ENDIAN
+#if GIT_BYTE_ORDER == GIT_BIG_ENDIAN
 # define ntohll(n) (n)
 # define htonll(n) (n)
 #else
-- 
1.9.0
