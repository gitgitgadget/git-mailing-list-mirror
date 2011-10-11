From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] Implement parse_pathspec()
Date: Wed, 12 Oct 2011 09:44:41 +1100
Message-ID: <1318373083-13840-5-git-send-email-pclouds@gmail.com>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDl4o-0006yI-Rd
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620Ab1JKWp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 18:45:28 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52824 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab1JKWpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:45:25 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so89134vws.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3rv5ZEX0KCpYD8aYIr4qsKPnWCthUkKhYneqiGuBg3A=;
        b=MsM/3A7Rgwdo/U8oep5TgMzaOiwdhQ+VWJK+mzj1zOhWZwkq0Tat2I4wEomXUfN61u
         rhqbVEa5rqBEWJzl18svJDqeou0cMYClpqe2jT0ToZDWYyDgiej8iCQgjR6g0aYZlm3/
         smEafk0khvpK7QYUpm21WkT6nneBMdjT01RUc=
Received: by 10.52.32.230 with SMTP id m6mr20771996vdi.37.1318373125218;
        Tue, 11 Oct 2011 15:45:25 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id hl5sm154264vdb.18.2011.10.11.15.45.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 15:45:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 09:45:17 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183338>

This function is the same as get_pathspec() except that it produces
struct pathspec directly.

no_prefix code path is necessary because init_pathspec() can be called
without get_pathspec_old() in "diff --no-index" case. Without this
exception, prefix_path() will be eventually called and die because
there is not worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    5 ++++
 dir.c   |   82 ++++++++++++++++++++++++++++++++++++++++++++++---------=
-------
 setup.c |    4 +-
 3 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index 17df06f..719d4a3 100644
--- a/cache.h
+++ b/cache.h
@@ -443,6 +443,9 @@ extern void set_git_work_tree(const char *tree);
=20
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
+struct pathspec_item;
+extern const char *prefix_pathspec(struct pathspec_item *item, const c=
har *prefix,
+				   int prefixlen, const char *elt);
 extern const char **get_pathspec(const char *prefix, const char **path=
spec);
 extern const char *pathspec_prefix(const char *prefix, const char **pa=
thspec);
 extern void setup_work_tree(void);
@@ -554,6 +557,8 @@ struct pathspec {
 };
=20
 extern int init_pathspec(struct pathspec *, const char **);
+extern int parse_pathspec(struct pathspec *pathspec, const char *prefi=
x,
+			  int argc, const char **argv);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
=20
diff --git a/dir.c b/dir.c
index 6c82615..d38af0f 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,8 @@ static int read_directory_recursive(struct dir_struct=
 *dir, const char *path, in
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
+static const char *no_prefix =3D "We do not want outside repository ch=
eck.";
+
 /* helper string functions with support for the ignore_case flag */
 int strcmp_icase(const char *a, const char *b)
 {
@@ -1252,34 +1254,62 @@ static int pathspec_item_cmp(const void *a_, co=
nst void *b_)
 	return strcmp(a->match, b->match);
 }
=20
-int init_pathspec(struct pathspec *pathspec, const char **paths)
+extern const char *prefix_pathspec(struct pathspec_item *item, const c=
har *prefix,
+				   int prefixlen, const char *elt);
+int parse_pathspec(struct pathspec *pathspec, const char *prefix,
+		   int argc, const char **argv)
 {
-	const char **p =3D paths;
-	int i;
+	struct pathspec_item *pitem;
+	const char **dst;
+	int prefixlen;
=20
 	memset(pathspec, 0, sizeof(*pathspec));
-	if (!p)
-		return 0;
-	while (*p)
-		p++;
-	pathspec->raw =3D paths;
-	pathspec->nr =3D p - paths;
-	pathspec->magic =3D PATHSPEC_NOGLOB;
-	if (!pathspec->nr)
+
+	if (argc =3D=3D -1) {
+		argc =3D 0;
+		for (dst =3D argv; *dst; dst++)
+			argc++;
+	}
+
+	if ((!prefix || prefix =3D=3D no_prefix) && !argc)
 		return 0;
=20
-	pathspec->items =3D xmalloc(sizeof(struct pathspec_item)*pathspec->nr=
);
-	memset(pathspec->items, 0, sizeof(struct pathspec_item)*pathspec->nr)=
;
-	for (i =3D 0; i < pathspec->nr; i++) {
-		struct pathspec_item *item =3D pathspec->items+i;
-		const char *path =3D paths[i];
+	if (!argc) {
+		static const char *spec[2];
+		spec[0] =3D prefix;
+		spec[1] =3D NULL;
+		init_pathspec(pathspec, spec);
+		pathspec->items[0].plain_len =3D pathspec->items[0].len;
+		return 0;
+	}
=20
-		item->match =3D path;
-		item->len =3D strlen(path);
-		if (no_wildcard(path))
-			item->magic |=3D PATHSPEC_NOGLOB;
+	prefixlen =3D prefix && prefix !=3D no_prefix ? strlen(prefix) : 0;
+	pathspec->nr =3D argc; /* be optimistic, lower it later if necessary =
*/
+	pathspec->items =3D xmalloc(sizeof(struct pathspec_item) * argc);
+	pathspec->raw =3D argv;
+	pathspec->magic =3D PATHSPEC_NOGLOB;
+	pitem =3D pathspec->items;
+	dst =3D argv;
+
+	while (*argv) {
+		if (prefix =3D=3D no_prefix) {
+			memset(pitem, 0, sizeof(*pitem));
+			pitem->match =3D *argv;
+			pitem->len =3D strlen(pitem->match);
+		}
+		else
+			prefix_pathspec(pitem, prefix, prefixlen, *argv);
+		*dst =3D *argv++;
+		if (pitem->match && pitem->len) {
+			if (no_wildcard(pitem->match + pitem->plain_len))
+				pitem->magic |=3D PATHSPEC_NOGLOB;
+			else
+				pathspec->magic &=3D ~PATHSPEC_NOGLOB;
+			pitem++;
+			dst++;
+		}
 		else
-			pathspec->magic &=3D ~PATHSPEC_NOGLOB;
+			pathspec->nr--;
 	}
=20
 	qsort(pathspec->items, pathspec->nr,
@@ -1288,8 +1318,18 @@ int init_pathspec(struct pathspec *pathspec, con=
st char **paths)
 	return 0;
 }
=20
+int init_pathspec(struct pathspec *pathspec, const char **paths)
+{
+	const char **p =3D paths;
+	while (p && *p)
+		p++;
+	return parse_pathspec(pathspec, no_prefix, p - paths, paths);
+}
+
 void free_pathspec(struct pathspec *pathspec)
 {
+	/* memory leak: pathspec_item->match likely be xstrdup'd by
+	   prefix_pathspec */
 	free(pathspec->items);
 	pathspec->items =3D NULL;
 }
diff --git a/setup.c b/setup.c
index 8f1c2c0..b074210 100644
--- a/setup.c
+++ b/setup.c
@@ -126,8 +126,8 @@ static struct pathspec_magic {
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-static const char *prefix_pathspec(struct pathspec_item *item, const c=
har *prefix,
-				   int prefixlen, const char *elt)
+const char *prefix_pathspec(struct pathspec_item *item, const char *pr=
efix,
+			    int prefixlen, const char *elt)
 {
 	unsigned magic =3D 0;
 	const char *copyfrom =3D elt;
--=20
1.7.3.1.256.g2539c.dirty
