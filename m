From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] improve base85 generated assembly code
Date: Mon, 08 May 2006 11:31:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605081010150.24505@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 17:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd7hb-0007GT-Hc
	for gcvg-git@gmane.org; Mon, 08 May 2006 17:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWEHPbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 11:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWEHPbN
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 11:31:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12973 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932402AbWEHPbM
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 May 2006 11:31:12 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYY002UTDRZ1MT0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 08 May 2006 11:31:12 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19769>

This code is arguably pretty hot, if you use binary patches of course. 
This patch helps gcc generate both smaller and faster code especially in 
the error free path.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/base85.c b/base85.c
index b97f7f9..a9e97f8 100644
--- a/base85.c
+++ b/base85.c
@@ -44,34 +44,38 @@ int decode_85(char *dst, char *buffer, i
 	say2("decode 85 <%.*s>", len/4*5, buffer);
 	while (len) {
 		unsigned acc = 0;
-		int cnt;
-		for (cnt = 0; cnt < 5; cnt++, buffer++) {
-			int ch = *((unsigned char *)buffer);
-			int de = de85[ch];
-			if (!de)
+		int de, cnt = 4;
+		unsigned char ch;
+		do {
+			ch = *buffer++;
+			de = de85[ch];
+			if (--de < 0)
 				return error("invalid base85 alphabet %c", ch);
-			de--;
-			if (cnt == 4) {
-				/*
-				 * Detect overflow.  The largest
-				 * 5-letter possible is "|NsC0" to
-				 * encode 0xffffffff, and "|NsC" gives
-				 * 0x03030303 at this point (i.e.
-				 * 0xffffffff = 0x03030303 * 85).
-				 */
-				if (0x03030303 < acc ||
-				    (0x03030303 == acc && de))
-					error("invalid base85 sequence %.5s",
-					      buffer-3);
-			}
 			acc = acc * 85 + de;
-			say1(" <%08x>", acc);
-		}
+		} while (--cnt);
+		ch = *buffer++;
+		de = de85[ch];
+		if (--de < 0)
+			return error("invalid base85 alphabet %c", ch);
+		/*
+		 * Detect overflow.  The largest
+		 * 5-letter possible is "|NsC0" to
+		 * encode 0xffffffff, and "|NsC" gives
+		 * 0x03030303 at this point (i.e.
+		 * 0xffffffff = 0x03030303 * 85).
+		 */
+		if (0x03030303 < acc ||
+		    0xffffffff - de < (acc *= 85))
+			error("invalid base85 sequence %.5s", buffer-5);
+		acc += de;
 		say1(" %08x", acc);
-		for (cnt = 0; cnt < 4 && len; cnt++, len--) {
-			*dst++ = (acc >> 24) & 0xff;
-			acc = acc << 8;
-		}
+
+		cnt = (len < 4) ? len : 4;
+		len -= cnt;
+		do {
+			acc = (acc << 8) | (acc >> 24);
+			*dst++ = acc;
+		} while (--cnt);
 	}
 	say("\n");
 
@@ -86,15 +90,17 @@ void encode_85(char *buf, unsigned char 
 	while (bytes) {
 		unsigned acc = 0;
 		int cnt;
-		for (cnt = 0; cnt < 4 && bytes; cnt++, bytes--) {
+		for (cnt = 24; cnt >= 0; cnt -= 8) {
 			int ch = *data++;
-			acc |= ch << ((3-cnt)*8);
+			acc |= ch << cnt;
+			if (--bytes == 0)
+				break;
 		}
 		say1(" %08x", acc);
-		for (cnt = 0; cnt < 5; cnt++) {
+		for (cnt = 4; cnt >= 0; cnt--) {
 			int val = acc % 85;
 			acc /= 85;
-			buf[4-cnt] = en85[val];
+			buf[cnt] = en85[val];
 		}
 		buf += 5;
 	}
