From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 19:08:03 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
 <alpine.LFD.2.00.0908052144430.16073@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 04:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYsPb-0002yY-PX
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 04:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbZHFCIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 22:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbZHFCIw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 22:08:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34140 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750825AbZHFCIv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 22:08:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n762835f012601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 19:08:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n762839V028837;
	Wed, 5 Aug 2009 19:08:03 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0908052144430.16073@xanadu.home>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125020>



On Wed, 5 Aug 2009, Nicolas Pitre wrote:
> 
> Even better is to not shift len at all in SHA_update() but shift 
> ctx->size only at the end in SHA_final().  It is not like if 
> SHA_update() could operate on partial bytes, so counting total bytes 
> instead of total bits is all you need.  This way you need no cast there 
> and make the code slightly faster.

Yeah, I tried it, but it's not noticeable.

The bigger issue seems to be that it's shifter-limited, or that's what I 
take away from my profiles. I suspect it's even _more_ shifter-limited on 
some other micro-architectures, because gcc is being stupid, and generates

	ror $31,%eax

from the "left shift + right shift" combination. It seems to -always- 
generate a "ror", rather than trying to generate 'rot' if the shift count 
would be smaller that way.

And I know _some_ old micro-architectures will literally internally loop 
on the rol/ror counts, so "ror $31" can be _much_ more expensive than "rol 
$1".

That isn't the case on my Nehalem, though. But I can't seem to get gcc to 
generate better code without actually using inline asm..

(So to clarify: this patch makes no difference that I can see to 
performance, but I suspect it could matter on other CPU's like an old 
Pentium or maybe an Atom).

		Linus

---
 block-sha1/sha1.c |   36 ++++++++++++++++++++++++------------
 block-sha1/sha1.h |    2 +-
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 8fd90b0..a45a3de 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -80,7 +80,19 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 		((unsigned int *)hashout)[i] = htonl(ctx->H[i]);
 }
 
-#define SHA_ROT(X,n) (((X) << (n)) | ((X) >> (32-(n))))
+#if defined(__i386__) || defined(__x86_64__)
+
+#define SHA_ASM(op, x, n) ({ unsigned int __res; asm(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
+#define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
+#define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
+
+#else
+
+#define SHA_ROT(X,n)	(((X) << (l)) | ((X) >> (r)))
+#define SHA_ROL(X,n)	SHA_ROT(X,n,32-(n))
+#define SHA_ROR(X,n)	SHA_ROT(X,32-(n),n)
+
+#endif
 
 static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 {
@@ -93,7 +105,7 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 
 	/* Unroll it? */
 	for (t = 16; t <= 79; t++)
-		W[t] = SHA_ROT(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
+		W[t] = SHA_ROL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
 
 	A = ctx->H[0];
 	B = ctx->H[1];
@@ -102,8 +114,8 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	E = ctx->H[4];
 
 #define T_0_19(t) \
-	TEMP = SHA_ROT(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
-	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+	TEMP = SHA_ROL(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
 	T_0_19( 0); T_0_19( 1); T_0_19( 2); T_0_19( 3); T_0_19( 4);
 	T_0_19( 5); T_0_19( 6); T_0_19( 7); T_0_19( 8); T_0_19( 9);
@@ -111,8 +123,8 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	T_0_19(15); T_0_19(16); T_0_19(17); T_0_19(18); T_0_19(19);
 
 #define T_20_39(t) \
-	TEMP = SHA_ROT(A,5) + (B^C^D)           + E + W[t] + 0x6ed9eba1; \
-	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+	TEMP = SHA_ROL(A,5) + (B^C^D)           + E + W[t] + 0x6ed9eba1; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
 	T_20_39(20); T_20_39(21); T_20_39(22); T_20_39(23); T_20_39(24);
 	T_20_39(25); T_20_39(26); T_20_39(27); T_20_39(28); T_20_39(29);
@@ -120,8 +132,8 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	T_20_39(35); T_20_39(36); T_20_39(37); T_20_39(38); T_20_39(39);
 
 #define T_40_59(t) \
-	TEMP = SHA_ROT(A,5) + ((B&C)|(D&(B|C))) + E + W[t] + 0x8f1bbcdc; \
-	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+	TEMP = SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + E + W[t] + 0x8f1bbcdc; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
 	T_40_59(40); T_40_59(41); T_40_59(42); T_40_59(43); T_40_59(44);
 	T_40_59(45); T_40_59(46); T_40_59(47); T_40_59(48); T_40_59(49);
@@ -129,8 +141,8 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	T_40_59(55); T_40_59(56); T_40_59(57); T_40_59(58); T_40_59(59);
 
 #define T_60_79(t) \
-	TEMP = SHA_ROT(A,5) + (B^C^D)           + E + W[t] + 0xca62c1d6; \
-	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
+	TEMP = SHA_ROL(A,5) + (B^C^D)           + E + W[t] + 0xca62c1d6; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
 	T_60_79(60); T_60_79(61); T_60_79(62); T_60_79(63); T_60_79(64);
 	T_60_79(65); T_60_79(66); T_60_79(67); T_60_79(68); T_60_79(69);
