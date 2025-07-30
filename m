Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820F2E0B73
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898146; cv=none; b=t2K/4O50ul3w4c0VGSpFND1ErzHy/Im0xQSe7kBK0QmBSxVqj1byxw12ARQ2VRYQ32gqjd8SUOCkvvEyrwW7VADLrxVkr/AByD1bj0mNcBi3Dh2DqZqDwhwlq8YRTm6jpT/orBkRSdtIusfQTCk55+IKofqWVI1quefm9Z26Zqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898146; c=relaxed/simple;
	bh=C+jQmUa7J3JmcAyH/SV7QXoAT/B/XdOrUp0sXlqYtz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5xJdFIl0b3SCgz1knee4NnmO+KHXp+7IzYbvJD61NAfyw8Ez9fopJ17ySvEDCrMiPWH97y44Wx+4KnADqf40nllcq6kYy9F+2F4LnlJyLXsa0OgXTumeeXGN53wXQhjOO60f1dYaiH7kfXE36zIAT4RlYq0ul1sjRtjs3hwvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YxNmp1mf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YxNmp1mf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753898140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IfJyTIqaNJmeuN+6hxOB+28+RJjeBmnrsPfyl0Wdnc=;
	b=YxNmp1mfJroZ+LfCIn0EGF7wju8IRybt8kwm3nX8J8+vFXm3WU9JG4qMJNBAwc4Iuo+Aug
	Xf5o2/7Fn8QjOgNX2IZ9QddqIIhVuVg55AWsiZqERjkFjBS2z6b0iGZ5nAKNl57/y0B2TR
	/v3SceW5JDV1PitNEPYl5SLHjkJxNrc=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v6 1/4] last-modified: new subcommand to show when files were last modified
Date: Wed, 30 Jul 2025 19:55:07 +0200
Message-ID: <20250730175510.987383-2-toon@iotcl.com>
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>
References: <20250716133206.1787549-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similar to git-blame(1), introduce a new subcommand
git-last-modified(1). This command shows the most recent modification to
paths in a tree. It does so by expanding the tree at a given commit,
taking note of the current state of each path, and then walking
backwards through history looking for commits where each path changed
into its final commit ID.

Based-on-patch-by: Jeff King <peff@peff.net>
Improved-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 .gitignore                           |   1 +
 Documentation/git-last-modified.adoc |  49 +++++
 Documentation/meson.build            |   1 +
 Makefile                             |   1 +
 builtin.h                            |   1 +
 builtin/last-modified.c              | 278 +++++++++++++++++++++++++++
 command-list.txt                     |   1 +
 git.c                                |   1 +
 meson.build                          |   1 +
 t/meson.build                        |   1 +
 t/t8020-last-modified.sh             | 203 +++++++++++++++++++
 11 files changed, 538 insertions(+)
 create mode 100644 Documentation/git-last-modified.adoc
 create mode 100644 builtin/last-modified.c
 create mode 100755 t/t8020-last-modified.sh

