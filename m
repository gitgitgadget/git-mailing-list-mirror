From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/9] for-each-ref: avoid printing each element directly to stdout
Date: Sun, 19 May 2013 17:27:09 +0700
Message-ID: <1368959235-27777-4-git-send-email-pclouds@gmail.com>
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
	id 1Ue0pC-0006XP-4S
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159Ab3ESK0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:26:32 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51846 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3ESK0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:26:30 -0400
Received: by mail-pd0-f177.google.com with SMTP id g12so3659pdj.22
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=crvgVqsjqrS2zvICjdJI7EiKXl9z2/NVkplcmj5HE0o=;
        b=V8hiLvuFu1Hdnyce1zCxYS5GBVCfOyxBTPHhrTi001hnNi9p/VC28heAOHUqgTNcA0
         Ko+NokXBF866CCdMbiQhZfR5RZa/H3yK3lozzpSDK2fg2TEuifWJ2rysI3oAZNeWS3/k
         x0GbwTP7Ih4di4FF2MfCI5bkdLOW5U9GwGgoYKfI9HAziGRnMumZxv1J5iG3ohS1jdwb
         dwD6yclgohz95g8VGtlSKZ30IMs4Dtc50YqQxaszP+fIwlFg7iWI4K7+/soCNH33hq+Q
         3PmP/aVszFFSLkSTgY0/Fedr41MXsrqVe3N6hszIRvrLAfaO2WvofWyIsN7PKZUH9fyy
         6fnA==
X-Received: by 10.68.136.198 with SMTP id qc6mr56705331pbb.117.1368959190159;
        Sun, 19 May 2013 03:26:30 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id bs2sm20656490pad.17.2013.05.19.03.26.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:26:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:27:40 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224840>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/for-each-ref.c | 48 +++++++++++++++++++++++++++++-------------=
------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 14151b4..08d4eb1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -864,15 +864,14 @@ static void sort_refs(struct ref_sort *sort, stru=
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
-	struct strbuf sb_buf =3D STRBUF_INIT;
-	struct strbuf *sb =3D &sb_buf;
 	get_value(ref, atom, &v);
 	switch (quote_style) {
 	case QUOTE_NONE:
-		fputs(v->s, stdout);
+		strbuf_addstr(sb, v->s);
 		break;
 	case QUOTE_SHELL:
 		sq_quote_buf(sb, v->s);
@@ -887,10 +886,6 @@ static void print_value(struct refinfo *ref, int a=
tom, int quote_style)
 		tcl_quote_buf(sb, v->s);
 		break;
 	}
-	if (quote_style !=3D QUOTE_NONE) {
-		fputs(sb->buf, stdout);
-		strbuf_release(sb);
-	}
 }
=20
 static int hex1(char ch)
@@ -911,7 +906,7 @@ static int hex2(const char *cp)
 		return -1;
 }
=20
-static void emit(const char *cp, const char *ep)
+static void emit(struct strbuf *sb, const char *cp, const char *ep)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp =3D=3D '%') {
@@ -920,32 +915,47 @@ static void emit(const char *cp, const char *ep)
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
+	}
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
 	}
-	putchar('\n');
+	strbuf_release(&sb);
 }
=20
 static struct ref_sort *default_sort(void)
@@ -988,7 +998,7 @@ static char const * const for_each_ref_usage[] =3D =
{
=20
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i, num_refs;
+	int num_refs;
 	const char *format =3D "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort =3D NULL, **sort_tail =3D &sort;
 	int maxcount =3D 0, quote_style =3D 0;
@@ -1042,7 +1052,7 @@ int cmd_for_each_ref(int argc, const char **argv,=
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
1.8.2.83.gc99314b
