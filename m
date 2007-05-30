From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix signed range problems with hex conversions
Date: Wed, 30 May 2007 13:09:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705301213450.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 19:09:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtRg0-0006eS-Qv
	for gcvg-git@gmane.org; Wed, 30 May 2007 19:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426AbXE3RJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 13:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757403AbXE3RJ1
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 13:09:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:16752 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbXE3RJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 13:09:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIV00CK26BO1Q20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 30 May 2007 13:09:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48772>

The get_sha1_hex() function is defined as accepting a char array.  
Because the char type is signed by default on many architectures, 
get_sha1_hex() can be passed a pointer to negative chars. This can 
happen with user input containing chars with the top bit set.

Then those chars are passed to hexval() which is defined as accepting an 
unsigned int value. Whenever a signed char is promoted to an int, the 
promotion is always signed and then the result is stored in the unsigned 
int variable.  In the negative char case that means really large 
unsigned int values will result, and then the hexval_table is happily 
indexed with that value.

On 32-bit architectures the large int value will create a wrap-around 
and a byte located somewhere before the hexval_table array in memory 
will be fetched.  Depending on that byte value a bogus SHA1 value could 
be returned.

On 64-bit architectures the large int value will most probably cause a 
segmentation fault.

This patch adds a range test to hexval() in order to prevent this.  Also 
let's index the hexval_table array directly in get_sha1_hex() using 
explicitly unsigned chars to avoid the range test producing faster
code.

While at it, make hexval_table const.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/cache.h b/cache.h
index f675223..30fcaa9 100644
--- a/cache.h
+++ b/cache.h
@@ -359,10 +359,10 @@ extern void *map_sha1_file(const unsigned char *sha1, unsigned long *);
 extern int has_pack_file(const unsigned char *sha1);
 extern int has_pack_index(const unsigned char *sha1);
 
-extern signed char hexval_table[256];
+extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned int c)
 {
-	return hexval_table[c];
+	return (c & ~0xff) ? -1 : hexval_table[c];
 }
 
 /* Convert to/from hex/sha1 representation */
diff --git a/sha1_file.c b/sha1_file.c
index a3637d7..e10fb4b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -33,7 +33,7 @@ const unsigned char null_sha1[20];
 
 static unsigned int sha1_file_open_flag = O_NOATIME;
 
-signed char hexval_table[256] = {
+const signed char hexval_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
@@ -72,11 +72,12 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
 	for (i = 0; i < 20; i++) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+		unsigned char c0 = *hex++;
+		unsigned char c1 = *hex++;
+		unsigned int val = (hexval_table[c0] << 4) | hexval_table[c1];
 		if (val & ~0xff)
 			return -1;
 		*sha1++ = val;
-		hex += 2;
 	}
 	return 0;
 }
