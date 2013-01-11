From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/21] status: convert to use parse_pathspec
Date: Fri, 11 Jan 2013 18:21:00 +0700
Message-ID: <1357903275-16804-7-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtcgQ-0006l4-PI
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab3AKLVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:21:39 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58218 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3AKLVi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:21:38 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so901808pbc.5
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=JhhRDkAgXVoo4xX61scCv/WCH+MT8Dd5PQk7UrigYhM=;
        b=BJnGNh3MpuaHVrMhg6PmerDVN1cx3Fre0e+QSnVSGEgYcM9oCpAV6u7gnmpkF+wyl6
         vOXzWNCWLIz1oWwyoyLl8HotybB2gBNsa285Ixbz/K1K19o7c0bdYHYMgDAr3oAt+u6Y
         d9/EXmcomLibKAo15QKcf9gY+23dGxjwN3PwlanBjgEiaM/FkwhlDZbk/fNL7x/ps2wb
         G5BDwpfLsDrhb0QaxxuSb66pq2u7cbDHfhEdyXLe+mtPa/GFc76uKyg7M/MUFi0irxT3
         YosJ79CDuIqXnQHRsfWta21VzX/pUNDkAAC84iD6/2/+7FS+cJU27CpPu+ngYoaNt2+b
         hO1g==
X-Received: by 10.66.73.105 with SMTP id k9mr206374790pav.37.1357903297675;
        Fri, 11 Jan 2013 03:21:37 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id nt5sm2632945pbb.59.2013.01.11.03.21.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:21:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:21:52 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213198>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |  9 +++++----
 wt-status.c      | 17 +++++++----------
 wt-status.h      |  2 +-
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 444ae1d..196dfab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1205,11 +1205,12 @@ int cmd_status(int argc, const char **argv, con=
st char *prefix)
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
 		s.show_ignored_files =3D 1;
-	if (*argv)
-		s.pathspec =3D get_pathspec(prefix, argv);
+	parse_pathspec(&s.pathspec, PATHSPEC_FROMTOP,
+		       PATHSPEC_EMPTY_MATCH_ALL,
+		       prefix, argv);
=20
-	read_cache_preload(s.pathspec);
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec,=
 NULL, NULL);
+	read_cache_preload(s.pathspec.raw);
+	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec.=
raw, NULL, NULL);
=20
 	fd =3D hold_locked_index(&index_lock, 0);
 	if (0 <=3D fd)
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..13e6aba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -434,7 +434,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 	}
 	rev.diffopt.format_callback =3D wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
-	init_pathspec(&rev.prune_data, s->pathspec);
+	rev.prune_data =3D s->pathspec;
 	run_diff_files(&rev, 0);
 }
=20
@@ -459,22 +459,20 @@ static void wt_status_collect_changes_index(struc=
t wt_status *s)
 	rev.diffopt.detect_rename =3D 1;
 	rev.diffopt.rename_limit =3D 200;
 	rev.diffopt.break_opt =3D 0;
-	init_pathspec(&rev.prune_data, s->pathspec);
+	rev.prune_data =3D s->pathspec;
 	run_diff_index(&rev, 1);
 }
=20
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
-	struct pathspec pathspec;
 	int i;
=20
-	init_pathspec(&pathspec, s->pathspec);
 	for (i =3D 0; i < active_nr; i++) {
 		struct string_list_item *it;
 		struct wt_status_change_data *d;
 		struct cache_entry *ce =3D active_cache[i];
=20
-		if (!ce_path_match(ce, &pathspec))
+		if (!ce_path_match(ce, &s->pathspec))
 			continue;
 		it =3D string_list_insert(&s->change, ce->name);
 		d =3D it->util;
@@ -489,7 +487,6 @@ static void wt_status_collect_changes_initial(struc=
t wt_status *s)
 		else
 			d->index_status =3D DIFF_STATUS_ADDED;
 	}
-	free_pathspec(&pathspec);
 }
=20
 static void wt_status_collect_untracked(struct wt_status *s)
@@ -505,11 +502,11 @@ static void wt_status_collect_untracked(struct wt=
_status *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, s->pathspec);
+	fill_directory(&dir, s->pathspec.raw);
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+		    match_pathspec_depth(&s->pathspec, ent->name, ent->len, 0, NULL)=
)
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
@@ -517,11 +514,11 @@ static void wt_status_collect_untracked(struct wt=
_status *s)
 	if (s->show_ignored_files) {
 		dir.nr =3D 0;
 		dir.flags =3D DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
-		fill_directory(&dir, s->pathspec);
+		fill_directory(&dir, s->pathspec.raw);
 		for (i =3D 0; i < dir.nr; i++) {
 			struct dir_entry *ent =3D dir.entries[i];
 			if (cache_name_is_other(ent->name, ent->len) &&
-			    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+			    match_pathspec_depth(&s->pathspec, ent->name, ent->len, 0, NULL=
))
 				string_list_insert(&s->ignored, ent->name);
 			free(ent);
 		}
diff --git a/wt-status.h b/wt-status.h
index 236b41f..dd8df41 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -44,7 +44,7 @@ struct wt_status {
 	int is_initial;
 	char *branch;
 	const char *reference;
-	const char **pathspec;
+	struct pathspec pathspec;
 	int verbose;
 	int amend;
 	enum commit_whence whence;
--=20
1.8.0.rc2.23.g1fb49df
