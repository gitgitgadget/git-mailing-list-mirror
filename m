From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 08:04:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908110758160.3417@localhost.localdomain>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain> <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:05:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Masux-0005OF-Ri
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbZHKPFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 11:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbZHKPFa
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:05:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58095 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751108AbZHKPF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 11:05:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BF4UYk001308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Aug 2009 08:04:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BF4Tnl003425;
	Tue, 11 Aug 2009 08:04:30 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125569>



On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> 
> #define SHA_SRC(t) \
>   ({ unsigned char *__d = (unsigned char *)&data[t]; \
>      (__d[0] << 24) | (__d[1] << 16) | (__d[2] << 8) | (__d[3] << 0); })
> 
> And this provides the exact same performance as the ntohl() based 
> version (4.980s) except that this now cope with unaligned buffers too.

Is it better to do a (conditional) memcpy up front? Or is the byte-based 
one better just because you always end up doing the shifting anyway due to 
most ARM situations being little-endian?

I _suspect_ that most large SHA1 calls from git are pre-aligned. The big 
SHA1 calls are for pack-file verification in fsck, which should all be 
aligned. Same goes for index file integrity checking.

The actual object SHA1 calculations are likely not aligned (we do that 
object header thing), and if you can't do the htonl() any better way I 
guess the byte-based thing is the way to go..

		Linus

---
 block-sha1/sha1.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 9bc8b8a..df27e66 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -25,6 +25,12 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx)
 	ctx->H[4] = 0xc3d2e1f0;
 }
 
+#ifdef REALLY_SLOW_UNALIGNED
+  #define is_unaligned(ptr) (3 & (unsigned long)(ptr))
+#else
+  #define is_unaligned(ptr) 0
+#endif
+
 
 void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 {
@@ -47,7 +53,12 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 		blk_SHA1Block(ctx, ctx->W);
 	}
 	while (len >= 64) {
-		blk_SHA1Block(ctx, data);
+		const unsigned int *block = data;
+		if (is_unaligned(data)) {
+			memcpy(ctx->W, data, 64);
+			block = ctx->W;
+		}
+		blk_SHA1Block(ctx, block);
 		data += 64;
 		len -= 64;
 	}
