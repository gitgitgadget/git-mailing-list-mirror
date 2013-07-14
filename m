From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 32/46] Convert {read,fill}_directory to take struct pathspec
Date: Sun, 14 Jul 2013 15:35:55 +0700
Message-ID: <1373790969-13000-33-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:39:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHq6-00031x-Sn
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab3GNIj1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:39:27 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:38322 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3GNIj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:39:26 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so10378795pbc.10
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ibOQNK94pAa3fJekLMleT9EmBvdOg0mWO+f4hUzNIcE=;
        b=qE/GzvXCiweTretOW5ipzJVJVIUTPsVzOjERF3TEhNgKa4FtWb0mLHAEuP8uq54BII
         7kXIuLsP2n9OMP4QHblVhQTD9Ocup3gIozlBvKoS0q5+xllBhQC3G3ylD1l23JqJHlcO
         Lr/vu60Lup2dkr4ixyu0OcHOhauCqwrFJQhH35MeBGuCndZV086+gbFII4BzY7dix1gR
         n+3F24n7EgXaoibQNksA9o62358dhpY1i0zH/z0FVuZnU6ulM6Gy5TIrufnBgoGTL90S
         vJ3Iyub7eUtZz4Lau7OPkeBHDiCnsw2e+PxSLjIC9rhFMQKH9b9sygtwhZKXuFMPZxgt
         o+5A==
X-Received: by 10.68.179.225 with SMTP id dj1mr48306362pbc.193.1373791165520;
        Sun, 14 Jul 2013 01:39:25 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id pq1sm11555305pbb.26.2013.07.14.01.39.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:39:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:39:37 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230344>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c      |  4 +++-
 builtin/clean.c    |  2 +-
 builtin/grep.c     |  2 +-
 builtin/ls-files.c |  2 +-
 dir.c              | 16 +++++++++++-----
 dir.h              |  4 ++--
 wt-status.c        |  2 +-
 7 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f5d6a33..34c9358 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -507,6 +507,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
=20
 	if (add_new_files) {
 		int baselen;
+		struct pathspec empty_pathspec;
=20
 		/* Set up the default git porcelain excludes */
 		memset(&dir, 0, sizeof(dir));
@@ -515,8 +516,9 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 			setup_standard_excludes(&dir);
 		}
=20
+		memset(&empty_pathspec, 0, sizeof(empty_pathspec));
 		/* This picks up the paths that are not tracked */
-		baselen =3D fill_directory(&dir, implicit_dot ? NULL : pathspec.raw)=
;
+		baselen =3D fill_directory(&dir, implicit_dot ? &empty_pathspec : &p=
athspec);
 		if (pathspec.nr)
 			seen =3D prune_directory(&dir, pathspec.raw, baselen,
 					implicit_dot ? WARN_IMPLICIT_DOT : 0);
diff --git a/builtin/clean.c b/builtin/clean.c
index fdd4980..d540ca4 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -214,7 +214,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
=20
-	fill_directory(&dir, pathspec.raw);
+	fill_directory(&dir, &pathspec);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
diff --git a/builtin/grep.c b/builtin/grep.c
index 4bc0754..76a6a60 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -523,7 +523,7 @@ static int grep_directory(struct grep_opt *opt, con=
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
index 50e6edf..fa1a6be 100644
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
index 19978d3..290c7a3 100644
--- a/dir.c
+++ b/dir.c
@@ -142,7 +142,7 @@ char *common_prefix(const char **pathspec)
 	return len ? xmemdupz(*pathspec, len) : NULL;
 }
=20
-int fill_directory(struct dir_struct *dir, const char **pathspec)
+int fill_directory(struct dir_struct *dir, const struct pathspec *path=
spec)
 {
 	size_t len;
=20
@@ -150,10 +150,10 @@ int fill_directory(struct dir_struct *dir, const =
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
@@ -1388,14 +1388,20 @@ static int treat_leading_path(struct dir_struct=
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
+		GUARD_PATHSPEC(pathspec, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
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
index 229ccc8..076dd96 100644
--- a/dir.h
+++ b/dir.h
@@ -137,8 +137,8 @@ extern int match_pathspec_depth(const struct pathsp=
ec *pathspec,
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
index fae0c27..33baf0a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -514,7 +514,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 		dir.flags |=3D DIR_SHOW_IGNORED_TOO;
 	setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, s->pathspec.raw);
+	fill_directory(&dir, &s->pathspec);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
--=20
1.8.2.83.gc99314b
