From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/15] for-each-ref, quote: convert *_quote_print -> *_quote_buf
Date: Tue,  9 Jul 2013 16:02:12 +0530
Message-ID: <1373365946-9230-2-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHR-0006ku-5X
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab3GIKgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:16 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:37693 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214Ab3GIKgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:15 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so5354965pbc.35
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9HSr7K1qSZ0moM9L0FnuTrA31ITjHxea1wCTlmB+ccI=;
        b=AELVYBC1OdrrfKSzpiFf+6MfnrUV53gtLK/hhsiZTEeib8AX6XCSMRzvIc/o9cCBcR
         q7BYQTA3qUTAvQjjf02o0rXEodrYvAouGG+qDFXE9gl22/fST+zHJaASjCEQAHqangi0
         vlV8TD2rTe8+BXgcR9MXu2qDHbqfC8DTT7NT774VGDAg678bbM2dozDbT27jer6SuEl/
         cGGBJivcPnzpRZDEdOy/a6jik6ZKXPlF0sEq2XSDkcPUlgJR94hjhM2sPgmxwOlAXzAw
         cwTfnEiLTxE/Rvb6TDv68+cadF8R1oUdq9WedMjZZ7TuPhUZxXKnkKc1CD336GlER4vu
         Z5jg==
X-Received: by 10.66.178.174 with SMTP id cz14mr27383264pac.136.1373366174144;
        Tue, 09 Jul 2013 03:36:14 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229930>

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
1.8.3.2.736.g869de25
