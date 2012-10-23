From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Move try_merge_command and checkout_fast_forward to libgit.a
Date: Tue, 23 Oct 2012 09:24:51 +0700
Message-ID: <1350959091-30030-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 04:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQUBD-0001yz-2H
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 04:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545Ab2JWCZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2012 22:25:04 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:41929 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab2JWCZC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 22:25:02 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1680604dak.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 19:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=7sl1Gv7chOLIOfy7bP3BeMmtTfEqozovwz9Id5rr/8w=;
        b=Uihsv4l21dJtLLLbsGioe76JGQFVmSOOriTQtsJbrggRekg/eDfgr4/OnSg9UzODTM
         6xhEaRzH118KSvWPG+0O1S8exwCiSyoVJD/AKpF2fmijJYElihXZwAueWPadQzIVepJw
         G5+frKEP25jCY3HuRfN1unDST3lSi+Ljl2Nb7kt+XOlmpa/28cQ11ZVXzqoG6FvQnYIt
         zsGto9TT+DS2W1v1HFZgcdVUqRaT7sZMh1t2Etdx8Phe16na+gtc5yqmkl5xrPmK5DFR
         +ZVTGYDKTMbqZ+YRcDJZ109WpTn5jX5IV7/vHpMM1MsNyc7ulcyj2IBekouVLMlc6h4c
         7Ekw==
Received: by 10.68.203.137 with SMTP id kq9mr35408658pbc.96.1350959101826;
        Mon, 22 Oct 2012 19:25:01 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ay5sm6857948pab.1.2012.10.22.19.24.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 19:24:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 23 Oct 2012 09:24:52 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208211>

These functions are called in sequencer.c, which is part of
libgit.a. This makes libgit.a potentially require builtin/merge.c for
external git commands.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I made some unrelated changes in sequencer.c and this problem shown
 up. merge-recursive.c is probably not the best place for these
 functions. I just don't want to create merge.c for them.

 builtin/merge.c   | 106 +---------------------------------------------=
-------
 cache.h           |   3 --
 merge-recursive.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 merge-recursive.h |   4 ++
 sequencer.c       |   2 +-
 5 files changed, 115 insertions(+), 108 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0ec8f0d..a96e8ea 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -628,59 +628,6 @@ static void write_tree_trivial(unsigned char *sha1=
)
 		die(_("git write-tree failed to write a tree"));
 }
=20
-static const char *merge_argument(struct commit *commit)
-{
-	if (commit)
-		return sha1_to_hex(commit->object.sha1);
-	else
-		return EMPTY_TREE_SHA1_HEX;
-}
-
-int try_merge_command(const char *strategy, size_t xopts_nr,
-		      const char **xopts, struct commit_list *common,
-		      const char *head_arg, struct commit_list *remotes)
-{
-	const char **args;
-	int i =3D 0, x =3D 0, ret;
-	struct commit_list *j;
-	struct strbuf buf =3D STRBUF_INIT;
-
-	args =3D xmalloc((4 + xopts_nr + commit_list_count(common) +
-			commit_list_count(remotes)) * sizeof(char *));
-	strbuf_addf(&buf, "merge-%s", strategy);
-	args[i++] =3D buf.buf;
-	for (x =3D 0; x < xopts_nr; x++) {
-		char *s =3D xmalloc(strlen(xopts[x])+2+1);
-		strcpy(s, "--");
-		strcpy(s+2, xopts[x]);
-		args[i++] =3D s;
-	}
-	for (j =3D common; j; j =3D j->next)
-		args[i++] =3D xstrdup(merge_argument(j->item));
-	args[i++] =3D "--";
-	args[i++] =3D head_arg;
-	for (j =3D remotes; j; j =3D j->next)
-		args[i++] =3D xstrdup(merge_argument(j->item));
-	args[i] =3D NULL;
-	ret =3D run_command_v_opt(args, RUN_GIT_CMD);
-	strbuf_release(&buf);
-	i =3D 1;
-	for (x =3D 0; x < xopts_nr; x++)
-		free((void *)args[i++]);
-	for (j =3D common; j; j =3D j->next)
-		free((void *)args[i++]);
-	i +=3D 2;
-	for (j =3D remotes; j; j =3D j->next)
-		free((void *)args[i++]);
-	free(args);
-	discard_cache();
-	if (read_cache() < 0)
-		die(_("failed to read the cache"));
-	resolve_undo_clear();
-
-	return ret;
-}
-
 static int try_merge_strategy(const char *strategy, struct commit_list=
 *common,
 			      struct commit_list *remoteheads,
 			      struct commit *head, const char *head_arg)
