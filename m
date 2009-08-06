From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 7/7] block-sha1: get rid of redundant 'lenW' context
Date: Thu, 6 Aug 2009 08:25:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908060824090.3390@localhost.localdomain>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <alpine.LFD.2.01.0908060814050.3390@localhost.localdomain> <alpine.LFD.2.01.0908060815430.3390@localhost.localdomain> <alpine.LFD.2.01.0908060816550.3390@localhost.localdomain>
 <alpine.LFD.2.01.0908060818220.3390@localhost.localdomain> <alpine.LFD.2.01.0908060820110.3390@localhost.localdomain> <alpine.LFD.2.01.0908060822390.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:26:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4rD-0005As-KO
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbZHFP0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756057AbZHFP0H
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:26:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49751 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756014AbZHFP0F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 11:26:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FPj5n009704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 08:25:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FPjUG008248;
	Thu, 6 Aug 2009 08:25:45 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908060822390.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125086>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Aug 2009 07:45:46 -0700
Subject: [PATCH 7/7] block-sha1: get rid of redundant 'lenW' context

.. and simplify the ctx->size logic.

We now count the size in bytes, which means that 'lenW' was always just
the low 6 bits of the total size, so we don't carry it around separately
any more.  And we do the 'size in bits' shift at the end.

Suggested by Nicolas Pitre and linux@horizon.com.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Some final cleanup. Based on two separate discussions yesterday. Trivial 
and doesn't make any difference that I can tell, but definitely the right 
thing to do.

 block-sha1/sha1.c |   17 +++++++----------
 block-sha1/sha1.h |    1 -
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 9a060a6..78dcb0c 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -14,7 +14,6 @@ static void blk_SHA1Block(blk_SHA_CTX *ctx, const unsigned int *data);
 
 void blk_SHA1_Init(blk_SHA_CTX *ctx)
 {
-	ctx->lenW = 0;
 	ctx->size = 0;
 
 	/* Initialize H with the magic constants (see FIPS180 for constants)
@@ -29,9 +28,9 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx)
 
 void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 {
-	int lenW = ctx->lenW;
+	int lenW = ctx->size & 63;
 
-	ctx->size += (unsigned long long) len << 3;
+	ctx->size += len;
 
 	/* Read the data into W and process blocks as they get full
 	 */
@@ -43,7 +42,6 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 		lenW = (lenW + left) & 63;
 		len -= left;
 		data += left;
-		ctx->lenW = lenW;
 		if (lenW)
 			return;
 		blk_SHA1Block(ctx, ctx->W);
@@ -53,10 +51,8 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 		data += 64;
 		len -= 64;
 	}
-	if (len) {
+	if (len)
 		memcpy(ctx->W, data, len);
-		ctx->lenW = len;
-	}
 }
 
 
@@ -68,10 +64,11 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 	/* Pad with a binary 1 (ie 0x80), then zeroes, then length
 	 */
-	padlen[0] = htonl(ctx->size >> 32);
-	padlen[1] = htonl(ctx->size);
+	padlen[0] = htonl(ctx->size >> 29);
+	padlen[1] = htonl(ctx->size << 3);
 
-	blk_SHA1_Update(ctx, pad, 1+ (63 & (55 - ctx->lenW)));
+	i = ctx->size & 63;
+	blk_SHA1_Update(ctx, pad, 1+ (63 & (55 - i)));
 	blk_SHA1_Update(ctx, padlen, 8);
 
 	/* Output hash
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index 7be2d93..c1ae74d 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -7,7 +7,6 @@
 typedef struct {
 	unsigned int H[5];
 	unsigned int W[16];
-	int lenW;
 	unsigned long long size;
 } blk_SHA_CTX;
 
-- 
1.6.4.31.g154b2.dirty
