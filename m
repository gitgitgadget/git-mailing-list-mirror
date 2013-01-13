From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 29/31] Remove match_pathspec() in favor of match_pathspec_depth()
Date: Sun, 13 Jan 2013 19:35:37 +0700
Message-ID: <1358080539-17436-30-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:39:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMqZ-0000J9-Bk
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab3AMMjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:39:10 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41318 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab3AMMjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:39:09 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so1754305pad.13
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lu2MuTwLrF1Vc6IQYol9mG6bv1CpNvKK8VP+GP+g9EU=;
        b=nCDcpFES8YhjE0z4rKyQ9L+L2LOX9bHUlFi6HrNZqdCKQK4jVNYXmJpRaCVNGo9ukb
         2SLIkXz3GxAiF4P9++fAPqfQ8QEZ75CIxFTjUHEIDFNfYUZhDeBxxkrOtj/1ZKOhgE9m
         Ww/m77hnazl/zuHknXMuABK8rZYgxipyx820fOND0l1BKlykDdzy43xpVMYQ0DzdGH+o
         UesgQ6wHb5F9Tzvidrvy+IhL4qbgy0U7/5V+vBa6nTqga3c29Z8+qfGH5uaB0D/HyYRL
         r59+A3eKTEJi9fPlg8W9ASjnStVhLLO+hCzNYjZMwz8D/MMD4/cEhRkfjGFTpzrJeIIm
         8MlA==
X-Received: by 10.66.80.65 with SMTP id p1mr222590494pax.20.1358080748927;
        Sun, 13 Jan 2013 04:39:08 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id k4sm6755633paz.26.2013.01.13.04.39.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:39:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:39:19 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213370>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c |  46 ++++++++++++---------------
 dir.c         | 100 --------------------------------------------------=
--------
 dir.h         |   1 -
 3 files changed, 20 insertions(+), 127 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 89ae67d..9edab95 100644
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
@@ -401,7 +395,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		/* This picks up the paths that are not tracked */
 		baselen =3D fill_directory(&dir, &pathspec);
 		if (pathspec.nr)
-			seen =3D prune_directory(&dir, pathspec.raw, baselen);
+			seen =3D prune_directory(&dir, &pathspec, baselen);
 	}
=20
 	if (refresh_only) {
@@ -415,23 +409,23 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
=20
 		path_exclude_check_init(&check, &dir);
 		if (!seen)
-			seen =3D find_used_pathspec(pathspec.raw);
+			seen =3D find_used_pathspec(&pathspec);
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
diff --git a/dir.c b/dir.c
index 76b267e..2a1bcb8 100644
--- a/dir.c
+++ b/dir.c
@@ -139,106 +139,6 @@ int within_depth(const char *name, int namelen,
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
index ff5ada5..a03af80 100644
--- a/dir.h
+++ b/dir.h
@@ -91,7 +91,6 @@ struct dir_struct {
 extern int simple_length(const char *match);
 extern int no_wildcard(const char *string);
 extern char *common_prefix(const struct pathspec *pathspec);
-extern int match_pathspec(const char **pathspec, const char *name, int=
 namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
 				const char *name, int namelen,
 				int prefix, char *seen);
--=20
1.8.0.rc2.23.g1fb49df
