From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: [PATCH 1/4] Add base64 encoder and decoder
Date: Tue,  9 Feb 2010 21:09:02 +0900
Message-ID: <1265717345-2118-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 09 13:19:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nep3c-0000uz-Ls
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 13:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab0BIMS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 07:18:59 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:54582 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab0BIMSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 07:18:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id E270AE9D86F;
	Tue,  9 Feb 2010 21:09:54 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njFngukzEFZh; Tue,  9 Feb 2010 21:09:53 +0900 (JST)
Received: from localhost.localdomain (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id B4F48E9D866;
	Tue,  9 Feb 2010 21:09:53 +0900 (JST)
X-Mailer: git-send-email 1.7.0.rc1.52.gf7cc2.dirty
In-Reply-To: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139399>

This patch imports base64 encoder and decoder from libsylph 2.5.0 .
Main purpose is implementing CRAM-MD5 auth method for git-imap-send.

Cc: Jeremy White <jwhite@codeweavers.com>
Cc: Robert Shearman <robertshearman@gmail.com>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 Makefile |    2 +
 base64.c |  122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 base64.h |   36 ++++++++++++++++++
 3 files changed, 160 insertions(+), 0 deletions(-)
 create mode 100644 base64.c
 create mode 100644 base64.h

diff --git a/Makefile b/Makefile
index 7bf2fca..2b6b8b2 100644
--- a/Makefile
+++ b/Makefile
@@ -421,6 +421,7 @@ XDIFF_LIB=xdiff/lib.a
 LIB_H += advice.h
 LIB_H += archive.h
 LIB_H += attr.h
+LIB_H += base64.h
 LIB_H += blob.h
 LIB_H += builtin.h
 LIB_H += cache.h
@@ -488,6 +489,7 @@ LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += attr.o
+LIB_OBJS += base64.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blob.o
diff --git a/base64.c b/base64.c
new file mode 100644
index 0000000..4504643
--- /dev/null
+++ b/base64.c
@@ -0,0 +1,122 @@
+/*
+ * base64.c
+ *
+ * imported from libsylph 2.5.0
+ * by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
+ * 
+ */
+
+/*
+ * LibSylph -- E-Mail client library
+ * Copyright (C) 1999-2005 Hiroyuki Yamamoto
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <ctype.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "base64.h"
+
+static const char base64char[64] =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+
+static const char base64val[128] = {
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
+	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
+	-1,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
+	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
+	-1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
+	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1
+};
+
+#define BASE64VAL(c)	(isascii((char)c) ? base64val[(int)(c)] : -1)
+
+void base64_encode(char *out, const char *in, int inlen)
+{
+	const char *inp = in;
+	char *outp = out;
+
+	while (inlen >= 3) {
+		*outp++ = base64char[(inp[0] >> 2) & 0x3f];
+		*outp++ = base64char[((inp[0] & 0x03) << 4) |
+				     ((inp[1] >> 4) & 0x0f)];
+		*outp++ = base64char[((inp[1] & 0x0f) << 2) |
+				     ((inp[2] >> 6) & 0x03)];
+		*outp++ = base64char[inp[2] & 0x3f];
+
+		inp += 3;
+		inlen -= 3;
+	}
+
+	if (inlen > 0) {
+		*outp++ = base64char[(inp[0] >> 2) & 0x3f];
+		if (inlen == 1) {
+			*outp++ = base64char[(inp[0] & 0x03) << 4];
+			*outp++ = '=';
+		} else {
+			*outp++ = base64char[((inp[0] & 0x03) << 4) |
+					     ((inp[1] >> 4) & 0x0f)];
+			*outp++ = base64char[((inp[1] & 0x0f) << 2)];
+		}
+		*outp++ = '=';
+	}
+
+	*outp = '\0';
+}
+
+int base64_decode(char *out, const char *in, int inlen)
+{
+	const char *inp = in;
+	char *outp = out;
+	char buf[4];
+
+	if (inlen < 0)
+		inlen = INT_MAX;
+
+	while (inlen >= 4 && *inp != '\0') {
+		buf[0] = *inp++;
+		inlen--;
+		if (BASE64VAL(buf[0]) == -1) break;
+
+		buf[1] = *inp++;
+		inlen--;
+		if (BASE64VAL(buf[1]) == -1) break;
+
+		buf[2] = *inp++;
+		inlen--;
+		if (buf[2] != '=' && BASE64VAL(buf[2]) == -1) break;
+
+		buf[3] = *inp++;
+		inlen--;
+		if (buf[3] != '=' && BASE64VAL(buf[3]) == -1) break;
+
+		*outp++ = ((BASE64VAL(buf[0]) << 2) & 0xfc) |
+			  ((BASE64VAL(buf[1]) >> 4) & 0x03);
+		if (buf[2] != '=') {
+			*outp++ = ((BASE64VAL(buf[1]) & 0x0f) << 4) |
+				  ((BASE64VAL(buf[2]) >> 2) & 0x0f);
+			if (buf[3] != '=') {
+				*outp++ = ((BASE64VAL(buf[2]) & 0x03) << 6) |
+					   (BASE64VAL(buf[3]) & 0x3f);
+			}
+		}
+	}
+
+	return outp - out;
+}
diff --git a/base64.h b/base64.h
new file mode 100644
index 0000000..5771c5a
--- /dev/null
+++ b/base64.h
@@ -0,0 +1,36 @@
+/*
+ * base64.h
+ *
+ * imported from libsylph 2.5.0
+ * by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
+ * 
+ */
+
+/*
+ * LibSylph -- E-Mail client library
+ * Copyright (C) 1999-2005 Hiroyuki Yamamoto
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef BASE64_H
+#define BASE64_H
+
+#include <limits.h>
+
+void base64_encode(char *out, const char *in, int inlen);
+int base64_decode(char *out, const char *in, int inlen);
+
+#endif /* BASE64_H */
-- 
1.7.0.rc1.52.gf7cc2.dirty
