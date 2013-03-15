From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 21/45] ls-files: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:36 +0700
Message-ID: <1363327620-29017-22-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO6N-0005or-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab3COG0Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:26:25 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64742 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab3COG0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:26:24 -0400
Received: by mail-ie0-f174.google.com with SMTP id k10so4002104iea.33
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Lsyx7GDkJCHW1WU9OtOPKyrDu8xheMkx74lBuxU8tq4=;
        b=P62HdhmfLg8X6HQwXhFtYj+ALrKuzmRLcoRgwASczhmmN1+Rdr9svWKkXAuSNGJDYb
         Iimtdp/hqQMzCxYKQwTTzUNorLcfgT6g2V+SViKvz54nqS+kZovWumYb3+piVKSDdW35
         qKqnfjjhuHfYvxhZ4rv1oCUKtvjvQNV4IOVttB4hjnvywLd1pGbzGjduHbN0qCsdco6L
         YRaqFduVf0BRAqOPGRjgkAl+9mpS3gjPI71Dk5bdAwBlriGjKGvFknwHNb15MjN5VgXV
         lnBbkx3nSIYVRP7tL5t9iAzYHZCEwHaLaUnElpgTElT/FJYDq4mqMIYgXCrQDgUpld7T
         2Zfg==
X-Received: by 10.50.159.162 with SMTP id xd2mr385612igb.11.1363328784154;
        Thu, 14 Mar 2013 23:26:24 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id g6sm622641ign.4.2013.03.14.23.26.21
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:26:23 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:09:26 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218208>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 46 +++++++++++++---------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 752570b..bd64829 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,7 +31,7 @@ static int debug_mode;
 static const char *prefix;
 static int max_prefix_len;
 static int prefix_len;
-static const char **pathspec;
+static struct pathspec pathspec;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
@@ -60,7 +60,7 @@ static void show_dir_entry(const char *tag, struct di=
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
@@ -135,7 +135,7 @@ static void show_ce_entry(const char *tag, struct c=
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
@@ -189,7 +189,7 @@ static void show_ru_info(void)
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
@@ -218,7 +218,7 @@ static void show_files(struct dir_struct *dir)
=20
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		fill_directory(dir, pathspec);
+		fill_directory(dir, pathspec.raw);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
@@ -289,21 +289,6 @@ static void prune_cache(const char *prefix)
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
@@ -557,23 +542,18 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
-	pathspec =3D get_pathspec(prefix, argv);
-
-	/* be nice with submodule paths ending in a slash */
-	if (pathspec)
-		strip_trailing_slash_from_submodules();
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       prefix, argv);
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
@@ -600,7 +580,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
=20
 	if (ps_matched) {
 		int bad;
-		bad =3D report_path_error(ps_matched, pathspec, prefix);
+		bad =3D report_path_error(ps_matched, pathspec.raw, prefix);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
=20
--=20
1.8.0.rc0.19.g7bbb31d
