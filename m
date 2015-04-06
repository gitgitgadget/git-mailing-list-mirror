From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/25] list-files: add --color
Date: Mon,  6 Apr 2015 20:52:20 +0700
Message-ID: <1428328354-14897-12-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7TM-0005PU-JV
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbbDFNxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:48 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33973 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbDFNxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:47 -0400
Received: by pacyx8 with SMTP id yx8so44811611pac.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eCBOyrhfpLhGrzKj76pj/HwLensx6/ElKhhr2BWRr0E=;
        b=b7hQpgkjd9ekWlJvCg1tIk0yGhPZ+za0DTJ7w997kd9Fj1qqhmi6K8lCX8lSf5MkAV
         CjpIq0MUj003hgiwsmi6UvsA1ujbUZoS+NeffzlL8iCBiLlTSq6d7z/4uPxp5ubmWHNp
         OMAZ/VGSY0poZNrFBKqbEF3UfGcWOGzmxnWvkwPln0c1NpHlmMpsdIBiaBLT/0dEp/No
         RCsn6E4Tt7QqLXRwkGoLyMU/aGwol+dPneXWX+qs7/AKZunhhDJOIEPWfbIVX73vrFNM
         0az6YkQYhbHMuHvF03nunCt9v0Xjdn65VYF9bMsoxPiN4rtHcOu5EqeSDnfgWEjbYmXv
         Pu9g==
X-Received: by 10.68.90.132 with SMTP id bw4mr27247811pbb.102.1428328427401;
        Mon, 06 Apr 2015 06:53:47 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id s17sm4783650pdn.87.2015.04.06.06.53.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:58 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266856>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 30 +++++++++++++++++++++++++++++-
 t/t7013-list-files.sh | 44 +++++++++++++++++++++++++++++++++++++++++++=
+
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index a60ab98..02a088d 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -5,6 +5,7 @@
 #include "dir.h"
 #include "quote.h"
 #include "column.h"
+#include "color.h"
=20
 enum item_type {
 	FROM_INDEX,
@@ -32,6 +33,7 @@ static int show_tag =3D -1;
 static unsigned int colopts;
 static int max_depth;
 static int show_dirs;
+static int use_color =3D -1;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -48,6 +50,7 @@ struct option ls_options[] =3D {
 	  NULL, 1 },
 	OPT_SET_INT('R', "recursive", &max_depth,
 		    N_("shortcut for --max-depth=3D-1"), -1),
+	OPT__COLOR(&use_color, N_("show color")),
 	OPT_END()
 };
=20
@@ -69,6 +72,17 @@ static void free_item(struct item *item)
 	}
 }
=20
+static mode_t get_mode(const struct item *item)
+{
+	switch (item->type) {
+	case IS_DIR:
+		return S_IFDIR;
+	case FROM_INDEX:
+		return item->ce->ce_mode;
+	}
+	return S_IFREG;
+}
+
 static void remove_duplicates(struct item_list *list)
 {
 	int src, dst;
@@ -220,6 +234,13 @@ static void display(const struct item_list *result=
)
 			strbuf_addch(&quoted, ' ');
 		}
 		quote_item(&quoted, item);
+		if (want_color(use_color)) {
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_swap(&sb, &quoted);
+			color_filename(&quoted, item->path, sb.buf,
+				       get_mode(item), 1);
+			strbuf_release(&sb);
+		}
 		if (column_active(colopts))
 			string_list_append(&s, quoted.buf);
 		else
@@ -240,7 +261,11 @@ static int ls_config(const char *var, const char *=
value, void *cb)
 {
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "listfiles", &colopts);
-	return git_default_config(var, value, cb);
+	if (!strcmp(var, "color.listfiles")) {
+		use_color =3D git_config_colorbool(var, value);
+		return 0;
+	}
+	return git_color_default_config(var, value, cb);
 }
=20
 int cmd_list_files(int argc, const char **argv, const char *cmd_prefix=
)
@@ -261,6 +286,9 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
+	if (want_color(use_color))
+		parse_ls_color();
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       (max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index a4916d8..cdbc34a 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -110,4 +110,48 @@ test_expect_success 'list-files from subdir (2)' '
 	)
 '
=20
+test_expect_success 'setup 2' '
+	git init 2 &&
+	(
+	cd 2 &&
+	mkdir dir &&
+	touch file dir/file &&
+	git init gitlink &&
+	( cd gitlink && test_commit foo ) &&
+	git add file dir/file gitlink &&
+	git commit -qm1
+	)
+'
+
+test_expect_success 'LS_COLORS env variable' '
+	(
+	cd 2 &&
+	LS_COLORS=3D"rs=3D0:fi=3D31:di=3D32" &&
+	export LS_COLORS &&
+	git list-files --color=3Dalways | test_decode_color | \
+		grep -v gitlink >actual &&
+	cat >expected <<-\EOF &&
+	<GREEN>dir<RESET>
+	<RED>file<RESET>
+	EOF
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'color.ls.*' '
+	(
+	cd 2 &&
+	test_config color.ls.file red &&
+	test_config color.ls.directory green &&
+	test_config color.ls.submodule yellow &&
+	git list-files --color=3Dalways | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<GREEN>dir<RESET>
+	<RED>file<RESET>
+	<YELLOW>gitlink<RESET>
+	EOF
+	test_cmp expected actual
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
