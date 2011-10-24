From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 11/11] dir.c: remove dead code after read_directory() rewrite
Date: Mon, 24 Oct 2011 17:36:16 +1100
Message-ID: <1319438176-7304-12-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIECT-00014w-NX
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab1JXGjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:39:53 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51752 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1JXGjw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:39:52 -0400
Received: by ggnb1 with SMTP id b1so5422440ggn.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gCf5j4CpEmkTfWg4MVhAAsSjyc49+o6FFVcdo1NAGR0=;
        b=kc3o6vwCiwlNJM73rShlWPMgg91RZkbQpgGKNJnbisBywGiNZt5sUi0y1QiI9UIbKu
         JW63rzHxYxtgdAnuDXrBqcrqAiDqkPQ9BZg2hVCBQk8COI0+/g4jJpptEGB7ko8gDW8R
         Vixk2yFwQ6NptU1SCqeKdO5yK3Dfj9TiTlLd8=
Received: by 10.236.124.4 with SMTP id w4mr32698450yhh.30.1319438391990;
        Sun, 23 Oct 2011 23:39:51 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id r30sm31163182yhj.20.2011.10.23.23.39.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:39:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:38:11 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184164>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |  121 ---------------------------------------------------------=
--------
 dir.h |    3 --
 2 files changed, 0 insertions(+), 124 deletions(-)

diff --git a/dir.c b/dir.c
index 2946b2d..4094962 100644
--- a/dir.c
+++ b/dir.c
@@ -11,11 +11,6 @@
 #include "tree-walk.h"
 #include "string-list.h"
=20
-struct path_simplify {
-	int len;
-	const char *path;
-};
-
 static int read_directory_recursive(struct dir_struct *dir,
 				    struct strbuf *base,
 				    int check_only,
@@ -604,15 +599,6 @@ static struct dir_entry *dir_add_name(struct dir_s=
truct *dir, const char *pathna
 	return dir->entries[dir->nr++] =3D dir_entry_new(pathname, len);
 }
=20
-struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len)
-{
-	if (!cache_name_is_other(pathname, len))
-		return NULL;
-
-	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
-	return dir->ignored[dir->ignored_nr++] =3D dir_entry_new(pathname, le=
n);
-}
-
 /* Read and convert directory to tree object (with invalid SHA-1) */
 static void* dir_to_tree(struct strbuf *path, unsigned long *size)
 {
@@ -845,31 +831,6 @@ static enum directory_treatment treat_directory(st=
ruct dir_struct *dir,
 }
=20
 /*
- * This is an inexact early pruning of any recursive directory
- * reading - if the path cannot possibly be in the pathspec,
- * return true, and we'll skip it early.
- */
-static int simplify_away(const char *path, int pathlen, const struct p=
ath_simplify *simplify)
-{
-	if (simplify) {
-		for (;;) {
-			const char *match =3D simplify->path;
-			int len =3D simplify->len;
-
-			if (!match)
-				break;
-			if (len > pathlen)
-				len =3D pathlen;
-			if (!memcmp(path, match, len))
-				return 0;
-			simplify++;
-		}
-		return 1;
-	}
-	return 0;
-}
-
-/*
  * This function flags pathspecs that are completely excluded, which
  * usually means an input mistake. In other words, if all matched
  * _files_ of a pathspec are excluded, flag the pathspec.
@@ -1087,88 +1048,6 @@ static int cmp_name(const void *p1, const void *=
p2)
 				  e2->name, e2->len);
 }
=20
-/*
- * Return the length of the "simple" part of a path match limiter.
- */
-static int simple_length(const char *match)
-{
-	int len =3D -1;
-
-	for (;;) {
-		unsigned char c =3D *match++;
-		len++;
-		if (c =3D=3D '\0' || is_glob_special(c))
-			return len;
-	}
-}
-
-static struct path_simplify *create_simplify(const char **pathspec)
-{
-	int nr, alloc =3D 0;
-	struct path_simplify *simplify =3D NULL;
-
-	if (!pathspec)
-		return NULL;
-
-	for (nr =3D 0 ; ; nr++) {
-		const char *match;
-		if (nr >=3D alloc) {
-			alloc =3D alloc_nr(alloc);
-			simplify =3D xrealloc(simplify, alloc * sizeof(*simplify));
-		}
-		match =3D *pathspec++;
-		if (!match)
-			break;
-		simplify[nr].path =3D match;
-		simplify[nr].len =3D simple_length(match);
-	}
-	simplify[nr].path =3D NULL;
-	simplify[nr].len =3D 0;
-	return simplify;
-}
-
-static void free_simplify(struct path_simplify *simplify)
-{
-	free(simplify);
-}
-
-#if 0
-static int treat_leading_path(struct dir_struct *dir,
-			      const char *path, int len,
-			      const struct path_simplify *simplify)
-{
-	char pathbuf[PATH_MAX];
-	int baselen, blen;
-	const char *cp;
-
-	while (len && path[len - 1] =3D=3D '/')
-		len--;
-	if (!len)
-		return 1;
-	baselen =3D 0;
-	while (1) {
-		cp =3D path + baselen + !!baselen;
-		cp =3D memchr(cp, '/', path + len - cp);
-		if (!cp)
-			baselen =3D len;
-		else
-			baselen =3D cp - path;
-		memcpy(pathbuf, path, baselen);
-		pathbuf[baselen] =3D '\0';
-		if (!is_directory(pathbuf))
-			return 0;
-		if (simplify_away(pathbuf, baselen, simplify))
-			return 0;
-		blen =3D baselen;
-		if (treat_one_path(dir, pathbuf, &blen, simplify,
-				   DT_DIR, NULL) =3D=3D path_ignored)
-			return 0; /* do not recurse into it */
-		if (len <=3D baselen)
-			return 1; /* finished checking */
-	}
-}
-#endif
-
 int read_directory(struct dir_struct *dir, const char *path, int len,
 		   const char **pathspec)
 {
diff --git a/dir.h b/dir.h
index 362d7b1..7a7d818 100644
--- a/dir.h
+++ b/dir.h
@@ -33,7 +33,6 @@ struct exclude_stack {
=20
 struct dir_struct {
 	int nr, alloc;
-	int ignored_nr, ignored_alloc;
 	enum {
 		DIR_SHOW_IGNORED =3D 1<<0,
 		DIR_SHOW_OTHER_DIRECTORIES =3D 1<<1,
@@ -42,7 +41,6 @@ struct dir_struct {
 		DIR_COLLECT_IGNORED =3D 1<<4
 	} flags;
 	struct dir_entry **entries;
-	struct dir_entry **ignored;
 	int *useful;
=20
 	/* Include info (a joint of ps1 and ps2) */
@@ -82,7 +80,6 @@ extern int read_directory(struct dir_struct *, const =
char *path, int len, const
 extern int excluded_from_list(const char *pathname, int pathlen, const=
 char *basename,
 			      int *dtype, struct exclude_list *el);
 extern int excluded(struct dir_struct *, const char *, int *);
-struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *=
pathname, int len);
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  char **buf_p, struct exclude_list *which, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
--=20
1.7.3.1.256.g2539c.dirty
