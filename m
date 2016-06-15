From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/46] status: convert to use parse_pathspec
Date: Sun, 14 Jul 2013 15:35:39 +0700
Message-ID: <1373790969-13000-17-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHob-00020M-Ue
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab3GNIhy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:37:54 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43251 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:53 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so10213114pab.38
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RoK/bE4TW8bJS2/ZQtFwBChvHwe6APZPmL0ZUQ9Q0b0=;
        b=Cyb61ToXOP0xr3J3DDgh+zrP3t5YnPs5Kp1d4TwoBkPO5tSuH0LweojpuVU7bYsA/k
         GSzhJsdkxio/qipUvk0iFrq3exoMhnsFbnOxH2PgSECSx9cupn5kJqJ52jeLizIQcHbu
         74QJNv64CM8pDxjwpu/rVbog5XTCJTTNCyMfKfykl89i6vXIqW8zdf5IPHsvenQqUjHr
         AUhG1KAed7XngfK1h3C4WRullPIWzB8/HCSGyd74n5kl6vs673MHTZcHmmjAu71HrUcd
         ZtQIHZe0jZAxi5POq0hkrZjPn69vLN4y5HU1q4j8yokS3Owa7kTkxfc4HqRU8VmgpLxb
         m0yQ==
X-Received: by 10.68.178.161 with SMTP id cz1mr49185560pbc.123.1373791073044;
        Sun, 14 Jul 2013 01:37:53 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id ie3sm54567492pbc.13.2013.07.14.01.37.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:38:04 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230328>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |  9 +++++----
 wt-status.c      | 16 +++++++---------
 wt-status.h      |  2 +-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 530f0ed..64d1a3d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1241,11 +1241,12 @@ int cmd_status(int argc, const char **argv, con=
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
index 9c4d086..fae0c27 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "pathspec.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
@@ -438,7 +439,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 	}
 	rev.diffopt.format_callback =3D wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
-	init_pathspec(&rev.prune_data, s->pathspec);
+	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
 }
=20
@@ -463,22 +464,20 @@ static void wt_status_collect_changes_index(struc=
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
@@ -493,7 +492,6 @@ static void wt_status_collect_changes_initial(struc=
t wt_status *s)
 		else
 			d->index_status =3D DIFF_STATUS_ADDED;
 	}
-	free_pathspec(&pathspec);
 }
=20
 static void wt_status_collect_untracked(struct wt_status *s)
@@ -516,12 +514,12 @@ static void wt_status_collect_untracked(struct wt=
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
@@ -529,7 +527,7 @@ static void wt_status_collect_untracked(struct wt_s=
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
