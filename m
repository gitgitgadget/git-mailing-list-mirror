From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 12:41:00 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8pt-0005mv-K6
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbZHFTlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756562AbZHFTlE
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:41:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34659 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756542AbZHFTlD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 15:41:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76Jf0LF031206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 12:41:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76Jf0Jv016647;
	Thu, 6 Aug 2009 12:41:00 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7B2A88.2040602@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125113>



On Thu, 6 Aug 2009, Artur Skawina wrote:
> 
> Oh, i noticed that '-mtune' makes quite a difference, it can change
> the relative performance of the functions significantly, in unobvious
> ways; depending on which cpu gcc tunes for (build config or -mtune);
> some implementations slow down, others become a bit faster.

That probably is mainly true for P4, although it's quite possible that it 
has an effect for just what the register allocator does, and then for 
spilling.

And it looks like _all_ the tweakability is in the spilling. Nothing else 
matters.

How does this patch work for you? It avoids doing that C-level register 
rotation, and instead rotates the register names with the preprocessor.

I realize it's ugly as hell, but it does make it easier for gcc to see 
what's going on.

The patch is against my git patches, but I think it should apply pretty 
much as-is to your sha1bench sources too. Does it make any difference for 
you?

		Linus

---
 block-sha1/sha1.c |  117 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 90 insertions(+), 27 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 78dcb0c..ac47162 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -101,20 +101,20 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 #define SHA_SRC(t) htonl(data[t])
 #define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
 
-#define SHA_ROUND(t, input, fn, constant) \
-	TEMP = input(t); W(t) = TEMP; \
-	TEMP += SHA_ROL(A,5) + (fn) + E + (constant); \
-	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP
+#define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
+	unsigned int TEMP = input(t); W(t) = TEMP; \
+	TEMP += E + SHA_ROL(A,5) + (fn) + (constant); \
+	B = SHA_ROR(B, 2); E = TEMP; } while (0)
 
