From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/6] cope with multiple line breaks within sideband progress
 messages
Date: Tue, 16 Oct 2007 21:55:46 -0400
Message-ID: <1192586150-13743-3-git-send-email-nico@cam.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
 <1192586150-13743-2-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy9Q-0003Wi-Ta
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936199AbXJQB4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbXJQBz7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:55:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8510 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936190AbXJQBzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:55:55 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ10063X9D2E630@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 21:55:52 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1212.gdb015
In-reply-to: <1192586150-13743-2-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61308>

A single sideband packet may sometimes contain multiple lines of progress
messages, but we prepend "remote: " only to the whole buffer which creates
a messed up display in that case.  Make sure that the "remote: " prefix
is applied to every remote lines.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sideband.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 277fa3c..ab8a1e9 100644
--- a/sideband.c
+++ b/sideband.c
@@ -17,7 +17,7 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 	strcpy(buf, "remote:");
 	while (1) {
 		int band, len;
-		len	= packet_read_line(in_stream, buf+7, LARGE_PACKET_MAX);
+		len = packet_read_line(in_stream, buf+7, LARGE_PACKET_MAX);
 		if (len == 0)
 			break;
 		if (len < 1) {
@@ -35,7 +35,22 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 			return SIDEBAND_REMOTE_ERROR;
 		case 2:
 			buf[7] = ' ';
-			safe_write(err, buf, 8+len);
+			len += 8;
+			while (1) {
+				int brk = 8;
+				while (brk < len) {
+					brk++;
+					if (buf[brk-1] == '\n' ||
+					    buf[brk-1] == '\r')
+						break;
+				}
+				safe_write(err, buf, brk);
+				if (brk < len) {
+					memmove(buf + 8, buf + brk, len - brk);
+					len = len - brk + 8;
+				} else
+					break;
+			}
 			continue;
 		case 1:
 			safe_write(out, buf+8, len);
-- 
1.5.3.4.1212.gdb015
