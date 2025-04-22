Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCB11E1308
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344017; cv=none; b=Bjs+1xQ/AQjPCwvUiLUmTLxF4f9icZwASwiEUdCRcCUqoSRz6dqp71bVLCsYiCRSBWZH2zkuR6pN2d6jQYEfUjXFCFTXZ/RB2FjnzIEWpwdZLnFD/Am9D1HdKVvQTcQdgyA05ldFvLF/1AY9rbfUmDcwu+0eKoBoDbwDM3VLqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344017; c=relaxed/simple;
	bh=k7hOp3/0piB/vysE+Z87aZRbvCUDOZkzyd0tsVh4ooU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLTa4DfG3UTa1nCxMexEMQS5VdNpg6iWjUh4Ui/Ke45w76p9X+pXUW5nTaCJMgctjyNXEprXT5QXa2m/ii4l3xuFKUxBpJI2W7D/NCwClVpRFh10RkOPUGrMHmAZaEcKT1m/IbM1H77Iol+Cu823PBVpEuRzQU3uAh3vPNYodUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=S+skYL7Y; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="S+skYL7Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745344011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51xQUP/UidqJCF1L3Vn+tSpbeqLv7he0iaF0wMY6qDg=;
	b=S+skYL7YNXbj2E8FQ1GWq1uGyL9BeUsCy+M8cCY/7tOeURJBCbVmOg7ryGQUW+8mdHjy4j
	uxIzkP0ew/BaAhSocYiPD9bfpniTlNdwg2/AZCpSPZ2QfClFcMt0sw2fv5rGJsY4RIY/tU
	H17AtZgxffT/MyBS1gOzwBcQVXx3Ipg=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 22 Apr 2025 19:46:24 +0200
Subject: [PATCH RFC 1/5] blame-tree: introduce new subcommand to blame
 files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250422-toon-new-blame-tree-v1-1-fdb51b8a394a@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
In-Reply-To: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
X-Migadu-Flow: FLOW_OUT

Similar to git-blame(1), introduce a new subcommand git-blame-tree(1).
This command shows the most recent modification to paths in a tree. It
does so by expanding the tree at a given commit, taking note of the
current state of each path, and then walking backwards through history
looking for commits where each path changed into its final commit ID.

Based-on-patch-by: Jeff King <peff@peff.net>
Improved-by: "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 .gitignore            |   1 +
 Makefile              |   2 +
 blame-tree.c          | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++
 blame-tree.h          |  27 +++++++
 builtin.h             |   1 +
 builtin/blame-tree.c  |  43 ++++++++++
 git.c                 |   1 +
 meson.build           |   2 +
 t/helper/test-tool.h  |   1 +
 t/meson.build         |   1 +
 t/t8020-blame-tree.sh | 147 ++++++++++++++++++++++++++++++++++
 11 files changed, 439 insertions(+)

diff --git a/.gitignore b/.gitignore
index 04c444404e..ba23d5b098 100644
--- a/.gitignore
+++ b/.gitignore
@@ -22,6 +22,7 @@
 /git-backfill
 /git-bisect
 /git-blame
+/git-blame-tree
 /git-branch
 /git-bugreport
 /git-bundle
diff --git a/Makefile b/Makefile
index 13f9062a05..aaf22af0b8 100644
--- a/Makefile
+++ b/Makefile
@@ -972,6 +972,7 @@ LIB_OBJS += archive.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
+LIB_OBJS += blame-tree.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
@@ -1216,6 +1217,7 @@ BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/backfill.o
 BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
+BUILTIN_OBJS += builtin/blame-tree.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
 BUILTIN_OBJS += builtin/bundle.o
