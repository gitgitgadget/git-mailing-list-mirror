From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 37/45] Remove match_pathspec() in favor of match_pathspec_depth()
Date: Fri, 15 Mar 2013 13:06:52 +0700
Message-ID: <1363327620-29017-38-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:28:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO8E-0007pY-LL
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab3COG2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:28:20 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:47350 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3COG2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:28:19 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so4014034ieb.15
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=THF2cmSMZH3xyvLcgMkDsoy1Te2AtedpVRNnWP43IbM=;
        b=W/ZuBOCC73EiTD1vNiPF2uHNH0VRpdKDXwrZHsXMdug0wN+3579Nta7dxcAH7dzPwG
         +aa+7N7ANB3ihKReCxxmKGezVOUty2jIyqEYdlihYCUTFOdkbsLuUJ8FLjC9NIoaZgzt
         +ub4hXyFakz0sPhiYiZAJVjxgKNjh+2WVjqBE32pg20AErc7Yr+MBlBsQ5HWXO41kQlo
         YKv5Bi7gxzCLeE8RVqDnHCmKzGKPDCugLzWFmNmBuxc4mcQbD32HfnbMEy1hhaQcG54w
         5zlzv4uvgwfE1sx1VE7IBl25vpy8eHEZewCN6KDLUk6/3+UvXcP8WmRLrhPTf0dmpULk
         HuIw==
X-Received: by 10.50.216.164 with SMTP id or4mr522620igc.38.1363328898826;
        Thu, 14 Mar 2013 23:28:18 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id g6sm624052ign.4.2013.03.14.23.28.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:28:18 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:11:20 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218224>

match_pathspec_depth was created to replace match_pathspec (see
61cf282 (pathspec: add match_pathspec_depth() - 2010-12-15). It took
more than two years, but the replacement finally happens :-)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c          |  30 +++++++-------
 builtin/check-ignore.c |   4 +-
 dir.c                  | 107 -----------------------------------------=
--------
 dir.h                  |   1 -
 pathspec.c             |  19 ++++-----
 pathspec.h             |   4 +-
 6 files changed, 25 insertions(+), 140 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 70bfc05..aa0709e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -100,26 +100,24 @@ int add_files_to_cache(const char *prefix,
 	return !!data.add_errors;
 }
=20
-static char *prune_directory(struct dir_struct *dir, const char **path=
spec, int prefix)
+static char *prune_directory(struct dir_struct *dir, struct pathspec *=
pathspec, int prefix)
 {
 	char *seen;
-	int i, specs;
+	int i;
 	struct dir_entry **src, **dst;
=20
-	for (specs =3D 0; pathspec[specs];  specs++)
-		/* nothing */;
-	seen =3D xcalloc(specs, 1);
+	seen =3D xcalloc(pathspec->nr, 1);
=20
 	src =3D dst =3D dir->entries;
 	i =3D dir->nr;
 	while (--i >=3D 0) {
 		struct dir_entry *entry =3D *src++;
-		if (match_pathspec(pathspec, entry->name, entry->len,
-				   prefix, seen))
+		if (match_pathspec_depth(pathspec, entry->name, entry->len,
+					 prefix, seen))
 			*dst++ =3D entry;
 	}
 	dir->nr =3D dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, seen, specs);
+	add_pathspec_matches_against_index(pathspec, seen);
 	return seen;
 }
=20
@@ -409,7 +407,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		/* This picks up the paths that are not tracked */
 		baselen =3D fill_directory(&dir, &pathspec);
 		if (pathspec.nr)
-			seen =3D prune_directory(&dir, pathspec.raw, baselen);
+			seen =3D prune_directory(&dir, &pathspec, baselen);
 	}
