From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 04/13] pretty: share code between format_decoration and show_decorations
Date: Fri, 19 Apr 2013 09:08:43 +1000
Message-ID: <1366326532-28517-5-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:09:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxxS-0007Tp-V1
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967211Ab3DRXJd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:09:33 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:56158 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966948Ab3DRXJc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:09:32 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so1856494pde.4
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=pXjEepw8xGHJBbNek7nkLpeH020kf2HVgxg9mncNd8I=;
        b=Wu9bbucFY14hiNhyVqJMOletu40kAwsh5WlDQt6Xmd+zRY+95zEO1VvRuJBQdBUAIW
         BeoJ3m/E65YFpXXEvlqwCBA0c9eBaieTllbk8NYiZDSJJkumw8c2UkSvaNmVcCFf6uWj
         TvAipNa0v0BVtl64eIm9ATQTMJa6kMGHm8liY8e5+c7yBwytlh65Eby6AFDU14IqT30u
         pnwVlpmDtgO3XsbgcN3ZV0st7SbMIiV2CUa57g2jvBrLQoM56dX9oNyTFvfNtfd4kTdP
         k0NI30dWwUp0ZQgZuEl6zfIu4EdwqyhrAvnDVN48aIwbayLAjkGY8NsxQU57uKpRQOYp
         3WFw==
X-Received: by 10.68.254.195 with SMTP id ak3mr15546257pbd.154.1366326571901;
        Thu, 18 Apr 2013 16:09:31 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id li15sm12402737pab.2.2013.04.18.16.09.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:09:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:09:21 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221706>

This also adds color support to format_decorations()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c                       | 48 ++++++++++++++++++++++++++------=
--------
 log-tree.h                       |  1 +
 pretty.c                         | 20 ++---------------
 t/t4207-log-decoration-colors.sh |  8 +++----
 4 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7cc7d59..1946e9c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -175,36 +175,52 @@ static void show_children(struct rev_info *opt, s=
truct commit *commit, int abbre
 	}
 }
=20
-void show_decorations(struct rev_info *opt, struct commit *commit)
+/*
+ * The caller makes sure there is no funny color before
+ * calling. format_decorations makes sure the same after return.
+ */
+void format_decorations(struct strbuf *sb,
+			const struct commit *commit,
+			int use_color)
 {
 	const char *prefix;
 	struct name_decoration *decoration;
 	const char *color_commit =3D
-		diff_get_color_opt(&opt->diffopt, DIFF_COMMIT);
+		diff_get_color(use_color, DIFF_COMMIT);
 	const char *color_reset =3D
-		decorate_get_color_opt(&opt->diffopt, DECORATION_NONE);
+		decorate_get_color(use_color, DECORATION_NONE);
=20
-	if (opt->show_source && commit->util)
-		printf("\t%s", (char *) commit->util);
-	if (!opt->show_decorations)
-		return;
 	decoration =3D lookup_decoration(&name_decoration, &commit->object);
 	if (!decoration)
 		return;
 	prefix =3D " (";
 	while (decoration) {
-		printf("%s", prefix);
-		fputs(decorate_get_color_opt(&opt->diffopt, decoration->type),
-		      stdout);
+		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, prefix);
+		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
 		if (decoration->type =3D=3D DECORATION_REF_TAG)
-			fputs("tag: ", stdout);
-		printf("%s", decoration->name);
-		fputs(color_reset, stdout);
-		fputs(color_commit, stdout);
+			strbuf_addstr(sb, "tag: ");
+		strbuf_addstr(sb, decoration->name);
+		strbuf_addstr(sb, color_reset);
 		prefix =3D ", ";
 		decoration =3D decoration->next;
 	}
-	putchar(')');
+	strbuf_addstr(sb, color_commit);
+	strbuf_addch(sb, ')');
+	strbuf_addstr(sb, color_reset);
+}
+
+void show_decorations(struct rev_info *opt, struct commit *commit)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+
+	if (opt->show_source && commit->util)
+		printf("\t%s", (char *) commit->util);
+	if (!opt->show_decorations)
+		return;
+	format_decorations(&sb, commit, opt->diffopt.use_color);
+	fputs(sb.buf, stdout);
+	strbuf_release(&sb);
 }
=20
 static unsigned int digits_in_number(unsigned int number)
@@ -540,8 +556,8 @@ void show_log(struct rev_info *opt)
 			printf(" (from %s)",
 			       find_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
+		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), stdout);
 		show_decorations(opt, commit);
-		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 		if (opt->commit_format =3D=3D CMIT_FMT_ONELINE) {
 			putchar(' ');
 		} else {
diff --git a/log-tree.h b/log-tree.h
index 9140f48..d6ecd4d 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,6 +13,7 @@ int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
 void show_log(struct rev_info *opt);
+void format_decorations(struct strbuf *sb, const struct commit *commit=
, int use_color);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *comm=
it,
 			     const char **subject_p,
diff --git a/pretty.c b/pretty.c
index e59688b..e0f93ba 100644
--- a/pretty.c
+++ b/pretty.c
@@ -908,23 +908,6 @@ static void parse_commit_message(struct format_com=
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
@@ -1103,7 +1086,8 @@ static size_t format_commit_one(struct strbuf *sb=
, const char *placeholder,
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decoration(sb, commit);
+		load_ref_decorations(DECORATE_SHORT_REFS);
+		format_decorations(sb, commit, 0);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-=
colors.sh
index bbde31b..925f577 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -44,15 +44,15 @@ test_expect_success setup '
 '
=20
 cat >expected <<EOF
-${c_commit}COMMIT_ID (${c_HEAD}HEAD${c_reset}${c_commit},\
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD${c_reset}${c_=
commit},\
  ${c_tag}tag: v1.0${c_reset}${c_commit},\
  ${c_tag}tag: B${c_reset}${c_commit},\
  ${c_branch}master${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID (${c_tag}tag: A1${c_reset}${c_commit},\
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_tag}tag: A1${c_reset}${=
c_commit},\
  ${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
-${c_commit}COMMIT_ID (${c_stash}refs/stash${c_reset}${c_commit})${c_re=
set}\
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_stash}refs/stash${c_res=
et}${c_commit})${c_reset}\
  On master: Changes to A.t
-${c_commit}COMMIT_ID (${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_tag}tag: A${c_reset}${c=
_commit})${c_reset} A
 EOF
=20
 # We want log to show all, but the second parent to refs/stash is irre=
levant
--=20
1.8.2.82.gc24b958
