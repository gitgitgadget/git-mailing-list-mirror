From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 02/15] for-each-ref: don't print out elements directly
Date: Sun,  9 Jun 2013 23:24:21 +0530
Message-ID: <1370800474-8940-3-git-send-email-artagnon@gmail.com>
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
	id 1UljrF-0006QU-NA
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab3FIR4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:56:43 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47918 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3FIR4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:41 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so3817939pad.37
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3Nsq+ExbGSLVHCh2yoc4vcuTED3Hm3n5CzvHllmiUq8=;
        b=OidrhdwIH9t3aSkR5Jy57biuF9hz6i08Mslq9HW+7LpuAoNf41L9GGoJBb7TLw5P3N
         p9JMtz6WMCXym+5W3NLqOpC1npXBJG1jr85zlSTuSJXbVKvg14YZG+H7GWZpcWZgLj3O
         ADqDD9AYWymhz618HBfX/edHXmYhPmtyw4x4IjKjAtJmspnnTnxoMujNXpV28YeJx4RM
         N+ZGTo8IPHmo7sgQ0/9XiL//E8XjFFYgh46g6RcUrvQHcufM8gv4TgE4oDNMf6tmCD9D
         lpyDRD5oF9ACBXo8U6yxSlIZ8nHijxcKUOO3dChxYgtOfGF9+Jozn8+wSAQzJUPu8O6a
         NuSg==
X-Received: by 10.68.164.196 with SMTP id ys4mr6798923pbb.170.1370800600684;
        Sun, 09 Jun 2013 10:56:40 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227060>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Currently, the entire callchain starting from show_ref() parses and
prints immediately.  This inflexibility limits our ability to extend th=
e
parser.  So, convert the entire callchain to accept a strbuf argument t=
o
write to.  Also introduce a show_refs() helper that calls show_ref() in
a loop to avoid cluttering up cmd_for_each_ref() with the task of
initializing/freeing the strbuf.

[rr: commit message]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/for-each-ref.c | 55 ++++++++++++++++++++++++++++++++----------=
--------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1d4083c..e2d6c5a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -864,31 +864,31 @@ static void sort_refs(struct ref_sort *sort, stru=
ct refinfo **refs, int num_refs
 	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
 }
=20
-static void print_value(struct refinfo *ref, int atom, int quote_style=
)
+static void print_value(struct strbuf *sb, struct refinfo *ref,
+			int atom, int quote_style)
 {
 	struct atom_value *v;
-	struct strbuf sb =3D STRBUF_INIT;
 	get_value(ref, atom, &v);
 	switch (quote_style) {
 	case QUOTE_NONE:
-		fputs(v->s, stdout);
+		strbuf_addstr(sb, v->s);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(&sb, v->s);
+		sq_quote_buf(sb, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(&sb, v->s);
+		perl_quote_buf(sb, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(&sb, v->s);
+		python_quote_buf(sb, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(&sb, v->s);
+		tcl_quote_buf(sb, v->s);
 		break;
 	}
 	if (quote_style !=3D QUOTE_NONE) {
-		fputs(sb.buf, stdout);
-		strbuf_release(&sb);
+		fputs(sb->buf, stdout);
+		strbuf_release(sb);
 	}
 }
=20
@@ -910,7 +910,7 @@ static int hex2(const char *cp)
 		return -1;
 }
=20
-static void emit(const char *cp, const char *ep)
+static void emit(struct strbuf *sb, const char *cp, const char *ep)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp =3D=3D '%') {
@@ -919,32 +919,47 @@ static void emit(const char *cp, const char *ep)
 			else {
 				int ch =3D hex2(cp + 1);
 				if (0 <=3D ch) {
-					putchar(ch);
+					strbuf_addch(sb, ch);
 					cp +=3D 3;
 					continue;
 				}
 			}
 		}
-		putchar(*cp);
+		strbuf_addch(sb, *cp);
 		cp++;
 	}
 }
=20
-static void show_ref(struct refinfo *info, const char *format, int quo=
te_style)
+static void show_ref(struct strbuf *sb, struct refinfo *info,
+		     const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
=20
 	for (cp =3D format; *cp && (sp =3D find_next(cp)); cp =3D ep + 1) {
 		ep =3D strchr(sp, ')');
 		if (cp < sp)
-			emit(cp, sp);
-		print_value(info, parse_atom(sp + 2, ep), quote_style);
+			emit(sb, cp, sp);
+		print_value(sb, info, parse_atom(sp + 2, ep), quote_style);
 	}
 	if (*cp) {
 		sp =3D cp + strlen(cp);
-		emit(cp, sp);
+		emit(sb, cp, sp);
 	}
-	putchar('\n');
+	strbuf_addch(sb, '\n');
+}
+
+static void show_refs(struct refinfo **refs, int maxcount,
+		      const char *format, int quote_style)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i;
+
+	for (i =3D 0; i < maxcount; i++) {
+		strbuf_reset(&sb);
+		show_ref(&sb, refs[i], format, quote_style);
+		fputs(sb.buf, stdout);
+	}
+	strbuf_release(&sb);
 }
=20
 static struct ref_sort *default_sort(void)
@@ -987,7 +1002,7 @@ static char const * const for_each_ref_usage[] =3D=
 {
=20
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i, num_refs;
+	int num_refs;
 	const char *format =3D "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort =3D NULL, **sort_tail =3D &sort;
 	int maxcount =3D 0, quote_style =3D 0;
@@ -1041,7 +1056,7 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
=20
 	if (!maxcount || num_refs < maxcount)
 		maxcount =3D num_refs;
-	for (i =3D 0; i < maxcount; i++)
-		show_ref(refs[i], format, quote_style);
+
+	show_refs(refs, maxcount, format, quote_style);
 	return 0;
 }
--=20
1.8.3.247.g485169c
