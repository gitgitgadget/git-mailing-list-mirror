Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CA2512EE
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020387; cv=none; b=rXzbkdL/k9NlUaJ84mkTp2WIYYOaSciZKePQdmfLCLqqfm3mnSb1czbaX48QAtLAHGELwOn2Q5jW9rlg5hkx2X+M861ekf0v6+BBfyz5kinin5kYLFjhW31TTNkQp63dnNOPnANeGNmjwQfYQQlnzeEp0Zs8TBPINKJMqFRhA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020387; c=relaxed/simple;
	bh=0O2WvGs2ykmym5YUzBe7rlmucIYLRnIsN2j3UU8eaZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCrmk6oxBas5oLy3wQm+dyTMgtRsbZYu0t3L8Ry6B4oB3dnmmkoRiJShe5HccfrTqYTTM0lYDFh5UbJt0Ah4Doqk6MXChJFIUQufxgAfFe/nmxvZVPlU88aMaLXWg1n2nEy57dF3uUOiPs0qau2bmUjrOLccRVvCgJN9/1ySd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0nU2L4UQ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0nU2L4UQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743020382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPlFTI5WyODzn9QvpIhXIEqvRzM0lNrWQHcv5HTkSMQ=;
	b=0nU2L4UQMgEybCz27AZmC6rbc8yX+pmsimHSrD05UEwz5/Kg+cewQIPK/5ByasvVuOAqSz
	Dq1zbAnCoLIeNgDE5YfdxylZ+iwqQsPKcKBubeuWdE2weE+OdUEm4nMptMPkiJZ2t13zhh
	PsstawfHLkaJ+VnqQyq8iqcYiS+dgwo=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Mar 2025 21:18:28 +0100
Subject: [PATCH 4/8] blame-tree: introduce new subcommand to blame files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250326-toon-blame-tree-v1-4-4173133f3786@iotcl.com>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
In-Reply-To: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Similar to git-blame(1), introduce a new subcommand git-blame-tree(1).
This command shows the most recent modification to paths in a tree. It
does so by expanding the tree at a given commit, taking note of the
current state of each path, and then walking backwards through history
looking for commits where each path changed into its final commit ID.

Based-on-a-patch-by: Jeff King <peff@peff.net>
Improved-by: "Ævar Arnfjörð Bjarmason" <avarab@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 .gitignore            |   1 +
 Makefile              |   2 +
 blame-tree.c          | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++
 blame-tree.h          |  43 +++++++++++
 builtin.h             |   1 +
 builtin/blame-tree.c  |  67 +++++++++++++++++
 git.c                 |   1 +
 meson.build           |   2 +
 t/helper/test-tool.h  |   1 +
 t/meson.build         |   1 +
 t/t8020-blame-tree.sh | 142 ++++++++++++++++++++++++++++++++++++
 11 files changed, 459 insertions(+)

diff --git a/.gitignore b/.gitignore
index 08a66ca508..27faa0ce90 100644
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
index 7315507381..92fdfc76df 100644
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
@@ -1215,6 +1216,7 @@ BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/backfill.o
 BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
+BUILTIN_OBJS += builtin/blame-tree.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
 BUILTIN_OBJS += builtin/bundle.o