@@ -762,56 +709,6 @@ static int count_unmerged_entries(void)
 	return ret;
 }
=20
-int checkout_fast_forward(const unsigned char *head, const unsigned ch=
ar *remote)
-{
-	struct tree *trees[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
-	struct tree_desc t[MAX_UNPACK_TREES];
-	int i, fd, nr_trees =3D 0;
-	struct dir_struct dir;
-	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file));
-
-	refresh_cache(REFRESH_QUIET);
-
-	fd =3D hold_locked_index(lock_file, 1);
-
-	memset(&trees, 0, sizeof(trees));
-	memset(&opts, 0, sizeof(opts));
-	memset(&t, 0, sizeof(t));
-	if (overwrite_ignore) {
-		memset(&dir, 0, sizeof(dir));
-		dir.flags |=3D DIR_SHOW_IGNORED;
-		setup_standard_excludes(&dir);
-		opts.dir =3D &dir;
-	}
-
-	opts.head_idx =3D 1;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
-	opts.update =3D 1;
-	opts.verbose_update =3D 1;
-	opts.merge =3D 1;
-	opts.fn =3D twoway_merge;
-	setup_unpack_trees_porcelain(&opts, "merge");
-
-	trees[nr_trees] =3D parse_tree_indirect(head);
-	if (!trees[nr_trees++])
-		return -1;
-	trees[nr_trees] =3D parse_tree_indirect(remote);
-	if (!trees[nr_trees++])
-		return -1;
-	for (i =3D 0; i < nr_trees; i++) {
-		parse_tree(trees[i]);
-		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
-	}
-	if (unpack_trees(nr_trees, t, &opts))
-		return -1;
-	if (write_cache(fd, active_cache, active_nr) ||
-		commit_locked_index(lock_file))
-		die(_("unable to write new index file"));
-	return 0;
-}
-
 static void split_merge_strategies(const char *string, struct strategy=
 **list,
 				   int *nr, int *alloc)
 {
@@ -1424,7 +1321,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		}
=20
 		if (checkout_fast_forward(head_commit->object.sha1,
-					  commit->object.sha1)) {
+					  commit->object.sha1,
+					  overwrite_ignore)) {
 			ret =3D 1;
 			goto done;
 		}
diff --git a/cache.h b/cache.h
index a58df84..415c777 100644
--- a/cache.h
+++ b/cache.h
@@ -1265,9 +1265,6 @@ struct startup_info {
 };
 extern struct startup_info *startup_info;
=20
-/* builtin/merge.c */
-int checkout_fast_forward(const unsigned char *from, const unsigned ch=
ar *to);
-
 int sane_execvp(const char *file, char *const argv[]);
=20
 #endif /* CACHE_H */
diff --git a/merge-recursive.c b/merge-recursive.c
index d882060..4d2422a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -21,6 +21,9 @@
 #include "merge-recursive.h"
 #include "dir.h"
 #include "submodule.h"
+#include "run-command.h"
+#include "resolve-undo.h"
+#include "unpack-trees.h"
=20
 static struct tree *shift_tree_object(struct tree *one, struct tree *t=
wo,
 				      const char *subtree_shift)
@@ -2087,3 +2090,108 @@ int parse_merge_opt(struct merge_options *o, co=
nst char *s)
 		return -1;
 	return 0;
 }
