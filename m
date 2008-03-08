From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/2 v3] renaming quote_path() as quote_path_relative()
Date: Sat,  8 Mar 2008 22:33:35 +0300
Message-ID: <1205004816-28301-1-git-send-email-dpotapov@gmail.com>
References: <7vbq5r5czw.fsf@gitster.siamese.dyndns.org>
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 20:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY4oS-0007J6-Au
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 20:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbYCHTdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 14:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755088AbYCHTdt
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 14:33:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:53031 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbYCHTds (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 14:33:48 -0500
Received: by nf-out-0910.google.com with SMTP id g13so519155nfb.21
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 11:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dJJlVi+ploh9gI7J7vLp2baRoJ41IHXFRB0WU7lyKFM=;
        b=fikVsK8HNdip+ULAUTe8KzZWjr46dNtodYTkki4Cv5H4UBG1mU5qDGNaWq2SsJkdqk9UxA8d7CzttM+kVduTVXWcM4vbwa3/Y3g/4oOju/8I1w2lP2vlPDpmCaUGBcnd3HxEG3v59WGFwcqzr5mv8/ibHGgZPompASzKraqdELk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hWrPQ6NAlFr7uLZ7BlRAsy4MzabtwXoAZp6crDY2ohPguexvIyhGQ6MYEBYUFKZd3dVitVa+wnp4cbkP9ZP1Kl6/BaLWdLTioOczBmvwqLZk6Plrc6po2DgHqC+Rjo2KrE6To/6xTdLxiPCBIFTLnn+VQ1lrZ82Q2PP1JQkRCMc=
Received: by 10.78.122.16 with SMTP id u16mr8614762huc.11.1205004826325;
        Sat, 08 Mar 2008 11:33:46 -0800 (PST)
Received: from localhost ( [85.141.189.14])
        by mx.google.com with ESMTPS id g1sm20364022muf.5.2008.03.08.11.33.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 11:33:42 -0800 (PST)
X-Mailer: git-send-email 1.5.4
In-Reply-To: <7vbq5r5czw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76574>

Based on Junio's suggestion, this patch moves quote_path() from
wt-status.c to quote.c and renames it as quote_path_relative(),
because it is a better name for a public function.

Also, instead of handcrafted quoting, quote_c_style_counted() is now
used, so it will honor core.quotepath specified in configuration.
The whole path is quoted now (as it was before in the scripted version
of git status before it was rewritten in C).

I have put strbuf_setlen() before strbuf_grow(), because otherwise
strbuf_grow() will increase the buffer on top of the context of the
buffer that we discard by setting the buffer length to zero.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

This version of patch has been changed to put in double quotes only
those names that have escaped characters in them.  Names containing
spaces or single quotes are not quoted, but it is consistent with
how all other functions work (for instance, write_name_quotedpfx).

If we want quote names consisting of spaces and single quotes, I will
prepare a separate patch.

 quote.c     |   45 +++++++++++++++++++++++++++++++++++++++++++++
 quote.h     |    4 ++++
 wt-status.c |   47 ++---------------------------------------------
 3 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/quote.c b/quote.c
index 40702f6..133f714 100644
--- a/quote.c
+++ b/quote.c
@@ -260,6 +260,51 @@ extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
+/* quote path as relative to the given prefix */
+char *quote_path_relative(const char *in, int len,
+                          struct strbuf *out, const char *prefix)
+{
+	int needquote = 0;
+
+	if (len < 0)
+		len = strlen(in);
+
+	strbuf_setlen(out, 0);
+	needquote = next_quote_pos (in, len) != len;
+	if (needquote)
+	{
+		strbuf_grow(out, len*3/2);
+		strbuf_addch(out, '"');
+	}
+	else
+		strbuf_grow(out, len);
+
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
+	if (needquote)
+		strbuf_addch(out, '"');
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
