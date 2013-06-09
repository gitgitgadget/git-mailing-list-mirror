From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/45] status: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:49 +0700
Message-ID: <1370759178-1709-17-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ5M-0000Rq-4m
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab3FIG0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:26:36 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57854 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab3FIG0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:26:35 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so3634404pdj.40
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vaKwJDhA6+9RnDHOEuLLJWBgus/ul5+ptrgwXfd480Q=;
        b=gHu1q5g8VXWIJlfb5AQmfJB2cJcrHwzsZo5fF7v4Z5uKBno81QphGvNVjJhFboCgAY
         bOEOBw+iH/7i8tB2gZqGFhsQA2h97WuxRoOyyhOKjXmFbUIKG3nfRQv5sG+M4G4ZCLrM
         4KpuE/nDXEoxvqXh5fcKd99+fN1fmIZKqZjCQZHY7RbT9MkW6IcVzafyC9fAys8iXeIH
         KP9jAOy0KiAVW4gaZ8OPe0TCBhv9yNOGGYpXf91vMWQzrD5F8ptKbDMr0H2L2icfST2I
         6ZCb0yQczfBxBqSgXsvn6BT7+bWo8bm6hBlaKqfwgPqvEfTquXBf+2NnE954pf0PEWQJ
         IUqA==
X-Received: by 10.66.162.102 with SMTP id xz6mr6826161pab.0.1370759195008;
        Sat, 08 Jun 2013 23:26:35 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id yj2sm5486684pbb.40.2013.06.08.23.26.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:06 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226908>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |  9 +++++----
 wt-status.c      | 16 +++++++---------
 wt-status.h      |  2 +-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0efe269..833c7be 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1197,11 +1197,12 @@ int cmd_status(int argc, const char **argv, con=
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
index bf84a86..99302e6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "pathspec.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
@@ -437,7 +438,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 	}
 	rev.diffopt.format_callback =3D wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
-	init_pathspec(&rev.prune_data, s->pathspec);
+	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
 }
=20
@@ -462,22 +463,20 @@ static void wt_status_collect_changes_index(struc=
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
@@ -492,7 +491,6 @@ static void wt_status_collect_changes_initial(struc=
t wt_status *s)
 		else
 			d->index_status =3D DIFF_STATUS_ADDED;
 	}
-	free_pathspec(&pathspec);
 }
=20
 static void wt_status_collect_untracked(struct wt_status *s)
@@ -515,12 +513,12 @@ static void wt_status_collect_untracked(struct wt=
_status *s)
 		dir.flags |=3D DIR_SHOW_IGNORED_TOO;
 	setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, s->pathspec);
+	fill_directory(&dir, s->pathspec.raw);
=20
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+		    match_pathspec_depth(&s->pathspec, ent->name, ent->len, 0, NULL)=
)
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
@@ -528,7 +526,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 	for (i =3D 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent =3D dir.ignored[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
+		    match_pathspec_depth(&s->pathspec, ent->name, ent->len, 0, NULL)=
)
 			string_list_insert(&s->ignored, ent->name);
 		free(ent);
 	}
diff --git a/wt-status.h b/wt-status.h
index 4121bc2..8463672 100644
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
1.8.2.83.gc99314b
