From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/9] Convert some match_pathspec_depth() to ce_path_match()
Date: Fri, 24 Jan 2014 20:40:28 +0700
Message-ID: <1390570836-20394-2-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:35:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6guo-0004yd-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbaAXNfP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:15 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38435 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNfN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:13 -0500
Received: by mail-pd0-f172.google.com with SMTP id p10so3158289pdj.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vPOkMZV4jMrVbzmcOLUOa3qo+Ot/jpR/Us4fHqxq+hA=;
        b=xTJCgrUxf9IxFdxwp1CtoLkPQLTpdXGowCEW/M8U2dgu4mAdM1/Br9nf8BIQ2YOWuO
         MFvYqEog7v/mFB69k2eRBDnvXgvInKf150e06kPUbl6hJKjT4gLrDKQs6PYHZezePQ9M
         0nUqTwWH90wCK5Xih84gxFFV+H/agdz46S4tvQuAgY4aFTv6b6ZBzRPSlGjvv9jw2l/Y
         GSZHv+0uBb+7p4heabRmP+StzgSvImL2RKlZo9qul2muyy0VzoTNWJge1qvJTz+kLQNY
         lasMEATDg3I7YNn9uVnYdM+ovXZBErHWQEV35GazrpekD4G+cBaqb9Dn50yGDShZBoZd
         Dg3g==
X-Received: by 10.66.232.129 with SMTP id to1mr14525727pac.29.1390570511550;
        Fri, 24 Jan 2014 05:35:11 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id os1sm7648885pac.20.2014.01.24.05.35.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:40:45 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241000>

This helps reduce the number of match_pathspec_depth() call sites and
show how match_pathspec_depth() is used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c     | 3 +--
 builtin/commit.c       | 2 +-
 builtin/grep.c         | 2 +-
 builtin/rm.c           | 2 +-
 builtin/update-index.c | 3 ++-
 cache.h                | 2 --
 diff-lib.c             | 5 +++--
 dir.h                  | 7 +++++++
 pathspec.c             | 2 +-
 preload-index.c        | 3 ++-
 read-cache.c           | 8 +-------
 resolve-undo.c         | 2 +-
 revision.c             | 3 ++-
 wt-status.c            | 2 +-
 14 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5df3837..ada51fa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -297,8 +297,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		 * match_pathspec() for _all_ entries when
 		 * opts->source_tree !=3D NULL.
 		 */
-		if (match_pathspec_depth(&opts->pathspec, ce->name, ce_namelen(ce),
-				   0, ps_matched))
+		if (ce_path_match(ce, &opts->pathspec, ps_matched))
 			ce->ce_flags |=3D CE_MATCHED;
 	}
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..26b2986 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -234,7 +234,7 @@ static int list_paths(struct string_list *list, con=
st char *with_tree,
=20
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!match_pathspec_depth(pattern, ce->name, ce_namelen(ce), 0, m))
+		if (!ce_path_match(ce, pattern, m))
 			continue;
 		item =3D string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
