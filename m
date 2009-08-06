From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/7] block-sha1: make the 'ntohl()' part of the first SHA1
 loop
Date: Thu, 6 Aug 2009 08:18:18 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908060816550.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <alpine.LFD.2.01.0908060814050.3390@localhost.localdomain> <alpine.LFD.2.01.0908060815430.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4je-0001Qz-Ud
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023AbZHFPSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbZHFPSV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:18:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50970 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755923AbZHFPSU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 11:18:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FIJ7Z008762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 08:18:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FIICG028131;
	Thu, 6 Aug 2009 08:18:19 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908060815430.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125082>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Aug 2009 20:28:07 -0700
Subject: [PATCH 3/7] block-sha1: make the 'ntohl()' part of the first SHA1 loop

This helps a teeny bit.  But what I -really- want to do is to avoid the
whole 80-array loop, and do the xor updates as I go along..

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is a pretty trivial one, but it was the first stage to getting rid of 
the annoying 80-word array that not only wastes precious L1 cache, but 
that loop to initialize it was a noticeable cost.

 block-sha1/sha1.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index a45a3de..39a5bbb 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -100,27 +100,31 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	unsigned int A,B,C,D,E,TEMP;
 	unsigned int W[80];
 
-	for (t = 0; t < 16; t++)
-		W[t] = htonl(data[t]);
-
-	/* Unroll it? */
-	for (t = 16; t <= 79; t++)
-		W[t] = SHA_ROL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
-
 	A = ctx->H[0];
 	B = ctx->H[1];
 	C = ctx->H[2];
 	D = ctx->H[3];
 	E = ctx->H[4];
 
-#define T_0_19(t) \
+#define T_0_15(t) \
+	TEMP = htonl(data[t]); W[t] = TEMP; \
+	TEMP += SHA_ROL(A,5) + (((C^D)&B)^D)     + E + 0x5a827999; \
+	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP; \
+
+	T_0_15( 0); T_0_15( 1); T_0_15( 2); T_0_15( 3); T_0_15( 4);
+	T_0_15( 5); T_0_15( 6); T_0_15( 7); T_0_15( 8); T_0_15( 9);
+	T_0_15(10); T_0_15(11); T_0_15(12); T_0_15(13); T_0_15(14);
+	T_0_15(15);
+
+	/* Unroll it? */
+	for (t = 16; t <= 79; t++)
+		W[t] = SHA_ROL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
+
+#define T_16_19(t) \
 	TEMP = SHA_ROL(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
 	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
 
-	T_0_19( 0); T_0_19( 1); T_0_19( 2); T_0_19( 3); T_0_19( 4);
-	T_0_19( 5); T_0_19( 6); T_0_19( 7); T_0_19( 8); T_0_19( 9);
-	T_0_19(10); T_0_19(11); T_0_19(12); T_0_19(13); T_0_19(14);
-	T_0_19(15); T_0_19(16); T_0_19(17); T_0_19(18); T_0_19(19);
+	T_16_19(16); T_16_19(17); T_16_19(18); T_16_19(19);
 
 #define T_20_39(t) \
 	TEMP = SHA_ROL(A,5) + (B^C^D)           + E + W[t] + 0x6ed9eba1; \
-- 
1.6.4.31.g154b2.dirty
