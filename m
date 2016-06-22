Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D662018C
	for <e@80x24.org>; Wed, 22 Jun 2016 05:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbcFVF35 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 01:29:57 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:26101 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbcFVF34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 01:29:56 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 0f2ecea8
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Wed, 22 Jun 2016 07:29:51 +0200 (CEST)
From:	Lukas Fleischer <lfleischer@lfos.de>
To:	git@vger.kernel.org
Cc:	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3] Refactor recv_sideband()
Date:	Wed, 22 Jun 2016 07:29:51 +0200
Message-Id: <20160622052951.8402-1-lfleischer@lfos.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160613195224.13398-1-lfleischer@lfos.de>
References: <20160613195224.13398-1-lfleischer@lfos.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Before this patch, we used character buffer manipulations to split
messages from the sideband at line breaks and insert "remote: " at the
beginning of each line, using the packet size to determine the end of a
message. However, since it is safe to assume that diagnostic messages
from the sideband never contain NUL characters, we can also
NUL-terminate the buffer, use strpbrk() for splitting lines and use
format strings to insert the prefix.

A static strbuf is used for constructing the output which is then
printed using a single write() call, such that the atomicity of the
output is preserved. See 9ac13ec (atomic write for sideband remote
messages, 2006-10-11) for details.

Helped-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
Now using a static strbuf for the output buffer such that the number of
memory allocations is kept to a minimum.

 sideband.c | 98 ++++++++++++++++++++++----------------------------------------
 1 file changed, 34 insertions(+), 64 deletions(-)

diff --git a/sideband.c b/sideband.c
index fde8adc..08b75e2 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,103 +13,73 @@
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
+	static struct strbuf outbuf = STRBUF_INIT;
+	const char *b, *brk;
 
-	memcpy(buf, PREFIX, pf);
+	strbuf_reset(&outbuf);
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
2.9.0

