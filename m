From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/15] for-each-ref: don't print out elements directly
Date: Tue,  4 Jun 2013 18:05:24 +0530
Message-ID: <1370349337-20938-3-git-send-email-artagnon@gmail.com>
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
	id 1UjqRE-0006cZ-Jz
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab3FDMd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:33:59 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34302 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab3FDMdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:33:55 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so171161pbc.31
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xGefcPi1ZR+Jm3wap1nA/Qf+zY6RRIbz84iRfh54BaM=;
        b=yzuLAImycQ3lEe8qmCEXj4y77VFVDpJYYCwnfOhYD/5VVcOQKjEmFHBJpj/HYpTWM4
         6GCaXtqp6HRJ0dLdGISETXXYq5vgchB06p9UndeMn2TvEs3zRlBTXLYXvXpg/DrVMwiy
         RuYTull/CxHQvR5HG4jkN5NdVVajbOrD/nH+O6yNoSKHSdZ+pqLsUxZhFLUiOkLhlmUb
         9gdq/BwYe0pXvqfckYUVS2MhidygjizM8sDnx60fWrkcjL1bMs81qNl+zYG+0MQtXKSW
         W0P+V9WD87WnQwmxO/VCnLxEfk7c8HB4nr/OAOT8k/lOtBJuWVlzA1OQglN/MqJcBXJS
         J1JQ==
X-Received: by 10.66.245.49 with SMTP id xl17mr29125689pac.101.1370349235315;
        Tue, 04 Jun 2013 05:33:55 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.33.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:33:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226344>

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
1.8.3.GIT