=20
 	if (refresh_only) {
@@ -423,23 +421,23 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
=20
 		path_exclude_check_init(&check, &dir);
 		if (!seen)
-			seen =3D find_pathspecs_matching_against_index(pathspec.raw);
+			seen =3D find_pathspecs_matching_against_index(&pathspec);
=20
 		/*
 		 * file_exists() assumes exact match
 		 */
 		GUARD_PATHSPEC(&pathspec, PATHSPEC_FROMTOP);
=20
-		for (i =3D 0; pathspec.raw[i]; i++) {
-			if (!seen[i] && pathspec.raw[i][0]
-			    && !file_exists(pathspec.raw[i])) {
+		for (i =3D 0; i < pathspec.nr; i++) {
+			const char *path =3D pathspec.items[i].match;
+			if (!seen[i] && !file_exists(path)) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
-					if (is_path_excluded(&check, pathspec.raw[i], -1, &dtype))
-						dir_add_ignored(&dir, pathspec.raw[i], strlen(pathspec.raw[i]));
+					if (is_path_excluded(&check, path, -1, &dtype))
+						dir_add_ignored(&dir, path, pathspec.items[i].len);
 				} else
 					die(_("pathspec '%s' did not match any files"),
-					    pathspec.raw[i]);
+					    pathspec.items[i].original);
 			}
 		}
 		free(seen);
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 6e55f06..80e6bf7 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -93,9 +93,9 @@ static int check_ignore(int argc, const char **argv, =
const char *prefix)
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen =3D find_pathspecs_matching_against_index(pathspec.raw);
+	seen =3D find_pathspecs_matching_against_index(&pathspec);
 	for (i =3D 0; i < pathspec.nr; i++) {
-		const char *full_path =3D pathspec.raw[i];
+		const char *full_path =3D pathspec.items[i].match;
 		if (!seen[i]) {
 			exclude =3D last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
diff --git a/dir.c b/dir.c
index e354abb..9627d7e 100644
--- a/dir.c
+++ b/dir.c
@@ -140,113 +140,6 @@ int within_depth(const char *name, int namelen,
  *
  * It returns 0 when there is no match.
  */
-static int match_one(const char *match, const char *name, int namelen)
-{
-	int matchlen;
-	int literal =3D limit_pathspec_to_literal();
-
-	/* If the match was just the prefix, we matched */
-	if (!*match)
-		return MATCHED_RECURSIVELY;
-
-	if (ignore_case) {
-		for (;;) {
-			unsigned char c1 =3D tolower(*match);
-			unsigned char c2 =3D tolower(*name);
-			if (c1 =3D=3D '\0' || (!literal && is_glob_special(c1)))
-				break;
-			if (c1 !=3D c2)
-				return 0;
-			match++;
-			name++;
-			namelen--;
-		}
-	} else {
-		for (;;) {
-			unsigned char c1 =3D *match;
-			unsigned char c2 =3D *name;
-			if (c1 =3D=3D '\0' || (!literal && is_glob_special(c1)))
-				break;
-			if (c1 !=3D c2)
-				return 0;
-			match++;
-			name++;
-			namelen--;
-		}
-	}
-
-	/*
-	 * If we don't match the matchstring exactly,
-	 * we need to match by fnmatch
-	 */
-	matchlen =3D strlen(match);
-	if (strncmp_icase(match, name, matchlen)) {
-		if (literal)
-			return 0;
-		return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;
-	}
-
-	if (namelen =3D=3D matchlen)
-		return MATCHED_EXACTLY;
-	if (match[matchlen-1] =3D=3D '/' || name[matchlen] =3D=3D '/')
-		return MATCHED_RECURSIVELY;
-	return 0;
-}
-
-/*
- * Given a name and a list of pathspecs, returns the nature of the
- * closest (i.e. most specific) match of the name to any of the
- * pathspecs.
- *
- * The caller typically calls this multiple times with the same
- * pathspec and seen[] array but with different name/namelen
- * (e.g. entries from the index) and is interested in seeing if and
- * how each pathspec matches all the names it calls this function
- * with.  A mark is left in the seen[] array for each pathspec element
- * indicating the closest type of match that element achieved, so if
- * seen[n] remains zero after multiple invocations, that means the nth
- * pathspec did not match any names, which could indicate that the
- * user mistyped the nth pathspec.
- */
-int match_pathspec(const char **pathspec, const char *name, int namele=
n,
-		int prefix, char *seen)
-{
-	int i, retval =3D 0;
-
-	if (!pathspec)
-		return 1;
-
-	name +=3D prefix;
-	namelen -=3D prefix;
-
-	for (i =3D 0; pathspec[i] !=3D NULL; i++) {
-		int how;
-		const char *match =3D pathspec[i] + prefix;
-		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
-			continue;
-		how =3D match_one(match, name, namelen);
-		if (how) {
-			if (retval < how)
-				retval =3D how;
-			if (seen && seen[i] < how)
-				seen[i] =3D how;
-		}
-	}
-	return retval;
-}
-
-/*
- * Does 'match' match the given name?
- * A match is found if
- *
- * (1) the 'match' string is leading directory of 'name', or
- * (2) the 'match' string is a wildcard and matches 'name', or
- * (3) the 'match' string is exactly the same as 'name'.
- *
- * and the return value tells which case it was.
- *
- * It returns 0 when there is no match.
- */
 static int match_pathspec_item(const struct pathspec_item *item, int p=
refix,
 			       const char *name, int namelen)
 {
diff --git a/dir.h b/dir.h
index d3f76df..13da62c 100644
--- a/dir.h
+++ b/dir.h
@@ -128,7 +128,6 @@ struct dir_struct {
 extern int simple_length(const char *match);
 extern int no_wildcard(const char *string);
 extern char *common_prefix(const struct pathspec *pathspec);
-extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
 				const char *name, int namelen,
 				int prefix, char *seen);
diff --git a/pathspec.c b/pathspec.c
index 767ce65..1ea1c4c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -15,8 +15,8 @@
  * If seen[] has not already been written to, it may make sense
  * to use find_pathspecs_matching_against_index() instead.
  */
-void add_pathspec_matches_against_index(const char **pathspec,
-					char *seen, int specs)
+void add_pathspec_matches_against_index(const struct pathspec *pathspe=
c,
+					char *seen)
 {
 	int num_unmatched =3D 0, i;
=20
@@ -26,14 +26,14 @@ void add_pathspec_matches_against_index(const char =
**pathspec,
 	 * mistakenly think that the user gave a pathspec that did not match
 	 * anything.
 	 */
-	for (i =3D 0; i < specs; i++)
+	for (i =3D 0; i < pathspec->nr; i++)
 		if (!seen[i])
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
 	for (i =3D 0; i < active_nr; i++) {
 		struct cache_entry *ce =3D active_cache[i];
-		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
+		match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, seen);
 	}
 }
=20
@@ -45,15 +45,10 @@ void add_pathspec_matches_against_index(const char =
**pathspec,
  * nature of the "closest" (i.e. most specific) matches which each of =
the
  * given pathspecs achieves against all items in the index.
  */
-char *find_pathspecs_matching_against_index(const char **pathspec)
+char *find_pathspecs_matching_against_index(const struct pathspec *pat=
hspec)
 {
-	char *seen;
-	int i;
-
-	for (i =3D 0; pathspec[i];  i++)
-		; /* just counting */
-	seen =3D xcalloc(i, 1);
-	add_pathspec_matches_against_index(pathspec, seen, i);
+	char *seen =3D xcalloc(pathspec->nr, 1);
+	add_pathspec_matches_against_index(pathspec, seen);
 	return seen;
 }
=20
diff --git a/pathspec.h b/pathspec.h
index 9e9e442..30aea46 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -54,8 +54,8 @@ extern void free_pathspec(struct pathspec *);
=20
 extern int limit_pathspec_to_literal(void);
=20
-extern char *find_pathspecs_matching_against_index(const char **pathsp=
ec);
-extern void add_pathspec_matches_against_index(const char **pathspec, =
char *seen, int specs);
+extern char *find_pathspecs_matching_against_index(const struct pathsp=
ec *pathspec);
+extern void add_pathspec_matches_against_index(const struct pathspec *=
pathspec, char *seen);
 extern const char *check_path_for_gitlink(const char *path);
 extern void die_if_path_beyond_symlink(const char *path, const char *p=
refix);
=20
--=20
1.8.0.rc0.19.g7bbb31d
