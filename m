From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: block-sha1: improve code on large-register-set machines
Date: Mon, 10 Aug 2009 16:52:07 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 01:52:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaefZ-0001Qg-P1
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 01:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbZHJXwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 19:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZHJXwl
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 19:52:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43051 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750969AbZHJXwk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 19:52:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7ANq7mJ030079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Aug 2009 16:52:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7ANq7kS027404;
	Mon, 10 Aug 2009 16:52:07 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125503>


For x86 performance (especially in 32-bit mode) I added that hack to write 
the SHA1 internal temporary hash using a volatile pointer, in order to get 
gcc to not try to cache the array contents. Because gcc will do all the 
wrong things, and then spill things in insane random ways.

But on architectures like PPC, where you have 32 registers, it's actually 
perfectly reasonable to put the whole temporary array[] into the register 
set, and gcc can do so.

So make the 'volatile unsigned int *' cast be dependent on a 
SMALL_REGISTER_SET preprocessor symbol, and enable it (currently) on just 
x86 and x86-64.  With that, the routine is fairly reasonable even when 
compared to the hand-scheduled PPC version. Ben Herrenschmidt reports on 
a G5:

 * Paulus asm version:       about 3.67s
 * Yours with no change:     about 5.74s
 * Yours without "volatile": about 3.78s

so with this the C version is within about 3% of the asm one.

And add a lot of commentary on what the heck is going on.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I also asked David Miller to test the non-volatile version on Sparc, but I 
suspect it will have the same pattern. ia64 likewise (but I have not asked 
anybody to test).

Of the other architectures, ARM probably would wants SMALL_REGISTER_SET, 
but I suspect the problem there is the htonl() (on little-endian), and 
possibly the unaligned loads - at least on older ARM. The latter is 
something gcc could be taught about, though (the SHA_SRC macro would just 
need to use a pointer that goes through a packed struct member or 
something).

 block-sha1/sha1.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 36da763..9bc8b8a 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -82,6 +82,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 #define SHA_ASM(op, x, n) ({ unsigned int __res; asm(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
 #define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
 #define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
+#define SMALL_REGISTER_SET
 
 #else
 
@@ -93,7 +94,29 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 
 /* This "rolls" over the 512-bit array */
 #define W(x) (array[(x)&15])
-#define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
+
+/*
+ * If you have 32 registers or more, the compiler can (and should)
+ * try to change the array[] accesses into registers. However, on
+ * machines with less than ~25 registers, that won't really work,
+ * and at least gcc will make an unholy mess of it.
+ *
+ * So to avoid that mess which just slows things down, we force
+ * the stores to memory to actually happen (we might be better off
+ * with a 'W(t)=(val);asm("":"+m" (W(t))' there instead, as
+ * suggested by Artur Skawina - that will also make gcc unable to
+ * try to do the silly "optimize away loads" part because it won't
+ * see what the value will be).
+ *
+ * Ben Herrenschmidt reports that on PPC, the C version comes close
+ * to the optimized asm with this (ie on PPC you don't want that
+ * 'volatile', since there are lots of registers).
+ */
+#ifdef SMALL_REGISTER_SET
+  #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
+#else
+  #define setW(x, val) (W(x) = (val))
+#endif
 
 /*
  * Where do we get the source from? The first 16 iterations get it from
