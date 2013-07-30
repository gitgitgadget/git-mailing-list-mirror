From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] for-each-ref, quote: convert *_quote_print -> *_quote_buf
Date: Tue, 30 Jul 2013 14:01:25 +0530
Message-ID: <1375173087-2164-2-git-send-email-artagnon@gmail.com>
References: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 10:35:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V45Oq-0003R2-SO
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 10:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131Ab3G3IfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 04:35:11 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36551 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab3G3IfI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 04:35:08 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so6931006pab.10
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=q6K2ncRBROFIH+z/638+XKh64zYzid0AXcXRe++vaJU=;
        b=wV6fDX5Bh2sysUNzIKR570x85lcAPsc57c8rcTkUs+LDWsOs154BeUEkq3EnLSXhZX
         IAHKZJzQzkFpXhev7hR1r89ZT3rfN5vGDcd/AviXAPOSqBTpf/e5bg02ewL4wk8ZW1D1
         9gG7inEL77CA1UGRSgQtUI43DoBFM89WWu8Qbl+a/+1Z+S5Pc2mhAcD5U1tN8hJVF1j3
         53DTVlUjSFngJHjojmxW0ubWCi3+a6IEwaBbfGH+q2P4vApuQnPwqBYcNmFmz9JbEzLF
         54Nq9oDRSiRdc82O2ifvGlCZpCTknC//4p4HAtr0bexB8Xc1myAKjAUa0Cw0KnIP5CcC
         3jUA==
X-Received: by 10.68.169.97 with SMTP id ad1mr71277396pbc.84.1375173307436;
        Tue, 30 Jul 2013 01:35:07 -0700 (PDT)
Received: from localhost.localdomain ([122.164.159.87])
        by mx.google.com with ESMTPSA id qb15sm25641801pab.13.2013.07.30.01.35.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 01:35:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.4.g4634265
In-Reply-To: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231354>

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
index 5c88081..9fd66c6 100644
--- a/quote.c
+++ b/quote.c
@@ -408,72 +408,72 @@ int unquote_c_style(struct strbuf *sb, const char=
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
index ed110a5..6996ebd 100644
--- a/quote.h
+++ b/quote.h
@@ -68,8 +68,8 @@ extern char *quote_path_relative(const char *in, cons=
t char *prefix,
 			  struct strbuf *out);
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
1.8.4.rc0.4.g4634265
