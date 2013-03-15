From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 17/45] status: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 13:06:32 +0700
Message-ID: <1363327620-29017-18-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:26:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5x-0005OY-IE
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034Ab3COGZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:58 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38274 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab3COGZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:58 -0400
Received: by mail-ie0-f174.google.com with SMTP id k10so3923904iea.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=rYuHXftLF7sP12RuN220ORPh/q13s1oeCN3C2o3dhXc=;
        b=NR8xm/4UmsCtpA5Qt6gx6OoL50+DDUvGtVqwevK2pf3d0Gsdl670yNEcTa4Pl/+j9D
         AdnTL420ZGqnZOCBKkor7giU7XgFT0qtwRWr1guAAEiUBmlXXriv0b2NjPwY1mwhf1Ib
         Zf1H6pK7oakh6iwBc5PW6fhHUZLD6dMkXi7w3n7ob13p0vFbDMb38uNMxKrWkls1diEK
         kqSaiMArAAj7EBu1aq3Din7XztPqOlsQupvNeTu9/pEL6UoUDkxoPKO+wmKfv3TFTgOT
         3u8tfqNCebT9igurLgOkKxS7p6wHFEZUOa5qhEk2JZXw12JmoK7XamG747ZpCgGgDm5O
         2h3Q==
X-Received: by 10.50.203.72 with SMTP id ko8mr4336663igc.93.1363328757684;
        Thu, 14 Mar 2013 23:25:57 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ip2sm619512igc.5.2013.03.14.23.25.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:57 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:09:00 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218204>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |  9 +++++----
 wt-status.c      | 18 ++++++++----------
 wt-status.h      |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index ba6731b..d8e6b28 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1195,11 +1195,12 @@ int cmd_status(int argc, const char **argv, con=
st char *prefix)
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
 		s.show_ignored_files =3D 1;
-	if (*argv)
-		s.pathspec =3D get_pathspec(prefix, argv);
+	parse_pathspec(&s.pathspec, 0,
+		       PATHSPEC_PREFER_FULL,
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
index ef405d0..5dec9af 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "pathspec.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
@@ -434,7 +435,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 	}
 	rev.diffopt.format_callback =3D wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
-	init_pathspec(&rev.prune_data, s->pathspec);
+	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
 }
=20
@@ -459,22 +460,20 @@ static void wt_status_collect_changes_index(struc=
t wt_status *s)
 	rev.diffopt.detect_rename =3D 1;
 	rev.diffopt.rename_limit =3D 200;
 	rev.diffopt.break_opt =3D 0;
-	init_pathspec(&rev.prune_data, s->pathspec);
+	copy_pathspec(&rev.prune_data, &s->pathspec);
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
@@ -489,7 +488,6 @@ static void wt_status_collect_changes_initial(struc=
t wt_status *s)
 		else
 			d->index_status =3D DIFF_STATUS_ADDED;
 	}
-	free_pathspec(&pathspec);
 }
=20
 static void wt_status_collect_untracked(struct wt_status *s)
@@ -505,11 +503,11 @@ static void wt_status_collect_untracked(struct wt=
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
@@ -519,11 +517,11 @@ static void wt_status_collect_untracked(struct wt=
_status *s)
 		dir.flags =3D DIR_SHOW_IGNORED;
 		if (s->show_untracked_files !=3D SHOW_ALL_UNTRACKED_FILES)
 			dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
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
index 81e1dcf..bb01c23 100644
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
1.8.0.rc0.19.g7bbb31d
