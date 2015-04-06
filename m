From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/25] list-files: add --ignored
Date: Mon,  6 Apr 2015 20:52:24 +0700
Message-ID: <1428328354-14897-16-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Tm-0005hq-FZ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbbDFNyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:15 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33764 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbbDFNyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:13 -0400
Received: by paboj16 with SMTP id oj16so45223124pab.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8Fs/ss9bEKs+oyNCxrzxcF/a3y4pIIrxK8K4lQl8Vsc=;
        b=wexfGVY6mxZr10pNTIZ+Z0CF1GcpPdzwX9m39EStSv6wGgokfPeuK+GNqUI+rmAR3O
         U2RVlJmBLNSGl+Mk1RC4R37zUsXsrNrxcYXVQSOZRHh09ylPeq6lksKsJd120JO+p/NQ
         lgD/UsgCkRWNrzHEviYyMc6JGqoi7rEevepWsn3TzU/LwjRyPXyWKHhuQWVP9TawJv/0
         FLqs0JpVA2f521TdzPJ9yMUyBl4bKn1fu9uwKSnSFCoI3OKcd54erQBdtuOmq58+WWCO
         as95G0A6NKBuUYcEgOZ3cf09k5WKKPx/6ZfqjJqdPxLaTe/xEWMPhjf/ILWRdNnw5KsO
         n2kQ==
X-Received: by 10.68.57.237 with SMTP id l13mr23770640pbq.100.1428328453158;
        Mon, 06 Apr 2015 06:54:13 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id d4sm4798016pds.43.2015.04.06.06.54.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:23 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266859>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 22 ++++++++++++++++------
 t/t7013-list-files.sh | 15 +++++++++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 3cbd30d..31991a4 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -39,6 +39,7 @@ static int show_dirs;
 static int use_color =3D -1;
 static int show_indicator;
 static int show_cached, show_untracked;
+static int show_ignored;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -51,6 +52,8 @@ struct option ls_options[] =3D {
 		 N_("show cached files (default)")),
 	OPT_BOOL('o', "others", &show_untracked,
 		 N_("show untracked files")),
+	OPT_BOOL('i', "ignored", &show_ignored,
+		 N_("show ignored files")),
=20
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL(0, "tag", &show_tag, N_("show tags")),
@@ -202,7 +205,8 @@ static void add_wt_item(struct item_list *result,
 }
=20
 static void populate_untracked(struct item_list *result,
-			       const struct string_list *untracked)
+			       const struct string_list *untracked,
+			       const char *tag)
 {
 	int i;
=20
@@ -217,7 +221,7 @@ static void populate_untracked(struct item_list *re=
sult,
 		if (!matched(result, name, st.st_mode))
 			continue;
=20
-		add_wt_item(result, FROM_WORKTREE, name, "??", &st);
+		add_wt_item(result, FROM_WORKTREE, name, tag, &st);
 	}
 }
=20
@@ -226,18 +230,22 @@ static void wt_status_populate(struct item_list *=
result,
 {
 	struct wt_status ws;
=20
-	if (!show_untracked)
+	if (!show_untracked && !show_ignored)
 		return;
=20
 	wt_status_prepare(&ws);
 	copy_pathspec(&ws.pathspec, &recursive_pathspec);
+	if (show_ignored)
+		ws.show_ignored_files =3D 1;
 	ws.relative_paths =3D 0;
 	ws.use_color =3D 0;
 	ws.fp =3D NULL;
 	wt_status_collect(&ws);
=20
 	if (show_untracked)
-		populate_untracked(result, &ws.untracked);
+		populate_untracked(result, &ws.untracked, "??");
+	if (show_ignored)
+		populate_untracked(result, &ws.ignored, "!!");
=20
 	remove_duplicates(result);
 }
@@ -251,7 +259,9 @@ static void cleanup_tags(struct item_list *result)
 		result->tag_len =3D 0;
 		return;
 	}
-	if (show_tag > 0 || show_cached + show_untracked > 1) {
+
+	if (show_tag > 0 ||
+	    show_cached + show_untracked + show_ignored > 1) {
 		result->tag_pos =3D 0;
 		result->tag_len =3D 2;
 		return;
@@ -388,7 +398,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
-	if (!show_cached && !show_untracked)
+	if (!show_cached && !show_untracked && !show_ignored)
 		show_cached =3D 1;
=20
 	if (want_color(use_color))
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index 53dc745..6b76d1f 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -44,6 +44,21 @@ test_expect_success 'list-files --others' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'list-files --others' '
+	git list-files --ignored >actual &&
+	cat >expect <<-\EOF &&
+	!! foo
+	   sa
+	EOF
+	test_cmp expect actual &&
+	git list-files --ignored -R >actual &&
+	cat >expect <<-\EOF &&
+	foo
+	sa/foo
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'list-files -R from index' '
 	git list-files -R >actual &&
 	cat >expect <<-\EOF &&
--=20
2.3.0.rc1.137.g477eb31
