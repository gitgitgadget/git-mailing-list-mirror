From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/45] add: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:56 +0700
Message-ID: <1370759178-1709-24-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ64-0000qu-73
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab3FIG1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:27:19 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:51650 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab3FIG1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:27:18 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so6297169pdi.11
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+Fmnx1nMfshYV98+vPqvFRxkWUTdLaClCAdLmNgys0Y=;
        b=zKWWvA5FR5urZR4EgXD1tUpP138DPz82uRucj5guBhjP12wV0kArlzuJM2Xtt/fRsG
         mnPdCbPBKnVhqkNs4ZN2Whu2Z97ydnJcIfuEQug8OlQoUwAK/+qQeVBfJXj7iGSqMzt2
         HXipVCPOUqYv+EHxaXauzF+a3oVlVNDScLo6jLHwRJHBaVV7kxlqbOOc5VcI6MOHECFK
         nMl2wxCHp4v/gyYNJkKYMmPe/BFOCUi0EhNeEl15hpWhO3oJAWVzzNSgFaIncQ9u4PgX
         d1a+M9PQblZub4vjH+bGYuBky8GnEuNYBa8y84tOJLjAOXiQPIV21rhLqAL39a1BSFP6
         omEw==
X-Received: by 10.66.253.9 with SMTP id zw9mr9479147pac.35.1370759238449;
        Sat, 08 Jun 2013 23:27:18 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id xz1sm10267032pab.5.2013.06.08.23.27.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:27:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:49 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226915>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 103 +++++++++++++++++++++++++-------------------------=
--------
 pathspec.c    |  43 ------------------------
 2 files changed, 45 insertions(+), 101 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f45d9d4..9a7235e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -226,21 +226,6 @@ static char *prune_directory(struct dir_struct *di=
r, const char **pathspec,
 	return seen;
 }
=20
-/*
- * Checks the index to see whether any path in pathspec refers to
- * something inside a submodule.  If so, dies with an error message.
- */
-static void treat_gitlinks(const char **pathspec)
-{
-	int i;
-
-	if (!pathspec || !*pathspec)
-		return;
-
-	for (i =3D 0; pathspec[i]; i++)
-		pathspec[i] =3D check_path_for_gitlink(pathspec[i]);
-}
-
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
@@ -258,25 +243,6 @@ static void refresh(int verbose, const char **path=
spec)
         free(seen);
 }
=20
-/*
- * Normalizes argv relative to prefix, via get_pathspec(), and then
- * runs die_if_path_beyond_symlink() on each path in the normalized
- * list.
- */
-static const char **validate_pathspec(const char **argv, const char *p=
refix)
-{
-	const char **pathspec =3D get_pathspec(prefix, argv);
-
-	if (pathspec) {
-		const char **p;
-		for (p =3D pathspec; *p; p++) {
-			die_if_path_beyond_symlink(*p, prefix);
-		}
-	}
-
-	return pathspec;
-}
-
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const char **pathspec)
 {
@@ -308,17 +274,23 @@ int run_add_interactive(const char *revision, con=
st char *patch_mode,
=20
 int interactive_add(int argc, const char **argv, const char *prefix, i=
nt patch)
 {
-	const char **pathspec =3D NULL;
+	struct pathspec pathspec;
=20
-	if (argc) {
-		pathspec =3D validate_pathspec(argv, prefix);
-		if (!pathspec)
-			return -1;
-	}
+	/*
+	 * git-add--interactive itself does not parse pathspec. It
+	 * simply passes the pathspec to other builtin commands. Let's
+	 * hope all of them support all magic, or we'll need to limit
+	 * the magic here. There is still a problem with prefix. But
+	 * that'll be worked on later on.
+	 */
+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
+		       PATHSPEC_PREFER_FULL |
+		       PATHSPEC_SYMLINK_LEADING_PATH,
+		       prefix, argv);
=20
 	return run_add_interactive(NULL,
 				   patch ? "--patch" : NULL,
-				   pathspec);
+				   pathspec.raw);
 }
=20
 static int edit_patch(int argc, const char **argv, const char *prefix)
@@ -445,7 +417,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 {
 	int exit_status =3D 0;
 	int newfd;
-	const char **pathspec;
+	struct pathspec pathspec;
 	struct dir_struct dir;
 	int flags;
 	int add_new_files;
@@ -526,11 +498,19 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
-	pathspec =3D validate_pathspec(argv, prefix);
=20
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-	treat_gitlinks(pathspec);
+
+	/*
+	 * Check the "pathspec '%s' did not match any files" block
+	 * below before enabling new magic.
+	 */
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_FULL |
+		       PATHSPEC_SYMLINK_LEADING_PATH |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE,
+		       prefix, argv);
=20
 	if (add_new_files) {
 		int baselen;
@@ -543,34 +523,40 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		}
=20
 		/* This picks up the paths that are not tracked */
