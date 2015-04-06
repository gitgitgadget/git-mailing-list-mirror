From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/25] list-files: add file modification options -[admADM]
Date: Mon,  6 Apr 2015 20:52:26 +0700
Message-ID: <1428328354-14897-18-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Tz-0005rd-AD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbbDFNy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:27 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34767 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbbDFNy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:26 -0400
Received: by pacyx8 with SMTP id yx8so44826036pac.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k8HlQeLkTQzUNpmtRTCfP7VWXlGZi9aFXwhqJePFreE=;
        b=AdgvpfXTDPd0ZNDW1ICIB2NJvLoIh+2yjNZiM5vQEh5XTO1dIFohiiPMIR8qILaMcQ
         u9Ec6Z+D/cPAyL5AzzEvvR8hw0xQ3EBLWZ55AC2Ph9DtBMNSgfivW/7qFFgcTce1t+xE
         63Yfe+XJw/JCiWB1ISWwL1SoDwHqI7XY+lfmy3wzwMBJvaPQzLH0SOqNpu9qGu3heXzb
         RLUL4GwdfyK4BU00gFGenFm06hjVGFK2s3xDTCDE+w8O2asoBaPlRgq69QZr59BDz4tV
         tAseVsRg06b6Z//N9lLHBIGaYQJtYuOQS+N3HriZLN9IWPB8tUUdbkUPZjgMH1NAvIJ1
         LAKQ==
X-Received: by 10.68.240.40 with SMTP id vx8mr27408700pbc.27.1428328465875;
        Mon, 06 Apr 2015 06:54:25 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id ef3sm4782051pbc.26.2015.04.06.06.54.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:37 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266862>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 73 +++++++++++++++++++++++++++++++++++++++++++=
+++++---
 t/t7013-list-files.sh | 62 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c           |  8 +++---
 wt-status.h           |  1 +
 4 files changed, 137 insertions(+), 7 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index fe15417..14ffd62 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -11,6 +11,7 @@
 enum item_type {
 	FROM_INDEX,
 	FROM_WORKTREE,
+	FROM_DIFF,
 	IS_DIR,
 	IS_UNMERGED
 };
@@ -39,8 +40,10 @@ static int max_depth;
 static int show_dirs;
 static int use_color =3D -1;
 static int show_indicator;
-static int show_cached, show_untracked, show_unmerged;
+static int show_cached, show_untracked, show_unmerged, show_changed;
 static int show_ignored;
+static int show_added, show_deleted, show_modified;
+static int show_wt_added, show_wt_deleted, show_wt_modified;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -57,6 +60,18 @@ struct option ls_options[] =3D {
 		 N_("show ignored files")),
 	OPT_BOOL('u', "unmerged", &show_unmerged,
 		 N_("show unmerged files")),
+	OPT_BOOL('a', "added", &show_added,
+		 N_("show added files compared to HEAD")),
+	OPT_BOOL('d', "deleted", &show_deleted,
+		 N_("show deleted files compared to HEAD")),
+	OPT_BOOL('m', "modified", &show_modified,
+		 N_("show modified files compared to HEAD")),
+	OPT_BOOL('A', "wt-added", &show_wt_added,
+		 N_("show added files in worktree")),
+	OPT_BOOL('D', "wt-deleted", &show_wt_deleted,
+		 N_("show deleted files in worktree")),
+	OPT_BOOL('M', "wt-modified", &show_wt_modified,
+		 N_("show modified files on worktree")),
=20
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL(0, "tag", &show_tag, N_("show tags")),
@@ -100,6 +115,7 @@ static mode_t get_mode(const struct item *item)
 	case FROM_INDEX:
 		return item->ce->ce_mode;
 	case FROM_WORKTREE:
+	case FROM_DIFF:
 	case IS_UNMERGED:
 		return item->st.st_mode;
 	}
@@ -263,18 +279,59 @@ static void populate_unmerged(struct item_list *r=
esult,
 	}
 }
