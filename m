Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC3288C22
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074808; cv=none; b=PRJgUZJKDWgXIaIKz+99YmzNiTe0+iWMTFpG7V4G1GMbBBor/5wI7v6Hh9F/tz8LaSw4VIN58vMY6pmBo7iNEnjDe35OKU4iZyxQ9x3wjhC8oTw5eHkV39/rrP864biqFvo57g3VeAtS2kzlEfGSGCoM6HrVqaijOtoCljvP+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074808; c=relaxed/simple;
	bh=zkGRCoJvkWYvk19Nu501QG7/wJx+gIC6N3CpyTis7lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rd2ZKuEMltkr8ZbQw+fNSVwQ2wUy0D3YSFvDaZ2LGL9B5eBGhR0M2adwZsTiwe+KwQV61v0tPn9SyR9iYZi+eqU65e8Mf3MLuRDBVvJhZhl8ELDH9Wcs4ccnKWCkabyFWzIsspVbju4JCFdHP7ADbt2qk9S0G+erT4UU20xXPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=jP/UXyZ/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="jP/UXyZ/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752074800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UGEDzwuF/pXuMV1sIWSOzQsZwqaaDjnit3GOSx5zcY=;
	b=jP/UXyZ/iZ3bdSlIdkX6H2CrQiBEzvKB1Kba62VEv5op4kQNtLSyG4KEEZneL2k7ZRuJx3
	DsI4Ca0aNELKGpcp0IESEl2dYDZ0Jsokq0oGSwc9eyWlw1gq+xVbaPZTUQo6PucCdPps2I
	ltCHz046qxTt8uSjaJNAOzU5ftr0RNo=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"Derrick Stolee" <stolee@gmail.com>,
	"Taylor Blau" <me@ttaylorr.com>
Subject: [PATCH v4 0/3] Introduce git-last-modified(1) command
Date: Wed,  9 Jul 2025 17:26:25 +0200
Message-ID: <20250709152628.1644521-1-toon@iotcl.com>
In-Reply-To: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds the git-last-modified(1) subcommand. In the past the
subcommand was proposed[1] to be named git-blame-tree(1). This version
is based on the patches shared by the kind people at GitHub[2].

What is different from the series shared by GitHub:

* Renamed the subcommand from `blame-tree` to `last-modified`. There was
  some consensus[5] this name works better, so let's give it a try and
  see how this name feels.

* Patches for --max-depth are excluded. I think it's a separate topic to
  discuss and I'm not sure it needs to be part of series anyway. The
  main patch was submitted in the previous attempt[3] and if people
  consider it valuable, I'm happy to discuss that in a separate patch
  series.

* The patches in 'tb/blame-tree' at Taylor's fork[4] implements a
  caching layer. This feature reads/writes cached results in
  `.git/blame-tree/<hash>.btc`. To keep this series to a reviewable
  size, that feature is excluded from this series. I think it's better
  to submit this as a separate series.

* Squashed various commits together. Like they introduced a flag
  `--go-faster`, which later became the default and only implementation.
  That story was wrapped up in a single commit.

* Dropped the patches that attempt to increase performance for tree
  entries that have not been updated in a long time. In my testing I've
  seen both performance improvements *and* degradation with these
  changes:

  Test                                        HEAD~             HEAD
  ------------------------------------------------------------------------------------
  8020.1: top-level last-modified             4.52(4.38+0.11)   2.03(1.93+0.08) -55.1%
  8020.2: top-level recursive last-modified   5.79(5.64+0.11)   8.34(8.17+0.11) +44.0%
  8020.3: subdir last-modified                0.15(0.09+0.06)   0.19(0.14+0.06) +26.7%

  Before we include these patches, I want to make sure these changes
  have positive impact in all/most scenarios. This can happen in a
  separate series.

* The last-modified command isn't recursive by default. If you want
  recurse into subtrees, you need to pass `-r`.

* Fixed all memory leaks, and removed the use of
  USE_THE_REPOSITORY_VARIABLE.

