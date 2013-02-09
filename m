From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5] Add utf8_fprintf helper that returns correct columns
Date: Sat,  9 Feb 2013 14:31:09 +0800
Message-ID: <618461e2e8e98c48279759138ff2e850629d0e76.1360391274.git.worldhello.net@gmail.com>
References: <51152575.8090507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 07:32:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U43yl-0008A2-Gb
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 07:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792Ab3BIGba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2013 01:31:30 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:47943 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab3BIGb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 01:31:29 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa10so2470243pad.27
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 22:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Hh3DGpwVMDUjNpsdywB40Z0XTqYFpQ19tWIiTcG4Mpc=;
        b=D5K4Mx2BIfE42/TeOTCe6YrmA6VxnodRpzMDwQrGCUCoIW2xOiPcCjNc5R2V3rVUd9
         //piC4DqPvgKofeYmHEB9FNsKL7N+1IKkJUQJb3BapUfF9+H1RlGR0bO6WKcbgdIUCTJ
         02dEIldhmNpdwSSpnMOhvcJht8mUxazXFG79GoT5FWktsTpuZjhFuu9OLAnrXuIQuC+J
         Jx2+llAf/2dbAAabn+Lg44oEt3sF9b9Y4N9j+rC4B+qvSrJyCu0SOVQi0w4+KfYECGOJ
         SzTnEtntIwhw1aYyc/4akzDL9joaY8Fz9t6Ebv+Ftt6cRr2fJpmu+6CbWpKp2d55nrBR
         Pxrg==
X-Received: by 10.66.74.234 with SMTP id x10mr25049066pav.10.1360391488884;
        Fri, 08 Feb 2013 22:31:28 -0800 (PST)
Received: from localhost.localdomain ([114.248.128.34])
        by mx.google.com with ESMTPS id i6sm59603639paw.19.2013.02.08.22.31.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 22:31:27 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.370.gf39fc7e
In-Reply-To: <51152575.8090507@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215851>

Since command usages can be translated, they may include utf-8 encoded
strings, and the output in console may not align well any more. This is
because strlen() is different from strwidth() on utf-8 strings. A wrapp=
er
utf8_fprintf() can help to return the correct columns required.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 parse-options.c |  5 +++--
 utf8.c          | 21 +++++++++++++++++++++
 utf8.h          |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 67e98..a6ce9e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
+#include "utf8.h"
=20
 static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 			       const char * const *usagestr,
@@ -482,7 +483,7 @@ static int usage_argh(const struct option *opts, FI=
LE *outfile)
 			s =3D literal ? "[%s]" : "[<%s>]";
 	else
 		s =3D literal ? " %s" : " <%s>";
-	return fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
+	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("...")=
);
 }
=20
 #define USAGE_OPTS_WIDTH 24
@@ -541,7 +542,7 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
 		if (opts->long_name)
 			pos +=3D fprintf(outfile, "--%s", opts->long_name);
 		if (opts->type =3D=3D OPTION_NUMBER)
-			pos +=3D fprintf(outfile, "-NUM");
+			pos +=3D utf8_fprintf(outfile, _("-NUM"));
=20
 		if ((opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
 		    !(opts->flags & PARSE_OPT_NOARG))
diff --git a/utf8.c b/utf8.c
index a4ee6..c09dc 100644
--- a/utf8.c
+++ b/utf8.c
@@ -430,6 +430,27 @@ int same_encoding(const char *src, const char *dst=
)
 }
=20
 /*
+ * Wrapper for fprintf and returns the total number of columns require=
d
+ * for the printed string, assuming that the string is utf8.
+ */
+int utf8_fprintf(FILE *stream, const char *format, ...)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	va_list arg;
+	int columns;
+
+	va_start (arg, format);
+	strbuf_vaddf(&buf, format, arg);
+	va_end (arg);
+
+	columns =3D fputs(buf.buf, stream);
+	if (0 <=3D columns) /* keep the error from the I/O */
+		columns =3D utf8_strwidth(buf.buf);
+	strbuf_release(&buf);
+	return columns;
+}
+
+/*
  * Given a buffer and its encoding, return it re-encoded
  * with iconv.  If the conversion fails, returns NULL.
  */
diff --git a/utf8.h b/utf8.h
index a2142..501b2 100644
--- a/utf8.h
+++ b/utf8.h
@@ -8,6 +8,7 @@ int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 int same_encoding(const char *, const char *);
+int utf8_fprintf(FILE *, const char *, ...);
=20
 void strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
--=20
1.8.1.1.370.gf39fc7e
