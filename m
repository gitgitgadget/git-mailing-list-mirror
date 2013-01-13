From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 18/31] add: convert to use parse_pathspec
Date: Sun, 13 Jan 2013 19:35:26 +0700
Message-ID: <1358080539-17436-19-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMpI-0007XO-JF
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab3AMMhw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:37:52 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36519 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab3AMMhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:37:52 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so1776347pad.7
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Sb+33HccNsp8Rrp4XfGMUNXMp+J2yEdXrawCCCrRukg=;
        b=ca7Lt9RpvU+2onK7MLG0/SmIlK0aC8f+zmoU1f5ZQm6FgwdV6bLRnsWiHlEv1qCA9f
         6BjNxVCkLKeRwgZ4vSaGWDpJ//keBQqMONsxG97BDLymz7BJD1D3hbR5PXqprdUYXLIq
         S8ir42eL4oDLw1GIik2zys6rP3KyRyzDnBORJVbWR111XfF2K7nyo5pWnv3FuCzLzb0X
         32dpqf6lrqEmOdp1G4/oUfd07dYB3qRFrG5GMUwRPS2s0jtx0LS5njPsEbS00cO4TrTc
         PmCmSZPP7ePhtRlIyYxJ80roIGSFfLR56kJbNDcHJ4oCCrzCOYkUVd4RqrfhKdbnVs1f
         o/Qg==
X-Received: by 10.68.129.40 with SMTP id nt8mr244719804pbb.113.1358080671645;
        Sun, 13 Jan 2013 04:37:51 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id k4sm6754241paz.26.2013.01.13.04.37.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:37:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:38:01 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213358>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 106 +++++++++++++++++++++-----------------------------=
--------
 1 file changed, 39 insertions(+), 67 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 075312a..22076ff 100644
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
@@ -197,23 +170,6 @@ static void refresh(int verbose, const char **path=
spec)
         free(seen);
 }
=20
-static const char **validate_pathspec(int argc, const char **argv, con=
st char *prefix)
-{
-	const char **pathspec =3D get_pathspec(prefix, argv);
-
-	if (pathspec) {
-		const char **p;
-		for (p =3D pathspec; *p; p++) {
-			if (has_symlink_leading_path(*p, strlen(*p))) {
-				int len =3D prefix ? strlen(prefix) : 0;
-				die(_("'%s' is beyond a symbolic link"), *p + len);
-			}
-		}
-	}
-
-	return pathspec;
-}
-
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const char **pathspec)
 {
@@ -245,17 +201,20 @@ int run_add_interactive(const char *revision, con=
st char *patch_mode,
=20
 int interactive_add(int argc, const char **argv, const char *prefix, i=
nt patch)
 {
-	const char **pathspec =3D NULL;
+	struct pathspec pathspec;
=20
-	if (argc) {
-		pathspec =3D validate_pathspec(argc, argv, prefix);
-		if (!pathspec)
-			return -1;
-	}
+	/*
+	 * Do not enable fancy magic here.  git-add--interactive may
+	 * not be able to handle it.
+	 */
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
+		       PATHSPEC_EMPTY_MATCH_ALL |
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
@@ -367,7 +326,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 {
 	int exit_status =3D 0;
 	int newfd;
-	const char **pathspec;
+	struct pathspec pathspec;
 	struct dir_struct dir;
 	int flags;
 	int add_new_files;
@@ -415,11 +374,18 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
-	pathspec =3D validate_pathspec(argc, argv, prefix);
=20
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-	treat_gitlinks(pathspec);
+
+	/*
+	 * Check the "pathspec '%s' did not match any files" block
+	 * below before enabling new magic.
+	 */
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
+		       PATHSPEC_SYMLINK_LEADING_PATH |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE,
+		       prefix, argv);
=20
 	if (add_new_files) {
 		int baselen;
@@ -432,33 +398,39 @@ int cmd_add(int argc, const char **argv, const ch=
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
--=20
1.8.0.rc2.23.g1fb49df