+
+static const char *merge_argument(struct commit *commit)
+{
+	if (commit)
+		return sha1_to_hex(commit->object.sha1);
+	else
+		return EMPTY_TREE_SHA1_HEX;
+}
+
+int try_merge_command(const char *strategy, size_t xopts_nr,
+		      const char **xopts, struct commit_list *common,
+		      const char *head_arg, struct commit_list *remotes)
+{
+	const char **args;
+	int i =3D 0, x =3D 0, ret;
+	struct commit_list *j;
+	struct strbuf buf =3D STRBUF_INIT;
+
+	args =3D xmalloc((4 + xopts_nr + commit_list_count(common) +
+			commit_list_count(remotes)) * sizeof(char *));
+	strbuf_addf(&buf, "merge-%s", strategy);
+	args[i++] =3D buf.buf;
+	for (x =3D 0; x < xopts_nr; x++) {
+		char *s =3D xmalloc(strlen(xopts[x])+2+1);
+		strcpy(s, "--");
+		strcpy(s+2, xopts[x]);
+		args[i++] =3D s;
+	}
+	for (j =3D common; j; j =3D j->next)
+		args[i++] =3D xstrdup(merge_argument(j->item));
+	args[i++] =3D "--";
+	args[i++] =3D head_arg;
+	for (j =3D remotes; j; j =3D j->next)
+		args[i++] =3D xstrdup(merge_argument(j->item));
+	args[i] =3D NULL;
+	ret =3D run_command_v_opt(args, RUN_GIT_CMD);
+	strbuf_release(&buf);
+	i =3D 1;
+	for (x =3D 0; x < xopts_nr; x++)
+		free((void *)args[i++]);
+	for (j =3D common; j; j =3D j->next)
+		free((void *)args[i++]);
+	i +=3D 2;
+	for (j =3D remotes; j; j =3D j->next)
+		free((void *)args[i++]);
+	free(args);
+	discard_cache();
+	if (read_cache() < 0)
+		die(_("failed to read the cache"));
+	resolve_undo_clear();
+
+	return ret;
+}
+
+int checkout_fast_forward(const unsigned char *head,
+			  const unsigned char *remote,
+			  int overwrite_ignore)
+{
+	struct tree *trees[MAX_UNPACK_TREES];
+	struct unpack_trees_options opts;
+	struct tree_desc t[MAX_UNPACK_TREES];
+	int i, fd, nr_trees =3D 0;
+	struct dir_struct dir;
+	struct lock_file *lock_file =3D xcalloc(1, sizeof(struct lock_file));
+
+	refresh_cache(REFRESH_QUIET);
+
+	fd =3D hold_locked_index(lock_file, 1);
+
+	memset(&trees, 0, sizeof(trees));
+	memset(&opts, 0, sizeof(opts));
+	memset(&t, 0, sizeof(t));
+	if (overwrite_ignore) {
+		memset(&dir, 0, sizeof(dir));
+		dir.flags |=3D DIR_SHOW_IGNORED;
+		setup_standard_excludes(&dir);
+		opts.dir =3D &dir;
+	}
+
+	opts.head_idx =3D 1;
+	opts.src_index =3D &the_index;
+	opts.dst_index =3D &the_index;
+	opts.update =3D 1;
+	opts.verbose_update =3D 1;
+	opts.merge =3D 1;
+	opts.fn =3D twoway_merge;
+	setup_unpack_trees_porcelain(&opts, "merge");
+
+	trees[nr_trees] =3D parse_tree_indirect(head);
+	if (!trees[nr_trees++])
+		return -1;
+	trees[nr_trees] =3D parse_tree_indirect(remote);
+	if (!trees[nr_trees++])
+		return -1;
+	for (i =3D 0; i < nr_trees; i++) {
+		parse_tree(trees[i]);
+		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+	}
+	if (unpack_trees(nr_trees, t, &opts))
+		return -1;
+	if (write_cache(fd, active_cache, active_nr) ||
+		commit_locked_index(lock_file))
+		die(_("unable to write new index file"));
+	return 0;
+}
diff --git a/merge-recursive.h b/merge-recursive.h
index 58f3435..e01a9c0 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -64,4 +64,8 @@ int try_merge_command(const char *strategy, size_t xo=
pts_nr,
 		const char **xopts, struct commit_list *common,
 		const char *head_arg, struct commit_list *remotes);
=20
+int checkout_fast_forward(const unsigned char *from,
+			  const unsigned char *to,
+			  int overwrite_ignore);
+
 #endif
diff --git a/sequencer.c b/sequencer.c
index e3723d2..be0cb8b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -191,7 +191,7 @@ static int fast_forward_to(const unsigned char *to,=
 const unsigned char *from)
 	struct ref_lock *ref_lock;
=20
 	read_cache();
-	if (checkout_fast_forward(from, to))
+	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
 	ref_lock =3D lock_any_ref_for_update("HEAD", from, 0);
 	return write_ref_sha1(ref_lock, to, "cherry-pick");
--=20
1.8.0.rc3.18.g0d9b108
