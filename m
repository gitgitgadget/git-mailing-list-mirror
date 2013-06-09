From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/45] Convert {read,fill}_directory to take struct pathspec
Date: Sun,  9 Jun 2013 13:26:05 +0700
Message-ID: <1370759178-1709-33-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ6z-0001Pm-4Y
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3FIG2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:28:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43683 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab3FIG2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:28:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so3564588pad.19
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oQfPF7nD3gax2SsTci8xjO5L+5pj4IUrHoWQ4EH+xD4=;
        b=oqrVuecU7YowB8q10oYs76iZAhuTL56Duf6wKNbJP+hqSnvlAepgV4xflR7a8qSqLw
         UJvQgunQOnnCS4e1Dy+u6kKU7TmB2jbQDwZYKKAAivnLOnBqgL7DCSc/POCHwPu3sZ/0
         slUnte8hmJQ+kouIP4fxp7lW+xEWf8YIwq1JnmVcp6H/eZ0GHpiNLjxvzXkbDbeWVk81
         lQ3vdOD4nVtkd5JoYUfgD5BCOoiQBaqfv2G6rYudywO3hE9rDp/6LKJpoOLewx4PvjgD
         1KfDWdH06Shuu90DKjUvK4qngwpfJpK0wAUBg2YO3+vZ8ZsuNdAb1dieKrLzBcyPsS1N
         gpKQ==
X-Received: by 10.66.251.65 with SMTP id zi1mr9322456pac.200.1370759295050;
        Sat, 08 Jun 2013 23:28:15 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id tq8sm5513074pbc.30.2013.06.08.23.28.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:28:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:29:46 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226924>


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
index f6db498..7feedba 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -214,7 +214,7 @@ static void show_files(struct dir_struct *dir)
=20
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		fill_directory(dir, pathspec.raw);
+		fill_directory(dir, &pathspec);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
diff --git a/dir.c b/dir.c
index fcc0b97..863ee39 100644
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
@@ -1390,14 +1390,20 @@ static int treat_leading_path(struct dir_struct=
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
index 99302e6..89ac6bd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -513,7 +513,7 @@ static void wt_status_collect_untracked(struct wt_s=
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
