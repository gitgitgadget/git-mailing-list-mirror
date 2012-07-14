From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH maint-1.6.5 v2] block-sha1: avoid pointer conversion that
 violates alignment constraints
Date: Sat, 14 Jul 2012 15:50:49 -0500
Message-ID: <20120714205049.GA28502@burratino>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz>
 <20120714002950.GA3159@burratino>
 <5000CBCA.8020607@orcon.net.nz>
 <20120714021856.GA3062@burratino>
 <50010B84.5030606@orcon.net.nz>
 <20120714075906.GD3693@burratino>
 <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Cree <mcree@orcon.net.nz>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:51:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq9Iu-0001FD-9w
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 22:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab2GNUvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 16:51:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60542 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2GNUu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 16:50:58 -0400
Received: by obbuo13 with SMTP id uo13so6924257obb.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FXwMXLaWEnTGvg5o8/Tcdp/B/kr5gGNHK143iY2jLUM=;
        b=qd9PoJregVjP3DLuBQTC+JVq/20qxiIlRw7+uv+v+lLwkg3YdiRGEDt50OYLsx0WDU
         k7cO/8h+P5kKVrVp61nttcH4jQiBAks0OIWp9AO4SaetoU0b5nBbdUUnc8UanfVjeWfL
         KTvlIk9lL1Ef+k9RkCnh26SsXL/CFFBlscQ1jkrD/zg/nY9KEk7tlJc071Gui6hM0SDv
         zfR5EXLPrTayw3UJZK9bRBMJl5NanPEmOAhE3JJ4Zs+jwbFn2Ym0L8VCczQlOrIe1U/Y
         VEyGFA3igZwnTqi9m+fJ/wJG+TzLhZcijI5kzUyb44rpgiaRHVYrKTbbGM6vCAd7J6I5
         wjcw==
Received: by 10.50.135.1 with SMTP id po1mr1978978igb.67.1342299057931;
        Sat, 14 Jul 2012 13:50:57 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id qo3sm10023044igc.8.2012.07.14.13.50.57
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Jul 2012 13:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201456>

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
paragraph 7), and gcc takes full advantage by converting the get_be32
calls back to a load and bswap and producing a whole bunch of
unaligned access traps.

So we need to obey the alignment constraints even when only dealing
with pointers instead of actual values.  Do so by changing the type
of 'data' to void *.  This patch renames 'data' to 'block' at the same
time to make sure all references are updated to reflect the new type.

Reported-and-tested-by: Michael Cree <mcree@orcon.net.nz>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Linus Torvalds wrote:

> Anyway, the whole "noticed on alpha" makes no sense, since alpha isn't
> even big-endian.

Thanks again for catching that.  Here's a reroll.

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
