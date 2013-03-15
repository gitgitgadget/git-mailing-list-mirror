From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 32/45] Convert {read,fill}_directory to take struct pathspec
Date: Fri, 15 Mar 2013 13:06:47 +0700
Message-ID: <1363327620-29017-33-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:28:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO7g-0007Ia-B4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab3COG1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:27:45 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:39108 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab3COG1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:27:45 -0400
Received: by mail-ia0-f179.google.com with SMTP id x24so2872952iak.24
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+ijXEuH0iejIJlpaxsI1a9M0DysncjXmK5VjkriMmXw=;
        b=U52c08214VjHVhl1NlNSDoLlHu7H+pNV3sXDNd7PcaoEDaXwIBtfNvakTXmv0kBhrU
         9pZHxFOhGZbY/jU6xw/TwthJemLb/uyoDpMmzHm0l1UwNRjPssts328cGsJnignOcT4v
         iWtj4U/j/hyzHpi2z4ntgof1TSWEJfTPaHQh1kbHW8RDNZQj6EMyIw6X4Qu9SdqNmB7G
         F33op/Yk9DHQssHZIpLM29xsvLl5sWApEIff6n5wcRYmaec3eWPrVzxJD6O63Ska1dr1
         9ompwj3bfT2zY8kNLp4zvc9Fm3h8SVZBo7D9Ecq9qtsL05TmbbpHo3PJxNtqML5mJI2T
         DKrA==
X-Received: by 10.50.207.39 with SMTP id lt7mr4457471igc.110.1363328864762;
        Thu, 14 Mar 2013 23:27:44 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id xc3sm606495igb.10.2013.03.14.23.27.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:27:44 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:10:46 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218219>


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
index cae002d..7b9e50c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -405,7 +405,7 @@ int cmd_add(int argc, const char **argv, const char=
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
index 1c7397a..301d280 100644
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
index a33ea18..37f0392 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -218,7 +218,7 @@ static void show_files(struct dir_struct *dir)
=20
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		fill_directory(dir, pathspec.raw);
+		fill_directory(dir, &pathspec);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
diff --git a/dir.c b/dir.c
index 6094ba8..20e6a3e 100644
--- a/dir.c
+++ b/dir.c
@@ -99,7 +99,7 @@ char *common_prefix(const char **pathspec)
 	return len ? xmemdupz(*pathspec, len) : NULL;
 }
=20
-int fill_directory(struct dir_struct *dir, const char **pathspec)
+int fill_directory(struct dir_struct *dir, const struct pathspec *path=
spec)
 {
 	size_t len;
=20
@@ -107,10 +107,10 @@ int fill_directory(struct dir_struct *dir, const =
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
@@ -1438,14 +1438,20 @@ static int treat_leading_path(struct dir_struct=
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
index 89427fd..70fdc98 100644
--- a/dir.h
+++ b/dir.h
@@ -134,8 +134,8 @@ extern int match_pathspec_depth(const struct pathsp=
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
index 5dec9af..1105fdd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -503,7 +503,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, s->pathspec.raw);
+	fill_directory(&dir, &s->pathspec);
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
@@ -517,7 +517,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 		dir.flags =3D DIR_SHOW_IGNORED;
 		if (s->show_untracked_files !=3D SHOW_ALL_UNTRACKED_FILES)
 			dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
-		fill_directory(&dir, s->pathspec.raw);
+		fill_directory(&dir, &s->pathspec);
 		for (i =3D 0; i < dir.nr; i++) {
 			struct dir_entry *ent =3D dir.entries[i];
 			if (cache_name_is_other(ent->name, ent->len) &&
--=20
1.8.0.rc0.19.g7bbb31d