-#define T_0_15(t)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999 )
-#define T_16_19(t) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999 )
-#define T_20_39(t) SHA_ROUND(t, SHA_MIX, (B^C^D) , 0x6ed9eba1 )
-#define T_40_59(t) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc )
-#define T_60_79(t) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6 )
+#define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
+#define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
+#define T_20_39(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) , 0x6ed9eba1, A, B, C, D, E )
+#define T_40_59(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc, A, B, C, D, E )
+#define T_60_79(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6, A, B, C, D, E )
 
 static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 {
-	unsigned int A,B,C,D,E,TEMP;
+	unsigned int A,B,C,D,E;
 	unsigned int array[16];
 
 	A = ctx->H[0];
@@ -124,31 +124,94 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	E = ctx->H[4];
 
 	/* Round 1 - iterations 0-16 take their input from 'data' */
-	T_0_15( 0); T_0_15( 1); T_0_15( 2); T_0_15( 3); T_0_15( 4);
-	T_0_15( 5); T_0_15( 6); T_0_15( 7); T_0_15( 8); T_0_15( 9);
-	T_0_15(10); T_0_15(11); T_0_15(12); T_0_15(13); T_0_15(14);
-	T_0_15(15);
+	T_0_15( 0, A, B, C, D, E);
+	T_0_15( 1, E, A, B, C, D);
+	T_0_15( 2, D, E, A, B, C);
+	T_0_15( 3, C, D, E, A, B);
+	T_0_15( 4, B, C, D, E, A);
+	T_0_15( 5, A, B, C, D, E);
+	T_0_15( 6, E, A, B, C, D);
+	T_0_15( 7, D, E, A, B, C);
+	T_0_15( 8, C, D, E, A, B);
+	T_0_15( 9, B, C, D, E, A);
+	T_0_15(10, A, B, C, D, E);
+	T_0_15(11, E, A, B, C, D);
+	T_0_15(12, D, E, A, B, C);
+	T_0_15(13, C, D, E, A, B);
+	T_0_15(14, B, C, D, E, A);
+	T_0_15(15, A, B, C, D, E);
 
 	/* Round 1 - tail. Input from 512-bit mixing array */
-	T_16_19(16); T_16_19(17); T_16_19(18); T_16_19(19);
+	T_16_19(16, E, A, B, C, D);
+	T_16_19(17, D, E, A, B, C);
+	T_16_19(18, C, D, E, A, B);
+	T_16_19(19, B, C, D, E, A);
 
 	/* Round 2 */
-	T_20_39(20); T_20_39(21); T_20_39(22); T_20_39(23); T_20_39(24);
-	T_20_39(25); T_20_39(26); T_20_39(27); T_20_39(28); T_20_39(29);
-	T_20_39(30); T_20_39(31); T_20_39(32); T_20_39(33); T_20_39(34);
-	T_20_39(35); T_20_39(36); T_20_39(37); T_20_39(38); T_20_39(39);
+	T_20_39(20, A, B, C, D, E);
+	T_20_39(21, E, A, B, C, D);
+	T_20_39(22, D, E, A, B, C);
+	T_20_39(23, C, D, E, A, B);
+	T_20_39(24, B, C, D, E, A);
+	T_20_39(25, A, B, C, D, E);
+	T_20_39(26, E, A, B, C, D);
+	T_20_39(27, D, E, A, B, C);
+	T_20_39(28, C, D, E, A, B);
+	T_20_39(29, B, C, D, E, A);
+	T_20_39(30, A, B, C, D, E);
+	T_20_39(31, E, A, B, C, D);
+	T_20_39(32, D, E, A, B, C);
+	T_20_39(33, C, D, E, A, B);
+	T_20_39(34, B, C, D, E, A);
+	T_20_39(35, A, B, C, D, E);
+	T_20_39(36, E, A, B, C, D);
+	T_20_39(37, D, E, A, B, C);
+	T_20_39(38, C, D, E, A, B);
+	T_20_39(39, B, C, D, E, A);
 
 	/* Round 3 */
-	T_40_59(40); T_40_59(41); T_40_59(42); T_40_59(43); T_40_59(44);
-	T_40_59(45); T_40_59(46); T_40_59(47); T_40_59(48); T_40_59(49);
-	T_40_59(50); T_40_59(51); T_40_59(52); T_40_59(53); T_40_59(54);
-	T_40_59(55); T_40_59(56); T_40_59(57); T_40_59(58); T_40_59(59);
+	T_40_59(40, A, B, C, D, E);
+	T_40_59(41, E, A, B, C, D);
+	T_40_59(42, D, E, A, B, C);
+	T_40_59(43, C, D, E, A, B);
+	T_40_59(44, B, C, D, E, A);
+	T_40_59(45, A, B, C, D, E);
+	T_40_59(46, E, A, B, C, D);
+	T_40_59(47, D, E, A, B, C);
+	T_40_59(48, C, D, E, A, B);
+	T_40_59(49, B, C, D, E, A);
+	T_40_59(50, A, B, C, D, E);
+	T_40_59(51, E, A, B, C, D);
+	T_40_59(52, D, E, A, B, C);
+	T_40_59(53, C, D, E, A, B);
+	T_40_59(54, B, C, D, E, A);
+	T_40_59(55, A, B, C, D, E);
+	T_40_59(56, E, A, B, C, D);
+	T_40_59(57, D, E, A, B, C);
+	T_40_59(58, C, D, E, A, B);
+	T_40_59(59, B, C, D, E, A);
 
 	/* Round 4 */
-	T_60_79(60); T_60_79(61); T_60_79(62); T_60_79(63); T_60_79(64);
-	T_60_79(65); T_60_79(66); T_60_79(67); T_60_79(68); T_60_79(69);
-	T_60_79(70); T_60_79(71); T_60_79(72); T_60_79(73); T_60_79(74);
-	T_60_79(75); T_60_79(76); T_60_79(77); T_60_79(78); T_60_79(79);
+	T_60_79(60, A, B, C, D, E);
+	T_60_79(61, E, A, B, C, D);
+	T_60_79(62, D, E, A, B, C);
+	T_60_79(63, C, D, E, A, B);
+	T_60_79(64, B, C, D, E, A);
+	T_60_79(65, A, B, C, D, E);
+	T_60_79(66, E, A, B, C, D);
+	T_60_79(67, D, E, A, B, C);
+	T_60_79(68, C, D, E, A, B);
+	T_60_79(69, B, C, D, E, A);
+	T_60_79(70, A, B, C, D, E);
+	T_60_79(71, E, A, B, C, D);
+	T_60_79(72, D, E, A, B, C);
+	T_60_79(73, C, D, E, A, B);
+	T_60_79(74, B, C, D, E, A);
+	T_60_79(75, A, B, C, D, E);
+	T_60_79(76, E, A, B, C, D);
+	T_60_79(77, D, E, A, B, C);
+	T_60_79(78, C, D, E, A, B);
+	T_60_79(79, B, C, D, E, A);
 
 	ctx->H[0] += A;
 	ctx->H[1] += B;
