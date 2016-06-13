From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH] Refactor recv_sideband()
Date: Mon, 13 Jun 2016 21:52:24 +0200
Message-ID: <20160613195224.13398-1-lfleischer@lfos.de>
Cc: Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 21:52:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCXub-0007bK-Be
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 21:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbcFMTwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 15:52:32 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:22566 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964894AbcFMTwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 15:52:31 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 082e0c56
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Mon, 13 Jun 2016 21:52:27 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297242>

Improve the readability of recv_sideband() significantly by replacing
fragile buffer manipulations with more sophisticated format strings.
Also, reorganize the overall control flow, remove some superfluous
variables and replace a custom implementation of strpbrk() with a call
to the standard C library function.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
I had a really hard time reading and understanding this function when I
came up with my last patch. What I ended up with is almost a complete
rewrite of recv_sideband() and I find the end result to be much more
readable than what we have now. Given that this is quite invasive, it
would be good to have some more eyes and opinions...

If you want me to split this patch into smaller changes, please let me
know. However, finding a good way to split this into logical changes
might not be easy given that the new code does not have much in common
with what we had before.

 sideband.c | 94 ++++++++++++++++++++------------------------------------------
 1 file changed, 30 insertions(+), 64 deletions(-)

diff --git a/sideband.c b/sideband.c
index fde8adc..0a078c3 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,103 +13,69 @@
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
 
-#define PREFIX "remote:"
+#define PREFIX "remote: "
 
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
-#define FIX_SIZE 10  /* large enough for any of the above */
-
 int recv_sideband(const char *me, int in_stream, int out)
 {
-	unsigned pf = strlen(PREFIX);
-	unsigned sf;
-	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
-	char *suffix, *term;
-	int skip_pf = 0;
+	const char *term;
+	const char *prefix = PREFIX, *suffix;
+	char buf[LARGE_PACKET_MAX + 1];
+	const char *b, *brk;
 
-	memcpy(buf, PREFIX, pf);
 	term = getenv("TERM");
 	if (isatty(2) && term && strcmp(term, "dumb"))
 		suffix = ANSI_SUFFIX;
 	else
 		suffix = DUMB_SUFFIX;
-	sf = strlen(suffix);
 
 	while (1) {
 		int band, len;
-		len = packet_read(in_stream, NULL, NULL, buf + pf, LARGE_PACKET_MAX, 0);
+		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
 		if (len == 0)
 			break;
 		if (len < 1) {
 			fprintf(stderr, "%s: protocol error: no band designator\n", me);
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
-		band = buf[pf] & 0xff;
+		band = buf[0] & 0xff;
+		buf[len] = '\0';
 		len--;
 		switch (band) {
 		case 3:
-			buf[pf] = ' ';
-			buf[pf+1+len] = '\0';
-			fprintf(stderr, "%s\n", buf);
+			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
 			return SIDEBAND_REMOTE_ERROR;
 		case 2:
-			buf[pf] = ' ';
-			do {
-				char *b = buf;
-				int brk = 0;
-
-				/*
-				 * If the last buffer didn't end with a line
-				 * break then we should not print a prefix
-				 * this time around.
-				 */
-				if (skip_pf) {
-					b += pf+1;
-				} else {
-					len += pf+1;
-					brk += pf+1;
-				}
+			b = buf + 1;
 
-				/* Look for a line break. */
-				for (;;) {
-					brk++;
-					if (brk > len) {
-						brk = 0;
-						break;
-					}
-					if (b[brk-1] == '\n' ||
-					    b[brk-1] == '\r')
-						break;
-				}
+			/*
+			 * Append a suffix to each nonempty line to clear the
+			 * end of the screen line.
+			 */
+			while ((brk = strpbrk(b, "\n\r"))) {
+				int linelen = brk - b;
 
-				/*
-				 * Let's insert a suffix to clear the end
-				 * of the screen line if a line break was
-				 * found.  Also, if we don't skip the
-				 * prefix, then a non-empty string must be
-				 * present too.
-				 */
-				if (brk > (skip_pf ? 0 : (pf+1 + 1))) {
-					char save[FIX_SIZE];
-					memcpy(save, b + brk, sf);
-					b[brk + sf - 1] = b[brk - 1];
-					memcpy(b + brk - 1, suffix, sf);
-					fprintf(stderr, "%.*s", brk + sf, b);
-					memcpy(b + brk, save, sf);
-					len -= brk;
+				if (linelen > 0) {
+					fprintf(stderr, "%s%.*s%s%c", prefix,
+						linelen, b, suffix, *brk);
 				} else {
-					int l = brk ? brk : len;
-					fprintf(stderr, "%.*s", l, b);
-					len -= l;
+					fprintf(stderr, "%s%c", prefix, *brk);
 				}
 
-				skip_pf = !brk;
-				memmove(buf + pf+1, b + brk, len);
-			} while (len);
+				b = brk + 1;
+				prefix = PREFIX;
+			}
+
+			if (*b) {
+				fprintf(stderr, "%s%s", prefix, b);
+				/* Incomplete line, skip the next prefix. */
+				prefix = "";
+			}
 			continue;
 		case 1:
-			write_or_die(out, buf + pf+1, len);
+			write_or_die(out, buf + 1, len);
 			continue;
 		default:
 			fprintf(stderr, "%s: protocol error: bad band #%d\n",
-- 
2.8.3
