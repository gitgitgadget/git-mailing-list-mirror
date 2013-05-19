From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/9] for-each-ref: convert to use *_quote_buf instead of _quote_print
Date: Sun, 19 May 2013 17:27:08 +0700
Message-ID: <1368959235-27777-3-git-send-email-pclouds@gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 12:26:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0pB-0006XP-JI
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab3ESK01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:26:27 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:64447 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3ESK0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:26:25 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so4802738pab.6
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iBcYXpTmIsCESWu+vaIq5xdhhhmtY4judtq4dS4dDDk=;
        b=iCKilHe4uMz7tKenrOmwe2S0CL9ksI8vPspxEZlHGpB4D32UOG+EZBpMZ9exlcMkDz
         ptQFyjJk+VX/FlT2vW1t1JPDsboMkYmCWTn0gz6wePA1WsqHeBz6exZ2Y8BF+zMvt8WG
         ygVXiOx/DlY+4nNu8nnhQw7Xq3cBSnVkr1KU0emPwFGTxaKArGZxzkyqGM65iqhBi3yN
         WbBZvloo7qY1bmawYMGb0T2SvbdhZspLFVUdY6wzvdb9joh/NTfIGKKDtuPUoL875tqk
         32X9RVphNGmLs/xMTodJjlROFIx+5odl8A/RwG7FLPKbhyxs2BvyhalO6rMEFkMnipss
         UdHg==
X-Received: by 10.68.171.69 with SMTP id as5mr4305777pbc.123.1368959184646;
        Sun, 19 May 2013 03:26:24 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id wt5sm19200388pbc.38.2013.05.19.03.26.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:26:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:27:34 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224839>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/for-each-ref.c | 14 ++++++++++----
 quote.c                | 44 ++++++++++++++++++++++--------------------=
--
 quote.h                |  6 +++---
 3 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7f059c3..14151b4 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -867,24 +867,30 @@ static void sort_refs(struct ref_sort *sort, stru=
ct refinfo **refs, int num_refs
 static void print_value(struct refinfo *ref, int atom, int quote_style=
)
 {
 	struct atom_value *v;
+	struct strbuf sb_buf =3D STRBUF_INIT;
+	struct strbuf *sb =3D &sb_buf;
 	get_value(ref, atom, &v);
 	switch (quote_style) {
 	case QUOTE_NONE:
 		fputs(v->s, stdout);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_print(stdout, v->s);
+		sq_quote_buf(sb, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_print(stdout, v->s);
+		perl_quote_buf(sb, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_print(stdout, v->s);
+		python_quote_buf(sb, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_print(stdout, v->s);
+		tcl_quote_buf(sb, v->s);
 		break;
 	}
+	if (quote_style !=3D QUOTE_NONE) {
+		fputs(sb->buf, stdout);
+		strbuf_release(sb);
+	}
 }
=20
 static int hex1(char ch)
diff --git a/quote.c b/quote.c
index c67f5d3..e7a240d 100644
--- a/quote.c
+++ b/quote.c
@@ -454,72 +454,72 @@ int unquote_c_style(struct strbuf *sb, const char=
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
1.8.2.83.gc99314b
