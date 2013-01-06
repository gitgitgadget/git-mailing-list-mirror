From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/21] add: convert to use parse_pathspec
Date: Sun,  6 Jan 2013 13:21:00 +0700
Message-ID: <1357453268-12543-14-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:22:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjd7-0000Bg-U5
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab3AFGW1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:22:27 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:63507 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab3AFGWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:22:25 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so8134714dak.34
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PVEjgObZuRJTCFWpySuBUqgEC0s3KrAsbJh6OXgJtCA=;
        b=QO2r+lV2x8oBflx43+CkIVok0BI6X3Eg+oisGY4BHJO/5FgqWtG9A0nh84/5DjvQxc
         QFn/GiWIkumYme92/AniAhposj/tYgd2ZHjp4OR7+NuiqJckkZqSWfxrr6ZSkcX1M1Dq
         cJ+3kdY+NQ5yiz158tsG+xylPUM2mjZaKnE8gEGSm86cZJHBGhQSH2hv0sQuVJ178KiS
         cPliMwg0vQEI32jf+lZxIawrnqVLNeZophgvOeU4GZ94xemTcEVsKq9sZYlnAcbhlIRB
         s/COLUcQUWUDfKPp9qw8s/dsTmu99Q811VkEGPacmhYlXztQIcQ+isSgb63XkNC6LQBq
         P0wA==
X-Received: by 10.68.211.42 with SMTP id mz10mr177401293pbc.100.1357453344349;
        Sat, 05 Jan 2013 22:22:24 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id vx2sm35292058pbc.33.2013.01.05.22.22.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:22:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:22:33 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212767>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 57 ++++++++++++++++++++++++++++-----------------------=
------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index e664100..af36bc4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -197,21 +197,18 @@ static void refresh(int verbose, const char **pat=
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
@@ -248,7 +245,8 @@ int interactive_add(int argc, const char **argv, co=
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
@@ -367,7 +365,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 {
 	int exit_status =3D 0;
 	int newfd;
-	const char **pathspec;
+	struct pathspec pathspec;
 	struct dir_struct dir;
 	int flags;
 	int add_new_files;
@@ -415,11 +413,12 @@ int cmd_add(int argc, const char **argv, const ch=
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
+	treat_gitlinks(pathspec.raw);
=20
 	if (add_new_files) {
 		int baselen;
@@ -432,33 +431,33 @@ int cmd_add(int argc, const char **argv, const ch=
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
@@ -467,7 +466,7 @@ int cmd_add(int argc, const char **argv, const char=
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
