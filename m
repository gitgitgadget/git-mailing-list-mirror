From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 15/31] ls-files: convert to use parse_pathspec
Date: Sun, 13 Jan 2013 19:35:23 +0700
Message-ID: <1358080539-17436-16-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMou-0007BI-Ms
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab3AMMhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:37:25 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:54763 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125Ab3AMMhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:37:24 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so1687366pbb.25
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=4mDWWMi5A9RwI8Rw9QmaqmGnrHcRS/13dtvgOf7BTG8=;
        b=gUOt8DfLJngLAywSuakox7coK0t7XX9JLf2h8r/Lyb7lumtcf2d9TkfRZtwWGLxl7W
         +v16b3JB1R48cuVeWoo9Sozob1bJv024OQCTOC9z65khewP+h0TgQ1m59sAPokDhr2eH
         37vZ6DE13Y66N5F3SXO8rli8YLBd5KgshM1MzbMUtNoCbaAgi2qtWOlCIKaUS+q+xLoj
         JlaSaqTu/xfqfGx1OvzWDMV72X/4P8itNT2e3slhsEKQTeTk6XAlBgNWMKyt+0uRmUfE
         M2jSyBS9auaIOX2fA3GVQuJv2XFaEa5/GioG0QnY/qA7Bz+4/A7gqUBR5QcxMlSxkOqD
         Ik7g==
X-Received: by 10.68.191.5 with SMTP id gu5mr245689464pbc.145.1358080644176;
        Sun, 13 Jan 2013 04:37:24 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id ti9sm6293729pbc.16.2013.01.13.04.37.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:37:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:37:37 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213355>

strip_trailing_slash_from_submodules() modifies pathspec and is moved
to dir.c, close to other pathspec code. It'll be removed later when
parse_pathspec() learns to take over its job.

This commit introduces a subtle bug:

- when match_pathspec() returns seen[], it follows the order of the
  input "const char **pathspec", which is now pathspec.raw[]

- when match_pathspec() returns seen[], it follows the order of
  pathspec.items[]

- due to 86e4ca6 (tree_entry_interesting(): fix depth limit with
  overlapping pathspecs - 2010-12-15), pathspec.items[] is sorted, but
  pathspec.raw[] is NOT.

by converting from match_pathspec() to match_pathspec_depth(), we also
have to switch the original path array. The bug causes wrong error
messages (e.g. if the first pathspec is faulty, it may report the
second..). report_path_error will be fixed in a separate patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 373c573..8905bd3 100644
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
@@ -549,23 +534,17 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
-	pathspec =3D get_pathspec(prefix, argv);
-
-	/* be nice with submodule paths ending in a slash */
-	if (pathspec)
-		strip_trailing_slash_from_submodules();
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP,
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
@@ -592,7 +571,7 @@ int cmd_ls_files(int argc, const char **argv, const=
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
1.8.0.rc2.23.g1fb49df
