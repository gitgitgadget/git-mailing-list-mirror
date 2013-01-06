From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/21] ls-files: convert to use parse_pathspec
Date: Sun,  6 Jan 2013 13:20:58 +0700
Message-ID: <1357453268-12543-12-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:22:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjcx-0008S5-4D
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab3AFGWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:22:15 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54661 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab3AFGWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:22:14 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so10034425pad.8
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=7Bm0y01RR4A9hOPHFgoJgw+eO/mpl/uvhO4TqGQ36+g=;
        b=x1jLVB42q/clbSsFCkIkXhuwHj3W7kU0oOGfzkBwf1riX33T1WqmUTYwGIf1LAVWnJ
         lJQznrYeJ1s9wiyg4NZ/uSgLNb6H60s9IprX4mlXDjJICdGBrNd5nn3aSrZRQMTSZlWq
         CKDJNFDMxIHLNnFIpmqbrdT00AWOT0NUPL+WnJ11f6YQf4uKRDThxCdUATiCnLZriIAp
         twzqors+Wwh29RZfvz3pmw0LNkI16qJub3Y1tf9GpC6Tf9IWsUbE//ibRgmDE4Dvj0jK
         D5647ts6PV5beWfC03gCOqWGIGXDvAFDiTYZ5an7Aqs88mOfpHUhZoVI+WR+CyfbV43C
         f68w==
X-Received: by 10.66.85.103 with SMTP id g7mr167655093paz.45.1357453333013;
        Sat, 05 Jan 2013 22:22:13 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id rn8sm5506123pbc.65.2013.01.05.22.22.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:22:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:22:17 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212765>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 42 +++++++++++-------------------------------
 cache.h            |  1 +
 dir.c              | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4a9ee69..9336abd 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -30,7 +30,7 @@ static int debug_mode;
 static const char *prefix;
 static int max_prefix_len;
 static int prefix_len;
-static const char **pathspec;
+static struct pathspec pathspec;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
@@ -58,7 +58,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 	if (len >=3D ent->len)
 		die("git ls-files: internal error - directory entry not superset of =
prefix");
=20
-	if (!match_pathspec(pathspec, ent->name, ent->len, len, ps_matched))
+	if (!match_pathspec_depth(&pathspec, ent->name, ent->len, len, ps_mat=
ched))
 		return;
=20
 	fputs(tag, stdout);
@@ -133,7 +133,7 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 	if (len >=3D ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
-	if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), len, ps_match=
ed))
+	if (!match_pathspec_depth(&pathspec, ce->name, ce_namelen(ce), len, p=
s_matched))
 		return;
=20
 	if (tag && *tag && show_valid_bit &&
@@ -187,7 +187,7 @@ static void show_ru_info(void)
 		len =3D strlen(path);
 		if (len < max_prefix_len)
 			continue; /* outside of the prefix */
-		if (!match_pathspec(pathspec, path, len, max_prefix_len, ps_matched)=
)
+		if (!match_pathspec_depth(&pathspec, path, len, max_prefix_len, ps_m=
atched))
 			continue; /* uninterested */
 		for (i =3D 0; i < 3; i++) {
 			if (!ui->mode[i])
@@ -216,7 +216,7 @@ static void show_files(struct dir_struct *dir)
=20
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		fill_directory(dir, pathspec);
+		fill_directory(dir, pathspec.raw);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
@@ -287,21 +287,6 @@ static void prune_cache(const char *prefix)
 	active_nr =3D last;
 }
=20
-static void strip_trailing_slash_from_submodules(void)
-{
-	const char **p;
-
-	for (p =3D pathspec; *p !=3D NULL; p++) {
-		int len =3D strlen(*p), pos;
-
-		if (len < 1 || (*p)[len - 1] !=3D '/')
-			continue;
-		pos =3D cache_name_pos(*p, len - 1);
-		if (pos >=3D 0 && S_ISGITLINK(active_cache[pos]->ce_mode))
-			*p =3D xstrndup(*p, len - 1);
-	}
-}
-
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -549,23 +534,18 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
-	pathspec =3D get_pathspec(prefix, argv);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
 	/* be nice with submodule paths ending in a slash */
-	if (pathspec)
-		strip_trailing_slash_from_submodules();
+	strip_trailing_slash_from_submodules(&pathspec);
=20
 	/* Find common prefix for all pathspec's */
-	max_prefix =3D common_prefix(pathspec);
+	max_prefix =3D common_prefix(pathspec.raw);
 	max_prefix_len =3D max_prefix ? strlen(max_prefix) : 0;
=20
 	/* Treat unmatching pathspec elements as errors */
-	if (pathspec && error_unmatch) {
-		int num;
-		for (num =3D 0; pathspec[num]; num++)
-			;
-		ps_matched =3D xcalloc(1, num);
-	}
+	if (pathspec.nr && error_unmatch)
+		ps_matched =3D xcalloc(1, pathspec.nr);
=20
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
@@ -592,7 +572,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
=20
 	if (ps_matched) {
 		int bad;
-		bad =3D report_path_error(ps_matched, pathspec, prefix);
+		bad =3D report_path_error(ps_matched, pathspec.raw, prefix);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
=20
diff --git a/cache.h b/cache.h
index e52365d..890d89b 100644
--- a/cache.h
+++ b/cache.h
@@ -493,6 +493,7 @@ extern int init_pathspec(struct pathspec *, const c=
har **);
 extern void parse_pathspec(struct pathspec *pathspec, unsigned magic,
 			   unsigned flags, const char *prefix,
 			   const char **args);
+void strip_trailing_slash_from_submodules(struct pathspec *pathspec);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
=20
diff --git a/dir.c b/dir.c
index 31f0995..11e8c1d 100644
--- a/dir.c
+++ b/dir.c
@@ -1440,6 +1440,26 @@ int init_pathspec(struct pathspec *pathspec, con=
st char **paths)
 	return 0;
 }
=20
+void strip_trailing_slash_from_submodules(struct pathspec *pathspec)
+{
+	int i;
+	for (i =3D 0; i < pathspec->nr; i++) {
+		const char *p =3D pathspec->raw[i];
+		int len =3D strlen(p), pos;
+
+		if (len < 1 || p[len - 1] !=3D '/')
+			continue;
+		pos =3D cache_name_pos(p, len - 1);
+		if (pos >=3D 0 && S_ISGITLINK(active_cache[pos]->ce_mode)) {
+			pathspec->raw[i] =3D xstrndup(p, len - 1);
+			pathspec->items[i].len--;
+			pathspec->items[i].match =3D
+				xstrndup(pathspec->items[i].match,
+					 pathspec->items[i].len);
+		}
+	}
+}
+
 void free_pathspec(struct pathspec *pathspec)
 {
 	free(pathspec->items);
--=20
1.8.0.rc2.23.g1fb49df
