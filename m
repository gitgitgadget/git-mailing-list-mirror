From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/6] exclude: filter patterns by directory level
Date: Sun, 10 Mar 2013 13:14:30 +0700
Message-ID: <1362896070-17456-7-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 07:15:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEZXw-0001SZ-Jh
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 07:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272Ab3CJGPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 01:15:18 -0500
Received: from mail-da0-f45.google.com ([209.85.210.45]:57503 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3CJGPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 01:15:17 -0500
Received: by mail-da0-f45.google.com with SMTP id v40so475688dad.32
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 22:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Y7MsKMoEiAp73AbK4xdP9Xd5YCLYlL3yxHZffxxDTkQ=;
        b=uullfaKojqYr63IYXmPKTKAbDK0oZoSNIE7MtGoTGo5wZybKOOOsWZxYlsKOROeZyt
         39zaqyUal0OemVkMBAkyQYsZtiu5Yx+TParEB22ms/czBX19676wlI5mnGMxvRjc1Z9b
         uqv6h/nwnVJ7960HZlxx715dHIMwZYSeKxb6Jm27nQvin85+Iuua45ebnyP/ZYeYEYcb
         0Cy6pYapExuyPb3hxCfUm5VQ1+jX2PAcXz5AH6HEKNh89Tv6Pq1G47tDJMAdnG3enrD/
         q2ASGXz4tCtJLKV0PNasO+Uwd217LvnT8BwqXD9gqr96cNb8cQqH3mWwMl3/npzWGNff
         QN8g==
X-Received: by 10.68.239.231 with SMTP id vv7mr17059095pbc.171.1362896116155;
        Sat, 09 Mar 2013 22:15:16 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id vd4sm13840718pbc.35.2013.03.09.22.15.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 22:15:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Mar 2013 13:15:10 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217786>

A non-basename pattern that does not contain /**/ can't match anything
outside the attached directory. Record its directory level and avoid
matching unless the pathname is also at the same directory level.

This optimization shines when there are a lot of non-basename patterns
are the root .gitignore and big/deep worktree. Due to the cascading
rule of .gitignore, patterns in the root .gitignore are checked for
_all_ entries in the worktree.

        before      after
user    0m0.424s    0m0.365s
user    0m0.427s    0m0.366s
user    0m0.432s    0m0.374s
user    0m0.435s    0m0.374s
user    0m0.435s    0m0.377s
user    0m0.437s    0m0.381s
user    0m0.439s    0m0.381s
user    0m0.440s    0m0.383s
user    0m0.450s    0m0.384s
user    0m0.454s    0m0.384s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c |  3 ++-
 dir.c  | 68 ++++++++++++++++++++++++++++++++++++++++++++++++----------=
--------
 dir.h  |  9 ++++++++-
 3 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/attr.c b/attr.c
index 1818ba5..7764ddd 100644
--- a/attr.c
+++ b/attr.c
@@ -254,7 +254,8 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 		parse_exclude_pattern(&res->u.pat.pattern,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
-				      &res->u.pat.nowildcardlen);
+				      &res->u.pat.nowildcardlen,
+				      NULL);
 		if (res->u.pat.flags & EXC_FLAG_MUSTBEDIR)
 			res->u.pat.patternlen++;
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
diff --git a/dir.c b/dir.c
index 880b5e6..de7a6ba 100644
--- a/dir.c
+++ b/dir.c
@@ -360,10 +360,12 @@ static int no_wildcard(const char *string)
 void parse_exclude_pattern(const char **pattern,
 			   int *patternlen,
 			   int *flags,
-			   int *nowildcardlen)
+			   int *nowildcardlen,
+			   int *dirs_p)
 {
 	const char *p =3D *pattern;
 	size_t i, len;
+	int dirs;
=20
 	*flags =3D 0;
 	if (*p =3D=3D '!') {
@@ -375,12 +377,15 @@ void parse_exclude_pattern(const char **pattern,
 		len--;
 		*flags |=3D EXC_FLAG_MUSTBEDIR;
 	}
-	for (i =3D 0; i < len; i++) {
+	for (i =3D 0, dirs =3D 0; i < len; i++) {
 		if (p[i] =3D=3D '/')
-			break;
+			dirs++;
 	}
-	if (i =3D=3D len)
+	if (!dirs)
 		*flags |=3D EXC_FLAG_NODIR;
+	else if (*p =3D=3D '/')
+		dirs--;
+
 	*nowildcardlen =3D simple_length(p);
 	/*
 	 * we should have excluded the trailing slash from 'p' too,
@@ -393,6 +398,8 @@ void parse_exclude_pattern(const char **pattern,
 		*flags |=3D EXC_FLAG_ENDSWITH;
 	*pattern =3D p;
 	*patternlen =3D len;
+	if (dirs_p)
+		*dirs_p =3D dirs;
 }
=20
 void add_exclude(const char *string, const char *base,
@@ -402,8 +409,9 @@ void add_exclude(const char *string, const char *ba=
se,
 	int patternlen;
 	int flags;
 	int nowildcardlen;
+	int dirs;
=20
-	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen);
+	parse_exclude_pattern(&string, &patternlen, &flags, &nowildcardlen, &=
dirs);
 	if (flags & EXC_FLAG_MUSTBEDIR) {
 		char *s;
 		x =3D xmalloc(sizeof(*x) + patternlen + 1);
@@ -415,11 +423,26 @@ void add_exclude(const char *string, const char *=
base,
 		x =3D xmalloc(sizeof(*x));
 		x->pattern =3D string;
 	}
+	/*
+	 * TODO: nowildcardlen < patternlen is a stricter than
+	 * necessary mainly to exclude "**" that breaks directory
+	 * boundary. Patterns like "/foo-*" should be fine.
+	 */
+	if ((flags & EXC_FLAG_NODIR) || nowildcardlen < patternlen)
+		dirs =3D -1;
+	else {
+		int i;
+		for (i =3D 0; i < baselen; i++) {
+			if (base[i] =3D=3D '/')
+				dirs++;
+		}
+	}
 	x->patternlen =3D patternlen;
 	x->nowildcardlen =3D nowildcardlen;
 	x->base =3D base;
 	x->baselen =3D baselen;
 	x->flags =3D flags;
+	x->dirs =3D dirs;
 	x->srcpos =3D srcpos;
 	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
 	el->excludes[el->nr++] =3D x;
@@ -701,7 +724,7 @@ int match_pathname(const char *pathname, int pathle=
n,
  * matched, or NULL for undecided.
  */
 static struct exclude *last_exclude_matching_from_list(const char *pat=
hname,
-						       int pathlen,
+						       int pathlen, int dirs,
 						       const char *basename,
 						       int *dtype,
 						       struct exclude_list *el)
@@ -732,6 +755,9 @@ static struct exclude *last_exclude_matching_from_l=
ist(const char *pathname,
 			continue;
 		}
=20
+		if (dirs >=3D 0 && x->dirs >=3D 0 && x->dirs !=3D dirs)
+			continue;
+
 		assert(x->baselen =3D=3D 0 || x->base[x->baselen - 1] =3D=3D '/');
 		if (match_pathname(pathname, pathlen,
 				   x->base, x->baselen ? x->baselen - 1 : 0,
@@ -750,7 +776,8 @@ int is_excluded_from_list(const char *pathname,
 			  struct exclude_list *el)
 {
 	struct exclude *exclude;
-	exclude =3D last_exclude_matching_from_list(pathname, pathlen, basena=
me, dtype, el);
+	exclude =3D last_exclude_matching_from_list(pathname, pathlen, -1,
+						  basename, dtype, el);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return -1; /* undecided */
@@ -765,6 +792,7 @@ int is_excluded_from_list(const char *pathname,
 static struct exclude *last_exclude_matching(struct dir_struct *dir,
 					     const char *pathname,
 					     int pathlen,
+					     int dirs,
 					     int *dtype_p)
 {
 	int i, j;
@@ -779,8 +807,8 @@ static struct exclude *last_exclude_matching(struct=
 dir_struct *dir,
 		group =3D &dir->exclude_list_group[i];
 		for (j =3D group->nr - 1; j >=3D 0; j--) {
 			exclude =3D last_exclude_matching_from_list(
-				pathname, pathlen, basename, dtype_p,
-				&group->el[j]);
+				pathname, pathlen, dir->dir_level,
+				basename, dtype_p, &group->el[j]);
 			if (exclude)
 				return exclude;
 		}
@@ -794,11 +822,11 @@ static struct exclude *last_exclude_matching(stru=
ct dir_struct *dir,
  * Returns 1 if true, otherwise 0.
  */
 static int is_excluded(struct dir_struct *dir,
-		       const char *pathname, int pathlen,
+		       const char *pathname, int pathlen, int dirs,
 		       int *dtype_p)
 {
 	struct exclude *exclude =3D
-		last_exclude_matching(dir, pathname, pathlen, dtype_p);
+		last_exclude_matching(dir, pathname, pathlen, dirs, dtype_p);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
@@ -862,7 +890,7 @@ struct exclude *last_exclude_matching_path(struct p=
ath_exclude_check *check,
 			int dt =3D DT_DIR;
 			exclude =3D last_exclude_matching(check->dir,
 							path->buf, path->len,
-							&dt);
+							-1, &dt);
 			if (exclude) {
 				check->exclude =3D exclude;
 				return exclude;
@@ -874,7 +902,7 @@ struct exclude *last_exclude_matching_path(struct p=
ath_exclude_check *check,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
=20
-	return last_exclude_matching(check->dir, name, namelen, dtype);
+	return last_exclude_matching(check->dir, name, namelen, -1, dtype);
 }
=20
 /*
@@ -1248,11 +1276,11 @@ enum path_treatment {
 };
=20
 static enum path_treatment treat_one_path(struct dir_struct *dir,
-					  struct strbuf *path,
+					  struct strbuf *path, int dirs,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude =3D is_excluded(dir, path->buf, path->len, &dtype);
+	int exclude =3D is_excluded(dir, path->buf, path->len, dirs, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
@@ -1310,7 +1338,7 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
 		return path_ignored;
=20
 	dtype =3D DTYPE(de);
-	return treat_one_path(dir, path, simplify, dtype, de);
+	return treat_one_path(dir, path, -1, simplify, dtype, de);
 }
=20
 /*
@@ -1338,6 +1366,7 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
 	if (!fdir)
 		goto out;
=20
+	dir->dir_level++;
 	while ((de =3D readdir(fdir)) !=3D NULL) {
 		switch (treat_path(dir, de, &path, baselen, simplify)) {
 		case path_recurse:
@@ -1357,6 +1386,7 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
 	}
 	closedir(fdir);
  out:
+	dir->dir_level--;
 	strbuf_release(&path);
=20
 	return contents;
@@ -1427,7 +1457,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 			break;
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
-		if (treat_one_path(dir, &sb, simplify,
+		if (treat_one_path(dir, &sb, -1, simplify,
 				   DT_DIR, NULL) =3D=3D path_ignored)
 			break; /* do not recurse into it */
 		if (len <=3D baselen) {
@@ -1447,8 +1477,10 @@ int read_directory(struct dir_struct *dir, const=
 char *path, int len, const char
 		return dir->nr;
=20
 	simplify =3D create_simplify(pathspec);
-	if (!len || treat_leading_path(dir, path, len, simplify))
+	if (!len || treat_leading_path(dir, path, len, simplify)) {
+		dir->dir_level =3D -1;
 		read_directory_recursive(dir, path, len, 0, simplify);
+	}
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
diff --git a/dir.h b/dir.h
index 560ade4..c434f1c 100644
--- a/dir.h
+++ b/dir.h
@@ -45,6 +45,7 @@ struct exclude_list {
 		const char *base;
 		int baselen;
 		int flags;
+		int dirs;
=20
 		/*
 		 * Counting starts from 1 for line numbers in ignore files,
@@ -87,6 +88,8 @@ struct dir_struct {
 	/* Exclude info */
 	const char *exclude_per_dir;
=20
+	int dir_level;
+
 	/*
 	 * We maintain three groups of exclude pattern lists:
 	 *
@@ -171,7 +174,11 @@ extern struct exclude_list *add_exclude_list(struc=
t dir_struct *dir,
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
-extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
+extern void parse_exclude_pattern(const char **string,
+				  int *patternlen,
+				  int *flags,
+				  int *nowildcardlen,
+				  int *dirs);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
--=20
1.8.1.2.536.gf441e6d
