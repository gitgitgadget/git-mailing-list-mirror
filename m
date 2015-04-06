From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/25] list-files: add --cached and --others
Date: Mon,  6 Apr 2015 20:52:23 +0700
Message-ID: <1428328354-14897-15-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Tg-0005fH-4h
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbbDFNyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:07 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33394 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbbDFNyG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:06 -0400
Received: by pdbnk13 with SMTP id nk13so45363453pdb.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vbtFC5foOUhxXqnBVIVS7WyOoArJ6Kusyt7ms0S3Nc4=;
        b=iS4AD+H1T9homolF7KZMedSfn9JkeB9CINkuSVAdA9yWo92n7xnz4Ym/XSNOSZJAvG
         b98sB0PYfWfuC8BNUpdfkaOcNoSqdoycadAeThUgGekih7rLaT5yrwmblbryvvNWylkE
         SxAxf131CJi4yKXeKft6K8z5BTvS46Xcrn81is0B8qJHLc9QlNb1gHqte4f346MZq8HG
         SjDc1UNnVTbXhgR3gK7elea9IF9EqPIu8DZpYwfqblYcm3xdHwo0hWouI+5S8DMoWhsR
         TC3IRTpXK4ilW4HKVhJAJx3gNuGpGPsJIbjnmAZyNwb80t/jgsYJpbdnp7jRNgyZbPxR
         DRNQ==
X-Received: by 10.66.136.17 with SMTP id pw17mr28030351pab.33.1428328446265;
        Mon, 06 Apr 2015 06:54:06 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id cz10sm4809326pdb.9.2015.04.06.06.54.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:17 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266860>

If no filter options are specified, --cached is the default.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 79 +++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 t/t7013-list-files.sh | 38 ++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 7c18848..3cbd30d 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -6,9 +6,11 @@
 #include "quote.h"
 #include "column.h"
 #include "color.h"
+#include "wt-status.h"
=20
 enum item_type {
 	FROM_INDEX,
+	FROM_WORKTREE,
 	IS_DIR
 };
=20
@@ -17,6 +19,7 @@ struct item {
 	const char *path;
 	char tag[2];
 	const struct cache_entry *ce;
+	struct stat st;
 };
=20
 struct item_list {
@@ -35,6 +38,7 @@ static int max_depth;
 static int show_dirs;
 static int use_color =3D -1;
 static int show_indicator;
+static int show_cached, show_untracked;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -42,6 +46,13 @@ static const char * const ls_usage[] =3D {
 };
=20
 struct option ls_options[] =3D {
+	OPT_GROUP(N_("Filter options")),
+	OPT_BOOL('c', "cached", &show_cached,
+		 N_("show cached files (default)")),
+	OPT_BOOL('o', "others", &show_untracked,
+		 N_("show untracked files")),
+
+	OPT_GROUP(N_("Other")),
 	OPT_BOOL(0, "tag", &show_tag, N_("show tags")),
 	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
 	OPT_SET_INT('1', NULL, &colopts,
@@ -82,6 +93,8 @@ static mode_t get_mode(const struct item *item)
 		return S_IFDIR;
 	case FROM_INDEX:
 		return item->ce->ce_mode;
+	case FROM_WORKTREE:
+		return item->st.st_mode;
 	}
 	return S_IFREG;
 }
@@ -148,6 +161,9 @@ static void populate_cached_entries(struct item_lis=
t *result,
 {
 	int i;
=20
+	if (!show_cached)
+		return;
+
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce =3D istate->cache[i];
 		struct item *item;
@@ -169,6 +185,63 @@ static void populate_cached_entries(struct item_li=
st *result,
 	remove_duplicates(result);
 }
=20
+static void add_wt_item(struct item_list *result,
+			enum item_type type,
+			const char *path,
+			const char *tag,
+			const struct stat *st)
+{
+	struct item *item;
+
+	ALLOC_GROW(result->items, result->nr + 1, result->alloc);
+	item =3D result->items + result->nr++;
+	item->type =3D type;
+	item->path =3D path;
+	memcpy(item->tag, tag, sizeof(item->tag));
+	memcpy(&item->st, &st, sizeof(st));
+}
+
+static void populate_untracked(struct item_list *result,
+			       const struct string_list *untracked)
+{
+	int i;
+
+	for (i =3D 0; i < untracked->nr; i++) {
+		const char *name =3D untracked->items[i].string;
+		struct stat st;
+
+		if (lstat(name, &st))
+			/* color_filename() treats this as an orphan file */
+			st.st_mode =3D 0;
+
+		if (!matched(result, name, st.st_mode))
+			continue;
+
+		add_wt_item(result, FROM_WORKTREE, name, "??", &st);
+	}
+}
+
+static void wt_status_populate(struct item_list *result,
+			       struct index_state *istate)
+{
+	struct wt_status ws;
+
+	if (!show_untracked)
+		return;
+
+	wt_status_prepare(&ws);
+	copy_pathspec(&ws.pathspec, &recursive_pathspec);
+	ws.relative_paths =3D 0;
+	ws.use_color =3D 0;
+	ws.fp =3D NULL;
+	wt_status_collect(&ws);
+
+	if (show_untracked)
+		populate_untracked(result, &ws.untracked);
+
+	remove_duplicates(result);
+}
+
 static void cleanup_tags(struct item_list *result)
 {
 	int i, same_1 =3D 1, same_2 =3D 1;
@@ -178,7 +251,7 @@ static void cleanup_tags(struct item_list *result)
 		result->tag_len =3D 0;
 		return;
 	}
-	if (show_tag > 0) {
+	if (show_tag > 0 || show_cached + show_untracked > 1) {
 		result->tag_pos =3D 0;
 		result->tag_len =3D 2;
 		return;
@@ -315,6 +388,9 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
+	if (!show_cached && !show_untracked)
+		show_cached =3D 1;
+
 	if (want_color(use_color))
 		parse_ls_color();
=20
@@ -335,6 +411,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	memset(&result, 0, sizeof(result));
 	populate_cached_entries(&result, &the_index);
+	wt_status_populate(&result, &the_index);
 	cleanup_tags(&result);
 	display(&result);
 	/* free-ing result seems unnecessary */
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index 37dd403..53dc745 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -7,7 +7,41 @@ test_description=3D'list-files'
 test_expect_success 'setup' '
 	mkdir sa sa/sb sc &&
 	touch a b c sa/a sa/sb/b sc/c &&
-	git add .
+	git add a sa/a &&
+	git commit -m initial &&
+	git add . &&
+	echo foo >.git/info/exclude &&
+	touch foo bar sa/foo sa/bar
+'
+
+test_expect_success 'list-files --others' '
+	git list-files --others >actual &&
+	cat >expect <<-\EOF &&
+	?? actual
+	?? bar
+	   sa
+	EOF
+	test_cmp expect actual &&
+	git list-files --others --cached >actual &&
+	cat >expect <<-\EOF &&
+	   a
+	?? actual
+	   b
+	?? bar
+	   c
+	?? expect
+	   sa
+	   sc
+	EOF
+	test_cmp expect actual &&
+	git list-files --others -R >actual &&
+	cat >expect <<-\EOF &&
+	actual
+	bar
+	expect
+	sa/bar
+	EOF
+	test_cmp expect actual
 '
=20
 test_expect_success 'list-files -R from index' '
@@ -34,6 +68,8 @@ test_expect_success 'list-files from index' '
 	EOF
 	test_cmp expect actual &&
 	git list-files >actual &&
+	test_cmp expect actual &&
+	git list-files --cached >actual &&
 	test_cmp expect actual
 '
=20
--=20
2.3.0.rc1.137.g477eb31
