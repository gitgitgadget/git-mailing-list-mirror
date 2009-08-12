From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/3] block-sha1: split the different "hacks" to be individually
 selected
Date: Wed, 12 Aug 2009 15:46:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908121545530.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJn9-0002Ln-Dh
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbZHLTrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 15:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbZHLTrN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:47:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36176 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZHLTrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:47:13 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOA00F8P49T4X10@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Aug 2009 15:46:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125735>


This is to make it easier for them to be selected individually depending
on the architecture instead of the other way around i.e. having each
architecture select a list of hacks up front.  That makes for clearer
documentation as well.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 block-sha1/sha1.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index c3f1ae5..67c9bd0 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -11,10 +11,16 @@
 
 #if defined(__i386__) || defined(__x86_64__)
 
+/*
+ * Force usage of rol or ror by selecting the one with the smaller constant.
+ * It _can_ generate slightly smaller code (a constant of 1 is special), but
+ * perhaps more importantly it's possibly faster on any uarch that does a
+ * rotate with a loop.
+ */
+
 #define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
 #define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
 #define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
-#define SMALL_REGISTER_SET
 
 #else
 
@@ -24,9 +30,6 @@
 
 #endif
 
-/* This "rolls" over the 512-bit array */
-#define W(x) (array[(x)&15])
-
 /*
  * If you have 32 registers or more, the compiler can (and should)
  * try to change the array[] accesses into registers. However, on
@@ -43,13 +46,23 @@
  * Ben Herrenschmidt reports that on PPC, the C version comes close
  * to the optimized asm with this (ie on PPC you don't want that
  * 'volatile', since there are lots of registers).
+ *
+ * On ARM we get the best code generation by forcing a full memory barrier
+ * between each SHA_ROUND, otherwise gcc happily get wild with spilling and
+ * the stack frame size simply explode and performance goes down the drain.
  */
-#ifdef SMALL_REGISTER_SET
+
+#if defined(__i386__) || defined(__x86_64__)
   #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
+#elif defined(__arm__)
+  #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
 #else
   #define setW(x, val) (W(x) = (val))
 #endif
 
+/* This "rolls" over the 512-bit array */
+#define W(x) (array[(x)&15])
+
 /*
  * Where do we get the source from? The first 16 iterations get it from
  * the input data, the next mix it from the 512-bit array.
-- 
1.6.4.189.g282fa
