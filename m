From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4] Add utf8_fprintf helper which returns correct columns
Date: Fri,  8 Feb 2013 10:10:11 +0800
Message-ID: <4ea03e99bad13e2910b137fd3991951244fa23f1.1360289411.git.worldhello.net@gmail.com>
References: <7va9rho350.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.co>
X-From: git-owner@vger.kernel.org Fri Feb 08 03:10:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3dQO-0006ye-PF
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 03:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab3BHCK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 21:10:26 -0500
Received: from mail-ia0-f171.google.com ([209.85.210.171]:34556 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab3BHCKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 21:10:25 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so3701698iaz.30
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 18:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XnBaxva0ZQ/HaWrWkqsI4Fa5vpzhkARKqBa1FsNJnHU=;
        b=QlvP7XlgFtEHucYgnWn6LO3DJPOj3hw0HUlZKJczQsO7eCndGKyexerI+tyOge/TtL
         hQya//NKXMkNwWiS371HVQpiKt84tC35HQefvZaf+BJpdpkv8nhyr4EdbTeE8ey0FlSz
         khUD82spS0qBXA44IYXoA3qd4gQBIYACNLX9/U6yRarYJ5SbKiRA2iDiSQNVAuBfx5Ci
         TxmjAILoSnI1kYqz8JI83jODSy1RJwuCaYdPGyHKyGjrGmxBkr8r4EZwvlmgaK+bEHOM
         lq6rpAjtbdsXIWTBh6rclsMNIT2PdYKj+aWQyanPzxWZE9tenPmlp4CH42ZEyvIzjHhN
         pWMQ==
X-Received: by 10.50.178.106 with SMTP id cx10mr19093819igc.53.1360289424259;
        Thu, 07 Feb 2013 18:10:24 -0800 (PST)
Received: from localhost.localdomain ([114.248.128.34])
        by mx.google.com with ESMTPS id vb15sm8215893igb.9.2013.02.07.18.10.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 18:10:23 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.368.g917cd65
In-Reply-To: <7va9rho350.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215743>

Since command usages can be translated, they may not align well especia=
lly
when they are translated to CJK. A wrapper utf8_fprintf can help to ret=
urn
the correct columns required.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.c |  5 +++--
 utf8.c          | 22 ++++++++++++++++++++++
 utf8.h          |  1 +
 3 files changed, 26 insertions(+), 2 deletions(-)

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
index a4ee6..05925 100644
--- a/utf8.c
+++ b/utf8.c
@@ -430,6 +430,28 @@ int same_encoding(const char *src, const char *dst=
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
+	/* If no error occurs, returns columns really required with utf8_strw=
idth. */
+	if (0 <=3D columns)
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
1.8.1.1.368.g917cd65