I've set myself as the author and added Based-on-patch-by trailers to
credit the original authors. Let me know if you disagree.

Again thanks to Taylor and the people at GitHub for sharing these
patches. I hope we can work together to get this upstreamed.

[1]: https://lore.kernel.org/git/patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com/
[2]: https://lore.kernel.org/git/Z+XJ+1L3PnC9Dyba@nand.local/
[3]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-3-4173133f3786@iotcl.com/
[4]: git@github.com:ttaylorr/git.git
[5]: https://lore.kernel.org/git/aCbBKj7O9LjO3SMK@pks.im/

--
Cheers,
Toon

Signed-off-by: Toon Claes <toon@iotcl.com>
---
Changes in v4:
- Removed root-level `last-modified.[ch]` library code and moved code to
  `builtin/last-modified.c`. Historically we've had libary code (also because it
  was used in testtool), but we no longer need that separation. I'm sorry this
  makes the range-diff hard to read.
- Added the use of parse_options() to get better usage messages.
- Formatting fixes after conversation in
  https://lore.kernel.org/git/xmqqh5zvk5h0.fsf@gitster.g/
- Link to v3: https://lore.kernel.org/git/20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com/

Changes in v3:
- Updated benchmarks in commit messages.
- Removed the patches that attempt to increase performance for tree
  entries that have not been updated in a long time. (see above)
- Move handling failure in `last_modified_init()` to the caller.
- Sorted #include clauses lexicographically.
- Removed unneeded `commit` in `struct last_modified_entry`.
- Renamed some functions/variables and added some comments to make it
  easier to understand.
- Removed unnecessary checking of the commit-graph generation number.
- Link to v2: https://lore.kernel.org/r/20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com

Changes in v2:
- The subcommand is renamed from `blame-tree` to `last-modified`
- Documentation is added. Here we mark the command as experimental.
- Some test cases are added related to merges.
- Link to v1: https://lore.kernel.org/r/20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com

Toon Claes (3):
  last-modified: new subcommand to show when files were last modified
  t/perf: add last-modified perf script
  last-modified: use Bloom filters when available

 .gitignore                           |   1 +
 Documentation/git-last-modified.adoc |  49 ++++
 Documentation/meson.build            |   1 +
 Makefile                             |   1 +
 builtin.h                            |   1 +
 builtin/last-modified.c              | 334 +++++++++++++++++++++++++++
 command-list.txt                     |   1 +
 git.c                                |   1 +
 meson.build                          |   1 +
 t/meson.build                        |   2 +
 t/perf/p8020-last-modified.sh        |  21 ++
 t/t8020-last-modified.sh             | 204 ++++++++++++++++
 12 files changed, 617 insertions(+)
 create mode 100644 Documentation/git-last-modified.adoc
 create mode 100644 builtin/last-modified.c
 create mode 100755 t/perf/p8020-last-modified.sh
 create mode 100755 t/t8020-last-modified.sh

