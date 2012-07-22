From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] block-sha1: avoid pointer conversion that violates
 alignment constraints
Date: Sun, 22 Jul 2012 18:39:54 -0500
Message-ID: <20120722233954.GA2012@burratino>
References: <20120722233547.GA1978@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 23 01:40:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St5kx-0003Mc-R7
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 01:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab2GVXkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 19:40:04 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48277 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab2GVXkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 19:40:03 -0400
Received: by obbuo13 with SMTP id uo13so8599383obb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1ZHATy8lE0K9GASFkJz1GXpwxbf0nfvMC2GTqZdsW0Q=;
        b=QrMNgX2l/99V3ERCRtC1GiQHSHn7iD8D9nkOpWDgPjbhXhcaenICOpL6A8aX0V/E7Q
         uLyZi0VT/qQI8+r8aWu4IImhJwnHNep5jMVIRPU99TmsBcXYE3Ge5uaSSBpcuf0YjLWQ
         CJoWIjenxj260zMSd5+HgkLYRboChptXtmSdfocPmIlPFvCDU2JpirHLWjb2icZJYI1w
         38P+uKV/vEOzzlKjnTJsOogHya73P1RHsEm8A/5N0QdeVyyEluu3lDgnZkqtclfuN9hC
         FxP8KhOw19hFjRnUjKBlyf5zg1+QIApMsHwaSVG1p7Fc8mqT/VRGSa9H+7Pq5OxVE8Xb
         lP+g==
Received: by 10.50.222.134 with SMTP id qm6mr9010707igc.49.1343000402687;
        Sun, 22 Jul 2012 16:40:02 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id dw5sm4652307igc.6.2012.07.22.16.40.01
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 16:40:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120722233547.GA1978@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201874>

With 660231aa (block-sha1: support for architectures with memory
alignment restrictions, 2009-08-12), blk_SHA1_Update was modified to
access 32-bit chunks of memory one byte at a time on arches that
prefer that:

	#define get_be32(p)    ( \
		(*((unsigned char *)(p) + 0) << 24) | \
		(*((unsigned char *)(p) + 1) << 16) | \
		(*((unsigned char *)(p) + 2) <<  8) | \
		(*((unsigned char *)(p) + 3) <<  0) )

The code previously accessed these values by just using htonl(*p).

Unfortunately, Michael noticed on an Alpha machine that git was using
plain 32-bit reads anyway.  As soon as we convert a pointer to int *,
the compiler can assume that the object pointed to is correctly
aligned as an int (C99 section 6.3.2.3 "pointer conversions"
paragraph 7), and gcc takes full advantage by using a single 32-bit
load, resulting in a whole bunch of unaligned access traps.

So we need to obey the alignment constraints even when only dealing
with pointers instead of actual values.  Do so by changing the type
of 'data' to void *.  This patch renames 'data' to 'block' at the same
time to make sure all references are updated to reflect the new type.

Reported-tested-and-explained-by: Michael Cree <mcree@orcon.net.nz>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---
Changes since v2:

 - fixed explanation of how the alignment assumption shows up in the
   assembler[1]
 - add Linus's ack

[1] http://thread.gmane.org/gmane.comp.version-control.git/201434/focus=201484

 block-sha1/sha1.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index d8934757..10fd94d1 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -100,7 +100,7 @@
  * Where do we get the source from? The first 16 iterations get it from
  * the input data, the next mix it from the 512-bit array.
  */
-#define SHA_SRC(t) get_be32(data + t)
+#define SHA_SRC(t) get_be32((unsigned char *) block + t*4)
 #define SHA_MIX(t) SHA_ROL(W(t+13) ^ W(t+8) ^ W(t+2) ^ W(t), 1)
 
 #define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
@@ -114,7 +114,7 @@
 #define T_40_59(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc, A, B, C, D, E )
 #define T_60_79(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6, A, B, C, D, E )
 
-static void blk_SHA1_Block(blk_SHA_CTX *ctx, const unsigned int *data)
+static void blk_SHA1_Block(blk_SHA_CTX *ctx, const void *block)
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
-- 
1.7.10.4
