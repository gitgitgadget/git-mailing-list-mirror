From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/25] list-files: show directories as well as files
Date: Mon,  6 Apr 2015 20:52:19 +0700
Message-ID: <1428328354-14897-11-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7TG-0005Mi-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbbDFNxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:42 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33855 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbDFNxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:41 -0400
Received: by pacyx8 with SMTP id yx8so44809402pac.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wRPrbavUUnLOfgXUx3WMjL4j0qEyG/+ZT5pxBRSowlU=;
        b=MqF5wBbjGIKI0rslw8Gbfni/avWXIAueIQenIFGDa1eNAw/ZcuvDvY3tnelQay2pas
         dTn5o1hAxe121q29MG3XZJ9axZCcMBlTyIoMNh/hqKvoE/4giJF4M+uRs/2mcGlqA7yR
         IcP/uIjjAq5QzVPM4pPcBcyruMDQWI0NFcdz2+OBjP0790WNj5gVWxMiLMj6DB29e8AB
         lrGBFlNnN5OFeSVTvdUnW4C3py3EP4/ndpe3kkXEBdBp2uND8DoHrtABFKLEll1Adpd3
         6aT6exPAJNkYZN1na+Ow451iPPzJg+v+Al6AYMxDYBMjp1N62J5fuRvrdCvgUSyFwNZz
         4IKQ==
X-Received: by 10.68.175.66 with SMTP id by2mr27180127pbc.141.1428328421076;
        Mon, 06 Apr 2015 06:53:41 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id eo1sm4775919pbd.36.2015.04.06.06.53.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:52 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266855>

The index does not store directories explicitly (except submodules) so
we have to figure them out from file list when output lis depth-limited=
=2E

The function add_directory() can generate duplicate entries, which is
cleaned up before displaying.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 94 +++++++++++++++++++++++++++++++++++++++++++=
++++----
 t/t7013-list-files.sh |  3 ++
 2 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 4599cf0..a60ab98 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -7,7 +7,8 @@
 #include "column.h"
=20
 enum item_type {
-	FROM_INDEX
+	FROM_INDEX,
+	IS_DIR
 };
=20
 struct item {
@@ -24,11 +25,13 @@ struct item_list {
 };
=20
 static struct pathspec pathspec;
+static struct pathspec recursive_pathspec;
 static const char *prefix;
 static int prefix_length;
 static int show_tag =3D -1;
 static unsigned int colopts;
 static int max_depth;
+static int show_dirs;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -48,6 +51,81 @@ struct option ls_options[] =3D {
 	OPT_END()
 };
=20
+static int compare_item(const void *a_, const void *b_)
+{
+	const struct item *a =3D a_;
+	const struct item *b =3D b_;
+	return strcmp(a->path, b->path);
+}
+
+static void free_item(struct item *item)
+{
+	switch (item->type) {
+	case IS_DIR:
+		free((char*)item->path);
+		break;
+	default:
+		break;
+	}
+}
+
+static void remove_duplicates(struct item_list *list)
+{
+	int src, dst;
+
+	if (list->nr <=3D 1)
+		return;
+	qsort(list->items, list->nr, sizeof(*list->items), compare_item);
+	for (src =3D dst =3D 1; src < list->nr; src++) {
+		if (!compare_item(list->items + dst - 1, list->items + src))
+			free_item(list->items + src);
+		else
+			list->items[dst++] =3D list->items[src];
+	}
+	list->nr =3D dst;
+}
+
+static int add_directory(struct item_list *result,
+			 const char *name)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct item *item;
+	const char *p;
+
+	strbuf_addstr(&sb, name);
+	while (sb.len && (p =3D strrchr(sb.buf, '/')) !=3D NULL) {
+		strbuf_setlen(&sb, p - sb.buf);
+		if (!match_pathspec(&pathspec, sb.buf, sb.len, 0, NULL, 1))
+			continue;
+
+		ALLOC_GROW(result->items, result->nr + 1, result->alloc);
+		item =3D result->items + result->nr++;
+		item->type =3D IS_DIR;
+		item->path =3D strbuf_detach(&sb, NULL);
+		item->tag[0] =3D ' ';
+		item->tag[1] =3D ' ';
+		return 1;
+	}
+	strbuf_release(&sb);
+	return 0;
+}
+
+static int matched(struct item_list *result, const char *name, int mod=
e)
+{
+	int len =3D strlen(name);
+
+	if (!match_pathspec(&recursive_pathspec, name, len, 0, NULL,
+			    S_ISDIR(mode) || S_ISGITLINK(mode)))
+		return 0;
+
+	if (show_dirs && strchr(name, '/') &&
+	    !match_pathspec(&pathspec, name, len, 0, NULL, 1) &&
+	    add_directory(result, name))
+		return 0;
+
+	return 1;
+}
+
 static void populate_cached_entries(struct item_list *result,
 				    const struct index_state *istate)
 {
@@ -57,10 +135,7 @@ static void populate_cached_entries(struct item_lis=
t *result,
 		const struct cache_entry *ce =3D istate->cache[i];
 		struct item *item;
=20
-		if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-				    0, NULL,
-				    S_ISDIR(ce->ce_mode) ||
-				    S_ISGITLINK(ce->ce_mode)))
+		if (!matched(result, ce->name, ce->ce_mode))
 			continue;
=20
 		ALLOC_GROW(result->items, result->nr + 1, result->alloc);
@@ -71,6 +146,10 @@ static void populate_cached_entries(struct item_lis=
t *result,
 		item->tag[1] =3D ' ';
 		item->ce =3D ce;
 	}
+
+	if (!show_dirs)
+		return;
+	remove_duplicates(result);
 }
=20
 static void cleanup_tags(struct item_list *result)
@@ -189,10 +268,13 @@ int cmd_list_files(int argc, const char **argv, c=
onst char *cmd_prefix)
 		       cmd_prefix, argv);
 	pathspec.max_depth =3D max_depth;
 	pathspec.recursive =3D 1;
+	show_dirs =3D max_depth >=3D 0;
+	copy_pathspec(&recursive_pathspec, &pathspec);
+	recursive_pathspec.max_depth =3D -1;
 	finalize_colopts(&colopts, -1);
=20
 	refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
-		      &pathspec, NULL, NULL);
+		      &recursive_pathspec, NULL, NULL);
=20
 	memset(&result, 0, sizeof(result));
 	populate_cached_entries(&result, &the_index);
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index 89930c7..a4916d8 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -29,6 +29,8 @@ test_expect_success 'list-files from index' '
 	a
 	b
 	c
+	sa
+	sc
 	EOF
 	test_cmp expect actual &&
 	git list-files >actual &&
@@ -78,6 +80,7 @@ test_expect_success '--max-depth' '
 	b
 	c
 	sa/a
+	sa/sb
 	sc/c
 	EOF
 	test_cmp expected actual
--=20
2.3.0.rc1.137.g477eb31
