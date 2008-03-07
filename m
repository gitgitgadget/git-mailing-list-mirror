From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] renaming quote_path() as quote_path_relative()
Date: Fri, 7 Mar 2008 05:30:58 +0300
Message-ID: <20080307023058.GB5305@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 03:32:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSN9-0005DB-HH
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726AbYCGCbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759426AbYCGCbH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:31:07 -0500
Received: from gv-out-0910.google.com ([216.239.58.189]:50350 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbYCGCbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 21:31:05 -0500
Received: by gv-out-0910.google.com with SMTP id s4so173094gve.37
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 18:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        bh=s6i4e4Re2IMI+hhHXTmI+kBYTIavCGM7HpyaOjGu/vQ=;
        b=io4oc0y83COxG/zQ9/J+zlomuC+MmE2DTQhFKXbuntnuHcYRtHZ53Blkcfbch74CX44/ydX/DQzxdz0J51TgmvjIYdo7fhYEEzBgw3tsU3anprPBHostfAzKGZbq1tqI2ImNhiP+pwcfuV53cVeWXOvZep/eQCpOA/xSz8eoOdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EtA5yrd12DtVOY3keFUHGOfa+Sr6XEOEfn+G48kmVarrWkAP+uOihYCqTosqmxyW0F5KDTOZDmlBYhmP8/rBSZAeK23Jc5c2eIvwjP5opVc3ev3qaKPIf+pcQwxVgbMmzVANWxP7nf6nO8LCWux7iXWAAGBKfuP9/nDFUQGYyS8=
Received: by 10.78.140.17 with SMTP id n17mr1987675hud.43.1204857063195;
        Thu, 06 Mar 2008 18:31:03 -0800 (PST)
Received: from localhost ( [85.140.168.16])
        by mx.google.com with ESMTPS id j10sm4391716muh.16.2008.03.06.18.31.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Mar 2008 18:31:02 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76458>

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
 quote.c     |   35 +++++++++++++++++++++++++++++++++++
 quote.h     |    4 ++++
 wt-status.c |   47 ++---------------------------------------------
 3 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/quote.c b/quote.c
index d061626..722dbd4 100644
--- a/quote.c
+++ b/quote.c
@@ -260,6 +260,41 @@ extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
 	fputc(terminator, fp);
 }
 
+/* quote path as relative to the given prefix */
+char *quote_path_relative(const char *in, int len,
+                          struct strbuf *out, const char *prefix)
+{
+	if (len < 0)
+		len = strlen(in);
+
+	strbuf_setlen(out, 0);
+	strbuf_grow(out, len+2);
+	strbuf_addch(out, '"');
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
+	strbuf_addch(out, '"');
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
