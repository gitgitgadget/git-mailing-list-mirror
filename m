From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/21] list-files: -M aka diff-cached
Date: Sun, 25 Jan 2015 19:37:55 +0700
Message-ID: <1422189476-7518-21-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:29:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMJg-0004CX-1I
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbbAYM3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:29:19 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47865 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbbAYM3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:29:17 -0500
Received: by mail-pd0-f169.google.com with SMTP id g10so6879815pdj.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1S/M5F0vOP6cwvn+gXwvMp1fYMQqcRx2rKzQ9CiOEOU=;
        b=P4i+6KvAxXkGPoPkreJP/47ZW9VxGJ2ekZku/hhBwhU+7KX7MglzKGW7QhhZV+toxA
         zkQl+gblYCwtYXgxze6rxgcQes0SVOukqaxM4daxf7UD7CpcdO5PM9rFQ74sTrj7bUYW
         RS2Mzz9BXbg+aCM6p3PtXYD4HsKXILrwg4/sWY2KWMIpxKlPvoR6R3T9eJ/sChKi3w14
         b5YjFI7oQjXYHna3hwaDNYI6K5x4dE7abcqRszOMBwqYp2uSie0pG0zW8D4e2JOXjd/R
         xM/jdnh5JLnGcuQHG/5enYswWLv7G6YfVXCEMhN5PpmIbraoKymT/K9VQwmJKFYiONTC
         JMdA==
X-Received: by 10.70.3.3 with SMTP id 3mr16740463pdy.17.1422188957396;
        Sun, 25 Jan 2015 04:29:17 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id i9sm7124188pdk.49.2015.01.25.04.29.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:29:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:40:41 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263016>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 697a307..b04c712 100644
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
@@ -404,7 +409,15 @@ static void show_files(struct dir_struct *dir)
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
@@ -424,7 +437,8 @@ static void show_files_compact(struct dir_struct *d=
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
@@ -444,6 +458,15 @@ static void show_files_compact(struct dir_struct *=
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
@@ -457,6 +480,38 @@ static void show_files_compact(struct dir_struct *=
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
@@ -726,6 +781,8 @@ int cmd_ls_files(int argc, const char **argv, const=
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
@@ -839,11 +896,12 @@ int cmd_ls_files(int argc, const char **argv, con=
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
@@ -851,6 +909,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		tag_removed =3D "R ";
 		tag_modified =3D "C ";
 		tag_other =3D "? ";
+		tag_diff_cached =3D "X ";
 		tag_killed =3D "K ";
 		tag_skip_worktree =3D "S ";
 		tag_resolve_undo =3D "U ";
@@ -871,6 +930,8 @@ int cmd_ls_files(int argc, const char **argv, const=
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
2.2.0.84.ge9c7a8a