Range-diff against v3:
1:  26a2d9b5e0 ! 1:  0cc625f3f5 last-modified: new subcommand to show when files were last modified
    @@ Documentation/git-last-modified.adoc (new)
     +SYNOPSIS
     +--------
     +[synopsis]
    -+git last-modified [-r] [<revision-range>] [[--] <path>...]
    ++git last-modified [-r] [-t] [<revision-range>] [[--] <path>...]
     +
     +DESCRIPTION
     +-----------
    @@ Documentation/git-last-modified.adoc (new)
     +[--] <path>...::
     +	For each _<path>_ given, the commit which last modified it is returned.
     +	Without an optional path parameter, all files and subdirectories
    -+	of the current working directory are included in the
    ++	in path traversal the are included in the output.
     +
     +SEE ALSO
     +--------
    @@ Documentation/meson.build: manpages = {
        'git-ls-remote.adoc' : 1,

      ## Makefile ##
    -@@ Makefile: LIB_OBJS += hook.o
    - LIB_OBJS += ident.o
    - LIB_OBJS += json-writer.o
    - LIB_OBJS += kwset.o
    -+LIB_OBJS += last-modified.o
    - LIB_OBJS += levenshtein.o
    - LIB_OBJS += line-log.o
    - LIB_OBJS += line-range.o
     @@ Makefile: BUILTIN_OBJS += builtin/hook.o
      BUILTIN_OBJS += builtin/index-pack.o
      BUILTIN_OBJS += builtin/init-db.o
    @@ builtin.h: int cmd_hook(int argc, const char **argv, const char *prefix, struct
      ## builtin/last-modified.c (new) ##
     @@
     +#include "git-compat-util.h"
    -+#include "last-modified.h"
    -+#include "hex.h"
    -+#include "quote.h"
    -+#include "config.h"
    -+#include "object-name.h"
    -+#include "parse-options.h"
     +#include "builtin.h"
    -+
    -+static void show_entry(const char *path, const struct commit *commit, void *d)
    -+{
    -+	struct last_modified *lm = d;
    -+
    -+	if (commit->object.flags & BOUNDARY)
    -+		putchar('^');
    -+	printf("%s\t", oid_to_hex(&commit->object.oid));
    -+
    -+	if (lm->rev.diffopt.line_termination)
    -+		write_name_quoted(path, stdout, '\n');
    -+	else
    -+		printf("%s%c", path, '\0');
    -+
    -+	fflush(stdout);
    -+}
    -+
    -+int cmd_last_modified(int argc,
    -+		   const char **argv,
    -+		   const char *prefix,
    -+		   struct repository *repo)
    -+{
    -+	struct last_modified lm;
    -+
    -+	repo_config(repo, git_default_config, NULL);
    -+
    -+	if (last_modified_init(&lm, repo, prefix, argc, argv))
    -+		die(_("error setting up last-modified traversal"));
    -+
    -+	if (last_modified_run(&lm, show_entry, &lm) < 0)
    -+		die(_("error running last-modified traversal"));
    -+
    -+	last_modified_release(&lm);
    -+
    -+	return 0;
    -+}
    -
    - ## command-list.txt ##
    -@@ command-list.txt: git-index-pack                          plumbingmanipulators
    - git-init                                mainporcelain           init
    - git-instaweb                            ancillaryinterrogators          complete
    - git-interpret-trailers                  purehelpers
    -+git-last-modified                       plumbinginterrogators
    - git-log                                 mainporcelain           info
    - git-ls-files                            plumbinginterrogators
    - git-ls-remote                           plumbinginterrogators
    -
    - ## git.c ##
    -@@ git.c: static struct cmd_struct commands[] = {
    - 	{ "init", cmd_init_db },
    - 	{ "init-db", cmd_init_db },
    - 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
    -+	{ "last-modified", cmd_last_modified, RUN_SETUP },
    - 	{ "log", cmd_log, RUN_SETUP },
    - 	{ "ls-files", cmd_ls_files, RUN_SETUP },
    - 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
    -
    - ## last-modified.c (new) ##
    -@@
    -+#include "git-compat-util.h"
     +#include "commit.h"
    ++#include "config.h"
     +#include "diff.h"
     +#include "diffcore.h"
    -+#include "last-modified.h"
    ++#include "hashmap.h"
    ++#include "hex.h"
     +#include "log-tree.h"
    ++#include "object-name.h"
     +#include "object.h"
    ++#include "parse-options.h"
    ++#include "quote.h"
     +#include "repository.h"
     +#include "revision.h"
     +
    @@ last-modified.c (new)
     +	const char path[FLEX_ARRAY];
     +};
     +
    ++static int last_modified_entry_hashcmp(const void *unused UNUSED,
    ++				       const struct hashmap_entry *hent1,
    ++				       const struct hashmap_entry *hent2,
    ++				       const void *path)
    ++{
    ++	const struct last_modified_entry *ent1 =
    ++		container_of(hent1, const struct last_modified_entry, hashent);
    ++	const struct last_modified_entry *ent2 =
    ++		container_of(hent2, const struct last_modified_entry, hashent);
    ++	return strcmp(ent1->path, path ? path : ent2->path);
    ++}
    ++
    ++struct last_modified {
    ++	struct hashmap paths;
    ++	struct rev_info rev;
    ++	int recursive, tree_in_recursive;
    ++};
    ++
    ++static void last_modified_release(struct last_modified *lm)
    ++{
    ++	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
    ++	release_revisions(&lm->rev);
    ++}
    ++
    ++typedef void (*last_modified_callback)(const char *path,
    ++				       const struct commit *commit, void *data);
    ++
    ++struct last_modified_callback_data {
    ++	struct commit *commit;
    ++	struct hashmap *paths;
    ++
    ++	last_modified_callback callback;
    ++	void *callback_data;
    ++};
    ++
     +static void add_path_from_diff(struct diff_queue_struct *q,
    -+			       struct diff_options *opt UNUSED,
    -+			       void *data)
    ++			       struct diff_options *opt UNUSED, void *data)
     +{
     +	struct last_modified *lm = data;
     +
    @@ last-modified.c (new)
     +	return 0;
     +}
     +
    -+static int last_modified_entry_hashcmp(const void *unused UNUSED,
    -+				    const struct hashmap_entry *hent1,
    -+				    const struct hashmap_entry *hent2,
    -+				    const void *path)
    -+{
    -+	const struct last_modified_entry *ent1 =
    -+		container_of(hent1, const struct last_modified_entry, hashent);
    -+	const struct last_modified_entry *ent2 =
    -+		container_of(hent2, const struct last_modified_entry, hashent);
    -+	return strcmp(ent1->path, path ? path : ent2->path);
    -+}
    -+
    -+int last_modified_init(struct last_modified *lm,
    -+		     struct repository *r,
    -+		     const char *prefix,
    -+		     int argc, const char **argv)
    -+{
    -+	memset(lm, 0, sizeof(*lm));
    -+	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
    -+
    -+	repo_init_revisions(r, &lm->rev, prefix);
    -+	lm->rev.def = "HEAD";
    -+	lm->rev.combine_merges = 1;
    -+	lm->rev.show_root_diff = 1;
    -+	lm->rev.boundary = 1;
    -+	lm->rev.no_commit_id = 1;
    -+	lm->rev.diff = 1;
    -+	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
    -+		return error(_("unknown last-modified argument: %s"), argv[1]);
    -+
    -+	if (populate_paths_from_revs(lm) < 0)
    -+		return error(_("unable to setup last-modified"));
    -+
    -+	return 0;
    -+}
    -+
    -+void last_modified_release(struct last_modified *lm)
    -+{
    -+	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
    -+	release_revisions(&lm->rev);
    -+}
    -+
    -+struct last_modified_callback_data {
    -+	struct commit *commit;
    -+	struct hashmap *paths;
    -+
    -+	last_modified_callback callback;
    -+	void *callback_data;
    -+};
    -+
     +static void mark_path(const char *path, const struct object_id *oid,
     +		      struct last_modified_callback_data *data)
     +{
    @@ last-modified.c (new)
     +		default:
     +			/*
     +			 * Otherwise, we care only that we somehow arrived at
    -+			 * a final path/sha1 state. Note that this covers some
    ++			 * a final oid state. Note that this covers some
     +			 * potentially controversial areas, including:
     +			 *
     +			 *  1. A rename or copy will be found, as it is the
    @@ last-modified.c (new)
     +	}
     +}
     +
    -+int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
    ++static int last_modified_run(struct last_modified *lm,
    ++			     last_modified_callback cb, void *cbdata)
     +{
     +	struct last_modified_callback_data data;
     +
    @@ last-modified.c (new)
     +
     +		if (data.commit->object.flags & BOUNDARY) {
     +			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
    -+				       &data.commit->object.oid,
    -+				       "", &lm->rev.diffopt);
    ++				      &data.commit->object.oid, "",
    ++				      &lm->rev.diffopt);
     +			diff_flush(&lm->rev.diffopt);
     +		} else {
     +			log_tree_commit(&lm->rev, data.commit);
    @@ last-modified.c (new)
     +	}
     +
     +	return 0;
    ++}
    ++
    ++static void show_entry(const char *path, const struct commit *commit, void *d)
    ++{
    ++	struct last_modified *lm = d;
    ++
    ++	if (commit->object.flags & BOUNDARY)
    ++		putchar('^');
    ++	printf("%s\t", oid_to_hex(&commit->object.oid));
    ++
    ++	if (lm->rev.diffopt.line_termination)
    ++		write_name_quoted(path, stdout, '\n');
    ++	else
    ++		printf("%s%c", path, '\0');
    ++
    ++	fflush(stdout);
    ++}
    ++
    ++static int last_modified_init(struct last_modified *lm, struct repository *r,
    ++			      const char *prefix, int argc, const char **argv)
    ++{
    ++	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
    ++
    ++	repo_init_revisions(r, &lm->rev, prefix);
    ++	lm->rev.def = "HEAD";
    ++	lm->rev.combine_merges = 1;
    ++	lm->rev.show_root_diff = 1;
    ++	lm->rev.boundary = 1;
    ++	lm->rev.no_commit_id = 1;
    ++	lm->rev.diff = 1;
    ++	lm->rev.diffopt.flags.recursive = lm->recursive || lm->tree_in_recursive;
    ++	lm->rev.diffopt.flags.tree_in_recursive = lm->tree_in_recursive;
    ++
    ++	if ((argc = setup_revisions(argc, argv, &lm->rev, NULL)) > 1) {
    ++		error(_("unknown last-modified argument: %s"), argv[1]);
    ++		return argc;
    ++	}
    ++
    ++	if (populate_paths_from_revs(lm) < 0)
    ++		return error(_("unable to setup last-modified"));
    ++
    ++	return 0;
    ++}
    ++
    ++int cmd_last_modified(int argc, const char **argv, const char *prefix,
    ++		      struct repository *repo)
    ++{
    ++	int ret;
    ++	struct last_modified lm;
    ++
    ++	const char * const last_modified_usage[] = {
    ++		N_("git last-modified [-r] [-t] "
    ++		   "[<revision-range>] [[--] <path>...]"),
    ++		NULL
    ++	};
    ++
    ++	struct option last_modified_options[] = {
    ++		OPT_BOOL('r', "recursive", &lm.recursive,
    ++			 N_("recurse into subtrees")),
    ++		OPT_BOOL('t', "tree-in-recursive", &lm.tree_in_recursive,
    ++			 N_("recurse into subtrees and include the tree entries too")),
    ++		OPT_END()
    ++	};
    ++
    ++	memset(&lm, 0, sizeof(lm));
    ++
    ++	argc = parse_options(argc, argv, prefix, last_modified_options,
    ++			     last_modified_usage,
    ++			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
    ++
    ++	repo_config(repo, git_default_config, NULL);
    ++
    ++	if ((ret = last_modified_init(&lm, repo, prefix, argc, argv))) {
    ++		if (ret > 0)
    ++			usage_with_options(last_modified_usage,
    ++					   last_modified_options);
    ++		goto out;
    ++	}
    ++
    ++	if ((ret = last_modified_run(&lm, show_entry, &lm)))
    ++		goto out;
    ++
    ++out:
    ++	last_modified_release(&lm);
    ++
    ++	return ret;
     +}

    - ## last-modified.h (new) ##
    -@@
    -+#ifndef LAST_MODIFIED_H
    -+#define LAST_MODIFIED_H
    -+
    -+#include "commit.h"
    -+#include "hashmap.h"
    -+#include "revision.h"
    -+
    -+struct last_modified {
    -+	struct hashmap paths;
    -+	struct rev_info rev;
    -+};
    -+
    -+/*
    -+ * Initialize the last-modified machinery using command line arguments.
    -+ */
    -+int last_modified_init(struct last_modified *lm,
    -+		     struct repository *r,
    -+		     const char *prefix,
    -+		     int argc, const char **argv);
    -+
    -+void last_modified_release(struct last_modified *);
    -+
    -+typedef void (*last_modified_callback)(const char *path,
    -+				    const struct commit *commit,
    -+				    void *data);
    -+
    -+/*
    -+ * Run the last-modified traversal. For each path found the callback is called
    -+ * passing the path, the commit, and the cbdata.
    -+ */
    -+int last_modified_run(struct last_modified *lm,
    -+		   last_modified_callback cb,
    -+		   void *cbdata);
    -+
    -+#endif /* LAST_MODIFIED_H */
    + ## command-list.txt ##
    +@@ command-list.txt: git-index-pack                          plumbingmanipulators
    + git-init                                mainporcelain           init
    + git-instaweb                            ancillaryinterrogators          complete
    + git-interpret-trailers                  purehelpers
    ++git-last-modified                       plumbinginterrogators
    + git-log                                 mainporcelain           info
    + git-ls-files                            plumbinginterrogators
    + git-ls-remote                           plumbinginterrogators
    +
    + ## git.c ##
    +@@ git.c: static struct cmd_struct commands[] = {
    + 	{ "init", cmd_init_db },
    + 	{ "init-db", cmd_init_db },
    + 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
    ++	{ "last-modified", cmd_last_modified, RUN_SETUP },
    + 	{ "log", cmd_log, RUN_SETUP },
    + 	{ "ls-files", cmd_ls_files, RUN_SETUP },
    + 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },

      ## meson.build ##
    -@@ meson.build: libgit_sources = [
    -   'ident.c',
    -   'json-writer.c',
    -   'kwset.c',
    -+  'last-modified.c',
    -   'levenshtein.c',
    -   'line-log.c',
    -   'line-range.c',
     @@ meson.build: builtin_sources = [
        'builtin/index-pack.c',
        'builtin/init-db.c',
2:  0691884735 = 2:  a017f2c81c t/perf: add last-modified perf script
3:  393f304a3f ! 3:  c739a7dbcc last-modified: use Bloom filters when available
    @@ Commit message

         Comparing the perf test results on git.git:

    -    Test                                        HEAD~             HEAD
    -    ------------------------------------------------------------------------------------
    -    8020.1: top-level last-modified             4.49(4.34+0.11)   2.22(2.05+0.09) -50.6%
    -    8020.2: top-level recursive last-modified   5.64(5.45+0.11)   5.62(5.30+0.11) -0.4%
    -    8020.3: subdir last-modified                0.11(0.06+0.04)   0.07(0.03+0.04) -36.4%
    +        Test                                        HEAD~             HEAD
    +        ------------------------------------------------------------------------------------
    +        8020.1: top-level last-modified             4.49(4.34+0.11)   2.22(2.05+0.09) -50.6%
    +        8020.2: top-level recursive last-modified   5.64(5.45+0.11)   5.62(5.30+0.11) -0.4%
    +        8020.3: subdir last-modified                0.11(0.06+0.04)   0.07(0.03+0.04) -36.4%

         Based-on-patch-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Toon Claes <toon@iotcl.com>

    - ## last-modified.c ##
    + ## builtin/last-modified.c ##
     @@
      #include "git-compat-util.h"
     +#include "bloom.h"
    + #include "builtin.h"
     +#include "commit-graph.h"
      #include "commit.h"
    + #include "config.h"
      #include "diff.h"
    - #include "diffcore.h"
    -+#include "dir.h"
    - #include "last-modified.h"
    - #include "log-tree.h"
    - #include "object.h"
     @@
      struct last_modified_entry {
      	struct hashmap_entry hashent;
    @@ last-modified.c
      	const char path[FLEX_ARRAY];
      };

    -@@ last-modified.c: static void add_path_from_diff(struct diff_queue_struct *q,
    +@@ builtin/last-modified.c: struct last_modified {

    - 		FLEX_ALLOC_STR(ent, path, path);
    - 		oidcpy(&ent->oid, &p->two->oid);
    -+		if (lm->rev.bloom_filter_settings)
    -+			fill_bloom_key(path, strlen(path), &ent->key,
    -+				       lm->rev.bloom_filter_settings);
    - 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
    - 		hashmap_add(&lm->paths, &ent->hashent);
    - 	}
    -@@ last-modified.c: int last_modified_init(struct last_modified *lm,
    - 	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
    - 		return error(_("unknown last-modified argument: %s"), argv[1]);
    -
    -+	/*
    -+	 * We're not interested in generation numbers here,
    -+	 * but calling this function to prepare the commit-graph.
    -+	 */
    -+	(void)generation_numbers_enabled(lm->rev.repo);
    -+	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
    -+
    - 	if (populate_paths_from_revs(lm) < 0)
    - 		return error(_("unable to setup last-modified"));
    -
    -@@ last-modified.c: int last_modified_init(struct last_modified *lm,
    -
    - void last_modified_release(struct last_modified *lm)
    + static void last_modified_release(struct last_modified *lm)
      {
     +	struct hashmap_iter iter;
     +	struct last_modified_entry *ent;
    @@ last-modified.c: int last_modified_init(struct last_modified *lm,
      	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
      	release_revisions(&lm->rev);
      }
    -@@ last-modified.c: static void mark_path(const char *path, const struct object_id *oid,
    +@@ builtin/last-modified.c: static void add_path_from_diff(struct diff_queue_struct *q,
    +
    + 		FLEX_ALLOC_STR(ent, path, path);
    + 		oidcpy(&ent->oid, &p->two->oid);
    ++		if (lm->rev.bloom_filter_settings)
    ++			fill_bloom_key(path, strlen(path), &ent->key,
    ++				       lm->rev.bloom_filter_settings);
    + 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
    + 		hashmap_add(&lm->paths, &ent->hashent);
    + 	}
    +@@ builtin/last-modified.c: static void mark_path(const char *path, const struct object_id *oid,
      		data->callback(path, data->commit, data->callback_data);

      	hashmap_remove(data->paths, &ent->hashent, path);
    @@ last-modified.c: static void mark_path(const char *path, const struct object_id
      	free(ent);
      }

    -@@ last-modified.c: static void last_modified_diff(struct diff_queue_struct *q,
    +@@ builtin/last-modified.c: static void last_modified_diff(struct diff_queue_struct *q,
      	}
      }

    ++
     +static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
     +{
     +	struct bloom_filter *filter;
    @@ last-modified.c: static void last_modified_diff(struct diff_queue_struct *q,
     +	return 0;
     +}
     +
    - int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
    + static int last_modified_run(struct last_modified *lm,
    + 			     last_modified_callback cb, void *cbdata)
      {
    - 	struct last_modified_callback_data data;
    -@@ last-modified.c: int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
    +@@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm,
      		if (!data.commit)
      			break;

    @@ last-modified.c: int last_modified_run(struct last_modified *lm, last_modified_c
     +
      		if (data.commit->object.flags & BOUNDARY) {
      			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
    - 				       &data.commit->object.oid,
    + 				      &data.commit->object.oid, "",
    +@@ builtin/last-modified.c: static int last_modified_init(struct last_modified *lm, struct repository *r,
    + 		return argc;
    + 	}
    +
    ++	/*
    ++	 * We're not interested in generation numbers here,
    ++	 * but calling this function to prepare the commit-graph.
    ++	 */
    ++	(void)generation_numbers_enabled(lm->rev.repo);
    ++	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
    ++
    + 	if (populate_paths_from_revs(lm) < 0)
    + 		return error(_("unable to setup last-modified"));
    +

base-commit: 41905d60226a0346b22f0d0d99428c746a5a3b14
--
2.50.0.rc0.18.gfcfe60668e
