From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/19] list-files: -M aka diff-cached
Date: Sun, 30 Nov 2014 15:56:07 +0700
Message-ID: <1417337767-4505-20-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:58:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0LK-0003XX-9N
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbaK3I6y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:58:54 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36578 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbaK3I6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:58:53 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so9163513pab.28
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nRTUMZWr89OR9po9pL7A2IFqdABCwSX0VNCIvsIue4o=;
        b=PDvnuV2LMF7rF+Gzvjwt2EOyKTgLradVM66lK7ml/2XU/Wqo0EoRt14ElkAxp2Ecw2
         l6JlID/JfkfWuB1UAc4Q7bl5cr+9vRE9kNrCykofNbvH8sLaa+AguLnIcYT85pLD4pgM
         mV43BYD6hkEGYrT5mRG/x7JoKC7dwNalDgh6ELBrF16HKJIHSJ2DnrsMfmYLPyfheCpv
         cLSp3yBD813SjdeSdm3a9AB/5PkjLI2r10CVgXm7liC/sfH3RWI0dhFp2R3uXHojKm4V
         Z6xdhmYPI6jTHRx153DBhI6lHGQCDZYAcywdr9S/1fJ/xz0CjxVWxbAeJpwdq5TbJrml
         YYIA==
X-Received: by 10.68.227.104 with SMTP id rz8mr32669602pbc.4.1417337933315;
        Sun, 30 Nov 2014 00:58:53 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id v3sm6199792pdf.22.2014.11.30.00.58.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:58:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:58:51 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260442>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 5b5a068..08ae206 100644
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
@@ -343,7 +348,7 @@ static void show_files(struct dir_struct *dir)
 				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
 		}
 	}
-	if (show_deleted || show_modified) {
+	if (show_deleted || show_modified || show_diff_cached) {
 		for (i =3D 0; i < active_nr; i++) {
 			const struct cache_entry *ce =3D active_cache[i];
 			struct stat st;
@@ -358,7 +363,15 @@ static void show_files(struct dir_struct *dir)
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
@@ -452,6 +465,38 @@ static void show_files_compact(struct dir_struct *=
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
@@ -721,6 +766,8 @@ int cmd_ls_files(int argc, const char **argv, const=
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
@@ -833,11 +880,12 @@ int cmd_ls_files(int argc, const char **argv, con=
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
@@ -845,6 +893,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		tag_removed =3D "R ";
 		tag_modified =3D "C ";
 		tag_other =3D "? ";
+		tag_diff_cached =3D "X ";
 		tag_killed =3D "K ";
 		tag_skip_worktree =3D "S ";
 		tag_resolve_undo =3D "U ";
@@ -865,6 +914,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
 		setup_pager();
 	}
+	if (show_diff_cached)
+		diff_cached(&pathspec);
 	if (porcelain)
 		show_files_compact(&dir);
 	else
--=20
2.2.0.60.gb7b3c64
