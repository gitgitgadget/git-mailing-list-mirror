From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/21] list-files: -M aka diff-cached
Date: Sun,  8 Feb 2015 16:01:38 +0700
Message-ID: <1423386099-19994-21-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNms-0006WP-QN
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbbBHJEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:04:12 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50433 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbbBHJEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:04:08 -0500
Received: by mail-pa0-f44.google.com with SMTP id rd3so26999304pab.3
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UYhKwxpb209wpRzgoIeA2qhqt6JYF4yFDcLQPRofGK4=;
        b=DPfn3zSTNAozKypHIarFp7HFOqTdz28GmAvbE8z1X5Ui9n/Ra+HX1kWZSzS+akFNy/
         klZnJspeEByjjPV8uKRJDmcDlRoY05Gy03vzxxd9kUQNOnlAe/pq61iWTMxAPLvkzTNY
         MrgGm1genImFolrydKdxX9C17cFeJooJOjnz2XB32qrUlMQt/DuFGwI7ZQYI0sQU4KLl
         cv+gDYsT+3f16nu+15mUB2iA0EH1Tbq8KtyDFGK2Tyzd5KMCmiffqBLGC4kflO4cyHiD
         /WcitKgfK2KGHW1e3OjI78sLL9rPB4tG/F4we7PqKuguzqWbFS5ybiG8qG5bVcPM3tEF
         C54g==
X-Received: by 10.69.25.105 with SMTP id ip9mr2878450pbd.5.1423386248197;
        Sun, 08 Feb 2015 01:04:08 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id sq6sm12708324pbc.40.2015.02.08.01.04.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:04:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:04:16 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263507>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d3540d1..b5e1a59 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -16,6 +16,9 @@
 #include "pathspec.h"
 #include "color.h"
 #include "column.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -25,6 +28,7 @@ static int show_stage;
 static int show_unmerged;
 static int show_resolve_undo;
 static int show_modified;
+static int show_diff_cached;
 static int show_killed;
 static int show_valid_bit;
 static int show_tag;
@@ -53,6 +57,7 @@ static const char *tag_removed =3D "";
 static const char *tag_other =3D "";
 static const char *tag_killed =3D "";
 static const char *tag_modified =3D "";
+static const char *tag_diff_cached =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
=20
@@ -412,7 +417,15 @@ static void show_files(struct dir_struct *dir)
 			err =3D lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
+			if (show_diff_cached && (ce->ce_flags & CE_MATCHED)) {
+				show_ce_entry(tag_diff_cached, ce);
+				/*
+				 * if we don't clear, it'll confuse write_ce_name()
+				 * when show_ce_entry(tag_modified, ce) is called
+				 */
+				active_cache[i]->ce_flags &=3D ~CE_MATCHED;
+			}
+			if (show_modified && (err || ce_modified(ce, &st, 0)))
 				show_ce_entry(tag_modified, ce);
 		}
 	}
@@ -432,7 +445,8 @@ static void show_files_compact(struct dir_struct *d=
ir)
 		if (show_killed)
 			show_killed_files(dir);
 	}
-	if (!(show_cached || show_unmerged || show_deleted || show_modified))
+	if (!(show_cached || show_unmerged || show_deleted ||
+	      show_modified || show_diff_cached))
 		return;
 	for (i =3D 0; i < active_nr; i++) {
 		const struct cache_entry *ce =3D active_cache[i];
@@ -452,6 +466,15 @@ static void show_files_compact(struct dir_struct *=
dir)
 			show_ce_entry(tag_removed, ce);
 			shown =3D 1;
 		}
+		if (show_diff_cached && (ce->ce_flags & CE_MATCHED)) {
+			show_ce_entry(tag_diff_cached, ce);
+			shown =3D 1;
+			/*
+			 * if we don't clear, it'll confuse write_ce_name()
+			 * when show_ce_entry(tag_modified, ce) is called
+			 */
+			active_cache[i]->ce_flags &=3D ~CE_MATCHED;
+		}
 		if (show_modified && (err || ce_modified(ce, &st, 0))) {
 			show_ce_entry(tag_modified, ce);
 			shown =3D 1;
@@ -465,6 +488,38 @@ static void show_files_compact(struct dir_struct *=
dir)
 	}
 }
=20
+static void mark_diff_cached(struct diff_queue_struct *q,
+			     struct diff_options *options,
+			     void *data)
+{
+	int i;
+
+	for (i =3D 0; i < q->nr; i++) {
+		struct diff_filepair *p =3D q->queue[i];
+		int pos =3D cache_name_pos(p->two->path, strlen(p->two->path));
+		if (pos < 0)
+			continue;
+		active_cache[pos]->ce_flags |=3D CE_MATCHED;
+	}
+}
+
+static void diff_cached(struct pathspec *pathspec)
+{
+	struct rev_info rev;
+	const char *argv[] =3D { "ls-files", "HEAD", NULL };
+
+	init_revisions(&rev, NULL);
+	setup_revisions(2, argv, &rev, NULL);
+
+	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback =3D mark_diff_cached;
+	rev.diffopt.detect_rename =3D 1;
+	rev.diffopt.rename_limit =3D 200;
+	rev.diffopt.break_opt =3D 0;
+	copy_pathspec(&rev.prune_data, pathspec);
+	run_diff_index(&rev, 1);
+}
+
 /*
  * Prune the index to only contain stuff starting with "prefix"
  */
@@ -734,6 +789,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			N_("show cached files that are deleted on working directory")),
 		OPT_BOOL('m', "modified", &show_modified,
 			N_("show cached files that have modification on working directory")=
),
+		OPT_BOOL('M', "modified", &show_diff_cached,
+			N_("show modified files in the cache")),
 		OPT_BOOL('o', "others", &show_others,
 			N_("show untracked files")),
 		OPT_SET_INT('R', "recursive", &max_depth,
@@ -847,11 +904,12 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage || show_deleted || show_others || show_unmerged ||
-	      show_killed || show_modified || show_resolve_undo))
+	      show_killed || show_modified || show_resolve_undo || show_diff_=
cached))
 		show_cached =3D 1;
=20
 	if (show_tag =3D=3D -1)
 		show_tag =3D (show_cached + show_deleted + show_others +
+			    show_diff_cached +
 			    show_unmerged + show_killed + show_modified) > 1;
 	if (show_tag || show_valid_bit) {
 		tag_cached =3D porcelain ? "  " : "H ";
@@ -859,6 +917,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		tag_removed =3D "R ";
 		tag_modified =3D "C ";
 		tag_other =3D "? ";
+		tag_diff_cached =3D "X ";
 		tag_killed =3D "K ";
 		tag_skip_worktree =3D "S ";
 		tag_resolve_undo =3D "U ";
@@ -879,6 +938,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED, &pathspe=
c, NULL, NULL);
 		setup_pager();
 	}
+	if (show_diff_cached)
+		diff_cached(&pathspec);
 	if (porcelain)
 		show_files_compact(&dir);
 	else
--=20
2.3.0.rc1.137.g477eb31
