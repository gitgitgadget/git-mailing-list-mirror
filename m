From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Wed, 5 Aug 2009 18:18:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908051800030.3390@localhost.localdomain>
References: <20090805181755.22765.qmail@science.horizon.com> <alpine.LFD.2.01.0908051352280.3390@localhost.localdomain> <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 03:19:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYre5-00077i-DX
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 03:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbZHFBTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 21:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZHFBTp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 21:19:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51664 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753006AbZHFBTo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 21:19:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n761IoiW009144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 18:18:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n761Inh2010913;
	Wed, 5 Aug 2009 18:18:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908051545000.3390@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125016>



On Wed, 5 Aug 2009, Linus Torvalds wrote:
> 
> Timings for "git fsck --full" on the git directory:
> 
>  - Mozilla SHA1 portable C-code (sucky sucky): MOZILLA_SHA1=1
> 
> 	real	0m38.194s
> 	user	0m37.838s
> 	sys	0m0.356s
> 
>  - This code ("half-portable C code"): BLK_SHA1=1
> 
> 	real	0m28.120s
> 	user	0m27.930s
> 	sys	0m0.192s
> 
>  - OpenSSL assembler code:
> 
> 	real	0m26.327s
> 	user	0m26.194s
> 	sys	0m0.136s

Ok, I installed the 32-bit libraries too, to see what it looks like for 
that case. As expected, the compiler is not able to do a great job due to 
it being somewhat register starved, but on the other hand, the old Mozilla 
code did even worse, so..

 - Mozilla SHA:

	real	0m47.063s
	user	0m46.815s
	sys	0m0.252s

 - BLK_SHA1=1

	real	0m34.705s
	user	0m34.394s
	sys	0m0.312s

 - OPENSSL:

	real	0m29.754s
	user	0m29.446s
	sys	0m0.288s

so the tuned asm from OpenSSL does kick ass, but the C code version isn't 
_that_ far away. It's quite a reasonable alternative if you don't have the 
OpenSSL libraries installed, for example.

I note that MINGW does NO_OPENSSL by default, for example, and maybe the 
MINGW people want to test the patch out and enable BLK_SHA1 rather than 
the original Mozilla one.

But while looking at 32-bit issues, I noticed that I really should also 
cast 'len' when shifting it. Otherwise the thing is limited to fairly 
small areas (28 bits - 256MB). This is not just a 32-bit problem ("int" is 
a signed 32-bit thing even in a 64-bit build), but I only noticed it when 
looking at 32-bit issues.

So here's an incremental patch to fix that. 

		Linus

---
 block-sha1/sha1.c |    4 ++--
 block-sha1/sha1.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 8fd90b0..eef32f7 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -27,11 +27,11 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx)
 }
 
 
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, int len)
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 {
 	int lenW = ctx->lenW;
 
-	ctx->size += len << 3;
+	ctx->size += (unsigned long long) len << 3;
 
 	/* Read the data into W and process blocks as they get full
 	 */
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index dbc719f..7be2d93 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -12,7 +12,7 @@ typedef struct {
 } blk_SHA_CTX;
 
 void blk_SHA1_Init(blk_SHA_CTX *ctx);
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, int len);
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, unsigned long len);
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
 
 #define git_SHA_CTX	blk_SHA_CTX
