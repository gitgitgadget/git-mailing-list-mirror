From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/25] list-files: reduce match_pathspec calls in matched()
Date: Mon,  6 Apr 2015 20:52:30 +0700
Message-ID: <1428328354-14897-22-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7UN-0006AV-Qr
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbbDFNyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:51 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35026 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbbDFNyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:51 -0400
Received: by patj18 with SMTP id j18so45144353pat.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=72BEhSxmWbQvFixDkENeMvdIaBWHybEU5Jl/xARo7qI=;
        b=v9jyJJnyO79qEAOstY2N5wD0xA+zmItd66+RQBm58Mew4mW75DLXYoCCtoexMcvI0E
         Ocuq1pxfEhhxXrCl//9HZ3Y1AjnSssJ+TfJy2LQYlPMYYuDzMJrmeDmk8LReasuYUQ3O
         C5aJ+Nu11eSKrkSDQlIEJNfGg22LDWJ+izaF+mGwr31P6PCBTJZGd7q0JhbuccC+6H3u
         g54c8Ti2naQPZNCgH4vNJFaI7D1BZd6dEeJvymmx7HvetrwAQ3SJPd8/nUcs/przRguL
         Ao7WxnuXSYfyaUl1y5yzyMWAZ/nFNIEHyTgvuODHHkvKxG/RUnPArVQ+apY+eHCAqYgG
         qE5w==
X-Received: by 10.70.1.227 with SMTP id 3mr27313521pdp.110.1428328490434;
        Mon, 06 Apr 2015 06:54:50 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id dl2sm4783252pbc.28.2015.04.06.06.54.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:55:01 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266866>

match_pathspec() is expensive and the loop of match_pathspec() in
add_directory() is even more so. Luckily the output string list is
usually sorted so if we add a directory "builtin", chances are
builtin/foo follows right after. Perform a cheaper strncasecmp() in
this case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 49 +++++++++++++++++++++++++++++++++++++-------=
-----
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 948b8e6..228c39b 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -146,8 +146,8 @@ static void remove_duplicates(struct item_list *lis=
t)
 	list->nr =3D dst;
 }
=20
-static int add_directory(struct item_list *result,
-			 const char *name)
+static const char *add_directory(struct item_list *result,
+				 const char *name)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	struct item *item;
@@ -165,24 +165,37 @@ static int add_directory(struct item_list *result=
,
 		item->path =3D strbuf_detach(&sb, NULL);
 		item->tag[0] =3D ' ';
 		item->tag[1] =3D ' ';
-		return 1;
+		return item->path;
 	}
 	strbuf_release(&sb);
-	return 0;
+	return NULL;
 }
=20
-static int matched(struct item_list *result, const char *name, int mod=
e)
+static int matched(struct item_list *result, const char *name, int mod=
e,
+		   const char **last_directory, int *last_dir_len)
 {
 	int len =3D strlen(name);
=20
+	if (*last_dir_len && len > *last_dir_len) {
+		if (!strncasecmp(name, *last_directory, *last_dir_len) &&
+		    name[*last_dir_len] =3D=3D '/')
+			return 0;
+		*last_dir_len =3D 0;
+	}
+
 	if (!match_pathspec(&recursive_pathspec, name, len, 0, NULL,
 			    S_ISDIR(mode) || S_ISGITLINK(mode)))
 		return 0;
=20
 	if (show_dirs && strchr(name, '/') &&
-	    !match_pathspec(&pathspec, name, len, 0, NULL, 1) &&
-	    add_directory(result, name))
-		return 0;
+	    !match_pathspec(&pathspec, name, len, 0, NULL, 1)) {
+		const char *p =3D add_directory(result, name);
+		if (p) {
+			*last_directory =3D p;
+			*last_dir_len =3D strlen(p);
+			return 0;
+		}
+	}
=20
 	return 1;
 }
@@ -190,6 +203,8 @@ static int matched(struct item_list *result, const =
char *name, int mode)
 static void populate_cached_entries(struct item_list *result,
 				    const struct index_state *istate)
 {
+	const char *last_directory;
+	int last_dir_len =3D 0;
 	int i;
=20
 	if (!show_cached)
@@ -199,7 +214,8 @@ static void populate_cached_entries(struct item_lis=
t *result,
 		const struct cache_entry *ce =3D istate->cache[i];
 		struct item *item;
=20
-		if (!matched(result, ce->name, ce->ce_mode))
+		if (!matched(result, ce->name, ce->ce_mode,
+			     &last_directory, &last_dir_len))
 			continue;
=20
 		ALLOC_GROW(result->items, result->nr + 1, result->alloc);
@@ -236,6 +252,8 @@ static void populate_untracked(struct item_list *re=
sult,
 			       const struct string_list *untracked,
 			       const char *tag)
 {
+	const char *last_directory;
+	int last_dir_len =3D 0;
 	int i;
=20
 	for (i =3D 0; i < untracked->nr; i++) {
@@ -246,7 +264,8 @@ static void populate_untracked(struct item_list *re=
sult,
 			/* color_filename() treats this as an orphan file */
 			st.st_mode =3D 0;
=20
-		if (!matched(result, name, st.st_mode))
+		if (!matched(result, name, st.st_mode,
+			     &last_directory, &last_dir_len))
 			continue;
=20
 		add_wt_item(result, FROM_WORKTREE, name, tag, &st);
@@ -256,6 +275,8 @@ static void populate_untracked(struct item_list *re=
sult,
 static void populate_unmerged(struct item_list *result,
 			      const struct string_list *change)
 {
+	const char *last_directory;
+	int last_dir_len =3D 0;
 	int i;
=20
 	for (i =3D 0; i < change->nr; i++) {
@@ -280,7 +301,8 @@ static void populate_unmerged(struct item_list *res=
ult,
 			/* color_filename() treats this as an orphan file */
 			st.st_mode =3D 0;
=20
-		if (!matched(result, name, st.st_mode))
+		if (!matched(result, name, st.st_mode,
+			     &last_directory, &last_dir_len))
 			continue;
=20
 		add_wt_item(result, IS_UNMERGED, name, tag, &st);
@@ -290,6 +312,8 @@ static void populate_unmerged(struct item_list *res=
ult,
 static void populate_changed(struct item_list *result,
 			     const struct string_list *change)
 {
+	const char *last_directory;
+	int last_dir_len =3D 0;
 	int i;
=20
 	for (i =3D 0; i < change->nr; i++) {
@@ -319,7 +343,8 @@ static void populate_changed(struct item_list *resu=
lt,
 			/* color_filename() treats this as an orphan file */
 			st.st_mode =3D 0;
=20
-		if (!matched(result, name, st.st_mode))
+		if (!matched(result, name, st.st_mode,
+			     &last_directory, &last_dir_len))
 			continue;
=20
 		add_wt_item(result, FROM_DIFF, name, tag, &st);
--=20
2.3.0.rc1.137.g477eb31
