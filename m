From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/7] block-sha1: macroize the rounds a bit further
Date: Thu, 6 Aug 2009 08:22:33 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908060820110.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <alpine.LFD.2.01.0908060814050.3390@localhost.localdomain> <alpine.LFD.2.01.0908060815430.3390@localhost.localdomain> <alpine.LFD.2.01.0908060816550.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908060818220.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4o8-0003g3-S0
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbZHFPWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756016AbZHFPWz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:22:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56106 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756008AbZHFPWy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 11:22:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FMX1B009305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 08:22:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FMXIC002766;
	Thu, 6 Aug 2009 08:22:33 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908060818220.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125084>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Aug 2009 07:20:54 -0700
Subject: [PATCH 5/7] block-sha1: macroize the rounds a bit further

Avoid repeating the shared parts of the different rounds by adding a
macro layer or two. It was already more cpp than C.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This makes things denser, and puts all the core rules in one place. That 
first hunk really contains just about all of the important parts of SHA1. 
The rest is just fluff and the necessary expansions etc.

 block-sha1/sha1.c |   56 ++++++++++++++++++++++++----------------------------
 1 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 80193d4..4837d58 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -94,6 +94,27 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 #endif
 
+/* This "rolls" over the 512-bit array */
+#define W(x) (array[(x)&15])
+
+/*
+ * Where do we get the source from? The first 16 iterations get it from
+ * the input data, the next mix it from the 512-bit array.
+ */
+#define SHA_SRC(t) htonl(data[t])
+#define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
+
+#define SHA_ROUND(t, input, fn, constant) \
+	TEMP = input(t); W(t) = TEMP; \
+	TEMP += SHA_ROL(A,5) + (fn) + E + (constant); \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP
+
+#define T_0_15(t)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999 )
+#define T_16_19(t) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999 )
+#define T_20_39(t) SHA_ROUND(t, SHA_MIX, (B^C^D) , 0x6ed9eba1 )
+#define T_40_59(t) SHA_ROUND(t, SHA_MIX, ((B&C)|(D&(B|C))) , 0x8f1bbcdc )
+#define T_60_79(t) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6 )
+
 static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 {
 	unsigned int A,B,C,D,E,TEMP;
@@ -105,53 +126,28 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	D = ctx->H[3];
 	E = ctx->H[4];
 
-#define T_0_15(t) \
-	TEMP = htonl(data[t]); array[t] = TEMP; \
-	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D) + E + 0x5a827999; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP; \
-
+	/* Round 1 - iterations 0-16 take their input from 'data' */
 	T_0_15( 0); T_0_15( 1); T_0_15( 2); T_0_15( 3); T_0_15( 4);
 	T_0_15( 5); T_0_15( 6); T_0_15( 7); T_0_15( 8); T_0_15( 9);
 	T_0_15(10); T_0_15(11); T_0_15(12); T_0_15(13); T_0_15(14);
 	T_0_15(15);
 
-/* This "rolls" over the 512-bit array */
-#define W(x) (array[(x)&15])
-#define SHA_XOR(t) \
-	TEMP = SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1); W(t) = TEMP;
-
-#define T_16_19(t) \
-	SHA_XOR(t); \
-	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D) + E + 0x5a827999; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP; \
-
+	/* Round 1 - tail. Input from 512-bit mixing array */
 	T_16_19(16); T_16_19(17); T_16_19(18); T_16_19(19);
 
-#define T_20_39(t) \
-	SHA_XOR(t); \
-	TEMP += SHA_ROL(A,5) + (B^C^D) + E + 0x6ed9eba1; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
-
+	/* Round 2 */
 	T_20_39(20); T_20_39(21); T_20_39(22); T_20_39(23); T_20_39(24);
 	T_20_39(25); T_20_39(26); T_20_39(27); T_20_39(28); T_20_39(29);
 	T_20_39(30); T_20_39(31); T_20_39(32); T_20_39(33); T_20_39(34);
 	T_20_39(35); T_20_39(36); T_20_39(37); T_20_39(38); T_20_39(39);
 
-#define T_40_59(t) \
-	SHA_XOR(t); \
-	TEMP += SHA_ROL(A,5) + ((B&C)|(D&(B|C))) + E + 0x8f1bbcdc; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
-
+	/* Round 3 */
 	T_40_59(40); T_40_59(41); T_40_59(42); T_40_59(43); T_40_59(44);
 	T_40_59(45); T_40_59(46); T_40_59(47); T_40_59(48); T_40_59(49);
 	T_40_59(50); T_40_59(51); T_40_59(52); T_40_59(53); T_40_59(54);
 	T_40_59(55); T_40_59(56); T_40_59(57); T_40_59(58); T_40_59(59);
 
-#define T_60_79(t) \
-	SHA_XOR(t); \
-	TEMP += SHA_ROL(A,5) + (B^C^D) + E + 0xca62c1d6; \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
-
+	/* Round 4 */
 	T_60_79(60); T_60_79(61); T_60_79(62); T_60_79(63); T_60_79(64);
 	T_60_79(65); T_60_79(66); T_60_79(67); T_60_79(68); T_60_79(69);
 	T_60_79(70); T_60_79(71); T_60_79(72); T_60_79(73); T_60_79(74);
-- 
1.6.4.31.g154b2.dirty
