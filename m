From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 24/45] add: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:39 +0700
Message-ID: <1363327620-29017-25-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO6y-0006Sb-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab3COG0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:26:49 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34798 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab3COG0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:26:47 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so3943061ieb.17
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=161PLXU9IOhw3i8eyTnmvrNzvgsqhtGUmMehcYx/hV0=;
        b=JcDjw5pTuoKnHZ12ynJcaaYoIwE6uGC+HDNp8tAb2pRnzKpIP6GD8bpYXvWAzmZ17n
         PYBAkMDNBxboz9lyU08qrb5l8WM75WydEd/pIf4wSDpDlI93eMqqsXCeb7rY+DXJDok6
         0FcoSwMZE0phzBjm4WrGCsf9s04EhQqr6zeLt6HXCVXuylcZtErADg7728H2W639AxpX
         mcHCywqi3c/4duGWaAwvA8zcZnQlYGA12C630aLQrtfx2mJtcR1yQKwXxaEpdsCZNfhL
         ZhFWYvUUMvHjFNB8gT2cN1Hx51dtiEDrprzTpcCOMQWy0zhyLycJWO/dkxnZUwrREJAo
         2H8g==
X-Received: by 10.42.203.68 with SMTP id fh4mr3879361icb.36.1363328805996;
        Thu, 14 Mar 2013 23:26:45 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ew5sm756977igc.2.2013.03.14.23.26.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:26:45 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:09:47 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218212>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 100 +++++++++++++++++++++++++-------------------------=
--------
 pathspec.c    |  43 -------------------------
 2 files changed, 43 insertions(+), 100 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ab1c9e8..ec6fbe3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -121,21 +121,6 @@ static char *prune_directory(struct dir_struct *di=
r, const char **pathspec, int
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
@@ -153,25 +138,6 @@ static void refresh(int verbose, const char **path=
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
@@ -203,17 +169,23 @@ int run_add_interactive(const char *revision, con=
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
@@ -354,7 +326,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 {
 	int exit_status =3D 0;
 	int newfd;
-	const char **pathspec;
+	struct pathspec pathspec;
 	struct dir_struct dir;
 	int flags;
 	int add_new_files;
@@ -415,11 +387,19 @@ int cmd_add(int argc, const char **argv, const ch=
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
@@ -432,33 +412,39 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		}
=20
 		/* This picks up the paths that are not tracked */
-		baselen =3D fill_directory(&dir, pathspec);
-		if (pathspec)
-			seen =3D prune_directory(&dir, pathspec, baselen);
+		baselen =3D fill_directory(&dir, pathspec.raw);
+		if (pathspec.nr)
+			seen =3D prune_directory(&dir, pathspec.raw, baselen);
 	}
=20
 	if (refresh_only) {
-		refresh(verbose, pathspec);
+		refresh(verbose, pathspec.raw);
 		goto finish;
 	}
=20
-	if (pathspec) {
+	if (pathspec.nr) {
 		int i;
 		struct path_exclude_check check;
=20
 		path_exclude_check_init(&check, &dir);
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
-					if (is_path_excluded(&check, pathspec[i], -1, &dtype))
-						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
+					if (is_path_excluded(&check, pathspec.raw[i], -1, &dtype))
+						dir_add_ignored(&dir, pathspec.raw[i], strlen(pathspec.raw[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
-					    pathspec[i]);
+					    pathspec.raw[i]);
 			}
 		}
 		free(seen);
@@ -467,7 +453,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 	plug_bulk_checkin();
=20
-	exit_status |=3D add_files_to_cache(prefix, pathspec, flags);
+	exit_status |=3D add_files_to_cache(prefix, pathspec.raw, flags);
=20
 	if (add_new_files)
 		exit_status |=3D add_files(&dir, flags);
diff --git a/pathspec.c b/pathspec.c
index f531038..0b658cb 100644
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
1.8.0.rc0.19.g7bbb31d