-		baselen =3D fill_directory(&dir, implicit_dot ? NULL : pathspec);
-		if (pathspec)
-			seen =3D prune_directory(&dir, pathspec, baselen,
+		baselen =3D fill_directory(&dir, implicit_dot ? NULL : pathspec.raw)=
;
+		if (pathspec.nr)
+			seen =3D prune_directory(&dir, pathspec.raw, baselen,
 					implicit_dot ? WARN_IMPLICIT_DOT : 0);
 	}
=20
 	if (refresh_only) {
-		refresh(verbose, pathspec);
+		refresh(verbose, pathspec.raw);
 		goto finish;
 	}
 	if (implicit_dot && prefix)
 		refresh_cache(REFRESH_QUIET);
=20
-	if (pathspec) {
+	if (pathspec.nr) {
 		int i;
=20
 		if (!seen)
-			seen =3D find_pathspecs_matching_against_index(pathspec);
-		for (i =3D 0; pathspec[i]; i++) {
-			if (!seen[i] && pathspec[i][0]
-			    && !file_exists(pathspec[i])) {
+			seen =3D find_pathspecs_matching_against_index(pathspec.raw);
+
+		/*
+		 * file_exists() assumes exact match
+		 */
+		GUARD_PATHSPEC(&pathspec, PATHSPEC_FROMTOP);
+
+		for (i =3D 0; pathspec.raw[i]; i++) {
+			if (!seen[i] && pathspec.raw[i][0]
+			    && !file_exists(pathspec.raw[i])) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
-					if (is_excluded(&dir, pathspec[i], &dtype))
-						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
+					if (is_excluded(&dir, pathspec.raw[i], &dtype))
+						dir_add_ignored(&dir, pathspec.raw[i], strlen(pathspec.raw[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
-					    pathspec[i]);
+					    pathspec.raw[i]);
 			}
 		}
 		free(seen);
@@ -586,10 +572,11 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		 */
 		update_data.implicit_dot =3D prefix;
 		update_data.implicit_dot_len =3D strlen(prefix);
-		pathspec =3D NULL;
+		free_pathspec(&pathspec);
+		memset(&pathspec, 0, sizeof(pathspec));
 	}
 	update_data.flags =3D flags & ~ADD_CACHE_IMPLICIT_DOT;
-	update_files_in_cache(prefix, pathspec, &update_data);
+	update_files_in_cache(prefix, pathspec.raw, &update_data);
=20
 	exit_status |=3D !!update_data.add_errors;
 	if (add_new_files)
diff --git a/pathspec.c b/pathspec.c
index 152f9b5..ecd0f28 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -58,49 +58,6 @@ char *find_pathspecs_matching_against_index(const ch=
ar **pathspec)
 }
=20
 /*
- * Check the index to see whether path refers to a submodule, or
- * something inside a submodule.  If the former, returns the path with
- * any trailing slash stripped.  If the latter, dies with an error
- * message.
- */
-const char *check_path_for_gitlink(const char *path)
-{
-	int i, path_len =3D strlen(path);
-	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
-		if (S_ISGITLINK(ce->ce_mode)) {
-			int ce_len =3D ce_namelen(ce);
-			if (path_len <=3D ce_len || path[ce_len] !=3D '/' ||
-			    memcmp(ce->name, path, ce_len))
-				/* path does not refer to this
-				 * submodule or anything inside it */
-				continue;
-			if (path_len =3D=3D ce_len + 1) {
-				/* path refers to submodule;
-				 * strip trailing slash */
-				return xstrndup(ce->name, ce_len);
-			} else {
-				die (_("Path '%s' is in submodule '%.*s'"),
-				     path, ce_len, ce->name);
-			}
-		}
-	}
-	return path;
-}
-
-/*
- * Dies if the given path refers to a file inside a symlinked
- * directory in the index.
- */
-void die_if_path_beyond_symlink(const char *path, const char *prefix)
-{
-	if (has_symlink_leading_path(path, strlen(path))) {
-		int len =3D prefix ? strlen(prefix) : 0;
-		die(_("'%s' is beyond a symbolic link"), path + len);
-	}
-}
-
-/*
  * Magic pathspec
  *
  * Possible future magic semantics include stuff like:
--=20
1.8.2.83.gc99314b