=20
+static void populate_changed(struct item_list *result,
+			     const struct string_list *change)
+{
+	int i;
+
+	for (i =3D 0; i < change->nr; i++) {
+		const struct string_list_item *it =3D change->items + i;
+		struct wt_status_change_data *d =3D it->util;
+		const char *name =3D it->string;
+		struct stat st;
+		char tag[2];
+
+		switch (d->stagemask)
+			continue;
+
+		tag[0] =3D d->index_status ? d->index_status : ' ';
+		tag[1] =3D d->worktree_status ? d->worktree_status : ' ';
+
+		if ((show_added       && tag[0] =3D=3D 'A') ||
+		    (show_deleted     && tag[0] =3D=3D 'D') ||
+		    (show_modified    && tag[0] !=3D ' ') ||
+		    (show_wt_added    && tag[1] =3D=3D 'A') ||
+		    (show_wt_deleted  && tag[1] =3D=3D 'D') ||
+		    (show_wt_modified && tag[1] !=3D ' '))
+			;	/* keep going */
+		else
+			continue;
+
+		if (lstat(name, &st))
+			/* color_filename() treats this as an orphan file */
+			st.st_mode =3D 0;
+
+		if (!matched(result, name, st.st_mode))
+			continue;
+
+		add_wt_item(result, FROM_DIFF, name, tag, &st);
+	}
+}
+
 static void wt_status_populate(struct item_list *result,
 			       struct index_state *istate)
 {
 	struct wt_status ws;
=20
-	if (!show_untracked && !show_ignored && !show_unmerged)
+	if (!show_untracked && !show_ignored &&
+	    !show_unmerged && !show_changed)
 		return;
=20
 	wt_status_prepare(&ws);
 	copy_pathspec(&ws.pathspec, &recursive_pathspec);
 	if (show_ignored)
 		ws.show_ignored_files =3D 1;
+	ws.no_rename =3D 1;
 	ws.relative_paths =3D 0;
 	ws.use_color =3D 0;
 	ws.fp =3D NULL;
@@ -286,6 +343,8 @@ static void wt_status_populate(struct item_list *re=
sult,
 		populate_untracked(result, &ws.ignored, "!!");
 	if (show_unmerged)
 		populate_unmerged(result, &ws.change);
+	if (show_changed)
+		populate_changed(result, &ws.change);
=20
 	remove_duplicates(result);
 }
@@ -301,7 +360,9 @@ static void cleanup_tags(struct item_list *result)
 	}
=20
 	if (show_tag > 0 || show_unmerged ||
-	    show_cached + show_untracked + show_ignored > 1) {
+	    show_cached + show_untracked + show_ignored +
+	    show_added + show_deleted + show_wt_added + show_wt_deleted +
+	    show_modified + show_wt_modified > 1) {
 		result->tag_pos =3D 0;
 		result->tag_len =3D 2;
 		return;
@@ -438,7 +499,11 @@ int cmd_list_files(int argc, const char **argv, co=
nst char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
-	if (!show_cached && !show_untracked && !show_ignored && !show_unmerge=
d)
+	show_changed =3D
+		show_added || show_deleted || show_modified ||
+		show_wt_added || show_wt_deleted || show_wt_modified;
+	if (!show_cached && !show_untracked && !show_ignored &&
+	    !show_unmerged && !show_changed)
 		show_cached =3D 1;
=20
 	if (want_color(use_color))
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index 7fe9673..c747453 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -253,4 +253,66 @@ test_expect_success 'list-files unmerged' '
 	)
 '
=20
+test_expect_success 'list-files --added' '
+	git list-files -a >actual &&
+	cat >expected <<-\EOF &&
+	A b
+	A c
+	  sa
+	  sc
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'list-files --modified' '
+	echo modified >>a &&
+	git add a &&
+	git list-files --modified >actual &&
+	cat >expected <<-\EOF &&
+	M a
+	A b
+	A c
+	  sa
+	  sc
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'list-files --deleted' '
+	git rm --cached a &&
+	git list-files --deleted >actual &&
+	cat >expected <<-\EOF &&
+	a
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'list-files --wt-modifed --wt-deleted' '
+	rm b &&
+	git list-files --wt-deleted >actual &&
+	cat >expected <<-\EOF &&
+	b
+	EOF
+	test_cmp expected actual &&
+	echo foo >>c &&
+	git list-files --wt-modified >actual &&
+	cat >expected <<-\EOF &&
+	D b
+	M c
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'list-files --wt-modifed --modified' '
+	git list-files -mM >actual &&
+	cat >expected <<-\EOF &&
+	D  a
+	AD b
+	AM c
+	   sa
+	   sc
+	EOF
+	test_cmp expected actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index cdbc8d7..ba9b56c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -537,9 +537,11 @@ static void wt_status_collect_changes_index(struct=
 wt_status *s)
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data =3D s;
-	rev.diffopt.detect_rename =3D 1;
-	rev.diffopt.rename_limit =3D 200;
-	rev.diffopt.break_opt =3D 0;
+	if (!s->no_rename) {
+		rev.diffopt.detect_rename =3D 1;
+		rev.diffopt.rename_limit =3D 200;
+		rev.diffopt.break_opt =3D 0;
+	}
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 }
diff --git a/wt-status.h b/wt-status.h
index 283a9fe..dc94f35 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -55,6 +55,7 @@ struct wt_status {
 	int relative_paths;
 	int submodule_summary;
 	int show_ignored_files;
+	int no_rename;
 	enum untracked_status_type show_untracked_files;
 	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
--=20
2.3.0.rc1.137.g477eb31
