Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9C31FE4E
	for <e@80x24.org>; Tue, 28 Jun 2016 04:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbcF1Efv (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 00:35:51 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:36772 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcF1Efv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 00:35:51 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 89e0359f
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Tue, 28 Jun 2016 06:35:41 +0200 (CEST)
From:	Lukas Fleischer <lfleischer@lfos.de>
To:	git@vger.kernel.org
Cc:	Nicolas Pitre <nico@fluxnic.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4] Refactor recv_sideband()
Date:	Tue, 28 Jun 2016 06:35:26 +0200
Message-Id: <20160628043526.19403-1-lfleischer@lfos.de>
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

A strbuf is used for accumulating the output which is then printed using
a single fprintf() call with a single conversion specifier per line,
such that the atomicity of the output is preserved. See 9ac13ec (atomic
write for sideband remote messages, 2006-10-11) for details.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
Changes since v3:
* The new code always frees the strbuf used for the output.
* Switched back to fprintf() to support ANSI codes under Windows.
* Added a comment on the tradeoff between atomicity and Windows support.

 sideband.c | 125 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 54 insertions(+), 71 deletions(-)

diff --git a/sideband.c b/sideband.c
index fde8adc..835d77d 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,111 +13,94 @@
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
+	int retval = 0;
 
-	memcpy(buf, PREFIX, pf);
+	strbuf_addf(&outbuf, "%s", PREFIX);
 	term = getenv("TERM");
 	if (isatty(2) && term && strcmp(term, "dumb"))
 		suffix = ANSI_SUFFIX;
 	else
 		suffix = DUMB_SUFFIX;
-	sf = strlen(suffix);
 
-	while (1) {
+	while (retval == 0) {
 		int band, len;
-		len = packet_read(in_stream, NULL, NULL, buf + pf, LARGE_PACKET_MAX, 0);
+		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
 		if (len == 0)
 			break;
 		if (len < 1) {
 			fprintf(stderr, "%s: protocol error: no band designator\n", me);
-			return SIDEBAND_PROTOCOL_ERROR;
+			retval = SIDEBAND_PROTOCOL_ERROR;
+			break;
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
-			return SIDEBAND_REMOTE_ERROR;
+			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
+			retval = SIDEBAND_REMOTE_ERROR;
+			break;
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
+			 *
+			 * The output is accumulated in a buffer and each line
+			 * is printed to stderr using fprintf() with a single
+			 * conversion specifier. This is a "best effort"
+			 * approach to supporting both inter-process atomicity
+			 * (single conversion specifiers are likely to end up
+			 * in single atomic write() system calls) and the ANSI
+			 * control code emulation under Windows.
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
+				fprintf(stderr, "%.*s", (int)outbuf.len,
+					outbuf.buf);
+				strbuf_reset(&outbuf);
+				strbuf_addf(&outbuf, "%s", PREFIX);
+
+				b = brk + 1;
+			}
 
-				skip_pf = !brk;
-				memmove(buf + pf+1, b + brk, len);
-			} while (len);
-			continue;
+			if (*b)
+				strbuf_addf(&outbuf, "%s", b);
+			break;
 		case 1:
-			write_or_die(out, buf + pf+1, len);
-			continue;
+			write_or_die(out, buf + 1, len);
+			break;
 		default:
 			fprintf(stderr, "%s: protocol error: bad band #%d\n",
 				me, band);
-			return SIDEBAND_PROTOCOL_ERROR;
+			retval = SIDEBAND_PROTOCOL_ERROR;
+			break;
 		}
 	}
-	return 0;
+
+	if (outbuf.len > 0)
+		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
+	strbuf_release(&outbuf);
+	return retval;
 }
 
 /*
-- 
2.9.0

