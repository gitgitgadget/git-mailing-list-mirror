From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 22/21] Convert the last use of match_pathspec() and remove it
Date: Fri, 11 Jan 2013 21:26:31 +0700
Message-ID: <1357914391-28734-1-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-22-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 15:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtfZE-0003R2-Od
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 15:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab3AKO0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 09:26:24 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:45755 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab3AKO0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 09:26:23 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so802467dad.41
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=b2bMHVXw5tZR9Ff5qlpDy95KUDEFvbtKuyD1HB9PEDE=;
        b=p/lUoRimkh/gmXrRYld+SXYNcKHdJ0f2zrupHAOb0UNw9siME9GR0u/ku0p3/c9C2O
         X6VA27SLRdran5IFLUQoHz9ZF4q5OJFOu/mSqWQKwPFkckrUdG0i9s/HUwaE3ounkF5m
         7TYhm4PamqBBtGPn/urXzjCo5GlkYcdOhXbfqS4pDecjjojNw41ePJAkZzBaiC+WRlJf
         sM4VMgaiCExzuXme7bGwh93nUQs97pkidUYfLAaFHPV3RQlQy6Cw6nYoj3DxD3NBbvd4
         GhDFou3Euh2B+f7K7jVWRJb/yX27oYCWSIyW/RiRRF/WtVwrqnSzQubDQe93STW6l0n6
         A72A==
X-Received: by 10.66.77.201 with SMTP id u9mr207543329paw.80.1357914382603;
        Fri, 11 Jan 2013 06:26:22 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id a4sm3188538paw.21.2013.01.11.06.26.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 06:26:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 21:26:36 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-22-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213218>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I was digging the t7400.38 failure and found that add.c is the last
 place that uses match_pathspec(). This is the first yay moment for me
 since 'struct pathspec' was introduced. I wanted to remove this
 function for so long!

 Good luck resolving conflicts by the way ;-)

 builtin/add.c | 47 ++++++++++++-----------------
 dir.c         | 97 ---------------------------------------------------=
--------
 dir.h         |  1 -
 3 files changed, 20 insertions(+), 125 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 6b6a72e..1235eb9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -99,7 +99,7 @@ int add_files_to_cache(const char *prefix,
 	return !!data.add_errors;
 }
=20
-static void fill_pathspec_matches(const char **pathspec, char *seen, i=
nt specs)
+static void fill_pathspec_matches(struct pathspec *pathspec, char *see=
n)
 {
 	int num_unmatched =3D 0, i;
=20
@@ -109,49 +109,43 @@ static void fill_pathspec_matches(const char **pa=
thspec, char *seen, int specs)
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
-static char *find_used_pathspec(const char **pathspec)
+static char *find_used_pathspec(struct pathspec *pathspec)
 {
 	char *seen;
-	int i;
-
-	for (i =3D 0; pathspec[i];  i++)
-		; /* just counting */
-	seen =3D xcalloc(i, 1);
-	fill_pathspec_matches(pathspec, seen, i);
+	seen =3D xcalloc(pathspec->nr, 1);
+	fill_pathspec_matches(pathspec, seen);
 	return seen;
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
-	fill_pathspec_matches(pathspec, seen, specs);
+	fill_pathspec_matches(pathspec, seen);
 	return seen;
 }
=20
@@ -406,7 +400,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		/* This picks up the paths that are not tracked */
 		baselen =3D fill_directory(&dir, &pathspec);
 		if (pathspec.nr)
-			seen =3D prune_directory(&dir, pathspec._raw, baselen);
+			seen =3D prune_directory(&dir, &pathspec, baselen);
 	}
=20
 	if (refresh_only) {
@@ -420,17 +414,16 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
=20
 		path_exclude_check_init(&check, &dir);
 		if (!seen)
-			seen =3D find_used_pathspec(pathspec._raw);
-		for (i =3D 0; pathspec._raw[i]; i++) {
-			if (!seen[i] && pathspec._raw[i][0]
-			    && !file_exists(pathspec._raw[i])) {
+			seen =3D find_used_pathspec(&pathspec);
+		for (i =3D 0; i < pathspec.nr; i++) {
+			const char *path =3D pathspec.items[i].match;
+			if (!seen[i] && !file_exists(path)) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
-					if (path_excluded(&check, pathspec._raw[i], -1, &dtype))
-						dir_add_ignored(&dir, pathspec._raw[i], strlen(pathspec._raw[i])=
);
+					if (path_excluded(&check, path, -1, &dtype))
+						dir_add_ignored(&dir, path, pathspec.items[i].len);
 				} else
-					die(_("pathspec '%s' did not match any files"),
-					    pathspec._raw[i]);
+					die(_("pathspec '%s' did not match any files"), path);
 			}
 		}
 		free(seen);
diff --git a/dir.c b/dir.c
index aad180b..44ff9bb 100644
--- a/dir.c
+++ b/dir.c
@@ -114,103 +114,6 @@ int within_depth(const char *name, int namelen,
  *
  * It returns 0 when there is no match.
  */
-static int match_one(const char *match, const char *name, int namelen)
-{
-	int matchlen;
-
-	/* If the match was just the prefix, we matched */
-	if (!*match)
-		return MATCHED_RECURSIVELY;
-
-	if (ignore_case) {
-		for (;;) {
-			unsigned char c1 =3D tolower(*match);
-			unsigned char c2 =3D tolower(*name);
-			if (c1 =3D=3D '\0' || is_glob_special(c1))
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
-			if (c1 =3D=3D '\0' || is_glob_special(c1))
-				break;
-			if (c1 !=3D c2)
-				return 0;
-			match++;
-			name++;
-			namelen--;
-		}
-	}
-
-
-	/*
-	 * If we don't match the matchstring exactly,
-	 * we need to match by fnmatch
-	 */
-	matchlen =3D strlen(match);
-	if (strncmp_icase(match, name, matchlen))
-		return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;
-
-	if (namelen =3D=3D matchlen)
-		return MATCHED_EXACTLY;
-	if (match[matchlen-1] =3D=3D '/' || name[matchlen] =3D=3D '/')
-		return MATCHED_RECURSIVELY;
-	return 0;
-}
-
-/*
- * Given a name and a list of pathspecs, see if the name matches
- * any of the pathspecs.  The caller is also interested in seeing
- * all pathspec matches some names it calls this function with
- * (otherwise the user could have mistyped the unmatched pathspec),
- * and a mark is left in seen[] array for pathspec element that
- * actually matched anything.
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
index b51d2e9..44e24eb 100644
--- a/dir.h
+++ b/dir.h
@@ -68,7 +68,6 @@ struct dir_struct {
 #define MATCHED_EXACTLY 3
 extern int simple_length(const char *match);
 extern char *common_prefix(const char **pathspec);
-extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
 				const char *name, int namelen,
 				int prefix, char *seen);
--=20
1.8.0.rc2.23.g1fb49df
