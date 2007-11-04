From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix display overlap between remote and local progress
Date: Sun, 04 Nov 2007 00:22:42 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711032328490.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 05:22:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoX0k-0006Cv-VU
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 05:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXKDEWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 00:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXKDEWo
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 00:22:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32456 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbXKDEWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 00:22:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQY00DSJS5U9EA0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 04 Nov 2007 00:22:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63343>

It is possible for the remote summary line to be displayed over the 
local progress display line, and therefore that local progress gets 
bumped to the next line.  However, if the progress line is long enough, 
it might not be entirely overwritten by the remote summary line.  This 
creates a messed up display such as:

	remote: Total 310 (delta 160), reused 178 (delta 112)iB/s
	Receiving objects: 100% (310/310), 379.98 KiB | 136 KiB/s, done.

So we have to clear the screen line before displaying the remote message 
to make sure the local progress is not visible anymore on the first 
line.

Yet some Git versions on the remote side might be sending updates to the 
same line and terminate it with \r, and a separate packet with a single 
\n might be sent later when the progress display is done.  This means 
the screen line must *not* be cleared in that case.

Since the sideband code already has to figure out line breaks in the 
received packet to properly prepend the "remote:" prefix, we can easily 
determine if the remote line about to be displayed is empty.  Only when 
it is not then a proper suffix is inserted before the \r or \n to clear 
the end of the screen line.

Also some magic constants related to the prefix length have been 
replaced with a variable, making it similar to the suffix length 
handling.  Since gcc is smart enough to detect that the variable is 
constant there is no impact on the generated code.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/sideband.c b/sideband.c
index ab8a1e9..66385ad 100644
--- a/sideband.c
+++ b/sideband.c
@@ -11,13 +11,19 @@
  * stream, aka "verbose").  A message over band #3 is a signal that
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
+
+#define PREFIX "remote:"
+#define SUFFIX "\e[K"  /* change to "        " if ANSI sequences don't work */ 
+
 int recv_sideband(const char *me, int in_stream, int out, int err)
 {
-	char buf[7 + LARGE_PACKET_MAX + 1];
-	strcpy(buf, "remote:");
+	unsigned pf = strlen(PREFIX);
+	unsigned sf = strlen(SUFFIX);
+	char buf[pf + LARGE_PACKET_MAX + sf + 1];
+	memcpy(buf, PREFIX, pf);
 	while (1) {
 		int band, len;
-		len = packet_read_line(in_stream, buf+7, LARGE_PACKET_MAX);
+		len = packet_read_line(in_stream, buf + pf, LARGE_PACKET_MAX);
 		if (len == 0)
 			break;
 		if (len < 1) {
@@ -25,35 +31,52 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 			safe_write(err, buf, len);
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
-		band = buf[7] & 0xff;
+		band = buf[pf] & 0xff;
 		len--;
 		switch (band) {
 		case 3:
-			buf[7] = ' ';
-			buf[8+len] = '\n';
-			safe_write(err, buf, 8+len+1);
+			buf[pf] = ' ';
+			buf[pf+1+len] = '\n';
+			safe_write(err, buf, pf+1+len+1);
 			return SIDEBAND_REMOTE_ERROR;
 		case 2:
-			buf[7] = ' ';
-			len += 8;
+			buf[pf] = ' ';
+			len += pf+1;
 			while (1) {
-				int brk = 8;
+				int brk = pf+1;
+
+				/* Break the buffer into separate lines. */
 				while (brk < len) {
 					brk++;
 					if (buf[brk-1] == '\n' ||
 					    buf[brk-1] == '\r')
 						break;
 				}
-				safe_write(err, buf, brk);
+
+				/*
+				 * Let's insert a suffix to clear the end
+				 * of the screen line, but only if current
+				 * line data actually contains something.
+				 */
+				if (brk > pf+1 + 1) {
+					char save[sf];
+					memcpy(save, buf + brk, sf);
+					buf[brk + sf - 1] = buf[brk - 1];
+					memcpy(buf + brk - 1, SUFFIX, sf);
+					safe_write(err, buf, brk + sf);
+					memcpy(buf + brk, save, sf);
+				} else
+					safe_write(err, buf, brk);
+
 				if (brk < len) {
-					memmove(buf + 8, buf + brk, len - brk);
-					len = len - brk + 8;
+					memmove(buf + pf+1, buf + brk, len - brk);
+					len = len - brk + pf+1;
 				} else
 					break;
 			}
 			continue;
 		case 1:
-			safe_write(out, buf+8, len);
+			safe_write(out, buf + pf+1, len);
 			continue;
 		default:
 			len = sprintf(buf,
