From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/7] block-sha1: re-use the temporary array as we calculate
 the SHA1
Date: Thu, 6 Aug 2009 08:20:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908060818220.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <alpine.LFD.2.01.0908060814050.3390@localhost.localdomain> <alpine.LFD.2.01.0908060815430.3390@localhost.localdomain> <alpine.LFD.2.01.0908060816550.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:21:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4m6-0002iV-GT
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbZHFPUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbZHFPUk
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:20:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40528 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756027AbZHFPUj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 11:20:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FK8Q8009040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 08:20:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FK8Jn031177;
	Thu, 6 Aug 2009 08:20:08 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908060816550.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125083>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Aug 2009 20:49:41 -0700
Subject: [PATCH 4/7] block-sha1: re-use the temporary array as we calculate the SHA1

The mozilla-SHA1 code did this 80-word array for the 80 iterations.  But
the SHA1 state is really just 512 bits, and you can actually keep it in
a kind of "circular queue" of just 16 words instead.

This requires us to do the xor updates as we go along (rather than as a
pre-phase), but that's really what we want to do anyway.

This gets me really close to the OpenSSL performance on my Nehalem.
Look ma, all C code (ok, there's the rol/ror hack, but that one doesn't
strictly even matter on my Nehalem, it's just a local optimization).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This gets rid of the annoying pre-initialization and its need for that 
extra space. We can dynamically iterate over a 512-bit circular buffer 
instead.

 block-sha1/sha1.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 39a5bbb..80193d4 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -96,9 +96,8 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 {
-	int t;
 	unsigned int A,B,C,D,E,TEMP;
-	unsigned int W[80];
+	unsigned int array[16];
 
 	A = ctx->H[0];
 	B = ctx->H[1];
@@ -107,8 +106,8 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	E = ctx->H[4];
 
 #define T_0_15(t) \
-	TEMP = htonl(data[t]); W[t] = TEMP; \
-	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D)     + E + 0x5a827999; \
+	TEMP = htonl(data[t]); array[t] = TEMP; \
+	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D) + E + 0x5a827999; \
 	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP; \
 
 	T_0_15( 0); T_0_15( 1); T_0_15( 2); T_0_15( 3); T_0_15( 4);
@@ -116,18 +115,21 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	T_0_15(10); T_0_15(11); T_0_15(12); T_0_15(13); T_0_15(14);
 	T_0_15(15);
 
-	/* Unroll it? */
-	for (t = 16; t <= 79; t++)
-		W[t] = SHA_ROL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
+/* This "rolls" over the 512-bit array */
+#define W(x) (array[(x)&15])
+#define SHA_XOR(t) \
+	TEMP = SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1); W(t) = TEMP;
 
 #define T_16_19(t) \
-	TEMP = SHA_ROL(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
+	SHA_XOR(t); \
+	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D) + E + 0x5a827999; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP; \
 
 	T_16_19(16); T_16_19(17); T_16_19(18); T_16_19(19);
 
 #define T_20_39(t) \
-	TEMP = SHA_ROL(A,5) + (B^C^D)           + E + W[t] + 0x6ed9eba1; \
+	SHA_XOR(t); \
+	TEMP += SHA_ROL(A,5) + (B^C^D) + E + 0x6ed9eba1; \
 	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
 	T_20_39(20); T_20_39(21); T_20_39(22); T_20_39(23); T_20_39(24);
@@ -136,7 +138,8 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	T_20_39(35); T_20_39(36); T_20_39(37); T_20_39(38); T_20_39(39);
 
 #define T_40_59(t) \
-	TEMP = SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + E + W[t] + 0x8f1bbcdc; \
+	SHA_XOR(t); \
+	TEMP += SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + E + 0x8f1bbcdc; \
 	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
 	T_40_59(40); T_40_59(41); T_40_59(42); T_40_59(43); T_40_59(44);
@@ -145,7 +148,8 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	T_40_59(55); T_40_59(56); T_40_59(57); T_40_59(58); T_40_59(59);
 
 #define T_60_79(t) \
-	TEMP = SHA_ROL(A,5) + (B^C^D)           + E + W[t] + 0xca62c1d6; \
+	SHA_XOR(t); \
+	TEMP += SHA_ROL(A,5) + (B^C^D) + E + 0xca62c1d6; \
 	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
 	T_60_79(60); T_60_79(61); T_60_79(62); T_60_79(63); T_60_79(64);
-- 
1.6.4.31.g154b2.dirty
