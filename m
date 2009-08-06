From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/7] block-sha1: add new optimized C 'block-sha1' routines
Date: Thu, 6 Aug 2009 08:15:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908060814050.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4h6-00005q-B2
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbZHFPPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbZHFPPl
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:15:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57061 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755866AbZHFPPk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 11:15:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FFd25008484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 08:15:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FFdCt023622;
	Thu, 6 Aug 2009 08:15:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125080>



From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Aug 2009 14:49:32 -0700
Subject: [PATCH 1/7] block-sha1: add new optimized C 'block-sha1' routines

Based ont he mozilla SHA1 routine, but doing the input data accesses a
word at a time and with 'htonl()' instead of loading bytes and shifting.

It requires an architecture that is ok with unaligned 32-bit loads and a
fast htonl().

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Side note: we can get rid of the "arch must support unaligned loads" 
requirement later on by telling the compiler which ones _can_ be 
unaligned. So the limitations aren't all that fundamental, really.

 Makefile          |    9 +++
 block-sha1/sha1.c |  145 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 block-sha1/sha1.h |   21 ++++++++
 3 files changed, 175 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d7669b1..f12024c 100644
--- a/Makefile
+++ b/Makefile
@@ -84,6 +84,10 @@ all::
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+# Define BLK_SHA1 environment variable if you want the C version
+# of the SHA1 that assumes you can do unaligned 32-bit loads and
+# have a fast htonl() function.
+#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -1166,6 +1170,10 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
+ifdef BLK_SHA1
+	SHA1_HEADER = "block-sha1/sha1.h"
+	LIB_OBJS += block-sha1/sha1.o
+else
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
@@ -1183,6 +1191,7 @@ else
 endif
 endif
 endif
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
new file mode 100644
index 0000000..eef32f7
--- /dev/null
+++ b/block-sha1/sha1.c
@@ -0,0 +1,145 @@
+/*
+ * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.c),
+ * optimized to do word accesses rather than byte accesses,
+ * and to avoid unnecessary copies into the context array.
+ */
+
+#include <string.h>
+#include <arpa/inet.h>
+
+#include "sha1.h"
+
+/* Hash one 64-byte block of data */
+static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data);
+
+void blk_SHA1_Init(blk_SHA_CTX *ctx)
+{
+	ctx->lenW = 0;
+	ctx->size = 0;
+
+	/* Initialize H with the magic constants (see FIPS180 for constants)
+	 */
+	ctx->H[0] = 0x67452301;
+	ctx->H[1] = 0xefcdab89;
+	ctx->H[2] = 0x98badcfe;
+	ctx->H[3] = 0x10325476;
+	ctx->H[4] = 0xc3d2e1f0;
+}
+
+
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
+{
+	int lenW = ctx->lenW;
+
+	ctx->size += (unsigned long long) len << 3;
+
+	/* Read the data into W and process blocks as they get full
+	 */
+	if (lenW) {
+		int left = 64 - lenW;
+		if (len < left)
+			left = len;
+		memcpy(lenW + (char *)ctx->W, data, left);
+		lenW = (lenW + left) & 63;
+		len -= left;
+		data += left;
+		ctx->lenW = lenW;
+		if (lenW)
+			return;
+		blk_SHA1Block(ctx, ctx->W);
+	}
+	while (len >= 64) {
+		blk_SHA1Block(ctx, data);
+		data += 64;
+		len -= 64;
+	}
+	if (len) {
+		memcpy(ctx->W, data, len);
+		ctx->lenW = len;
+	}
+}
+
+
+void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
+{
+	static const unsigned char pad[64] = { 0x80 };
+	unsigned int padlen[2];
+	int i;
+
+	/* Pad with a binary 1 (ie 0x80), then zeroes, then length
+	 */
+	padlen[0] = htonl(ctx->size >> 32);
+	padlen[1] = htonl(ctx->size);
+
+	blk_SHA1_Update(ctx, pad, 1+ (63 & (55 - ctx->lenW)));
+	blk_SHA1_Update(ctx, padlen, 8);
+
+	/* Output hash
+	 */
+	for (i = 0; i < 5; i++)
+		((unsigned int *)hashout)[i] = htonl(ctx->H[i]);
+}
+
+#define SHA_ROT(X,n) (((X) << (n)) | ((X) >> (32-(n))))
+
+static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
+{
+	int t;
+	unsigned int A,B,C,D,E,TEMP;
+	unsigned int W[80];
+
+	for (t = 0; t < 16; t++)
+		W[t] = htonl(data[t]);
+
+	/* Unroll it? */
+	for (t = 16; t <= 79; t++)
+		W[t] = SHA_ROT(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
+
+	A = ctx->H[0];
+	B = ctx->H[1];
+	C = ctx->H[2];
+	D = ctx->H[3];
+	E = ctx->H[4];
+
+#define T_0_19(t) \
+	TEMP = SHA_ROT(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
+	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+
+	T_0_19( 0); T_0_19( 1); T_0_19( 2); T_0_19( 3); T_0_19( 4);
+	T_0_19( 5); T_0_19( 6); T_0_19( 7); T_0_19( 8); T_0_19( 9);
+	T_0_19(10); T_0_19(11); T_0_19(12); T_0_19(13); T_0_19(14);
+	T_0_19(15); T_0_19(16); T_0_19(17); T_0_19(18); T_0_19(19);
+
+#define T_20_39(t) \
+	TEMP = SHA_ROT(A,5) + (B^C^D)           + E + W[t] + 0x6ed9eba1; \
+	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+
+	T_20_39(20); T_20_39(21); T_20_39(22); T_20_39(23); T_20_39(24);
+	T_20_39(25); T_20_39(26); T_20_39(27); T_20_39(28); T_20_39(29);
+	T_20_39(30); T_20_39(31); T_20_39(32); T_20_39(33); T_20_39(34);
+	T_20_39(35); T_20_39(36); T_20_39(37); T_20_39(38); T_20_39(39);
+
+#define T_40_59(t) \
+	TEMP = SHA_ROT(A,5) + ((B&C)|(D&(B|C))) + E + W[t] + 0x8f1bbcdc; \
+	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+
+	T_40_59(40); T_40_59(41); T_40_59(42); T_40_59(43); T_40_59(44);
+	T_40_59(45); T_40_59(46); T_40_59(47); T_40_59(48); T_40_59(49);
+	T_40_59(50); T_40_59(51); T_40_59(52); T_40_59(53); T_40_59(54);
+	T_40_59(55); T_40_59(56); T_40_59(57); T_40_59(58); T_40_59(59);
+
+#define T_60_79(t) \
+	TEMP = SHA_ROT(A,5) + (B^C^D)           + E + W[t] + 0xca62c1d6; \
+	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+
+	T_60_79(60); T_60_79(61); T_60_79(62); T_60_79(63); T_60_79(64);
+	T_60_79(65); T_60_79(66); T_60_79(67); T_60_79(68); T_60_79(69);
+	T_60_79(70); T_60_79(71); T_60_79(72); T_60_79(73); T_60_79(74);
+	T_60_79(75); T_60_79(76); T_60_79(77); T_60_79(78); T_60_79(79);
+
+	ctx->H[0] += A;
+	ctx->H[1] += B;
+	ctx->H[2] += C;
+	ctx->H[3] += D;
+	ctx->H[4] += E;
+}
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
new file mode 100644
index 0000000..7be2d93
--- /dev/null
+++ b/block-sha1/sha1.h
@@ -0,0 +1,21 @@
+/*
+ * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.h),
+ * optimized to do word accesses rather than byte accesses,
+ * and to avoid unnecessary copies into the context array.
+ */
+
+typedef struct {
+	unsigned int H[5];
+	unsigned int W[16];
+	int lenW;
+	unsigned long long size;
+} blk_SHA_CTX;
+
+void blk_SHA1_Init(blk_SHA_CTX *ctx);
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, unsigned long len);
+void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
+
+#define git_SHA_CTX	blk_SHA_CTX
+#define git_SHA1_Init	blk_SHA1_Init
+#define git_SHA1_Update	blk_SHA1_Update
+#define git_SHA1_Final	blk_SHA1_Final
-- 
1.6.4.31.g154b2.dirty
