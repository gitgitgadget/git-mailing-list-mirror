From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Use adler32() from zlib instead of defining our own.
Date: Sat, 4 Feb 2006 23:54:01 +0100
Message-ID: <20060204225401.GA24725@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 05 00:03:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5WRW-0004e1-TR
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 00:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWBDXDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 18:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWBDXDn
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 18:03:43 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:36799 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S964849AbWBDXDn
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 18:03:43 -0500
Received: (qmail 25031 invoked by uid 5842); 4 Feb 2006 22:54:01 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15609>


Since we already depend on zlib, we don't need to define our
own adler32().  Spotted by oprofile.

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

 diff-delta.c |   39 +--------------------------------------
 1 files changed, 1 insertions(+), 38 deletions(-)

86557e168f581f27b6869a751a56386bbc9e5059
diff --git a/diff-delta.c b/diff-delta.c
index 890986e..c2f656a 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -20,6 +20,7 @@
 
 #include <stdlib.h>
 #include "delta.h"
+#include "zlib.h"
 
 
 /* block size: min = 16, max = 64k, power of 2 */
@@ -30,44 +31,6 @@
 #define GR_PRIME 0x9e370001
 #define HASH(v, b) (((unsigned int)(v) * GR_PRIME) >> (32 - (b)))
 	
-/* largest prime smaller than 65536 */
-#define BASE 65521
-
-/* NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1 */
-#define NMAX 5552
-
-#define DO1(buf, i)  { s1 += buf[i]; s2 += s1; }
-#define DO2(buf, i)  DO1(buf, i); DO1(buf, i + 1);
-#define DO4(buf, i)  DO2(buf, i); DO2(buf, i + 2);
-#define DO8(buf, i)  DO4(buf, i); DO4(buf, i + 4);
-#define DO16(buf)    DO8(buf, 0); DO8(buf, 8);
-
-static unsigned int adler32(unsigned int adler, const unsigned char *buf, int len)
-{
-	int k;
-	unsigned int s1 = adler & 0xffff;
-	unsigned int s2 = adler >> 16;
-
-	while (len > 0) {
-		k = MIN(len, NMAX);
-		len -= k;
-		while (k >= 16) {
-			DO16(buf);
-			buf += 16;
-			k -= 16;
-		}
-		if (k != 0)
-			do {
-				s1 += *buf++;
-				s2 += s1;
-			} while (--k);
-		s1 %= BASE;
-		s2 %= BASE;
-	}
-
-	return (s2 << 16) | s1;
-}
-
 static unsigned int hashbits(unsigned int size)
 {
 	unsigned int val = 1, bits = 0;
-- 
1.1.6.g8655
