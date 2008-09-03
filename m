From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] improve handling of sideband message display
Date: Wed, 03 Sep 2008 15:13:42 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809031458150.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaxol-0005vh-9K
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 21:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbYICTNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 15:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756009AbYICTNu
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 15:13:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18775 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933AbYICTNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 15:13:49 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6M00D6PW2UU3H0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Sep 2008 15:13:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94839>


Currently the code looks for line break characters in order to prepend
"remote: " to every line received as many lines can be sent in a single
chunk.  However the opposite might happen too, i.e. a single message
line split amongst multiple chunks.  This patch adds support for the
later case to avoid displays like:

	remote: Compressing objeremote: cts: 100% (313/313), done.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 sideband.c |   66 +++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/sideband.c b/sideband.c
index b677781..cca3360 100644
--- a/sideband.c
+++ b/sideband.c
@@ -25,6 +25,7 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 	unsigned sf;
 	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
 	char *suffix, *term;
+	int skip_pf = 0;
 
 	memcpy(buf, PREFIX, pf);
 	term = getenv("TERM");
@@ -54,39 +55,58 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 			return SIDEBAND_REMOTE_ERROR;
 		case 2:
 			buf[pf] = ' ';
-			len += pf+1;
-			while (1) {
-				int brk = pf+1;
+			do {
+				char *b = buf;
+				int brk = 0;
 
-				/* Break the buffer into separate lines. */
-				while (brk < len) {
+				/*
+				 * If the last buffer didn't end with a line
+				 * break then we should not print a prefix
+				 * this time around.
+				 */
+				if (skip_pf) {
+					b += pf+1;
+				} else {
+					len += pf+1;
+					brk += pf+1;
+				}
+
+				/* Look for a line break. */
+				for (;;) {
 					brk++;
-					if (buf[brk-1] == '\n' ||
-					    buf[brk-1] == '\r')
+					if (brk > len) {
+						brk = 0;
+						break;
+					}
+					if (b[brk-1] == '\n' ||
+					    b[brk-1] == '\r')
 						break;
 				}
 
 				/*
 				 * Let's insert a suffix to clear the end
-				 * of the screen line, but only if current
-				 * line data actually contains something.
+				 * of the screen line if a line break was
+				 * found.  Also, if we don't skip the
+				 * prefix, then a non-empty string must be
+				 * present too.
 				 */
-				if (brk > pf+1 + 1) {
+				if (brk > (skip_pf ? 0 : (pf+1 + 1))) {
 					char save[FIX_SIZE];
-					memcpy(save, buf + brk, sf);
-					buf[brk + sf - 1] = buf[brk - 1];
-					memcpy(buf + brk - 1, suffix, sf);
-					safe_write(err, buf, brk + sf);
-					memcpy(buf + brk, save, sf);
-				} else
-					safe_write(err, buf, brk);
+					memcpy(save, b + brk, sf);
+					b[brk + sf - 1] = b[brk - 1];
+					memcpy(b + brk - 1, suffix, sf);
+					safe_write(err, b, brk + sf);
+					memcpy(b + brk, save, sf);
+					len -= brk;
+				} else {
+					int l = brk ? brk : len;
+					safe_write(err, b, l);
+					len -= l;
+				}
 
-				if (brk < len) {
-					memmove(buf + pf+1, buf + brk, len - brk);
-					len = len - brk + pf+1;
-				} else
-					break;
-			}
+				skip_pf = !brk;
+				memmove(buf + pf+1, b + brk, len);
+			} while (len);
 			continue;
 		case 1:
 			safe_write(out, buf + pf+1, len);
-- 
1.6.0.1.305.g552e0.dirty
