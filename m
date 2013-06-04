From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/15] for-each-ref, quote: convert *_quote_print -> *_quote_buf
Date: Tue,  4 Jun 2013 18:05:23 +0530
Message-ID: <1370349337-20938-2-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRE-0006cZ-3E
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624Ab3FDMdz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:33:55 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38907 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab3FDMdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:33:53 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so175002pdj.10
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WH+b+9P9zkNqgVV9f5I0JcdfhTjWUxVwLgxysrYe6CI=;
        b=NJAcokBs3VHUWyG0+P8MXyF59nQdz02fsfyABCxoYUxJ3DfOA2nBzCA54XlDkqB4LP
         RviVg9SoUKkzs5/JtqkTHbvJFAvJiOoPx+4Tb9mhZ84pfC+wXl3xqCFPbcRHGteIJhJ6
         4yk9v5kd/0AOYzBXvL3J1riTGTWZqs6u6lLYuDZ+ZXuf9joz7yitlDPvzlhNQYm45ZQt
         RV2E0z+9qqbVBMXi28tOoWh0RVqAPDAamBGcWigEes9LztAjPF849elKT7m8Lk2MXqjd
         I84/5vl7lRKqjFQqTqqAFVIoGiOUwDYXjE/GDuWIR7neg3vDmlBAGLcezMdJigCTo5O7
         RO0g==
X-Received: by 10.66.172.197 with SMTP id be5mr29259908pac.50.1370349232472;
        Tue, 04 Jun 2013 05:33:52 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.33.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:33:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226345>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

for-each-ref.c:print_value() currently prints values to stdout
immediately using {sq|perl|python|tcl}_quote_print, giving us no
opportunity to do any further processing.  In preparation for getting
print_value() to accept an additional strbuf argument to write to,
convert the *_quote_print functions and callers to *_quote_buf.

[rr: commit message, minor modifications]

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
1.8.3.GIT
