From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 24/31] Convert {read,fill}_directory to take struct pathspec
Date: Sun, 13 Jan 2013 19:35:32 +0700
Message-ID: <1358080539-17436-25-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:39:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMpw-000890-Ii
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab3AMMic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:38:32 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39717 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab3AMMib (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:38:31 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so1755054pad.2
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OKmRBDzmu/oUyFoadxhRfya2Gk5Whq55JLg8mzscU2k=;
        b=Ob6VCMCWbrQLzffvNT39FAPS0QCVVt8VFKSx5x69A1JFhBSH+PD0xSIb90YGAd/j7+
         /khSwWEziKPeqUxHL3mMlQJH4pIvlRz8CF2yhTnP5poabAQbXLPWJTo7t4xcseJW2HsQ
         u6toClKujbrOmCWrq8xS0SvYs7F3ioBzaqnOYHhgCWSFjRjdcy3bhg9crr7VimZ26Fem
         P8PWuj4o5qNsvfkFnG82ZZ+MVC0bDuq/BegusyLsNiJmUPxssPtsHrqhXZ9JhfY2XDG1
         fBBMAOScXIsXMha3pS3cMg70IJvV0pdyvzMY5jVz4Jp9mW49Qr5C+KX7rjxpJWxSdT4v
         qgCw==
X-Received: by 10.68.204.103 with SMTP id kx7mr246961115pbc.33.1358080711061;
        Sun, 13 Jan 2013 04:38:31 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id ir4sm6290658pbc.41.2013.01.13.04.38.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:38:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:38:45 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213365>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c      |  2 +-
 builtin/clean.c    |  2 +-
 builtin/grep.c     |  2 +-
 builtin/ls-files.c |  2 +-
 dir.c              | 16 +++++++++++-----
 dir.h              |  4 ++--
 wt-status.c        |  4 ++--
 7 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 7069b77..dcea98f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -397,7 +397,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		}
=20
 		/* This picks up the paths that are not tracked */
-		baselen =3D fill_directory(&dir, pathspec.raw);
+		baselen =3D fill_directory(&dir, &pathspec);
 		if (pathspec.nr)
 			seen =3D prune_directory(&dir, pathspec.raw, baselen);
 	}
diff --git a/builtin/clean.c b/builtin/clean.c
index fb0fe9a..1d8ff5f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -102,7 +102,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
=20
 	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
-	fill_directory(&dir, pathspec.raw);
+	fill_directory(&dir, &pathspec);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
diff --git a/builtin/grep.c b/builtin/grep.c
index 705f9ff..f370bad 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -522,7 +522,7 @@ static int grep_directory(struct grep_opt *opt, con=
st struct pathspec *pathspec,
 	if (exc_std)
 		setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, pathspec->raw);
+	fill_directory(&dir, pathspec);
 	for (i =3D 0; i < dir.nr; i++) {
 		const char *name =3D dir.entries[i]->name;
 		int namelen =3D strlen(name);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4bf3238..9655cc5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -216,7 +216,7 @@ static void show_files(struct dir_struct *dir)
=20
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		fill_directory(dir, pathspec.raw);
+		fill_directory(dir, &pathspec);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
diff --git a/dir.c b/dir.c
index 37280c8..6657b02 100644
--- a/dir.c
+++ b/dir.c
@@ -98,7 +98,7 @@ char *common_prefix(const char **pathspec)
 	return len ? xmemdupz(*pathspec, len) : NULL;
 }
=20
-int fill_directory(struct dir_struct *dir, const char **pathspec)
+int fill_directory(struct dir_struct *dir, const struct pathspec *path=
spec)
 {
 	size_t len;
=20
@@ -106,10 +106,10 @@ int fill_directory(struct dir_struct *dir, const =
char **pathspec)
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len =3D common_prefix_len(pathspec);
+	len =3D common_prefix_len(pathspec->raw);
=20
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec ? *pathspec : "", len, pathspec);
+	read_directory(dir, pathspec->nr ? pathspec->raw[0] : "", len, pathsp=
ec);
 	return len;
 }
=20
@@ -1323,14 +1323,20 @@ static int treat_leading_path(struct dir_struct=
 *dir,
 	return rc;
 }
=20
-int read_directory(struct dir_struct *dir, const char *path, int len, =
const char **pathspec)
+int read_directory(struct dir_struct *dir, const char *path, int len, =
const struct pathspec *pathspec)
 {
 	struct path_simplify *simplify;
=20
+	/*
+	 * Check out create_simplify()
+	 */
+	if (pathspec)
+		GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP);
+
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
=20
-	simplify =3D create_simplify(pathspec);
+	simplify =3D create_simplify(pathspec ? pathspec->raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
diff --git a/dir.h b/dir.h
index 0cf5ccf..36bb4dd 100644
--- a/dir.h
+++ b/dir.h
@@ -97,8 +97,8 @@ extern int match_pathspec_depth(const struct pathspec=
 *pathspec,
 				int prefix, char *seen);
 extern int within_depth(const char *name, int namelen, int depth, int =
max_depth);
=20
-extern int fill_directory(struct dir_struct *dir, const char **pathspe=
c);
-extern int read_directory(struct dir_struct *, const char *path, int l=
en, const char **pathspec);
+extern int fill_directory(struct dir_struct *dir, const struct pathspe=
c *pathspec);
+extern int read_directory(struct dir_struct *, const char *path, int l=
en, const struct pathspec *pathspec);
=20
 extern int is_excluded_from_list(const char *pathname, int pathlen, co=
nst char *basename,
 				 int *dtype, struct exclude_list *el);
diff --git a/wt-status.c b/wt-status.c
index 76edadc..c5b979e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -502,7 +502,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, s->pathspec.raw);
+	fill_directory(&dir, &s->pathspec);
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
@@ -514,7 +514,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 	if (s->show_ignored_files) {
 		dir.nr =3D 0;
 		dir.flags =3D DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
-		fill_directory(&dir, s->pathspec.raw);
+		fill_directory(&dir, &s->pathspec);
 		for (i =3D 0; i < dir.nr; i++) {
 			struct dir_entry *ent =3D dir.entries[i];
 			if (cache_name_is_other(ent->name, ent->len) &&
--=20
1.8.0.rc2.23.g1fb49df
