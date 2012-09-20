From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] pretty: share code between format_decoration and show_decorations
Date: Thu, 20 Sep 2012 19:26:15 +0700
Message-ID: <1348143976-4506-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 14:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEfpt-0006XU-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 14:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab2ITM0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 08:26:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53547 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab2ITM0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 08:26:18 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so96433pbb.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qSU9MTswEOcMpP2YGp0/2kX1i9sHpAPfIavtyuGtYyI=;
        b=WnktjKh8NMbzFEehUDRTJH9or7fJJk1urFxyX/ZIi43XbbpVW0x2ZJIJBkMKzooxwO
         v2LfW5RwVQLu0XhxdUXsXksvPEBbpED8YDkmWnZ6PDoAE1VVekKdOWgiR5wvrlxh4dUz
         nqpk8bL/TsHHlHYO5L6vhIcr0bNO+DNSZ57xCd3Wip2vka3YkYRLilbQ14A6cOlmCIsG
         YhcOU/9iTvZQnm9S+arAUw3nC+zWK0LcDmcCf1QDywBuHeguA7Pm7PAB/LlZldFguZba
         JgDkOxA3M0l9M2IQVW8h1WaWlaXFflmqGZMqCtRwdqLSm4iZoIAbmF8QO/hU0kNayL1G
         E51g==
Received: by 10.68.226.38 with SMTP id rp6mr6353880pbc.116.1348143978119;
        Thu, 20 Sep 2012 05:26:18 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id gi2sm3443948pbc.59.2012.09.20.05.26.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2012 05:26:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Sep 2012 19:26:26 +0700
X-Mailer: git-send-email 1.7.12.1.383.gda6001e.dirty
In-Reply-To: <1348143976-4506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206047>

This also adds color support to format_decoration()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c | 55 +++++++++++++++++++++++++++++++++---------------------=
-
 log-tree.h |  3 +++
 pretty.c   | 19 +------------------
 3 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index c894930..b8cea3f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -174,36 +174,47 @@ static void show_children(struct rev_info *opt, s=
truct commit *commit, int abbre
 	}
 }
=20
-void show_decorations(struct rev_info *opt, struct commit *commit)
+void format_decoration(struct strbuf *sb,
+		       const struct commit *commit,
+		       int use_color)
 {
-	const char *prefix;
-	struct name_decoration *decoration;
+	const char *prefix =3D " (";
+	struct name_decoration *d;
 	const char *color_commit =3D
-		diff_get_color_opt(&opt->diffopt, DIFF_COMMIT);
+		diff_get_color(use_color, DIFF_COMMIT);
 	const char *color_reset =3D
-		decorate_get_color_opt(&opt->diffopt, DECORATION_NONE);
+		decorate_get_color(use_color, DECORATION_NONE);
+
+	load_ref_decorations(DECORATE_SHORT_REFS);
+	d =3D lookup_decoration(&name_decoration, &commit->object);
+	if (!d)
+		return;
+	while (d) {
+		strbuf_addstr(sb, prefix);
+		strbuf_addstr(sb, decorate_get_color(use_color, d->type));
+		if (d->type =3D=3D DECORATION_REF_TAG)
+			strbuf_addstr(sb, "tag: ");
+		strbuf_addstr(sb, d->name);
+		strbuf_addstr(sb, color_reset);
+		strbuf_addstr(sb, color_commit);
+		prefix =3D ", ";
+		d =3D d->next;
+	}
+	if (prefix[0] =3D=3D ',')
+		strbuf_addch(sb, ')');
+}
+
+void show_decorations(struct rev_info *opt, struct commit *commit)
+{
+	struct strbuf sb =3D STRBUF_INIT;
=20
 	if (opt->show_source && commit->util)
 		printf("\t%s", (char *) commit->util);
 	if (!opt->show_decorations)
 		return;
-	decoration =3D lookup_decoration(&name_decoration, &commit->object);
-	if (!decoration)
-		return;
-	prefix =3D " (";
-	while (decoration) {
-		printf("%s", prefix);
-		fputs(decorate_get_color_opt(&opt->diffopt, decoration->type),
-		      stdout);
-		if (decoration->type =3D=3D DECORATION_REF_TAG)
-			fputs("tag: ", stdout);
-		printf("%s", decoration->name);
-		fputs(color_reset, stdout);
-		fputs(color_commit, stdout);
-		prefix =3D ", ";
-		decoration =3D decoration->next;
-	}
-	putchar(')');
+	format_decoration(&sb, commit, opt->diffopt.use_color);
+	fputs(sb.buf, stdout);
+	strbuf_release(&sb);
 }
=20
 /*
diff --git a/log-tree.h b/log-tree.h
index f5ac238..10c2682 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,6 +13,9 @@ int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt);
+void format_decoration(struct strbuf *sb,
+		       const struct commit *commit,
+		       int use_color);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *comm=
it,
 			     const char **subject_p,
diff --git a/pretty.c b/pretty.c
index 8b1ea9f..e910679 100644
--- a/pretty.c
+++ b/pretty.c
@@ -764,23 +764,6 @@ static void parse_commit_message(struct format_com=
mit_context *c)
 	c->commit_message_parsed =3D 1;
 }
=20
-static void format_decoration(struct strbuf *sb, const struct commit *=
commit)
-{
-	struct name_decoration *d;
-	const char *prefix =3D " (";
-
-	load_ref_decorations(DECORATE_SHORT_REFS);
-	d =3D lookup_decoration(&name_decoration, &commit->object);
-	while (d) {
-		strbuf_addstr(sb, prefix);
-		prefix =3D ", ";
-		strbuf_addstr(sb, d->name);
-		d =3D d->next;
-	}
-	if (prefix[0] =3D=3D ',')
-		strbuf_addch(sb, ')');
-}
-
 static void strbuf_wrap(struct strbuf *sb, size_t pos,
 			size_t width, size_t indent1, size_t indent2)
 {
@@ -1005,7 +988,7 @@ static size_t format_commit_one(struct strbuf *sb,=
 const char *placeholder,
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decoration(sb, commit);
+		format_decoration(sb, commit, 0);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
--=20
1.7.12.1.383.gda6001e.dirty
