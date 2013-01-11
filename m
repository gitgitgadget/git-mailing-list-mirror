From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/21] add: convert to use parse_pathspec
Date: Fri, 11 Jan 2013 18:21:06 +0700
Message-ID: <1357903275-16804-13-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttch5-0007On-5w
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617Ab3AKLWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:22:19 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:52133 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab3AKLWS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:22:18 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so738549dak.28
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=7H6EFfyRs0bjbjd4kzPoIrCnw5wRRmNtDpDwSTI+ySk=;
        b=MwXJ6Anbjqth/gvNG/GcfggpEY1QveGpZmUNp4rLoedUfnElw+OT4qzzKA92xPeEZs
         gmKHFBomCdqfT9ekVsSLWvL9oBb+pRIs7pvKhL2N4M88gKtCegy+hH9Ymcgjsh+GUfDt
         IRdUBeap/3AaMYQ9bcCIYyESowk5ZUBmaGxYA6Inlqz+V6wXrvdX72uIL2SXxQiF9L8E
         vXCQCqdUhM8cjRBqjdy0oeAFbwBBcVdWzQbkmAsoCj19lsHbmAKpZAZARhDWD6p8dCWo
         crecbXEXq0I6Y72DbS8g1Lr1WBlqPwzHUAuASv1gZG8MFceDRq/KZb+dAq3MjQfIrVZs
         6cIQ==
X-Received: by 10.68.131.73 with SMTP id ok9mr229884099pbb.83.1357903337832;
        Fri, 11 Jan 2013 03:22:17 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id ti9sm2641420pbc.16.2013.01.11.03.22.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:22:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:22:27 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213205>

treat_gitlinks() modifies pathspec and is moved to dir.c, close to
other pathspec code. It'll be removed later when parse_pathspec()
learns to take over its job. Note that treat_gitlinks() and
strip_trailing_slash_from_submodules() do not perform exactly the same
thing. But that does not matter for now.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 84 ++++++++++++++++++++-------------------------------=
--------
 cache.h       |  1 +
 dir.c         | 32 +++++++++++++++++++++++
 3 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e664100..c8592fe 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -153,33 +153,6 @@ static char *prune_directory(struct dir_struct *di=
r, const char **pathspec, int
 	return seen;
 }
=20
-static void treat_gitlinks(const char **pathspec)
-{
-	int i;
-
-	if (!pathspec || !*pathspec)
-		return;
-
-	for (i =3D 0; i < active_nr; i++) {
-		struct cache_entry *ce =3D active_cache[i];
-		if (S_ISGITLINK(ce->ce_mode)) {
-			int len =3D ce_namelen(ce), j;
-			for (j =3D 0; pathspec[j]; j++) {
-				int len2 =3D strlen(pathspec[j]);
-				if (len2 <=3D len || pathspec[j][len] !=3D '/' ||
-				    memcmp(ce->name, pathspec[j], len))
-					continue;
-				if (len2 =3D=3D len + 1)
-					/* strip trailing slash */
-					pathspec[j] =3D xstrndup(ce->name, len);
-				else
-					die (_("Path '%s' is in submodule '%.*s'"),
-						pathspec[j], len, ce->name);
-			}
-		}
-	}
-}
-
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
@@ -197,21 +170,18 @@ static void refresh(int verbose, const char **pat=
hspec)
         free(seen);
 }
