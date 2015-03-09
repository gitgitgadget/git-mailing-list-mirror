From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/16] list-files: show directories as well as files
Date: Mon,  9 Mar 2015 17:18:25 +0700
Message-ID: <1425896314-10941-8-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUumn-00023S-0e
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbbCIKTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:38 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:32864 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbbCIKTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:35 -0400
Received: by pdev10 with SMTP id v10so47479715pde.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HoWJo0KPe52MexcvXa2IO92Mn924HY12i5dJQer21fQ=;
        b=TiBrKCkGWmyS3d+sKJDSCfJFz/xqhadIGaEsCEFr3H4jggl+yTAydLEPJDpZYUIN7N
         QJlu1RJyxazw8oDfrOpmwCgsv8pEjmELjyanEVQHLNxsfCGPyCbZyS7feL39q6cS8aGM
         Kt9SJzthWqTirci/DJwganAuMakZEI4VwxEgNj3R98YBede6ues77GyrJNjqbX4LfxAI
         kMljqU6J0p1X6NpwREOiXr336xn3tqEkZ5uFB7MBSd8sZPf4lYjfSkLiabdMZa3tEqgt
         PNyQKMBf34/FvLodIvTpeHxiR4Z/bwnS8iHSYcYDtHZQIwtl5bvrHYYk08dzYGMW/1Ld
         yzIg==
X-Received: by 10.66.189.105 with SMTP id gh9mr51502252pac.41.1425896374614;
        Mon, 09 Mar 2015 03:19:34 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id pu9sm4515039pdb.49.2015.03.09.03.19.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:30 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265147>

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
 builtin/list-files.c | 62 ++++++++++++++++++++++++++++++++++++++++++++=
+++-----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 9a55ea6..dc865a1 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -7,10 +7,12 @@
 #include "column.h"
=20
 static struct pathspec pathspec;
+static struct pathspec recursive_pathspec;
 static const char *prefix;
 static int prefix_length;
 static unsigned int colopts;
 static int max_depth;
+static int show_dirs;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -43,6 +45,51 @@ static void add_one(struct string_list *result, cons=
t char *name,
 	item->util =3D (char *)name;
 }
=20
+static int add_directory(struct string_list *result,
+			 const char *name)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *p;
+
+	strbuf_add(&sb, name, strlen(name));
+	while (sb.len && (p =3D strrchr(sb.buf, '/')) !=3D NULL) {
+		strbuf_setlen(&sb, p - sb.buf);
+		if (!match_pathspec(&pathspec, sb.buf, sb.len, 0, NULL, 1))
+			continue;
+		add_one(result, sb.buf, "  ");
+		/*
+		 * sb.buf is leaked, but because this command is
+		 * short-lived anyway so it does not matter much
+		 */
+		return 1;
+	}
+	strbuf_release(&sb);
+	return 0;
+}
+
+static int matched(struct string_list *result, const char *name, int m=
ode)
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
+static int compare_output(const void *a_, const void *b_)
+{
+	const struct string_list_item *a =3D a_;
+	const struct string_list_item *b =3D b_;
+	return strcmp(a->util, b->util);
+}
+
 static void populate_cached_entries(struct string_list *result,
 				    const struct index_state *istate)
 {
@@ -51,14 +98,16 @@ static void populate_cached_entries(struct string_l=
ist *result,
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce =3D istate->cache[i];
=20
-		if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-				    0, NULL,
-				    S_ISDIR(ce->ce_mode) ||
-				    S_ISGITLINK(ce->ce_mode)))
+		if (!matched(result, ce->name, ce->ce_mode))
 			continue;
=20
 		add_one(result, ce->name, "  ");
 	}
+
+	if (!show_dirs)
+		return;
+	qsort(result->items, result->nr, sizeof(*result->items), compare_outp=
ut);
+	string_list_remove_duplicates(result, 0);
 }
=20
 static void cleanup_tags(struct string_list *result)
@@ -145,10 +194,13 @@ int cmd_list_files(int argc, const char **argv, c=
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
 	populate_cached_entries(&result, &the_index);
 	cleanup_tags(&result);
--=20
2.3.0.rc1.137.g477eb31
