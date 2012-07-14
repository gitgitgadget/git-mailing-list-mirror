From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH maint-1.6.5] block-sha1: avoid unaligned accesses on some
 big-endian systems
Date: Sat, 14 Jul 2012 02:59:06 -0500
Message-ID: <20120714075906.GD3693@burratino>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz>
 <20120714002950.GA3159@burratino>
 <5000CBCA.8020607@orcon.net.nz>
 <20120714021856.GA3062@burratino>
 <50010B84.5030606@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Michael Cree <mcree@orcon.net.nz>
X-From: git-owner@vger.kernel.org Sat Jul 14 09:59:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpxG2-0005gd-8b
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 09:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233Ab2GNH7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 03:59:13 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:56597 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab2GNH7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 03:59:12 -0400
Received: by ghrr11 with SMTP id r11so4220425ghr.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SUi5A1Xjtyel84VfPiUI/w4ugQWYN701Z0sv56mKRj0=;
        b=mQcYeEAGEqB7wmjHLEh3edFenUMk1Kh4UPkeGfVdKFaVvS2n/e6DxscJNmnSYBkUmX
         BBCDqfMGa2HpSPutMCu1dWgxvPtzT/1r/mvDKLe8VI5FoX6tsfOjvCgTCOaSUQ5ft/ZM
         9yNtPR+HO3OT1g7/X/uhWupqs/LRiM9kVBZdzvUxjNkdeY+GVgPDvwbaXQPAThHZBCeW
         lYukWODoMNRrTet9JfLlcRtEB+plIeAVIZAs4MOfQSGw3yaBFSMsESSGyP1KhZ9pbUxE
         j3SLEjR3V+Hm22HksHKZs5KJzAvoBc0c+r0+a5wQT0xS/NI0UBsxtk2RafpdDIY1hvsd
         7DTQ==
Received: by 10.43.85.69 with SMTP id an5mr2410559icc.37.1342252751261;
        Sat, 14 Jul 2012 00:59:11 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ua2sm2577379igb.7.2012.07.14.00.59.09
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Jul 2012 00:59:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50010B84.5030606@orcon.net.nz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201434>

With 660231aa (block-sha1: support for architectures with memory
alignment restrictions, 2009-08-12), blk_SHA1_Update was modified to
work reasonably on RISC-y architectures by accessing 32-bit values one
byte at a time on machines that prefer that:

	#define get_unaligned_be32(p)    ( \
		(*((unsigned char *)(p) + 0) << 24) | \
		(*((unsigned char *)(p) + 1) << 16) | \
		(*((unsigned char *)(p) + 2) <<  8) | \
		(*((unsigned char *)(p) + 3) <<  0) )

Unfortunately, on big-endian architectures, if p is a pointer to
unsigned int then current gcc assumes it is properly aligned and
converts this construct to a 32-bit load.  The result is the same
alignment fault we want to avoid.  Fix it by passing around 'data' as
an unsigned char * instead of unsigned int * to more clearly document
the intended alignment for compilers and humans.

The patch renames 'data' to 'block' to make sure all references are
updated to reflect its new type.

Noticed on an alpha.  Typical ARM systems and other little-endian
arches don't hit this because with the endianness conversion gcc
(rightly) prefers reading one byte at a time even if the pointer is
aligned.

Reported-and-tested-by: Michael Cree <mcree@orcon.net.nz>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Michael Cree wrote[1]:
> On 14/07/12 14:18, Jonathan Nieder wrote:

>> Does this patch help?
>
> Yes, it does!  Unaligned accesses are no longer reported and git is
> running noticeably faster.

Thanks!  Nico, Linus, what do you think?

As Michael mentioned, in the long term it might make sense to tweak
git to always pass aligned pointers and lengths in the 'data' and
'len' arguments to SHA1_Update, but that's an experiment for another
day.

[1] http://bugs.debian.org/681532

 block-sha1/sha1.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index d8934757..4d72e4bc 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -100,7 +100,7 @@
  * Where do we get the source from? The first 16 iterations get it from
  * the input data, the next mix it from the 512-bit array.
  */
-#define SHA_SRC(t) get_be32(data + t)
+#define SHA_SRC(t) get_be32(block + t*4)
 #define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
 
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
@@ -114,7 +114,7 @@
 #define T_40_59(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc, A, B, C, D, E )
 #define T_60_79(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6, A, B, C, D, E )
 
-static void blk_SHA1_Block(blk_SHA_CTX *ctx, const unsigned int *data)
+static void blk_SHA1_Block(blk_SHA_CTX *ctx, const unsigned char *block)
 {
 	unsigned int A,B,C,D,E;
 	unsigned int array[16];
@@ -125,7 +125,7 @@ static void blk_SHA1_Block(blk_SHA_CTX *ctx, const unsigned int *data)
 	D = ctx->H[3];
 	E = ctx->H[4];
 
-	/* Round 1 - iterations 0-16 take their input from 'data' */
+	/* Round 1 - iterations 0-16 take their input from 'block' */
 	T_0_15( 0, A, B, C, D, E);
 	T_0_15( 1, E, A, B, C, D);
 	T_0_15( 2, D, E, A, B, C);
@@ -251,7 +251,7 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 		data = ((const char *)data + left);
 		if (lenW)
 			return;
-		blk_SHA1_Block(ctx, ctx->W);
+		blk_SHA1_Block(ctx, (const unsigned char *) ctx->W);
 	}
 	while (len >= 64) {
 		blk_SHA1_Block(ctx, data);
-- 
1.7.10.4
