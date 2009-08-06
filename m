From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 20:31:47 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908052024081.3390@localhost.localdomain>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain> <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
 <alpine.LFD.2.00.0908052144430.16073@xanadu.home> <alpine.LFD.2.01.0908051902580.3390@localhost.localdomain> <4A7A4BC5.7010106@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, George Spelvin <linux@horizon.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 05:32:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYtiY-0004x0-3G
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 05:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbZHFDc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 23:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbZHFDc3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 23:32:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45381 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753958AbZHFDc2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 23:32:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n763VlrN018200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 20:31:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n763VlRK007208;
	Wed, 5 Aug 2009 20:31:47 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A7A4BC5.7010106@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125025>



On Thu, 6 Aug 2009, Artur Skawina wrote:
> 
> >  #define T_0_19(t) \
> > -	TEMP = SHA_ROT(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
> > -	E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
> > +	TEMP = SHA_ROL(A,5) + (((C^D)&B)^D)     + E + W[t] + 0x5a827999; \
> > +	E = D; D = C; C = SHA_ROR(B, 2); B = A; A = TEMP;
> >  
> >  	T_0_19( 0); T_0_19( 1); T_0_19( 2); T_0_19( 3); T_0_19( 4);
> >  	T_0_19( 5); T_0_19( 6); T_0_19( 7); T_0_19( 8); T_0_19( 9);
> 
> unrolling these otoh is a clear loss (iirc ~10%). 

I can well imagine. The P4 decode bandwidth is abysmal unless you get 
things into the trace cache, and the trace cache is of a very limited 
size.

However, on at least Nehalem, unrolling it all is quite a noticeable win.

The way it's written, I can easily make it do one or the other by just 
turning the macro inside a loop (and we can have a preprocessor flag to 
choose one or the other), but let me work on it a bit more first.

I'm trying to move the htonl() inside the loops (the same way I suggested 
George do with his assembly), and it seems to help a tiny bit. But I may 
be measuring noise.

However, right now my biggest profile hit is on this irritating loop:

	/* Unroll it? */
	for (t = 16; t <= 79; t++)
		W[t] = SHA_ROL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);

and I haven't been able to move _that_ into the other iterations yet.

Here's my micro-optimization update. It does the first 16 rounds (of the 
first 20-round thing) specially, and takes the data directly from the 
input array. I'm _this_ close to breaking the 28s second barrier on 
git-fsck, but not quite yet.

			Linus

---
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] block-sha1: make the 'ntohl()' part of the first SHA1 loop

This helps a teeny bit.  But what I -really- want to do is to avoid the
whole 80-array loop, and do the xor updates as I go along..

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
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
