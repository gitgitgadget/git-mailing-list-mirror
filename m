From: "George Spelvin" <linux@horizon.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: 6 Aug 2009 00:52:03 -0400
Message-ID: <20090806045203.558.qmail@science.horizon.com>
References: <alpine.LFD.2.01.0908052043082.3390@localhost.localdomain>
Cc: git@vger.kernel.org, gitster@pobox.com, linux@horizon.com,
	nico@cam.org
To: art.08.09@gmail.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Thu Aug 06 06:52:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYuxa-00063U-4I
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 06:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbZHFEwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 00:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbZHFEwG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 00:52:06 -0400
Received: from science.horizon.com ([71.41.210.146]:41422 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751263AbZHFEwF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 00:52:05 -0400
Received: (qmail 559 invoked by uid 1000); 6 Aug 2009 00:52:03 -0400
In-Reply-To: <alpine.LFD.2.01.0908052043082.3390@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125039>

On Wed, 5 Aug 2009, Linus Torvalds wrote:
> Oh yes I have.
> 
> Here's the patch that gets me sub-28s git-fsck times. In fact, it gives me 
> sub-27s times. In fact, it's really close to the OpenSSL times.
> 
> And all using plain C.
> 
> Again - this is all on x86-64. I suspect 32-bit code ends up having 
> spills due to register pressure. That said, I did get rid of that big 
> temporary array, and it now basically only uses that 512-bit array as one 
> circular queue.
> 
> 		Linus
> 
> PS. Ok, so my definition of "plain C" is a bit odd. There's nothing plain 
> about it. It's disgusting C preprocessor misuse. But dang, it's kind of 
> fun to abuse the compiler this way.

You're still missing three tricks, which give a slight speedup 
on my machine:

1) (major)
	Instead of reassigning all those variable all the time,
	make the round function
		E += SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + W[t] + 0x8f1bbcdc; \
		B = SHA_ROR(B, 2);
	and rename the variables between rounds.

2 (minor)
	One of the round functions ((B&C)|(D&(B|C))) can be rewritten
		  (B&C) | (C&D) | (D&B)
		= (B&C) | (D&(B|C))
		= (B&C) | (D&(B^C))
		= (B&C) ^ (D&(B^C))
		= (B&C) + (D&(B^C))
	to expose more associativty (and thus scheduling flexibility)
	to the compiler.

3) (minor)
	ctx->lenW is always simply a copy of the low 6 bits of ctx->size,
	so there's no need to bother with it.

Actually, looking at the code, GCC manages to figure out the first
(major) one by itself.  Way to go, GCC authors!

But getting avoiding the extra temporary in trick 2 also gets rid of
some extra REX prefixes, saving 240 bytes in blk_SHA1Block, which is
kind of nice in an inner loop.

Here's my modified version of your earlier code.  I haven't
incoporated the W[] formation into the round functions as in
your latest version.

I'm sure you can bash the two together in very little time.  Or I'll
get to it later; I really should attend to $DAY_JOB at the moment.

