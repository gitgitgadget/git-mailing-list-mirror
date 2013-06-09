From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 01/15] for-each-ref, quote: convert *_quote_print -> *_quote_buf
Date: Sun,  9 Jun 2013 23:24:20 +0530
Message-ID: <1370800474-8940-2-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:56:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljrF-0006QU-10
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab3FIR4l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:56:41 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45293 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab3FIR4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:38 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so6505527pbb.36
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p1SPs0ZDpAjy4osQ5eoBtH3JCaRDrMV8wlUm/yL9ZXY=;
        b=pv6SGgFI918D2T7cwA0hwo82taf/aCRY+4KrN0UHyrO7XSzsZQuSGDFiUK9jGDVX6e
         YdNBPkkoM/fatKQL837zy2H81iho22Co84qzzZ3dKA9lrROPZXnC/HgdwX0/c8dz/CWT
         0C0iL9vIQy4JxpTFJuBCqii+5Wwf5O9yaSrax3KcSXE+L/zGH2L+4ZW9dEvlO5xYamEg
         /PJwsIrvpSbCgiN6YbKQIWe/3O04Kue4jnygMX+WNLDduPPAAscxqQ26NcPgal8HF35m
         XAaxW9cmisAOTJyA383XmWF12rUnRL+tYmbo562FUV0GDUZw2k4N0eQA3602C+1G98K7
         lV0g==
X-Received: by 10.68.59.98 with SMTP id y2mr6854166pbq.135.1370800598217;
        Sun, 09 Jun 2013 10:56:38 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227058>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

for-each-ref.c:print_value() currently prints values to stdout
immediately using {sq|perl|python|tcl}_quote_print, giving us no
opportunity to do any further processing.  In preparation for getting
print_value() to accept an additional strbuf argument to write to,
convert the *_quote_print functions and callers to *_quote_buf.

[rr: commit message, minor modifications]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 13 +++++++++----
 quote.c                | 44 ++++++++++++++++++++++--------------------=
--
 quote.h                |  6 +++---
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7f059c3..1d4083c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -867,24 +867,29 @@ static void sort_refs(struct ref_sort *sort, stru=
ct refinfo **refs, int num_refs
 static void print_value(struct refinfo *ref, int atom, int quote_style=
)
 {
 	struct atom_value *v;
+	struct strbuf sb =3D STRBUF_INIT;
 	get_value(ref, atom, &v);
 	switch (quote_style) {
 	case QUOTE_NONE:
 		fputs(v->s, stdout);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_print(stdout, v->s);
+		sq_quote_buf(&sb, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_print(stdout, v->s);
+		perl_quote_buf(&sb, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_print(stdout, v->s);
+		python_quote_buf(&sb, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_print(stdout, v->s);
+		tcl_quote_buf(&sb, v->s);
 		break;
 	}
+	if (quote_style !=3D QUOTE_NONE) {
+		fputs(sb.buf, stdout);
+		strbuf_release(&sb);
+	}
 }
=20
 static int hex1(char ch)
diff --git a/quote.c b/quote.c
index 911229f..8c294df 100644
--- a/quote.c
+++ b/quote.c
@@ -463,72 +463,72 @@ int unquote_c_style(struct strbuf *sb, const char=
 *quoted, const char **endp)
=20
 /* quoting as a string literal for other languages */
=20
-void perl_quote_print(FILE *stream, const char *src)
+void perl_quote_buf(struct strbuf *sb, const char *src)
 {
 	const char sq =3D '\'';
 	const char bq =3D '\\';
 	char c;
=20
-	fputc(sq, stream);
+	strbuf_addch(sb, sq);
 	while ((c =3D *src++)) {
 		if (c =3D=3D sq || c =3D=3D bq)
-			fputc(bq, stream);
-		fputc(c, stream);
+			strbuf_addch(sb, bq);
+		strbuf_addch(sb, c);
 	}
-	fputc(sq, stream);
+	strbuf_addch(sb, sq);
 }
=20
-void python_quote_print(FILE *stream, const char *src)
+void python_quote_buf(struct strbuf *sb, const char *src)
 {
 	const char sq =3D '\'';
 	const char bq =3D '\\';
 	const char nl =3D '\n';
 	char c;
=20
-	fputc(sq, stream);
+	strbuf_addch(sb, sq);
 	while ((c =3D *src++)) {
 		if (c =3D=3D nl) {
-			fputc(bq, stream);
-			fputc('n', stream);
+			strbuf_addch(sb, bq);
+			strbuf_addch(sb, 'n');
 			continue;
 		}
 		if (c =3D=3D sq || c =3D=3D bq)
-			fputc(bq, stream);
-		fputc(c, stream);
+			strbuf_addch(sb, bq);
+		strbuf_addch(sb, c);
 	}
-	fputc(sq, stream);
+	strbuf_addch(sb, sq);
 }
=20
-void tcl_quote_print(FILE *stream, const char *src)
+void tcl_quote_buf(struct strbuf *sb, const char *src)
 {
 	char c;
=20
-	fputc('"', stream);
+	strbuf_addch(sb, '"');
 	while ((c =3D *src++)) {
 		switch (c) {
 		case '[': case ']':
 		case '{': case '}':
 		case '$': case '\\': case '"':
-			fputc('\\', stream);
+			strbuf_addch(sb, '\\');
 		default:
-			fputc(c, stream);
+			strbuf_addch(sb, c);
 			break;
 		case '\f':
-			fputs("\\f", stream);
+			strbuf_addstr(sb, "\\f");
 			break;
 		case '\r':
-			fputs("\\r", stream);
+			strbuf_addstr(sb, "\\r");
 			break;
 		case '\n':
-			fputs("\\n", stream);
+			strbuf_addstr(sb, "\\n");
 			break;
 		case '\t':
-			fputs("\\t", stream);
+			strbuf_addstr(sb, "\\t");
 			break;
 		case '\v':
-			fputs("\\v", stream);
+			strbuf_addstr(sb, "\\v");
 			break;
 		}
 	}
-	fputc('"', stream);
+	strbuf_addch(sb, '"');
 }
diff --git a/quote.h b/quote.h
index 133155a..ed06df5 100644
--- a/quote.h
+++ b/quote.h
@@ -69,8 +69,8 @@ extern char *quote_path_relative(const char *in, int =
len,
 			  struct strbuf *out, const char *prefix);
=20
 /* quoting as a string literal for other languages */
-extern void perl_quote_print(FILE *stream, const char *src);
-extern void python_quote_print(FILE *stream, const char *src);
-extern void tcl_quote_print(FILE *stream, const char *src);
+extern void perl_quote_buf(struct strbuf *sb, const char *src);
+extern void python_quote_buf(struct strbuf *sb, const char *src);
+extern void tcl_quote_buf(struct strbuf *sb, const char *src);
=20
 #endif
--=20
1.8.3.247.g485169c