diff --git a/.gitignore b/.gitignore
index 04c444404e..a36ee94443 100644
--- a/.gitignore
+++ b/.gitignore
@@ -87,6 +87,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-last-modified
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
new file mode 100644
index 0000000000..89138ebeb7
--- /dev/null
+++ b/Documentation/git-last-modified.adoc
@@ -0,0 +1,49 @@
+git-last-modified(1)
+====================
+
+NAME
+----
+git-last-modified - EXPERIMENTAL: Show when files were last modified
+
+
+SYNOPSIS
+--------
+[synopsis]
+git last-modified [-r] [-t] [<revision-range>] [[--] <path>...]
+
+DESCRIPTION
+-----------
+
+Shows which commit last modified each of the relevant files and subdirectories.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+OPTIONS
+-------
+
+-r::
+	Recurse into subtrees.
+
+-t::
+	Show tree entry itself as well as subtrees.  Implies `-r`.
+
+<revision-range>::
+	Only traverse commits in the specified revision range. When no
+	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
+	history leading to the current commit). For a complete list of ways to
+	spell `<revision-range>`, see the 'Specifying Ranges' section of
+	linkgit:gitrevisions[7].
+
+[--] <path>...::
+	For each _<path>_ given, the commit which last modified it is returned.
+	Without an optional path parameter, all files and subdirectories
+	in path traversal the are included in the output.
+
+SEE ALSO
+--------
+linkgit:git-blame[1],
+linkgit:git-log[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 4404c623f0..a8ac5285f0 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -74,6 +74,7 @@ manpages = {
   'git-init.adoc' : 1,
   'git-instaweb.adoc' : 1,
   'git-interpret-trailers.adoc' : 1,
+  'git-last-modified.adoc' : 1,
   'git-log.adoc' : 1,
   'git-ls-files.adoc' : 1,
   'git-ls-remote.adoc' : 1,
diff --git a/Makefile b/Makefile
index 5f7dd79dfa..b5ce55a703 100644
--- a/Makefile
+++ b/Makefile
@@ -1265,6 +1265,7 @@ BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
+BUILTIN_OBJS += builtin/last-modified.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
 BUILTIN_OBJS += builtin/ls-remote.o
diff --git a/builtin.h b/builtin.h
index bff13e3069..6ed6759ec4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -176,6 +176,7 @@ int cmd_hook(int argc, const char **argv, const char *prefix, struct repository
 int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_last_modified(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_log_reflog(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_log(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_ls_files(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
new file mode 100644
index 0000000000..e4c73464c7
--- /dev/null
+++ b/builtin/last-modified.c
@@ -0,0 +1,278 @@
+#include "git-compat-util.h"
+#include "builtin.h"
+#include "commit.h"
+#include "config.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "hashmap.h"
+#include "hex.h"
+#include "log-tree.h"
+#include "object-name.h"
+#include "object.h"
+#include "parse-options.h"
+#include "quote.h"
+#include "repository.h"
+#include "revision.h"
+
+struct last_modified_entry {
+	struct hashmap_entry hashent;
+	struct object_id oid;
+	const char path[FLEX_ARRAY];
+};
+
+static int last_modified_entry_hashcmp(const void *unused UNUSED,
+				       const struct hashmap_entry *hent1,
+				       const struct hashmap_entry *hent2,
+				       const void *path)
+{
+	const struct last_modified_entry *ent1 =
+		container_of(hent1, const struct last_modified_entry, hashent);
+	const struct last_modified_entry *ent2 =
+		container_of(hent2, const struct last_modified_entry, hashent);
+	return strcmp(ent1->path, path ? path : ent2->path);
+}
+
+struct last_modified {
+	struct hashmap paths;
+	struct rev_info rev;
+	int recursive;
+	int tree_in_recursive;
+};
+
+static void last_modified_release(struct last_modified *lm)
+{
+	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
+	release_revisions(&lm->rev);
+}
+
+struct last_modified_callback_data {
+	struct last_modified *lm;
+	struct commit *commit;
+};
+
+static void add_path_from_diff(struct diff_queue_struct *q,
+			       struct diff_options *opt UNUSED, void *data)
+{
+	struct last_modified *lm = data;
+
+	for (int i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct last_modified_entry *ent;
+		const char *path = p->two->path;
+
+		FLEX_ALLOC_STR(ent, path, path);
+		oidcpy(&ent->oid, &p->two->oid);
+		hashmap_entry_init(&ent->hashent, strhash(ent->path));
+		hashmap_add(&lm->paths, &ent->hashent);
+	}
+}
+
+static int populate_paths_from_revs(struct last_modified *lm)
+{
+	int num_interesting = 0;
+	struct diff_options diffopt;
+
+	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
+	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
+	/*
+	 * Use a callback to populate the paths from revs
+	 */
+	diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	diffopt.format_callback = add_path_from_diff;
+	diffopt.format_callback_data = lm;
+
+	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
+		struct object_array_entry *obj = lm->rev.pending.objects + i;
+
+		if (obj->item->flags & UNINTERESTING)
+			continue;
+
+		if (num_interesting++)
+			return error(_("last-modified can only operate on one tree at a time"));
+
+		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
+			      &obj->item->oid, "", &diffopt);
+		diff_flush(&diffopt);
+	}
+	diff_free(&diffopt);
+
+	return 0;
+}
+
+static void last_modified_emit(struct last_modified *lm,
+			       const char *path, const struct commit *commit)
+
+{
+	if (commit->object.flags & BOUNDARY)
+		putchar('^');
+	printf("%s\t", oid_to_hex(&commit->object.oid));
+
+	if (lm->rev.diffopt.line_termination)
+		write_name_quoted(path, stdout, '\n');
+	else
+		printf("%s%c", path, '\0');
+
+	fflush(stdout);
+}
+
+static void mark_path(const char *path, const struct object_id *oid,
+		      struct last_modified_callback_data *data)
+{
+	struct last_modified_entry *ent;
+
+	/* Is it even a path that we are interested in? */
+	ent = hashmap_get_entry_from_hash(&data->lm->paths, strhash(path), path,
+					  struct last_modified_entry, hashent);
+	if (!ent)
+		return;
+
+	/*
+	 * Is it arriving at a version of interest, or is it from a side branch
+	 * which did not contribute to the final state?
+	 */
+	if (!oideq(oid, &ent->oid))
+		return;
+
+	last_modified_emit(data->lm, path, data->commit);
+
+	hashmap_remove(&data->lm->paths, &ent->hashent, path);
+	free(ent);
+}
+
+static void last_modified_diff(struct diff_queue_struct *q,
+			       struct diff_options *opt UNUSED, void *cbdata)
+{
+	struct last_modified_callback_data *data = cbdata;
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
+			 * a final oid state. Note that this covers some
+			 * potentially controversial areas, including:
+			 *
+			 *  1. A rename or copy will be found, as it is the
+			 *     first time the content has arrived at the given
+			 *     path.
+			 *
+			 *  2. Even a non-content modification like a mode or
+			 *     type change will trigger it.
+			 *
+			 * We take the inclusive approach for now, and find
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
+static int last_modified_run(struct last_modified *lm)
+{
+	struct last_modified_callback_data data = { .lm = lm };
+
+	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	lm->rev.diffopt.format_callback = last_modified_diff;
+	lm->rev.diffopt.format_callback_data = &data;
+
+	prepare_revision_walk(&lm->rev);
+
+	while (hashmap_get_size(&lm->paths)) {
+		data.commit = get_revision(&lm->rev);
+		if (!data.commit)
+			break;
+
+		if (data.commit->object.flags & BOUNDARY) {
+			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
+				      &data.commit->object.oid, "",
+				      &lm->rev.diffopt);
+			diff_flush(&lm->rev.diffopt);
+		} else {
+			log_tree_commit(&lm->rev, data.commit);
+		}
+	}
+
+	return 0;
+}
+
+static int last_modified_init(struct last_modified *lm, struct repository *r,
+			      const char *prefix, int argc, const char **argv)
+{
+	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
+
+	repo_init_revisions(r, &lm->rev, prefix);
+	lm->rev.def = "HEAD";
+	lm->rev.combine_merges = 1;
+	lm->rev.show_root_diff = 1;
+	lm->rev.boundary = 1;
+	lm->rev.no_commit_id = 1;
+	lm->rev.diff = 1;
+	lm->rev.diffopt.flags.recursive = lm->recursive || lm->tree_in_recursive;
+	lm->rev.diffopt.flags.tree_in_recursive = lm->tree_in_recursive;
+
+	if ((argc = setup_revisions(argc, argv, &lm->rev, NULL)) > 1) {
+		error(_("unknown last-modified argument: %s"), argv[1]);
+		return argc;
+	}
+
+	if (populate_paths_from_revs(lm) < 0)
+		return error(_("unable to setup last-modified"));
+
+	return 0;
+}
+
+int cmd_last_modified(int argc, const char **argv, const char *prefix,
+		      struct repository *repo)
+{
+	int ret;
+	struct last_modified lm;
+
+	const char * const last_modified_usage[] = {
+		N_("git last-modified [-r] [-t] "
+		   "[<revision-range>] [[--] <path>...]"),
+		NULL
+	};
+
+	struct option last_modified_options[] = {
+		OPT_BOOL('r', "recursive", &lm.recursive,
+			 N_("recurse into subtrees")),
+		OPT_BOOL('t', "tree-in-recursive", &lm.tree_in_recursive,
+			 N_("recurse into subtrees and include the tree entries too")),
+		OPT_END()
+	};
+
+	memset(&lm, 0, sizeof(lm));
+
+	argc = parse_options(argc, argv, prefix, last_modified_options,
+			     last_modified_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+	repo_config(repo, git_default_config, NULL);
+
+	if ((ret = last_modified_init(&lm, repo, prefix, argc, argv))) {
+		if (ret > 0)
+			usage_with_options(last_modified_usage,
+					   last_modified_options);
+		goto out;
+	}
+
+	if ((ret = last_modified_run(&lm)))
+		goto out;
+
+out:
+	last_modified_release(&lm);
+
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index b7ade3ab9f..b715777b24 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -124,6 +124,7 @@ git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain           init
 git-instaweb                            ancillaryinterrogators          complete
 git-interpret-trailers                  purehelpers
+git-last-modified                       plumbinginterrogators
 git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
diff --git a/git.c b/git.c
index 07a5fe39fb..76a0b2a1a4 100644
--- a/git.c
+++ b/git.c
@@ -565,6 +565,7 @@ static struct cmd_struct commands[] = {
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
+	{ "last-modified", cmd_last_modified, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
diff --git a/meson.build b/meson.build
index 9bc1826cb6..77a3416b1c 100644
--- a/meson.build
+++ b/meson.build
@@ -607,6 +607,7 @@ builtin_sources = [
   'builtin/index-pack.c',
   'builtin/init-db.c',
   'builtin/interpret-trailers.c',
+  'builtin/last-modified.c',
   'builtin/log.c',
   'builtin/ls-files.c',
   'builtin/ls-remote.c',
diff --git a/t/meson.build b/t/meson.build
index 660d780dcc..904455e3ab 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -961,6 +961,7 @@ integration_tests = [
   't8012-blame-colors.sh',
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
+  't8020-last-modified.sh',
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
new file mode 100755
index 0000000000..05c113a1f8
--- /dev/null
+++ b/t/t8020-last-modified.sh
@@ -0,0 +1,203 @@
+#!/bin/sh
+
+test_description='last-modified tests'
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
+test_expect_success 'cannot run last-modified on two trees' '
+	test_must_fail git last-modified HEAD HEAD~1
+'
+
+check_last_modified() {
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
+	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
+	git name-rev --annotate-stdin --name-only --tags \
+		<tmp.1 >tmp.2 &&
+	tr '\t' ' ' <tmp.2 >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'last-modified non-recursive' '
+	check_last_modified <<-\EOF
+	3 a
+	1 file
+	EOF
+'
+
+test_expect_success 'last-modified recursive' '
+	check_last_modified -r <<-\EOF
+	3 a/b/file
+	2 a/file
+	1 file
+	EOF
+'
+
+test_expect_success 'last-modified recursive with tree' '
+	check_last_modified -t <<-\EOF
+	3 a
+	3 a/b
+	3 a/b/file
+	2 a/file
+	1 file
+	EOF
+'
+
+test_expect_success 'last-modified subdir' '
+	check_last_modified a <<-\EOF
+	3 a
+	EOF
+'
+
+test_expect_success 'last-modified subdir recursive' '
+	check_last_modified -r a <<-\EOF
+	3 a/b/file
+	2 a/file
+	EOF
+'
+
+test_expect_success 'last-modified from non-HEAD commit' '
+	check_last_modified HEAD^ <<-\EOF
+	2 a
+	1 file
+	EOF
+'
+
+test_expect_success 'last-modified from subdir defaults to root' '
+	check_last_modified -C a <<-\EOF
+	3 a
+	1 file
+	EOF
+'
+
+test_expect_success 'last-modified from subdir uses relative pathspecs' '
+	check_last_modified -C a -r b <<-\EOF
+	3 a/b/file
+	EOF
+'
+
+test_expect_success 'limit last-modified traversal by count' '
+	check_last_modified -1 <<-\EOF
+	3 a
+	^2 file
+	EOF
+'
+
+test_expect_success 'limit last-modified traversal by commit' '
+	check_last_modified HEAD~2..HEAD <<-\EOF
+	3 a
+	^1 file
+	EOF
+'
+
+test_expect_success 'only last-modified files in the current tree' '
+	git rm -rf a &&
+	git commit -m "remove a" &&
+	check_last_modified <<-\EOF
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
+	check_last_modified <<-\EOF
+	m2 m2.t
+	m1 m1.t
+	EOF
+'
+
+test_expect_success 'last-modified merge for resolved conflicts' '
+	git checkout HEAD^0 &&
+	git rm -rf . &&
+	test_commit c1 conflict &&
+	git checkout HEAD^ &&
+	git rm -rf . &&
+	test_commit c2 conflict &&
+	test_must_fail git merge c1 &&
+	test_commit resolved conflict &&
+	check_last_modified conflict <<-\EOF
+	resolved conflict
+	EOF
+'
+
+
+# Consider `file` with this content through history:
+#
+# A---B---B-------B---B
+#          \     /
+#           C---D
+test_expect_success 'last-modified merge ignores content from branch' '
+	git checkout HEAD^0 &&
+	git rm -rf . &&
+	test_commit a1 file A &&
+	test_commit a2 file B &&
+	test_commit a3 file C &&
+	test_commit a4 file D &&
+	git checkout a2 &&
+	git merge --no-commit --no-ff a4 &&
+	git checkout a2 -- file &&
+	git merge --continue &&
+	check_last_modified <<-\EOF
+	a2 file
+	EOF
+'
+
+# Consider `file` with this content through history:
+#
+#  A---B---B---C---D---B---B
+#           \         /
+#            B-------B
+test_expect_success 'last-modified merge undoes changes' '
+	git checkout HEAD^0 &&
+	git rm -rf . &&
+	test_commit b1 file A &&
+	test_commit b2 file B &&
+	test_commit b3 file C &&
+	test_commit b4 file D &&
+	git checkout b2 &&
+	test_commit b5 file2 2 &&
+	git checkout b4 &&
+	git merge --no-commit --no-ff b5 &&
+	git checkout b2 -- file &&
+	git merge --continue &&
+	check_last_modified <<-\EOF
+	b5 file2
+	b2 file
+	EOF
+'
+
+test_expect_success 'last-modified complains about unknown arguments' '
+	test_must_fail git last-modified --foo 2>err &&
+	grep "unknown last-modified argument: --foo" err
+'
+
+test_done
-- 
2.50.1.327.g047016eb4a