diff --git a/builtin/grep.c b/builtin/grep.c
index 63f8603..3d924c2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -379,7 +379,7 @@ static int grep_cache(struct grep_opt *opt, const s=
truct pathspec *pathspec, int
 		const struct cache_entry *ce =3D active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NUL=
L))
+		if (!ce_path_match(ce, pathspec, NULL))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
diff --git a/builtin/rm.c b/builtin/rm.c
index 3a0e0ea..0564218 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -308,7 +308,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
=20
 	for (i =3D 0; i < active_nr; i++) {
 		const struct cache_entry *ce =3D active_cache[i];
-		if (!match_pathspec_depth(&pathspec, ce->name, ce_namelen(ce), 0, se=
en))
+		if (!ce_path_match(ce, &pathspec, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
 		list.entry[list.nr].name =3D ce->name;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e3a10d7..aaa6f78 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -12,6 +12,7 @@
 #include "resolve-undo.h"
 #include "parse-options.h"
 #include "pathspec.h"
+#include "dir.h"
=20
 /*
  * Default to not allowing changes to the list of files. The
@@ -564,7 +565,7 @@ static int do_reupdate(int ac, const char **av,
 		struct cache_entry *old =3D NULL;
 		int save_nr;
=20
-		if (ce_stage(ce) || !ce_path_match(ce, &pathspec))
+		if (ce_stage(ce) || !ce_path_match(ce, &pathspec, NULL))
 			continue;
 		if (has_head)
 			old =3D read_one_ent(NULL, head_sha1,
diff --git a/cache.h b/cache.h
index 83a2726..3c558f8 100644
--- a/cache.h
+++ b/cache.h
@@ -500,8 +500,6 @@ extern void *read_blob_data_from_index(struct index=
_state *, const char *, unsig
 extern int ie_match_stat(const struct index_state *, const struct cach=
e_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, const struct cache_=
entry *, struct stat *, unsigned int);
=20
-extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
-
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, enum=
 object_type type, const char *path, unsigned flags);
diff --git a/diff-lib.c b/diff-lib.c
index 346cac6..2eddc66 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -11,6 +11,7 @@
 #include "unpack-trees.h"
 #include "refs.h"
 #include "submodule.h"
+#include "dir.h"
=20
 /*
  * diff-files
@@ -108,7 +109,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
=20
-		if (!ce_path_match(ce, &revs->prune_data))
+		if (!ce_path_match(ce, &revs->prune_data, NULL))
 			continue;
=20
 		if (ce_stage(ce)) {
@@ -438,7 +439,7 @@ static int oneway_diff(const struct cache_entry * c=
onst *src,
 	if (tree =3D=3D o->df_conflict_entry)
 		tree =3D NULL;
=20
-	if (ce_path_match(idx ? idx : tree, &revs->prune_data)) {
+	if (ce_path_match(idx ? idx : tree, &revs->prune_data, NULL)) {
 		do_oneway_diff(o, idx, tree);
 		if (diff_can_quit_early(&revs->diffopt)) {
 			o->exiting_early =3D 1;
diff --git a/dir.h b/dir.h
index 9b7e4e7..42793e5 100644
--- a/dir.h
+++ b/dir.h
@@ -205,4 +205,11 @@ extern int git_fnmatch(const struct pathspec_item =
*item,
 		       const char *pattern, const char *string,
 		       int prefix);
=20
+static inline int ce_path_match(const struct cache_entry *ce,
+				const struct pathspec *pathspec,
+				char *seen)
+{
+	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, se=
en);
+}
+
 #endif
diff --git a/pathspec.c b/pathspec.c
index 6cb9fd3..8043099 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -33,7 +33,7 @@ void add_pathspec_matches_against_index(const struct =
pathspec *pathspec,
 		return;
 	for (i =3D 0; i < active_nr; i++) {
 		const struct cache_entry *ce =3D active_cache[i];
-		match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, seen);
+		ce_path_match(ce, pathspec, seen);
 	}
 }
=20
diff --git a/preload-index.c b/preload-index.c
index 8c44ceb..968ee25 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "pathspec.h"
+#include "dir.h"
=20
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index,
@@ -53,7 +54,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce_uptodate(ce))
 			continue;
-		if (!ce_path_match(ce, &p->pathspec))
+		if (!ce_path_match(ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(c=
e)))
 			continue;
diff --git a/read-cache.c b/read-cache.c
index 33dd676..23eb251 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -728,11 +728,6 @@ int ce_same_name(const struct cache_entry *a, cons=
t struct cache_entry *b)
 	return ce_namelen(b) =3D=3D len && !memcmp(a->name, b->name, len);
 }
=20
-int ce_path_match(const struct cache_entry *ce, const struct pathspec =
*pathspec)
-{
-	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NU=
LL);
-}
-
 /*
  * We fundamentally don't like some paths: we don't want
  * dot or dot-dot anywhere, and for obvious reasons don't
@@ -1149,8 +1144,7 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
=20
-		if (pathspec &&
-		    !match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, see=
n))
+		if (pathspec && !ce_path_match(ce, pathspec, seen))
 			filtered =3D 1;
=20
 		if (ce_stage(ce)) {
diff --git a/resolve-undo.c b/resolve-undo.c
index c09b006..67d1543 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -182,7 +182,7 @@ void unmerge_index(struct index_state *istate, cons=
t struct pathspec *pathspec)
=20
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce =3D istate->cache[i];
-		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NUL=
L))
+		if (!ce_path_match(ce, pathspec, NULL))
 			continue;
 		i =3D unmerge_index_entry_at(istate, i);
 	}
diff --git a/revision.c b/revision.c
index a68fde6..e3dff61 100644
--- a/revision.c
+++ b/revision.c
@@ -16,6 +16,7 @@
 #include "line-log.h"
 #include "mailmap.h"
 #include "commit-slab.h"
+#include "dir.h"
=20
 volatile show_early_output_fn_t show_early_output;
=20
@@ -1396,7 +1397,7 @@ static void prepare_show_merge(struct rev_info *r=
evs)
 		const struct cache_entry *ce =3D active_cache[i];
 		if (!ce_stage(ce))
 			continue;
-		if (ce_path_match(ce, &revs->prune_data)) {
+		if (ce_path_match(ce, &revs->prune_data, NULL)) {
 			prune_num++;
 			prune =3D xrealloc(prune, sizeof(*prune) * prune_num);
 			prune[prune_num-2] =3D ce->name;
diff --git a/wt-status.c b/wt-status.c
index 4e55810..295c09e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -510,7 +510,7 @@ static void wt_status_collect_changes_initial(struc=
t wt_status *s)
 		struct wt_status_change_data *d;
 		const struct cache_entry *ce =3D active_cache[i];
=20
-		if (!ce_path_match(ce, &s->pathspec))
+		if (!ce_path_match(ce, &s->pathspec, NULL))
 			continue;
 		it =3D string_list_insert(&s->change, ce->name);
 		d =3D it->util;
--=20
1.8.5.2.240.g8478abd
