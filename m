From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH v2] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 23:00:38 +0200
Message-ID: <20160614210038.31465-1-lfleischer@lfos.de>
References: <20160613195224.13398-1-lfleischer@lfos.de>
Cc: Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 23:00:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCvS7-0007FL-9B
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbcFNVAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:00:47 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:48619 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123AbcFNVAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:00:46 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id eeea5499
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Tue, 14 Jun 2016 23:00:43 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160613195224.13398-1-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297328>

Improve the readability of recv_sideband() significantly by replacing
fragile buffer manipulations with string buffers and more sophisticated
format strings. Note that each line is printed using a single write()
syscall to avoid garbled output when multiple processes write to stderr
in parallel, see 9ac13ec (atomic write for sideband remote messages,
2006-10-11) for details.

Also, reorganize the overall control flow, remove some superfluous
variables and replace a custom implementation of strpbrk() with a call
to the standard C library function.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
Now uses a single write() invocation per line. Thanks to Nicolas and
Junio for bringing 9ac13ec to my attention.

 sideband.c | 97 +++++++++++++++++++++-----------------------------------------
 1 file changed, 33 insertions(+), 64 deletions(-)

diff --git a/sideband.c b/sideband.c
index fde8adc..8340a1b 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,103 +13,72 @@
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
+	const char *term, *suffix;
+	char buf[LARGE_PACKET_MAX + 1];
+	struct strbuf outbuf = STRBUF_INIT;
+	const char *b, *brk;
 
-	memcpy(buf, PREFIX, pf);
+	strbuf_addf(&outbuf, "%s", PREFIX);
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
+					strbuf_addf(&outbuf, "%.*s%s%c",
+						    linelen, b, suffix, *brk);
 				} else {
-					int l = brk ? brk : len;
-					fprintf(stderr, "%.*s", l, b);
-					len -= l;
+					strbuf_addf(&outbuf, "%c", *brk);
 				}
+				xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
+				strbuf_reset(&outbuf);
+				strbuf_addf(&outbuf, "%s", PREFIX);
+
+				b = brk + 1;
+			}
 
-				skip_pf = !brk;
-				memmove(buf + pf+1, b + brk, len);
-			} while (len);
+			if (*b) {
+				xwrite(STDERR_FILENO, outbuf.buf, outbuf.len);
+				/* Incomplete line, skip the next prefix. */
+				strbuf_reset(&outbuf);
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
