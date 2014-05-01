From: Charles Bailey <cbailey32@bloomberg.net>
Subject: [PATCH] Add extra logic required to detect endianness on Solaris
Date: Thu,  1 May 2014 08:43:17 +0100
Message-ID: <1398930197-12851-1-git-send-email-cbailey32@bloomberg.net>
Cc: Charles Bailey <cbailey32@bloomberg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 09:44:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wflez-0005AN-PY
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 09:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbaEAHn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 03:43:57 -0400
Received: from avasout05.plus.net ([84.93.230.250]:41382 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbaEAHn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 03:43:56 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout05 with smtp
	id wXjs1n0022iA9hg01Xjt86; Thu, 01 May 2014 08:43:55 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=WIHxXxcR c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=-B3GwaKTCNEA:10 a=N2sEI2mohSIA:10 a=BHUvooL90DcA:10
 a=BNFp--SqAAAA:8 a=DlqYoaA_MH3orwUWwXAA:9 a=92rhvNbd_XgA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1Wfles-0003Ny-9z; Thu, 01 May 2014 08:43:54 +0100
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247806>

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---

The endian detection added in 7e3dae494 isn't sufficient for the Solaris
Studio compilers. This adds some fallback logic which works for Solaris
but would also work for AIX and Linux if it were needed.

 compat/bswap.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index 120c6c1..5a41311 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -110,6 +110,27 @@ static inline uint64_t git_bswap64(uint64_t x)
 #endif
 
 #if !defined(__BYTE_ORDER)
+/* Known to be needed on Solaris but designed to potentially more portable */
+
+#if !defined(__BIG_ENDIAN)
+#define __BIG_ENDIAN 4321
+#endif
+
+#if !defined(__LITTLE_ENDIAN)
+#define __LITTLE_ENDIAN 1234
+#endif
+
+#if defined(_BIG_ENDIAN)
+#define __BYTE_ORDER __BIG_ENDIAN
+#endif
+
+#if defined(_LITTLE_ENDIAN)
+#define __BYTE_ORDER __LITTLE_ENDIAN
+#endif
+
+#endif /* !defined(__BYTE_ORDER) */
+
+#if !defined(__BYTE_ORDER)
 # error "Cannot determine endianness"
 #endif
 
-- 
1.9.0