=20
-static const char **validate_pathspec(int argc, const char **argv, con=
st char *prefix)
+static void validate_pathspec(const char **pathspec, const char *prefi=
x)
 {
-	const char **pathspec =3D get_pathspec(prefix, argv);
-
-	if (pathspec) {
-		const char **p;
-		for (p =3D pathspec; *p; p++) {
-			if (has_symlink_leading_path(*p, strlen(*p))) {
-				int len =3D prefix ? strlen(prefix) : 0;
-				die(_("'%s' is beyond a symbolic link"), *p + len);
-			}
+	const char **p;
+	if (!pathspec)
+		return;
+
+	for (p =3D pathspec; *p; p++) {
+		if (has_symlink_leading_path(*p, strlen(*p))) {
+			int len =3D prefix ? strlen(prefix) : 0;
+			die(_("'%s' is beyond a symbolic link"), *p + len);
 		}
 	}
-
-	return pathspec;
 }
=20
 int run_add_interactive(const char *revision, const char *patch_mode,
@@ -248,7 +218,8 @@ int interactive_add(int argc, const char **argv, co=
nst char *prefix, int patch)
 	const char **pathspec =3D NULL;
=20
 	if (argc) {
-		pathspec =3D validate_pathspec(argc, argv, prefix);
+		pathspec =3D get_pathspec(prefix, argv);
+		validate_pathspec(pathspec, prefix);
 		if (!pathspec)
 			return -1;
 	}
@@ -367,7 +338,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 {
 	int exit_status =3D 0;
 	int newfd;
-	const char **pathspec;
+	struct pathspec pathspec;
 	struct dir_struct dir;
 	int flags;
 	int add_new_files;
@@ -415,11 +386,12 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
-	pathspec =3D validate_pathspec(argc, argv, prefix);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
+	validate_pathspec(pathspec.raw, prefix);
=20
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-	treat_gitlinks(pathspec);
+	treat_gitlinks(&pathspec);
=20
 	if (add_new_files) {
 		int baselen;
@@ -432,33 +404,33 @@ int cmd_add(int argc, const char **argv, const ch=
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
-			seen =3D find_used_pathspec(pathspec);
-		for (i =3D 0; pathspec[i]; i++) {
-			if (!seen[i] && pathspec[i][0]
-			    && !file_exists(pathspec[i])) {
+			seen =3D find_used_pathspec(pathspec.raw);
+		for (i =3D 0; pathspec.raw[i]; i++) {
+			if (!seen[i] && pathspec.raw[i][0]
+			    && !file_exists(pathspec.raw[i])) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
-					if (path_excluded(&check, pathspec[i], -1, &dtype))
-						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
+					if (path_excluded(&check, pathspec.raw[i], -1, &dtype))
+						dir_add_ignored(&dir, pathspec.raw[i], strlen(pathspec.raw[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
-					    pathspec[i]);
+					    pathspec.raw[i]);
 			}
 		}
 		free(seen);
@@ -467,7 +439,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 	plug_bulk_checkin();
=20
-	exit_status |=3D add_files_to_cache(prefix, pathspec, flags);
+	exit_status |=3D add_files_to_cache(prefix, pathspec.raw, flags);
=20
 	if (add_new_files)
 		exit_status |=3D add_files(&dir, flags);
diff --git a/cache.h b/cache.h
index 62eefb1..af96376 100644
--- a/cache.h
+++ b/cache.h
@@ -497,6 +497,7 @@ extern void parse_pathspec(struct pathspec *pathspe=
c, unsigned magic,
 			   unsigned flags, const char *prefix,
 			   const char **args);
 void strip_trailing_slash_from_submodules(struct pathspec *pathspec);
+void treat_gitlinks(struct pathspec *pathspec);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
=20
diff --git a/dir.c b/dir.c
index 4be3ca1..4d1f71c 100644
--- a/dir.c
+++ b/dir.c
@@ -1460,6 +1460,38 @@ void strip_trailing_slash_from_submodules(struct=
 pathspec *pathspec)
 	}
 }
=20
+void treat_gitlinks(struct pathspec *pathspec)
+{
+	int i;
+
+	for (i =3D 0; i < active_nr; i++) {
+		struct cache_entry *ce =3D active_cache[i];
+		int len =3D ce_namelen(ce), j;
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		for (j =3D 0; j < pathspec->nr; j++) {
+			int len2 =3D strlen(pathspec->raw[j]);
+			if (len2 <=3D len || pathspec->raw[j][len] !=3D '/' ||
+			    memcmp(ce->name, pathspec->raw[j], len))
+				continue;
+			if (len2 =3D=3D len + 1) {
+				/* strip trailing slash */
+				char *path =3D xstrndup(ce->name, len);
+				pathspec->raw[j] =3D path;
+				pathspec->items[j].match =3D path;
+				pathspec->items[j].len =3D len;
+				pathspec->items[j].nowildcard_len =3D simple_length(path);
+			} else
+				die (_("Path '%s' is in submodule '%.*s'"),
+				     pathspec->raw[j], len, ce->name);
+		}
+	}
+}
+
+
+
 void free_pathspec(struct pathspec *pathspec)
 {
 	free(pathspec->items);
--=20
1.8.0.rc2.23.g1fb49df
