From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] pretty: share code between format_decoration and show_decorations
Date: Sat, 22 Sep 2012 11:22:14 +0700
Message-ID: <1348287739-12128-2-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHFQ-0003ew-LL
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab2IVEWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 00:22:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59381 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab2IVEWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:22:18 -0400
X-Greylist: delayed 143753 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2012 00:22:17 EDT
Received: by padhz1 with SMTP id hz1so137078pad.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LPdUNRlAfZ5OpZDvfNWWEsk2InSIB3SF1Un/BLdqDSo=;
        b=NTx70yqTne4RF+WgMxbz56jCXftamhbGhKs0+GiAvO1POdYCOiTR0Y/NNWGuzUXnIm
         T7cPDWpVbetJhyP4AusCxStZ4fw30bVJbDH4sBG1aDwZyG71BfBU4oHlOXRz+Oa4BLIg
         uH3gJREhhcoFGyhlpoMRulc7P1t22ziguF+K2wh3rJjG15RqMH6jQP+rdvRKinOdZ+kP
         +4nQHshWl7NFSQf7efAajRlrV7erZpgBhuSZmw9bd4qAsbZIH4wqlUKg2cKn6kKS60Ml
         5uiS8D9baHTUftmbEqavfEhPkMrqWw0Ha+Bj4bmnWp9ztBdak7WiakQztMMEVo5n/gpf
         MUqg==
Received: by 10.68.225.68 with SMTP id ri4mr15897318pbc.115.1348287737083;
        Fri, 21 Sep 2012 21:22:17 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id uh7sm6099029pbc.35.2012.09.21.21.22.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 21:22:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 11:22:27 +0700
X-Mailer: git-send-email 1.7.12.1.384.g7b808e7
In-Reply-To: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206186>

This also adds color support to format_decoration()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c                       | 59 ++++++++++++++++++++++++--------=
--------
 log-tree.h                       |  3 ++
 pretty.c                         | 19 +------------
 t/t4207-log-decoration-colors.sh |  8 +++---
 4 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index c894930..19c54dc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -174,36 +174,50 @@ static void show_children(struct rev_info *opt, s=
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
+	strbuf_addstr(sb, color_commit);
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
+	if (prefix[0] =3D=3D ',') {
+		strbuf_addch(sb, ')');
+		strbuf_addstr(sb, color_reset);
+	}
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
@@ -617,7 +631,6 @@ void show_log(struct rev_info *opt)
 			       find_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
 		show_decorations(opt, commit);
-		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 		if (opt->commit_format =3D=3D CMIT_FMT_ONELINE) {
 			putchar(' ');
 		} else {
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
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-=
colors.sh
index bbde31b..067f5aa 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -44,15 +44,15 @@ test_expect_success setup '
 '
=20
 cat >expected <<EOF
-${c_commit}COMMIT_ID (${c_HEAD}HEAD${c_reset}${c_commit},\
+${c_commit}COMMIT_ID${c_commit} (${c_HEAD}HEAD${c_reset}${c_commit},\
  ${c_tag}tag: v1.0${c_reset}${c_commit},\
  ${c_tag}tag: B${c_reset}${c_commit},\
  ${c_branch}master${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID (${c_tag}tag: A1${c_reset}${c_commit},\
+${c_commit}COMMIT_ID${c_commit} (${c_tag}tag: A1${c_reset}${c_commit},=
\
  ${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
-${c_commit}COMMIT_ID (${c_stash}refs/stash${c_reset}${c_commit})${c_re=
set}\
+${c_commit}COMMIT_ID${c_commit} (${c_stash}refs/stash${c_reset}${c_com=
mit})${c_reset}\
  On master: Changes to A.t
-${c_commit}COMMIT_ID (${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+${c_commit}COMMIT_ID${c_commit} (${c_tag}tag: A${c_reset}${c_commit})$=
{c_reset} A
 EOF
=20
 # We want log to show all, but the second parent to refs/stash is irre=
levant
--=20
1.7.12.1.384.g7b808e7