diff --git a/blame-tree.c b/blame-tree.c
new file mode 100644
index 0000000000..ce57db2cfc
--- /dev/null
+++ b/blame-tree.c
@@ -0,0 +1,213 @@
+#include "git-compat-util.h"
+#include "blame-tree.h"
+#include "commit.h"
+#include "diffcore.h"
+#include "diff.h"
+#include "object.h"
+#include "revision.h"
+#include "repository.h"
+#include "log-tree.h"
+
+struct blame_tree_entry {
+	struct hashmap_entry hashent;
+	struct object_id oid;
+	struct commit *commit;
+	const char path[FLEX_ARRAY];
+};
+
+static void add_from_diff(struct diff_queue_struct *q,
+			  struct diff_options *opt UNUSED,
+			  void *data)
+{
+	struct blame_tree *bt = data;
+
+	for (int i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct blame_tree_entry *ent;
+		const char *path = p->two->path;
+
+		FLEX_ALLOC_STR(ent, path, path);
+		oidcpy(&ent->oid, &p->two->oid);
+		hashmap_entry_init(&ent->hashent, strhash(ent->path));
+		hashmap_add(&bt->paths, &ent->hashent);
+	}
+}
+
+static int add_from_revs(struct blame_tree *bt)
+{
+	size_t count = 0;
+	struct diff_options diffopt;
+
+	memcpy(&diffopt, &bt->rev.diffopt, sizeof(diffopt));
+	copy_pathspec(&diffopt.pathspec, &bt->rev.diffopt.pathspec);
+	diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	diffopt.format_callback = add_from_diff;
+	diffopt.format_callback_data = bt;
+
+	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
+		struct object_array_entry *obj = bt->rev.pending.objects + i;
+
+		if (obj->item->flags & UNINTERESTING)
+			continue;
+
+		if (count++)
+			return error(_("can only blame one tree at a time"));
+
+		diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
+			      &obj->item->oid, "", &diffopt);
+		diff_flush(&diffopt);
+	}
+	clear_pathspec(&diffopt.pathspec);
+
+	return 0;
+}
+
+static int blame_tree_entry_hashcmp(const void *unused UNUSED,
+				    const struct hashmap_entry *he1,
+				    const struct hashmap_entry *he2,
+				    const void *path)
+{
+	const struct blame_tree_entry *e1 =
+		container_of(he1, const struct blame_tree_entry, hashent);
+	const struct blame_tree_entry *e2 =
+		container_of(he2, const struct blame_tree_entry, hashent);
+	return strcmp(e1->path, path ? path : e2->path);
+}
+
+void blame_tree_init(struct blame_tree *bt,
+		     struct repository *r,
+		     const char *prefix,
+		     int argc, const char **argv)
+{
+	memset(bt, 0, sizeof(*bt));
+	hashmap_init(&bt->paths, blame_tree_entry_hashcmp, NULL, 0);
+
+	repo_init_revisions(r, &bt->rev, prefix);
+	bt->rev.def = "HEAD";
+	bt->rev.combine_merges = 1;
+	bt->rev.show_root_diff = 1;
+	bt->rev.boundary = 1;
+	bt->rev.no_commit_id = 1;
+	bt->rev.diff = 1;
+	if (setup_revisions(argc, argv, &bt->rev, NULL) > 1)
+		die(_("unknown blame-tree argument: %s"), argv[1]);
+
+	if (add_from_revs(bt) < 0)
+		die(_("unable to setup blame-tree"));
+}
+
+void blame_tree_release(struct blame_tree *bt)
+{
+	hashmap_clear_and_free(&bt->paths, struct blame_tree_entry, hashent);
+	release_revisions(&bt->rev);
+}
+
+struct blame_tree_callback_data {
+	struct commit *commit;
+	struct hashmap *paths;
+
+	blame_tree_callback callback;
+	void *callback_data;
+};
+
+static void mark_path(const char *path, const struct object_id *oid,
+		      struct blame_tree_callback_data *data)
+{
+	struct blame_tree_entry *ent;
+
+	/* Is it even a path that we are interested in? */
+	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
+					  struct blame_tree_entry, hashent);
+	if (!ent)
+		return;
+
+	/* Have we already blamed a commit? */
+	if (ent->commit)
+		return;
+
+	/*
+	 * Is it arriving at a version of interest, or is it from a side branch
+	 * which did not contribute to the final state?
+	 */
+	if (!oideq(oid, &ent->oid))
+		return;
+
+	ent->commit = data->commit;
+	if (data->callback)
+		data->callback(path, data->commit, data->callback_data);
+
+	hashmap_remove(data->paths, &ent->hashent, path);
+	free(ent);
+}
+
+static void blame_diff(struct diff_queue_struct *q,
+		       struct diff_options *opt UNUSED, void *cbdata)
+{
+	struct blame_tree_callback_data *data = cbdata;
+
+	for (int i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		switch (p->status) {
+		case DIFF_STATUS_DELETED:
+			/*
+			 * There's no point in feeding a deletion, as it could
+			 * not have resulted in our current state, which
+			 * actually has the file.
+			 */
+			break;
+
+		default:
+			/*
+			 * Otherwise, we care only that we somehow arrived at
+			 * a final path/sha1 state. Note that this covers some
+			 * potentially controversial areas, including:
+			 *
+			 *  1. A rename or copy will be blamed, as it is the
+			 *     first time the content has arrived at the given
+			 *     path.
+			 *
+			 *  2. Even a non-content modification like a mode or
+			 *     type change will trigger it.
+			 *
+			 * We take the inclusive approach for now, and blame
+			 * anything which impacts the path. Options to tweak
+			 * the behavior (e.g., to "--follow" the content across
+			 * renames) can come later.
+			 */
+			mark_path(p->two->path, &p->two->oid, data);
+			break;
+		}
+	}
+}
+
+int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
+{
+	struct blame_tree_callback_data data;
+
+	data.paths = &bt->paths;
+	data.callback = cb;
+	data.callback_data = cbdata;
+
+	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	bt->rev.diffopt.format_callback = blame_diff;
+	bt->rev.diffopt.format_callback_data = &data;
+
+	prepare_revision_walk(&bt->rev);
+
+	while (hashmap_get_size(&bt->paths)) {
+		data.commit = get_revision(&bt->rev);
+		if (!data.commit)
+			break;
+
+		if (data.commit->object.flags & BOUNDARY) {
+			diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
+				       &data.commit->object.oid,
+				       "", &bt->rev.diffopt);
+			diff_flush(&bt->rev.diffopt);
+		} else {
+			log_tree_commit(&bt->rev, data.commit);
+		}
+	}
+
+	return 0;
+}
diff --git a/blame-tree.h b/blame-tree.h
new file mode 100644
index 0000000000..abb467cf1b
--- /dev/null
+++ b/blame-tree.h
@@ -0,0 +1,27 @@
+#ifndef BLAME_TREE_H
+#define BLAME_TREE_H
+
+#include "commit.h"
+#include "revision.h"
+#include "hashmap.h"
+
+struct blame_tree {
+	struct hashmap paths;
+	struct rev_info rev;
+};
+
+void blame_tree_init(struct blame_tree *bt,
+		     struct repository *r,
+		     const char *prefix,
+		     int argc, const char **argv);
+
+void blame_tree_release(struct blame_tree *);
+
+typedef void (*blame_tree_callback)(const char *path,
+				    const struct commit *commit,
+				    void *data);
+int blame_tree_run(struct blame_tree *,
+		   blame_tree_callback cb,
+		   void *data);
+
+#endif /* BLAME_TREE_H */
diff --git a/builtin.h b/builtin.h
index bff13e3069..c7b06130b6 100644
--- a/builtin.h
+++ b/builtin.h
@@ -123,6 +123,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix, struct reposito
 int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_bisect(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_blame(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_blame_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_branch(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_bugreport(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_bundle(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/blame-tree.c b/builtin/blame-tree.c
new file mode 100644
index 0000000000..aaa3e9daa1
--- /dev/null
+++ b/builtin/blame-tree.c
@@ -0,0 +1,43 @@
+#include "git-compat-util.h"
+#include "blame-tree.h"
+#include "hex.h"
+#include "quote.h"
+#include "config.h"
+#include "object-name.h"
+#include "parse-options.h"
+#include "builtin.h"
+
+static void show_entry(const char *path, const struct commit *commit, void *d)
+{
+	struct blame_tree *bt = d;
+
+	if (commit->object.flags & BOUNDARY)
+		putchar('^');
+	printf("%s\t", oid_to_hex(&commit->object.oid));
+
+	if (bt->rev.diffopt.line_termination)
+		write_name_quoted(path, stdout, '\n');
+	else
+		printf("%s%c", path, '\0');
+
+	fflush(stdout);
+}
+
+int cmd_blame_tree(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo)
+{
+	int ret = 0;
+	struct blame_tree bt;
+
+	repo_config(repo, git_default_config, NULL);
+
+	blame_tree_init(&bt, repo, prefix, argc, argv);
+	if (blame_tree_run(&bt, show_entry, &bt) < 0)
+		die(_("error running blame-tree traversal"));
+
+	blame_tree_release(&bt);
+
+	return ret;
+}
diff --git a/git.c b/git.c
index 77c4359522..9f8b99b2d1 100644
--- a/git.c
+++ b/git.c
@@ -509,6 +509,7 @@ static struct cmd_struct commands[] = {
 	{ "backfill", cmd_backfill, RUN_SETUP },
 	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
+	{ "blame-tree", cmd_blame_tree, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
diff --git a/meson.build b/meson.build
index c47cb79af0..214ccf5a72 100644
--- a/meson.build
+++ b/meson.build
@@ -274,6 +274,7 @@ libgit_sources = [
   'attr.c',
   'base85.c',
   'bisect.c',
+  'blame-tree.c',
   'blame.c',
   'blob.c',
   'bloom.c',
@@ -546,6 +547,7 @@ builtin_sources = [
   'builtin/archive.c',
   'builtin/backfill.c',
   'builtin/bisect.c',
+  'builtin/blame-tree.c',
   'builtin/blame.c',
   'builtin/branch.c',
   'builtin/bugreport.c',
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6d62a5b53d..41cc3730dc 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -5,6 +5,7 @@
 
 int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bitmap(int argc, const char **argv);
+int cmd__blame_tree(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__bundle_uri(int argc, const char **argv);
 int cmd__cache_tree(int argc, const char **argv);
diff --git a/t/meson.build b/t/meson.build
index bfb744e886..65402e97da 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -960,6 +960,7 @@ integration_tests = [
   't8012-blame-colors.sh',
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
+  't8020-blame-tree.sh',
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
diff --git a/t/t8020-blame-tree.sh b/t/t8020-blame-tree.sh
new file mode 100755
index 0000000000..c11876c210
--- /dev/null
+++ b/t/t8020-blame-tree.sh
@@ -0,0 +1,147 @@
+#!/bin/sh
+
+test_description='blame-tree tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit 1 file &&
+	mkdir a &&
+	test_commit 2 a/file &&
+	mkdir a/b &&
+	test_commit 3 a/b/file
+'
+
+test_expect_success 'cannot blame two trees' '
+	test_must_fail git blame-tree HEAD HEAD~1
+'
+
+check_blame() {
+	local indir= &&
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			indir="$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac &&
+		shift
+	done &&
+
+	cat >expect &&
+	test_when_finished "rm -f tmp.*" &&
+	git ${indir:+-C "$indir"} blame-tree "$@" >tmp.1 &&
+	git name-rev --annotate-stdin --name-only --tags \
+		<tmp.1 >tmp.2 &&
+	tr '\t' ' ' <tmp.2 >tmp.3 &&
+	sort tmp.3 >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'blame recursive' '
+	check_blame --recursive <<-\EOF
+	1 file
+	2 a/file
+	3 a/b/file
+	EOF
+'
+
+test_expect_success 'blame non-recursive' '
+	check_blame --no-recursive <<-\EOF
+	1 file
+	3 a
+	EOF
+'
+
+test_expect_success 'blame subdir' '
+	check_blame a <<-\EOF
+	3 a
+	EOF
+'
+
+test_expect_success 'blame subdir recursive' '
+	check_blame --recursive a <<-\EOF
+	2 a/file
+	3 a/b/file
+	EOF
+'
+
+test_expect_success 'blame from non-HEAD commit' '
+	check_blame --no-recursive HEAD^ <<-\EOF
+	1 file
+	2 a
+	EOF
+'
+
+test_expect_success 'blame from subdir defaults to root' '
+	check_blame -C a --no-recursive <<-\EOF
+	1 file
+	3 a
+	EOF
+'
+
+test_expect_success 'blame from subdir uses relative pathspecs' '
+	check_blame -C a --recursive b <<-\EOF
+	3 a/b/file
+	EOF
+'
+
+test_expect_failure 'limit blame traversal by count' '
+	check_blame --no-recursive -1 <<-\EOF
+	3 a
+	EOF
+'
+
+test_expect_success 'limit blame traversal by commit' '
+	check_blame --no-recursive HEAD~2..HEAD <<-\EOF
+	3 a
+	^1 file
+	EOF
+'
+
+test_expect_success 'only blame files in the current tree' '
+	git rm -rf a &&
+	git commit -m "remove a" &&
+	check_blame <<-\EOF
+	1 file
+	EOF
+'
+
+test_expect_success 'cross merge boundaries in blaming' '
+	git checkout HEAD^0 &&
+	git rm -rf . &&
+	test_commit m1 &&
+	git checkout HEAD^ &&
+	git rm -rf . &&
+	test_commit m2 &&
+	git merge m1 &&
+	check_blame <<-\EOF
+	m1 m1.t
+	m2 m2.t
+	EOF
+'
+
+test_expect_success 'blame merge for resolved conflicts' '
+	git checkout HEAD^0 &&
+	git rm -rf . &&
+	test_commit c1 conflict &&
+	git checkout HEAD^ &&
+	git rm -rf . &&
+	test_commit c2 conflict &&
+	test_must_fail git merge c1 &&
+	test_commit resolved conflict &&
+	check_blame conflict <<-\EOF
+	resolved conflict
+	EOF
+'
+
+test_expect_success 'blame-tree complains about unknown arguments' '
+	test_must_fail git blame-tree --foo 2>err &&
+	grep "unknown blame-tree argument: --foo" err
+'
+
+test_done

-- 
2.49.0.rc2

