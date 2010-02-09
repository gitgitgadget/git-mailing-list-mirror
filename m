From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: [PATCH 2/4] Add stuffs for MD5 hash algorithm
Date: Tue,  9 Feb 2010 21:09:03 +0900
Message-ID: <1265717345-2118-3-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 09 13:19:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nep3d-0000uz-8r
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 13:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab0BIMTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 07:19:01 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:54579 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab0BIMSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 07:18:49 -0500
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2010 07:18:49 EST
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 85A7CE9D895;
	Tue,  9 Feb 2010 21:09:56 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NoKbnxFUF9DF; Tue,  9 Feb 2010 21:09:54 +0900 (JST)
Received: from localhost.localdomain (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id B7313E9D867;
	Tue,  9 Feb 2010 21:09:53 +0900 (JST)
X-Mailer: git-send-email 1.7.0.rc1.52.gf7cc2.dirty
In-Reply-To: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139400>

This patch imports stuffs related to MD5 hash algorithm
from libsylph 2.5.0 .
Main purpose is implementing CRAM-MD5 auth method for git-imap-send.

Cc: Jeremy White <jwhite@codeweavers.com>
Cc: Robert Shearman <robertshearman@gmail.com>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 Makefile   |    4 +
 md5.c      |  600 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 md5.h      |   61 ++++++
 md5_hmac.c |  137 ++++++++++++++
 md5_hmac.h |   36 ++++
 5 files changed, 838 insertions(+), 0 deletions(-)
 create mode 100644 md5.c
 create mode 100644 md5.h
 create mode 100644 md5_hmac.c
 create mode 100644 md5_hmac.h

diff --git a/Makefile b/Makefile
index 2b6b8b2..6c28413 100644
--- a/Makefile
+++ b/Makefile
@@ -448,6 +448,8 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
+LIB_H += md5.h
+LIB_H += md5_hmac.h
 LIB_H += merge-recursive.h
 LIB_H += notes.h
 LIB_H += object.h
@@ -535,6 +537,8 @@ LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
+LIB_OBJS += md5.o
+LIB_OBJS += md5_hmac.o
 LIB_OBJS += merge-file.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += name-hash.o
diff --git a/md5.c b/md5.c
new file mode 100644
index 0000000..35230e2
--- /dev/null
+++ b/md5.c
@@ -0,0 +1,600 @@
+/*
+ * md5.c
+ *
+ * imported from libsylph 2.5.0
+ * by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
+ * 
+ */
+
+/*
+
+  GNet API added by David Helder <dhelder@umich.edu> 2000-6-11.  All
+  additions and changes placed in the public domain.
+
+  Files originally from: http://www.gxsnmp.org/CVS/gxsnmp/
+
+  Modified the prefix of functions to prevent conflict with original GNet.
+
+ */
+/*
+ * This code implements the MD5 message-digest algorithm.
+ * The algorithm is due to Ron Rivest.  This code was
+ * written by Colin Plumb in 1993, no copyright is claimed.
+ * This code is in the public domain; do with it what you wish.
+ *
+ * Equivalent code is available from RSA Data Security, Inc.
+ * This code has been tested against that, and is equivalent,
+ * except that you don't need to include two pages of legalese
+ * with every copy.
+ *
+ * To compute the message digest of a chunk of bytes, declare an
+ * MD5Context structure, pass it to MD5Init, call MD5Update as
+ * needed on buffers full of bytes, and then call MD5Final, which
+ * will fill a supplied 16-byte array with the digest.
+ */
+
+#include "md5.h"
+#include <string.h>
+#include <stdlib.h>
+
+
+/* ************************************************************ */
+/* Code below is from Colin Plumb implementation 		*/
+
+
+
+struct MD5Context {
+	unsigned int buf[4];
+	unsigned int bits[2];
+	unsigned char  in[64];
+	int     doByteReverse;
+};
+
+static void MD5Init(struct MD5Context *context);
+static void MD5Update(struct MD5Context *context, unsigned char const *buf,
+		      unsigned int len);
+static void MD5Final(unsigned char digest[16], struct MD5Context *context);
+static void MD5Transform(unsigned int buf[4], unsigned int const in[16]);
+
+/*
+ * This is needed to make RSAREF happy on some MS-DOS compilers.
+ */
+typedef struct MD5Context MD5_CTX;
+
+static void byteReverse(unsigned char *buf, unsigned int longs);
+
+/*
+ * Note: this code is harmless on little-endian machines.
+ */
+void  byteReverse(unsigned char *buf, unsigned int longs)
+{
+	unsigned int t;
+	do {
+		t = (unsigned int) ((unsigned int) buf[3] << 8 | buf[2]) << 16 |
+			((unsigned int) buf[1] << 8 | buf[0]);
+		*(unsigned int *) buf = t;
+		buf += 4;
+	} while (--longs);
+}
+
+/*
+ * Start MD5 accumulation.  Set bit count to 0 and buffer to mysterious
+ * initialization constants.
+ */
+void MD5Init(struct MD5Context *ctx)
+{
+	ctx->buf[0] = 0x67452301;
+	ctx->buf[1] = 0xefcdab89;
+	ctx->buf[2] = 0x98badcfe;
+	ctx->buf[3] = 0x10325476;
+
+	ctx->bits[0] = 0;
+	ctx->bits[1] = 0;
+
+#if (BYTE_ORDER == BIG_ENDIAN)
+	ctx->doByteReverse = 1;
+#else
+	ctx->doByteReverse = 0;
+#endif
+}
+
+/*
+ * Update context to reflect the concatenation of another buffer full
+ * of bytes.
+ */
+void  MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned int len)
+{
+	unsigned int t;
+
+	/* Update bitcount */
+	t = ctx->bits[0];
+	if ((ctx->bits[0] = t + ((unsigned int) len << 3)) < t)
+		ctx->bits[1]++;		/* Carry from low to high */
+	ctx->bits[1] += len >> 29;
+
+	t = (t >> 3) & 0x3f;	/* Bytes already in shsInfo->data */
+
+	/* Handle any leading odd-sized chunks */
+
+	if (t) {
+		unsigned char *p = (unsigned char *) ctx->in + t;
+
+		t = 64 - t;
+		if (len < t) {
+			memmove(p, buf, len);
+			return;
+		}
+		memmove(p, buf, t);
+		if (ctx->doByteReverse)
+			byteReverse(ctx->in, 16);
+		MD5Transform(ctx->buf, (unsigned int *) ctx->in);
+		buf += t;
+		len -= t;
+	}
+	/* Process data in 64-byte chunks */
+
+	while (len >= 64) {
+		memmove(ctx->in, buf, 64);
+		if (ctx->doByteReverse)
+			byteReverse(ctx->in, 16);
+		MD5Transform(ctx->buf, (unsigned int *) ctx->in);
+		buf += 64;
+		len -= 64;
+	}
+
+	/* Handle any remaining bytes of data. */
+
+	memmove(ctx->in, buf, len);
+}
+
+/*
+ * Final wrapup - pad to 64-byte boundary with the bit pattern 
+ * 1 0* (64-bit count of bits processed, MSB-first)
+ */
+void  MD5Final(unsigned char digest[16], struct MD5Context *ctx)
+{
+	unsigned int count;
+	unsigned char *p;
+
+	/* Compute number of bytes mod 64 */
+	count = (ctx->bits[0] >> 3) & 0x3F;
+
+	/* Set the first char of padding to 0x80.  This is safe since there is
+	   always at least one byte free */
+	p = ctx->in + count;
+	*p++ = 0x80;
+
+	/* Bytes of padding needed to make 64 bytes */
+	count = 64 - 1 - count;
+
+	/* Pad out to 56 mod 64 */
+	if (count < 8) {
+		/* Two lots of padding:  Pad the first block to 64 bytes */
+		memset(p, 0, count);
+		if (ctx->doByteReverse)
+			byteReverse(ctx->in, 16);
+		MD5Transform(ctx->buf, (unsigned int *) ctx->in);
+
+		/* Now fill the next block with 56 bytes */
+		memset(ctx->in, 0, 56);
+	} else {
+		/* Pad block to 56 bytes */
+		memset(p, 0, count - 8);
+	}
+	if (ctx->doByteReverse)
+		byteReverse(ctx->in, 14);
+
+	/* Append length in bits and transform */
+	((unsigned int *) ctx->in)[14] = ctx->bits[0];
+	((unsigned int *) ctx->in)[15] = ctx->bits[1];
+
+	MD5Transform(ctx->buf, (unsigned int *) ctx->in);
+	if (ctx->doByteReverse)
+		byteReverse((unsigned char *) ctx->buf, 4);
+	memmove(digest, ctx->buf, 16);
+	memset(ctx, 0, sizeof(ctx));	/* In case it's sensitive */
+}
+
+/* The four core functions - F1 is optimized somewhat */
+
+/* #define F1(x, y, z) (x & y | ~x & z) */
+#define F1(x, y, z) (z ^ (x & (y ^ z)))
+#define F2(x, y, z) F1(z, x, y)
+#define F3(x, y, z) (x ^ y ^ z)
+#define F4(x, y, z) (y ^ (x | ~z))
+
+/* This is the central step in the MD5 algorithm. */
+#define MD5STEP(f, w, x, y, z, data, s) \
+	( w += f(x, y, z) + data,  w = w<<s | w>>(32-s),  w += x )
+
+/*
+ * The core of the MD5 algorithm, this alters an existing MD5 hash to
+ * reflect the addition of 16 longwords of new data.  MD5Update blocks
+ * the data and converts bytes into longwords for this routine.
+ */
+void MD5Transform(unsigned int buf[4], unsigned int const in[16])
+{
+	register unsigned int a, b, c, d;
+
+	a = buf[0];
+	b = buf[1];
+	c = buf[2];
+	d = buf[3];
+
+	MD5STEP(F1, a, b, c, d, in[0] + 0xd76aa478, 7);
+	MD5STEP(F1, d, a, b, c, in[1] + 0xe8c7b756, 12);
+	MD5STEP(F1, c, d, a, b, in[2] + 0x242070db, 17);
+	MD5STEP(F1, b, c, d, a, in[3] + 0xc1bdceee, 22);
+	MD5STEP(F1, a, b, c, d, in[4] + 0xf57c0faf, 7);
+	MD5STEP(F1, d, a, b, c, in[5] + 0x4787c62a, 12);
+	MD5STEP(F1, c, d, a, b, in[6] + 0xa8304613, 17);
+	MD5STEP(F1, b, c, d, a, in[7] + 0xfd469501, 22);
+	MD5STEP(F1, a, b, c, d, in[8] + 0x698098d8, 7);
+	MD5STEP(F1, d, a, b, c, in[9] + 0x8b44f7af, 12);
+	MD5STEP(F1, c, d, a, b, in[10] + 0xffff5bb1, 17);
+	MD5STEP(F1, b, c, d, a, in[11] + 0x895cd7be, 22);
+	MD5STEP(F1, a, b, c, d, in[12] + 0x6b901122, 7);
+	MD5STEP(F1, d, a, b, c, in[13] + 0xfd987193, 12);
+	MD5STEP(F1, c, d, a, b, in[14] + 0xa679438e, 17);
+	MD5STEP(F1, b, c, d, a, in[15] + 0x49b40821, 22);
+
+	MD5STEP(F2, a, b, c, d, in[1] + 0xf61e2562, 5);
+	MD5STEP(F2, d, a, b, c, in[6] + 0xc040b340, 9);
+	MD5STEP(F2, c, d, a, b, in[11] + 0x265e5a51, 14);
+	MD5STEP(F2, b, c, d, a, in[0] + 0xe9b6c7aa, 20);
+	MD5STEP(F2, a, b, c, d, in[5] + 0xd62f105d, 5);
+	MD5STEP(F2, d, a, b, c, in[10] + 0x02441453, 9);
+	MD5STEP(F2, c, d, a, b, in[15] + 0xd8a1e681, 14);
+	MD5STEP(F2, b, c, d, a, in[4] + 0xe7d3fbc8, 20);
+	MD5STEP(F2, a, b, c, d, in[9] + 0x21e1cde6, 5);
+	MD5STEP(F2, d, a, b, c, in[14] + 0xc33707d6, 9);
+	MD5STEP(F2, c, d, a, b, in[3] + 0xf4d50d87, 14);
+	MD5STEP(F2, b, c, d, a, in[8] + 0x455a14ed, 20);
+	MD5STEP(F2, a, b, c, d, in[13] + 0xa9e3e905, 5);
+	MD5STEP(F2, d, a, b, c, in[2] + 0xfcefa3f8, 9);
+	MD5STEP(F2, c, d, a, b, in[7] + 0x676f02d9, 14);
+	MD5STEP(F2, b, c, d, a, in[12] + 0x8d2a4c8a, 20);
+
+	MD5STEP(F3, a, b, c, d, in[5] + 0xfffa3942, 4);
+	MD5STEP(F3, d, a, b, c, in[8] + 0x8771f681, 11);
+	MD5STEP(F3, c, d, a, b, in[11] + 0x6d9d6122, 16);
+	MD5STEP(F3, b, c, d, a, in[14] + 0xfde5380c, 23);
+	MD5STEP(F3, a, b, c, d, in[1] + 0xa4beea44, 4);
+	MD5STEP(F3, d, a, b, c, in[4] + 0x4bdecfa9, 11);
+	MD5STEP(F3, c, d, a, b, in[7] + 0xf6bb4b60, 16);
+	MD5STEP(F3, b, c, d, a, in[10] + 0xbebfbc70, 23);
+	MD5STEP(F3, a, b, c, d, in[13] + 0x289b7ec6, 4);
+	MD5STEP(F3, d, a, b, c, in[0] + 0xeaa127fa, 11);
+	MD5STEP(F3, c, d, a, b, in[3] + 0xd4ef3085, 16);
+	MD5STEP(F3, b, c, d, a, in[6] + 0x04881d05, 23);
+	MD5STEP(F3, a, b, c, d, in[9] + 0xd9d4d039, 4);
+	MD5STEP(F3, d, a, b, c, in[12] + 0xe6db99e5, 11);
+	MD5STEP(F3, c, d, a, b, in[15] + 0x1fa27cf8, 16);
+	MD5STEP(F3, b, c, d, a, in[2] + 0xc4ac5665, 23);
+
+	MD5STEP(F4, a, b, c, d, in[0] + 0xf4292244, 6);
+	MD5STEP(F4, d, a, b, c, in[7] + 0x432aff97, 10);
+	MD5STEP(F4, c, d, a, b, in[14] + 0xab9423a7, 15);
+	MD5STEP(F4, b, c, d, a, in[5] + 0xfc93a039, 21);
+	MD5STEP(F4, a, b, c, d, in[12] + 0x655b59c3, 6);
+	MD5STEP(F4, d, a, b, c, in[3] + 0x8f0ccc92, 10);
+	MD5STEP(F4, c, d, a, b, in[10] + 0xffeff47d, 15);
+	MD5STEP(F4, b, c, d, a, in[1] + 0x85845dd1, 21);
+	MD5STEP(F4, a, b, c, d, in[8] + 0x6fa87e4f, 6);
+	MD5STEP(F4, d, a, b, c, in[15] + 0xfe2ce6e0, 10);
+	MD5STEP(F4, c, d, a, b, in[6] + 0xa3014314, 15);
+	MD5STEP(F4, b, c, d, a, in[13] + 0x4e0811a1, 21);
+	MD5STEP(F4, a, b, c, d, in[4] + 0xf7537e82, 6);
+	MD5STEP(F4, d, a, b, c, in[11] + 0xbd3af235, 10);
+	MD5STEP(F4, c, d, a, b, in[2] + 0x2ad7d2bb, 15);
+	MD5STEP(F4, b, c, d, a, in[9] + 0xeb86d391, 21);
+
+	buf[0] += a;
+	buf[1] += b;
+	buf[2] += c;
+	buf[3] += d;
+}
+
+/* ************************************************************ */
+/* Code below is David Helder's API for GNet			*/
+
+struct _SMD5
+{
+	struct MD5Context ctx;
+	char digest[S_GNET_MD5_HASH_LENGTH];
+};
+
+/**
+ *  s_gnet_md5_new:
+ *  @buffer: buffer to hash
+ *  @length: length of @buffer
+ * 
+ *  Creates a #SMD5 from @buffer.
+ *
+ *  Returns: a new #SMD5.
+ *
+ **/
+SMD5 *s_gnet_md5_new(const unsigned char *buffer, unsigned int length)
+{
+	SMD5 *md5;
+
+	md5 = calloc(sizeof(SMD5), 1);
+	MD5Init (&md5->ctx);
+	MD5Update (&md5->ctx, buffer, length);
+	MD5Final ((void *) &md5->digest, &md5->ctx);
+
+	return md5;
+}
+
+/**
+ *  s_gnet_md5_new_string:
+ *  @str: hexidecimal string
+ * 
+ *  Creates a #SMD5 from @str.  @str is a hexidecimal string
+ *  representing the digest.
+ *
+ *  Returns: a new #SMD5.
+ *
+ **/
+SMD5 *s_gnet_md5_new_string (const char *str)
+{
+	SMD5 *md5;
+	unsigned int i;
+
+	if (!str)
+		return NULL;
+	if (!(strlen(str) >= (S_GNET_MD5_HASH_LENGTH * 2)))
+		return NULL;
+
+	md5 = calloc(sizeof(SMD5), 1);
+
+	for (i = 0; i < (S_GNET_MD5_HASH_LENGTH * 2); ++i) {
+		unsigned int val = 0;
+
+		switch (str[i]) {
+		case '0':	val = 0;	break;
+		case '1':	val = 1;	break;
+		case '2':	val = 2;	break;
+		case '3':	val = 3;	break;
+		case '4':	val = 4;	break;
+		case '5':	val = 5;	break;
+		case '6':	val = 6;	break;
+		case '7':	val = 7;	break;
+		case '8':	val = 8;	break;
+		case '9':	val = 9;	break;
+		case 'A':
+		case 'a':	val = 10;	break;
+		case 'B':
+		case 'b':	val = 11;	break;
+		case 'C':
+		case 'c':	val = 12;	break;
+		case 'D':
+		case 'd':	val = 13;	break;
+		case 'E':
+		case 'e':	val = 14;	break;
+		case 'F':
+		case 'f':	val = 15;	break;
+		default:
+			return NULL;
+		}
+
+		if (i % 2)
+			md5->digest[i / 2] |= val;
+		else
+			md5->digest[i / 2] = val << 4;
+	}
+
+	return md5;
+}
+
+/**
+ *  s_gnet_md5_clone
+ *  @md5: a #SMD5
+ * 
+ *  Copies a #SMD5.
+ *
+ *  Returns: a copy of @md5.
+ *
+ **/
+SMD5 *s_gnet_md5_clone(const SMD5 *md5)
+{
+	SMD5 *md52;
+
+	if (!md5)
+		return NULL;
+
+	md52 = calloc (sizeof(SMD5), 1);
+	md52->ctx = md5->ctx;
+	memcpy(md52->digest, md5->digest, sizeof(md5->digest));
+
+	return md52;
+}
+
+/** 
+ *  s_gnet_md5_delete
+ *  @md5: a #SMD5
+ *
+ *  Deletes a #SMD5.
+ *
+ **/
+void s_gnet_md5_delete(SMD5 *md5)
+{
+	if (md5)
+		free (md5);
+}
+
+/**
+ *  s_gnet_md5_new_incremental
+ *
+ *  Creates a #SMD5 incrementally.  After creating a #SMD5, call
+ *  s_gnet_md5_update() one or more times to hash data.  Finally, call
+ *  s_gnet_md5_final() to compute the final hash value.
+ *
+ *  Returns: a new #SMD5.
+ *
+ **/
+SMD5 *s_gnet_md5_new_incremental(void)
+{
+	SMD5 *md5;
+
+	md5 = calloc (sizeof(SMD5), 1);
+	MD5Init (&md5->ctx);
+	return md5;
+}
+
+/**
+ *  s_gnet_md5_update
+ *  @md5: a #SMD5
+ *  @buffer: buffer to add
+ *  @length: length of @buffer
+ *
+ *  Updates the hash with @buffer.  This may be called several times
+ *  on a hash created by s_gnet_md5_new_incremental() before being
+ *  finalized by calling s_gnet_md5_final().
+ * 
+ **/
+void s_gnet_md5_update(SMD5 *md5, const unsigned char *buffer, unsigned int length)
+{
+	if (!md5)
+		return;
+
+	MD5Update (&md5->ctx, buffer, length);
+}
+
+/**
+ *  s_gnet_md5_final
+ *  @md5: a #SMD5
+ *
+ *  Calcuates the final hash value of a #SMD5.  This should only be
+ *  called on an #SMD5 created by s_gnet_md5_new_incremental().
+ *
+ **/
+void s_gnet_md5_final(SMD5 *md5)
+{
+	if (!md5)
+		return;
+
+	MD5Final ((void *) &md5->digest, &md5->ctx);
+}
+
+/**
+ *  s_gnet_md5_equal
+ *  @p1: first #SMD5.
+ *  @p2: second #SMD5.
+ *
+ *  Compares two #SMD5's for equality.
+ *
+ *  Returns: TRUE if they are equal; FALSE otherwise.
+ *
+ **/
+int s_gnet_md5_equal(const void *p1, const void *p2)
+{
+	SMD5 *md5a = (SMD5*) p1;
+	SMD5 *md5b = (SMD5*) p2;
+	unsigned int i;
+
+	for (i = 0; i < S_GNET_MD5_HASH_LENGTH; ++i)
+		if (md5a->digest[i] != md5b->digest[i])
+			return FALSE;
+	return TRUE;
+}
+
+/**
+ *  s_gnet_md5_hash
+ *  @p: a #SMD5
+ *
+ *  Creates a hash code for a #SMD5 for use with GHashTable.  This
+ *  hash value is not the same as the MD5 digest.
+ *
+ *  Returns: the hash code for @p.
+ *
+ **/
+unsigned int s_gnet_md5_hash(const void *p)
+{
+	const SMD5 *md5 = (const SMD5*) p;
+	const unsigned int *q;
+
+	if (!md5)
+		return 0;
+
+	q = (const unsigned int*) md5->digest;
+
+	return (q[0] ^ q[1] ^ q[2] ^ q[3]);
+}
+
+/**
+ *  s_gnet_md5_get_digest
+ *  @md5: a #SMD5
+ *
+ *  Gets the raw MD5 digest.
+ *
+ *  Returns: a callee-owned buffer containing the MD5 hash digest.
+ *  The buffer is %S_GNET_MD5_HASH_LENGTH bytes long.
+ *
+ **/
+char *s_gnet_md5_get_digest (const SMD5 *md5)
+{
+	if (!md5)
+		return NULL;
+  
+	return (char*) md5->digest;
+}
+
+static char bits2hex[16] = { '0', '1', '2', '3', 
+			      '4', '5', '6', '7',
+			      '8', '9', 'a', 'b',
+			      'c', 'd', 'e', 'f' };
+
+/**
+ *  s_gnet_md5_get_string
+ *  @md5: a #SMD5
+ *
+ *  Gets the digest represented a human-readable string.
+ *
+ *  Returns: a hexadecimal string representing the digest.  The string
+ *  is 2 * %S_GNET_MD5_HASH_LENGTH bytes long and NULL terminated.  The
+ *  string is caller owned.
+ *
+ **/
+char *s_gnet_md5_get_string (const SMD5 *md5)
+{
+	char *str;
+	unsigned int i;
+
+	if (!md5)
+		return NULL;
+
+	str = calloc(sizeof(char), S_GNET_MD5_HASH_LENGTH * 2 + 1);
+	str[S_GNET_MD5_HASH_LENGTH * 2] = '\0';
+
+	for (i = 0; i < S_GNET_MD5_HASH_LENGTH; ++i) {
+		str[i * 2]       = bits2hex[(md5->digest[i] & 0xF0) >> 4];
+		str[(i * 2) + 1] = bits2hex[(md5->digest[i] & 0x0F)     ];
+	}
+
+	return str;
+}
+
+/**
+ * s_gnet_md5_copy_string
+ * @md5: a #SMD5
+ * @buffer: buffer at least 2 * %S_GNET_MD5_HASH_LENGTH bytes long
+ *
+ * Copies the digest, represented as a string, into @buffer.  The
+ * string is not NULL terminated.
+ * 
+ **/
+void s_gnet_md5_copy_string (const SMD5 *md5, char *buffer)
+{
+	unsigned int i;
+
+	if (!md5)
+		return;
+	if (!buffer)
+		return;
+
+	for (i = 0; i < S_GNET_MD5_HASH_LENGTH; ++i) {
+		buffer[i * 2]       = bits2hex[(md5->digest[i] & 0xF0) >> 4];
+		buffer[(i * 2) + 1] = bits2hex[(md5->digest[i] & 0x0F)     ];
+	}
+}
diff --git a/md5.h b/md5.h
new file mode 100644
index 0000000..958e383
--- /dev/null
+++ b/md5.h
@@ -0,0 +1,61 @@
+/*
+ * md5.h
+ *
+ * imported from libsylph 2.5.0
+ * by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
+ * 
+ */
+
+/**
+
+   This code is in the public domain.  See md5.c for details.
+
+   Authors:
+     Colin Plumb [original author]
+     David Helder [GNet API]
+
+   Modified the prefix of functions to prevent conflict with original GNet.
+
+ */
+
+
+#ifndef MD5_H
+#define MD5_H
+
+/**
+ *  SMD5
+ *
+ *  SMD5 is a MD5 hash.
+ *
+ **/
+typedef struct _SMD5 SMD5;
+
+/**
+ *  S_GNET_MD5_HASH_LENGTH
+ *
+ *  Length of the MD5 hash in bytes.
+ **/
+#define S_GNET_MD5_HASH_LENGTH	16
+#define DIGEST_HEX_LEN S_GNET_MD5_HASH_LENGTH * 2 + 1
+
+SMD5 *s_gnet_md5_new(const unsigned char *buffer, unsigned int length);
+SMD5 *s_gnet_md5_new_string(const char *str);
+SMD5 *s_gnet_md5_clone(const SMD5 *md5);
+void s_gnet_md5_delete(SMD5 *md5);
+	
+SMD5 *s_gnet_md5_new_incremental(void);
+void s_gnet_md5_update(SMD5 *md5, const unsigned char *buffer, unsigned int length);
+void s_gnet_md5_final(SMD5 *md5);
+	
+int s_gnet_md5_equal(const void *p1, const void *p2);
+unsigned int s_gnet_md5_hash(const void *p);
+	
+char *s_gnet_md5_get_digest(const SMD5 *md5);
+char *s_gnet_md5_get_string(const SMD5 *md5);
+	
+void s_gnet_md5_copy_string(const SMD5 *md5, char *buffer);
+
+#define FALSE 0
+#define TRUE 1
+
+#endif /* MD5_H */
diff --git a/md5_hmac.c b/md5_hmac.c
new file mode 100644
index 0000000..3f0c6de
--- /dev/null
+++ b/md5_hmac.c
@@ -0,0 +1,137 @@
+/*
+ * md5_hmac.h
+ *
+ * imported from libsylph 2.5.0
+ * by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
+ * 
+ */
+
+/*
+ * LibSylph -- E-Mail client library
+ * Copyright (C) 1999-2006 Hiroyuki Yamamoto
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
+#include <stdio.h>
+#include <string.h>
+
+#include "md5.h"
+#include "md5_hmac.h"
+
+/*
+** Function: md5_hmac_get
+** taken from the file rfc2104.txt
+** originally written by Martin Schaaf <mascha@ma-scha.de>
+** rewritten by Hiroyuki Yamamoto <hiro-y@kcn.ne.jp>
+*/
+static SMD5*
+md5_hmac_get(const unsigned char *text, int text_len,
+	     const unsigned char *key, int key_len)
+{
+	SMD5 *md5;
+	unsigned char k_ipad[64];    /* inner padding -
+			       * key XORd with ipad
+			       */
+	unsigned char k_opad[64];    /* outer padding -
+			       * key XORd with opad
+			       */
+	unsigned char digest[S_GNET_MD5_HASH_LENGTH];
+	int i;
+
+	/* start out by storing key in pads */
+	memset(k_ipad, 0, sizeof k_ipad);
+	memset(k_opad, 0, sizeof k_opad);
+
+	if (key_len > 64) {
+		/* if key is longer than 64 bytes reset it to key=MD5(key) */
+		SMD5 *tmd5;
+
+		tmd5 = s_gnet_md5_new(key, key_len);
+		memcpy(k_ipad, s_gnet_md5_get_digest(tmd5),
+		       S_GNET_MD5_HASH_LENGTH);
+		memcpy(k_opad, s_gnet_md5_get_digest(tmd5),
+		       S_GNET_MD5_HASH_LENGTH);
+		s_gnet_md5_delete(tmd5);
+	} else {
+		memcpy(k_ipad, key, key_len);
+		memcpy(k_opad, key, key_len);
+	}
+
+	/*
+	 * the HMAC_MD5 transform looks like:
+	 *
+	 * MD5(K XOR opad, MD5(K XOR ipad, text))
+	 *
+	 * where K is an n byte key
+	 * ipad is the byte 0x36 repeated 64 times
+	 * opad is the byte 0x5c repeated 64 times
+	 * and text is the data being protected
+	 */
+
+	/* XOR key with ipad and opad values */
+	for (i = 0; i < 64; i++) {
+		k_ipad[i] ^= 0x36;
+		k_opad[i] ^= 0x5c;
+	}
+
+	/*
+	 * perform inner MD5
+	 */
+	md5 = s_gnet_md5_new_incremental();	/* init context for 1st
+						 * pass */
+	s_gnet_md5_update(md5, k_ipad, 64);	/* start with inner pad */
+	s_gnet_md5_update(md5, text, text_len);	/* then text of datagram */
+	s_gnet_md5_final(md5);			/* finish up 1st pass */
+	memcpy(digest, s_gnet_md5_get_digest(md5), S_GNET_MD5_HASH_LENGTH);
+	s_gnet_md5_delete(md5);
+
+	/*
+	 * perform outer MD5
+	 */
+	md5 = s_gnet_md5_new_incremental();	/* init context for 2nd
+						 * pass */
+	s_gnet_md5_update(md5, k_opad, 64);	/* start with outer pad */
+	s_gnet_md5_update(md5, digest, 16);	/* then results of 1st
+						 * hash */
+	s_gnet_md5_final(md5);			/* finish up 2nd pass */
+
+	return md5;
+}
+
+void
+md5_hmac(unsigned char *digest,
+	 const unsigned char *text, int text_len,
+	 const unsigned char *key, int key_len)
+{
+	SMD5 *md5;
+
+	md5 = md5_hmac_get(text, text_len, key, key_len);
+	memcpy(digest, s_gnet_md5_get_digest(md5), S_GNET_MD5_HASH_LENGTH);
+	s_gnet_md5_delete(md5);
+}
+
+void
+md5_hex_hmac(char *hexdigest,
+	     const unsigned char *text, int text_len,
+	     const unsigned char *key, int key_len)
+{
+	SMD5 *md5;
+
+	md5 = md5_hmac_get(text, text_len, key, key_len);
+	s_gnet_md5_copy_string(md5, hexdigest);
+	hexdigest[S_GNET_MD5_HASH_LENGTH * 2] = '\0';
+	s_gnet_md5_delete(md5);
+}
diff --git a/md5_hmac.h b/md5_hmac.h
new file mode 100644
index 0000000..27619af
--- /dev/null
+++ b/md5_hmac.h
@@ -0,0 +1,36 @@
+/*
+ * md5_hmac.h
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
+#ifndef MD5_HMAC_H
+#define MD5_HMAC_H
+
+#include "md5.h"
+
+void md5_hmac(unsigned char *digest, const unsigned char* text, int text_len, const unsigned char* key, int key_len);
+void md5_hex_hmac(char *hexdigest, const unsigned char *text, int text_len, const unsigned char *key, int key_len);
+
+#endif /* MD5_HMAC_H */
-- 
1.7.0.rc1.52.gf7cc2.dirty