diff --git a/Makefile b/Makefile
index daf4296..e6df8ec 100644
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
@@ -1167,6 +1171,10 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
+ifdef BLK_SHA1
+	SHA1_HEADER = "block-sha1/sha1.h"
+	LIB_OBJS += block-sha1/sha1.o
+else
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
@@ -1184,6 +1192,7 @@ else
 endif
 endif
 endif
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
new file mode 100644
index 0000000..261eae7
--- /dev/null
+++ b/block-sha1/sha1.c
@@ -0,0 +1,141 @@
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
+static void blk_SHA1Block(blk_SHA_CTX *ctx, const uint32_t *data);
+
+void blk_SHA1_Init(blk_SHA_CTX *ctx)
+{
+	/* Initialize H with the magic constants (see FIPS180 for constants)
+	 */
+	ctx->H[0] = 0x67452301;
+	ctx->H[1] = 0xefcdab89;
+	ctx->H[2] = 0x98badcfe;
+	ctx->H[3] = 0x10325476;
+	ctx->H[4] = 0xc3d2e1f0;
+	ctx->size = 0;
+}
+
+
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, int len)
+{
+	int lenW = (int)ctx->size & 63;
+
+	ctx->size += len;
+
+	/* Read the data into W and process blocks as they get full
+	 */
+	if (lenW) {
+		int left = 64 - lenW;
+		if (len < left)
+			left = len;
+		memcpy(lenW + (char *)ctx->W, data, left);
+		if (left + lenW != 64)
+			return;
+		len -= left;
+		data += left;
+		blk_SHA1Block(ctx, ctx->W);
+	}
+	while (len >= 64) {
+		blk_SHA1Block(ctx, data);
+		data += 64;
+		len -= 64;
+	}
+	memcpy(ctx->W, data, len);
+}
+
+
+void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
+{
+	int i, lenW = (int)ctx->size & 63;
+
+	/* Pad with a binary 1 (ie 0x80), then zeroes, then length
+	 */
+	((char *)ctx->W)[lenW++] = 0x80;
+	if (lenW > 56) {
+		memset((char *)ctx->W + lenW, 0, 64 - lenW);
+		blk_SHA1Block(ctx, ctx->W);
+		lenW = 0;
+	}
+	memset((char *)ctx->W + lenW, 0, 56 - lenW);
+	ctx->W[14] = htonl(ctx->size >> 29);
+	ctx->W[15] = htonl((uint32_t)ctx->size << 3);
+	blk_SHA1Block(ctx, ctx->W);
+
+	/* Output hash
+	 */
+	for (i = 0; i < 5; i++)
+		((unsigned int *)hashout)[i] = htonl(ctx->H[i]);
+}
+
+/* SHA-1 helper macros */
+#define SHA_ROT(X,n) (((X) << (n)) | ((X) >> (32-(n))))
+#define F1(b,c,d) (((d^c)&b)^d)
+#define F2(b,c,d) (b^c^d)
+/* This version lets the compiler use the fact that + is associative. */
+#define F3(b,c,d) (c&d) + (b & (c^d))
+
+/* The basic SHA-1 round */
+#define ROUND(a, b, c, d, e, f, k, t) \
+	e += SHA_ROT(a,5) + f(b,c,d) + W[t] + k;  b = SHA_ROT(b, 30)
+/* Five SHA-1 rounds */
+#define FIVE(f, k, t) \
+	ROUND(A, B, C, D, E, f, k, t  ); \
+	ROUND(E, A, B, C, D, f, k, t+1); \
+	ROUND(D, E, A, B, C, f, k, t+2); \
+	ROUND(C, D, E, A, B, f, k, t+3); \
+	ROUND(B, C, D, E, A, f, k, t+4)
+
+static void blk_SHA1Block(blk_SHA_CTX *ctx, const uint32_t *data)
+{
+	int t;
+	uint32_t A,B,C,D,E;
+	uint32_t W[80];
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
+	FIVE(F1, 0x5a827999,  0);
+	FIVE(F1, 0x5a827999,  5);
+	FIVE(F1, 0x5a827999, 10);
+	FIVE(F1, 0x5a827999, 15);
+
+	FIVE(F2, 0x6ed9eba1, 20);
+	FIVE(F2, 0x6ed9eba1, 25);
+	FIVE(F2, 0x6ed9eba1, 30);
+	FIVE(F2, 0x6ed9eba1, 35);
+
+	FIVE(F3, 0x8f1bbcdc, 40);
+	FIVE(F3, 0x8f1bbcdc, 45);
+	FIVE(F3, 0x8f1bbcdc, 50);
+	FIVE(F3, 0x8f1bbcdc, 55);
+
+	FIVE(F2, 0xca62c1d6, 60);
+	FIVE(F2, 0xca62c1d6, 65);
+	FIVE(F2, 0xca62c1d6, 70);
+	FIVE(F2, 0xca62c1d6, 75);
+
+	ctx->H[0] += A;
+	ctx->H[1] += B;
+	ctx->H[2] += C;
+	ctx->H[3] += D;
+	ctx->H[4] += E;
+}
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
new file mode 100644
index 0000000..c9dc156
--- /dev/null
+++ b/block-sha1/sha1.h
@@ -0,0 +1,21 @@
+/*
+ * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.h),
+ * optimized to do word accesses rather than byte accesses,
+ * and to avoid unnecessary copies into the context array.
+ */
+ #include <stdint.h>
+
+typedef struct {
+	uint32_t H[5];
+	uint64_t size;
+	uint32_t W[16];
+} blk_SHA_CTX;
+
+void blk_SHA1_Init(blk_SHA_CTX *ctx);
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, int len);
+void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
+
+#define git_SHA_CTX	blk_SHA_CTX
+#define git_SHA1_Init	blk_SHA1_Init
+#define git_SHA1_Update	blk_SHA1_Update
+#define git_SHA1_Final	blk_SHA1_Final
