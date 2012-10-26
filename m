From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] Move try_merge_command and checkout_fast_forward to libgit.a
Date: Fri, 26 Oct 2012 22:53:49 +0700
Message-ID: <1351266835-22610-2-git-send-email-pclouds@gmail.com>
References: <20121026120253.GA1455@sigill.intra.peff.net>
 <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmEq-0008Us-Dg
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882Ab2JZPyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 11:54:11 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49515 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2JZPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:54:07 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1361868dak.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xD2C0FWLZ5eatfsARaFJxlSFP0ghNYso57Dltu55hC0=;
        b=zyncgw6oVJMygPMv5komRAQT0tsRNAa013TzKyvkZLXQB4bXYwsU/J8ZPFllKrgrk9
         zAEfm9OEaMluJTJF4OXzIXqa1pWxMT8D0w/NFKCLMplU6TMeMlLcUFzlnV1fqbPsE723
         o9WWuWuhtYIFSbVbXOBzsynZ8lzeLcFqg5qufv4qpu+cCv3R6rmlVOf+U3YBn35ZXtnH
         Ur3Nn9j1BiyV0mhbjEGEBuBIdxN9dJ0erZGv4G/7jo1ndSnKzlyD+PP75y8hmL7fa2u3
         NAv6Q6E8iIqUiQvK/BhGhjm8YYcMLGVg2lg+LY4wqoxHpETUJhnL0e5taDLV/eRDXRLe
         FhpA==
Received: by 10.68.224.138 with SMTP id rc10mr70723239pbc.34.1351266847423;
        Fri, 26 Oct 2012 08:54:07 -0700 (PDT)
Received: from lanh ([115.74.33.44])
        by mx.google.com with ESMTPS id f2sm1192077paz.25.2012.10.26.08.54.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 08:54:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Oct 2012 22:54:08 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208457>

These functions are called in sequencer.c, which is part of
libgit.a. This makes libgit.a potentially require builtin/merge.c for
external git commands.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile          |   1 +
 builtin/merge.c   | 106 +---------------------------------------------=
-----
 cache.h           |  11 +++++-
 merge-recursive.h |   5 ---
 merge.c           | 112 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 sequencer.c       |   2 +-
 6 files changed, 125 insertions(+), 112 deletions(-)
 create mode 100644 merge.c

diff --git a/Makefile b/Makefile
index f69979e..2c333dc 100644
--- a/Makefile
+++ b/Makefile
@@ -762,6 +762,7 @@ LIB_OBJS +=3D lockfile.o
 LIB_OBJS +=3D log-tree.o
 LIB_OBJS +=3D mailmap.o
 LIB_OBJS +=3D match-trees.o
+LIB_OBJS +=3D merge.o
 LIB_OBJS +=3D merge-file.o
 LIB_OBJS +=3D merge-recursive.o
 LIB_OBJS +=3D mergesort.o
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
index a58df84..2dc4dec 100644
--- a/cache.h
+++ b/cache.h
@@ -1265,8 +1265,15 @@ struct startup_info {
 };
 extern struct startup_info *startup_info;
=20
-/* builtin/merge.c */
-int checkout_fast_forward(const unsigned char *from, const unsigned ch=
ar *to);
+/* merge.c */
+struct commit_list;
+int try_merge_command(const char *strategy, size_t xopts_nr,
+		const char **xopts, struct commit_list *common,
+		const char *head_arg, struct commit_list *remotes);
+int checkout_fast_forward(const unsigned char *from,
+			  const unsigned char *to,
+			  int overwrite_ignore);
+
=20
 int sane_execvp(const char *file, char *const argv[]);
=20
diff --git a/merge-recursive.h b/merge-recursive.h
index 58f3435..9e090a3 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -59,9 +59,4 @@ struct tree *write_tree_from_memory(struct merge_opti=
ons *o);
=20
 int parse_merge_opt(struct merge_options *out, const char *s);
=20
-/* builtin/merge.c */
-int try_merge_command(const char *strategy, size_t xopts_nr,
-		const char **xopts, struct commit_list *common,
-		const char *head_arg, struct commit_list *remotes);
-
 #endif
diff --git a/merge.c b/merge.c
new file mode 100644
index 0000000..70f1000
--- /dev/null
+++ b/merge.c
@@ -0,0 +1,112 @@
+#include "cache.h"
+#include "commit.h"
+#include "run-command.h"
+#include "resolve-undo.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+#include "dir.h"
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
1.8.0.rc2.23.g1fb49df