diff --git a/blame-tree.c b/blame-tree.c
new file mode 100644
index 0000000000..ed4ec1e694
--- /dev/null
+++ b/blame-tree.c
@@ -0,0 +1,198 @@
+#include "git-compat-util.h"
+#include "blame-tree.h"
+#include "strvec.h"
+#include "hex.h"
+#include "commit.h"
+#include "diffcore.h"
+#include "diff.h"
+#include "object.h"
+#include "revision.h"
+#include "repository.h"
+#include "log-tree.h"
+
+void blame_tree_opts_release(struct blame_tree_options *bto)
+{
+	strvec_clear(&bto->args);
+}
+
+struct blame_tree_entry {
+	struct object_id oid;
+	struct commit *commit;
+};
+
+static void add_from_diff(struct diff_queue_struct *q,
+			  struct diff_options *opt UNUSED, void *data)
+{
+	struct blame_tree *bt = data;
+
+	for (int i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct blame_tree_entry *ent = xcalloc(1, sizeof(*ent));
+		struct string_list_item *it;
+
+		oidcpy(&ent->oid, &p->two->oid);
+		it = string_list_append(&bt->paths, p->two->path);
+		it->util = ent;
+	}
+}
+
+static int add_from_revs(struct blame_tree *bt)
+{
+	size_t count = 0;
+	struct diff_options diffopt;
+
+	memcpy(&diffopt, &bt->rev.diffopt, sizeof(diffopt));
+	diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	diffopt.format_callback = add_from_diff;
+	diffopt.format_callback_data = bt;
+	diffopt.no_free = 1;
+
+	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
+		struct object_array_entry *obj = bt->rev.pending.objects + i;
+
+		if (obj->item->flags & UNINTERESTING)
+			continue;
+
+		if (count++)
+			return error(_("can only blame one tree at a time"));
+		diff_tree_oid(bt->rev.repo->hash_algo->empty_tree,
+			      &obj->item->oid, "", &diffopt);
+		diff_flush(&diffopt);
+	}
+
+	string_list_sort(&bt->paths);
+	return 0;
+}
+
+void blame_tree_init(struct repository *r, struct blame_tree *bt,
+		     const struct blame_tree_options *opts)
+{
+	repo_init_revisions(r, &bt->rev, opts->prefix);
+	bt->rev.def = oid_to_hex(&opts->oid);
+	bt->rev.combine_merges = 1;
+	bt->rev.show_root_diff = 1;
+	bt->rev.boundary = 1;
+	bt->rev.no_commit_id = 1;
+	bt->rev.diff = 1;
+	bt->rev.diffopt.flags.recursive = opts->recursive;
+	setup_revisions(opts->args.nr, opts->args.v, &bt->rev, NULL);
+
+	if (add_from_revs(bt) < 0)
+		die(_("unable to setup blame-tree"));
+}
+
+void blame_tree_release(struct blame_tree *bt)
+{
+	string_list_clear(&bt->paths, 1);
+	release_revisions(&bt->rev);
+}
+
+struct blame_tree_callback_data {
+	struct commit *commit;
+	struct string_list *paths;
+	size_t num_interesting;
+
+	blame_tree_fn callback;
+	void *callback_data;
+};
+
+static void mark_path(const char *path, const struct object_id *oid,
+		      struct blame_tree_callback_data *data)
+{
+	struct string_list_item *item = string_list_lookup(data->paths, path);
+	struct blame_tree_entry *ent;
+
+	/* Is it even a path that exists in our tree? */
+	if (!item)
+		return;
+
+	/* Have we already blamed a commit? */
+	ent = item->util;
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
+	data->num_interesting--;
+	if (data->callback)
+		data->callback(path, data->commit, data->callback_data);
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
+int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *cbdata)
+{
+	struct blame_tree_callback_data data;
+
+	data.paths = &bt->paths;
+	data.num_interesting = bt->paths.nr;
+	data.callback = cb;
+	data.callback_data = cbdata;
+
+	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	bt->rev.diffopt.format_callback = blame_diff;
+	bt->rev.diffopt.format_callback_data = &data;
+
+	prepare_revision_walk(&bt->rev);
+
+	while (data.num_interesting) {
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
index 0000000000..ea06298f88
--- /dev/null
+++ b/blame-tree.h
@@ -0,0 +1,43 @@
+#ifndef BLAME_TREE_H
+#define BLAME_TREE_H
+
+#include "hash.h"
+#include "strvec.h"
+#include "string-list.h"
+#include "revision.h"
+#include "commit.h"
+
+struct blame_tree_options {
+	struct object_id oid;
+	const char *prefix;
+	unsigned int recursive;
+	struct strvec args;
+};
+
+#define BLAME_TREE_OPTIONS_INIT(...) { \
+	.args = STRVEC_INIT, \
+	__VA_ARGS__ \
+}
+
+void blame_tree_opts_release(struct blame_tree_options *bto);
+
+struct blame_tree {
+	struct string_list paths;
+	struct rev_info rev;
+	struct repository *repository;
+};
+#define BLAME_TREE_INIT { \
+	.paths = STRING_LIST_INIT_DUP, \
+	.rev = REV_INFO_INIT, \
+}
+
+void blame_tree_init(struct repository *r, struct blame_tree *bt,
+		     const struct blame_tree_options *opts);
+
+void blame_tree_release(struct blame_tree *);
+
+typedef void (*blame_tree_fn)(const char *path, const struct commit *commit,
+			      void *data);
+int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *data);
+
+#endif /* BLAME_TREE_H */
diff --git a/builtin.h b/builtin.h
index 993a583872..be3176924d 100644
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
index 0000000000..bc404b63f3
--- /dev/null
+++ b/builtin/blame-tree.c
@@ -0,0 +1,67 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "git-compat-util.h"
+#include "blame-tree.h"
+#include "strvec.h"
+#include "hex.h"
+#include "quote.h"
+#include "config.h"
+#include "environment.h"
+#include "object-name.h"
+#include "parse-options.h"
+#include "builtin.h"
+#include "setup.h"
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
+int cmd_blame_tree(int argc, const char **argv, const char *prefix, struct repository *repo)
+{
+	struct blame_tree bt = BLAME_TREE_INIT;
+	struct blame_tree_options opts = BLAME_TREE_OPTIONS_INIT(
+		.prefix = prefix,
+	);
+
+	struct option options[] = {
+		OPT_BOOL(0, "recursive", &opts.recursive,
+			 "recurse into to subtrees"),
+		OPT_END()
+	};
+
+	const char * const blame_tree_usage[] = {
+		N_("git blame-tree [--no-recursive] [<rev-opts>]"),
+		NULL,
+	};
+
+	git_config(git_default_config, NULL);
+
+	if (repo_get_oid(the_repository, "HEAD", &opts.oid))
+		 die("unable to get HEAD");
+
+	argc = parse_options(argc, argv, prefix, options, blame_tree_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
+	if (argc)
+		strvec_pushv(&opts.args, argv);
+
+	blame_tree_init(repo, &bt, &opts);
+
+	if (blame_tree_run(&bt, show_entry, &bt) < 0)
+		die(_("error running blame-tree traversal"));
+	blame_tree_release(&bt);
+	blame_tree_opts_release(&opts);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 450d6aaa86..42de740378 100644
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
index efe2871c9d..dd231b669b 100644
--- a/meson.build
+++ b/meson.build
@@ -241,6 +241,7 @@ libgit_sources = [
   'attr.c',
   'base85.c',
   'bisect.c',
+  'blame-tree.c',
   'blame.c',
   'blob.c',
   'bloom.c',
@@ -512,6 +513,7 @@ builtin_sources = [
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
index 950d1b7483..6f6485c8b4 100644
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
index 0000000000..5fd2c079fe
--- /dev/null
+++ b/t/t8020-blame-tree.sh
@@ -0,0 +1,142 @@
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
+test_done

-- 
2.49.0.rc2

