From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/2] renaming quote_path() as quote_path_relative()
Date: Fri,  7 Mar 2008 04:13:16 +0300
Message-ID: <1204852397-20939-1-git-send-email-dpotapov@gmail.com>
References: <7vr6en8n7k.fsf@gitster.siamese.dyndns.org>
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:14:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXR9t-0008S0-Jv
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 02:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbYCGBNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 20:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbYCGBNV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 20:13:21 -0500
Received: from smtp05.mtu.ru ([62.5.255.52]:63160 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbYCGBNU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 20:13:20 -0500
Received: from smtp05.mtu.ru (localhost [127.0.0.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id CE675A2D12D;
	Fri,  7 Mar 2008 04:13:18 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-168-16.pppoe.mtu-net.ru [85.140.168.16])
	by smtp05.mtu.ru (Postfix) with ESMTP id 51763A2C3FC;
	Fri,  7 Mar 2008 04:13:18 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JXR9B-0005S4-OY; Fri, 07 Mar 2008 04:13:17 +0300
X-Mailer: git-send-email 1.5.4.3.452.g9b9f
In-Reply-To: <7vr6en8n7k.fsf@gitster.siamese.dyndns.org>
X-DCC-STREAM-Metrics: smtp05.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76441>

Based on Junio's suggestion, this patch moves quote_path() from
wt-status.c to quote.c and renames it as quote_path_relative(),
because it is a better name for a public function.

Also, instead of handcrafted quoting, quote_c_style_counted() is now
used, so it will honor core.quotepath specified in configuration.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 quote.c     |   33 +++++++++++++++++++++++++++++++++
 quote.h     |    4 ++++
 wt-status.c |   47 ++---------------------------------------------
 3 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/quote.c b/quote.c
index d061626..84c6f8a 100644
--- a/quote.c
+++ b/quote.c
@@ -260,6 +260,39 @@ extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
+/* quote path as relative to the given prefix */
+char *quote_path_relative(const char *in, int len,
+                          struct strbuf *out, const char *prefix)
+{
+	if (len < 0)
+		len = strlen(in);
+
+	strbuf_grow(out, len);
+	strbuf_setlen(out, 0);
+	if (prefix) {
+		int off = 0;
+		while (prefix[off] && off < len && prefix[off] == in[off])
+			if (prefix[off] == '/') {
+				prefix += off + 1;
+				in += off + 1;
+				len -= off + 1;
+				off = 0;
+			} else
+				off++;
+
+		for (; *prefix; prefix++)
+			if (*prefix == '/')
+				strbuf_addstr(out, "../");
+	}
+
+	quote_c_style_counted (in, len, out, NULL, 1);
+
+	if (!out->len)
+		strbuf_addstr(out, "./");
+
+	return out->buf;
+}
+
 /*
  * C-style name unquoting.
  *
diff --git a/quote.h b/quote.h
index 4da110e..527c152 100644
--- a/quote.h
+++ b/quote.h
@@ -47,6 +47,10 @@ extern void write_name_quoted(const char *name, FILE *, int terminator);
 extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
                                  const char *name, FILE *, int terminator);
 
+/* quote path as relative to the given prefix */
+char *quote_path_relative(const char *in, int len,
+                          struct strbuf *out, const char *prefix);
+
 /* quoting as a string literal for other languages */
 extern void perl_quote_print(FILE *stream, const char *src);
 extern void python_quote_print(FILE *stream, const char *src);
diff --git a/wt-status.c b/wt-status.c
index 32d780a..701d13d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "diffcore.h"
+#include "quote.h"
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
@@ -82,51 +83,7 @@ static void wt_status_print_trailer(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
 
-static char *quote_path(const char *in, int len,
-			struct strbuf *out, const char *prefix)
-{
-	if (len < 0)
-		len = strlen(in);
-
-	strbuf_grow(out, len);
-	strbuf_setlen(out, 0);
-	if (prefix) {
-		int off = 0;
-		while (prefix[off] && off < len && prefix[off] == in[off])
-			if (prefix[off] == '/') {
-				prefix += off + 1;
-				in += off + 1;
-				len -= off + 1;
-				off = 0;
-			} else
-				off++;
-
-		for (; *prefix; prefix++)
-			if (*prefix == '/')
-				strbuf_addstr(out, "../");
-	}
-
-	for ( ; len > 0; in++, len--) {
-		int ch = *in;
-
-		switch (ch) {
-		case '\n':
-			strbuf_addstr(out, "\\n");
-			break;
-		case '\r':
-			strbuf_addstr(out, "\\r");
-			break;
-		default:
-			strbuf_addch(out, ch);
-			continue;
-		}
-	}
-
-	if (!out->len)
-		strbuf_addstr(out, "./");
