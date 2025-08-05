Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D91DD0EF
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386468; cv=none; b=h+4bVaU2fqqxTCoScYuCyR/oVO0fc+PkzRRJAhpj9ruTcEgqWlzXkffLZdK+zFPsSW2XqTEw+egpY8PBgaYe31j58U5nJlugkh3QG/YHVvvoYJsd7UF32uAKJMUzlOfrOwjetzhM8vNjOssq1b7s80oYigy6e3Ec7M1bAC8/x/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386468; c=relaxed/simple;
	bh=CBqHZZi+LllZPvHtzX+jMYANX7WpL8pHyZSEj5hAGlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4NCLesxz2K4dgVGqjAQKBMvRm2EyEeMpUEcPIhg6GH9pjn4FE+6Pc/05fZ74NtEt7BJda2OrL4mhOQawX6eiQEHzIucaeX1Qr8uA5pywgpTUVggK3iiNjw1xnoLzE+bA57Mi9SIz5m/oPVmFCbK1hdngz6xAiZ6G3HPE74kyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=xvldb43H; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="xvldb43H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754386461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXfJP32XtYBNjiFBOkL6sr1IQiM64qNwNdzrOINTTWM=;
	b=xvldb43HL7HQH0eOulxS+CMZ2UaT/J+yCJrLsyE2CEw3Mdkn5qhKFQQXMBGH1cOo/GzKIh
	PeZCaknc/Z/4XwvTZy132UCmxFMHPRMFfw9QFkm8iTgsW4w5szMy7KJ58jFC9fWHT2xsvN
	SRNZefdKBsX8yoZxKMpnzh3w7jBO0O8=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v7 0/3] Introduce git-last-modified(1) command
Date: Tue,  5 Aug 2025 11:33:55 +0200
Message-ID: <20250805093358.1791633-1-toon@iotcl.com>
In-Reply-To: <20250730175510.987383-1-toon@iotcl.com>
References: <20250730175510.987383-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On many forges the tree view is shown in combination with commit data.
In such a view each tree entry is accompanied with the commit message
and date that last modified that tree entry. Something similar like:

    | README.md   | README: *.txt -> *.adoc fixes                           | 4 months ago |
    | RelNotes    | Start 2.51 cycle, the first batch                       | 4 weeks ago  |
    | SECURITY.md | SECURITY: describe how to report vulnerabilities        | 4 years      |
    | abspath.c   | abspath: move related functions to abspath              | 2 years      |
    | abspath.h   | abspath: move related functions to abspath              | 2 years      |
    | aclocal.m4  | configure: use AC_LANG_PROGRAM consistently             | 15 years ago |
    | add-patch.c | pager: stop using `the_repository`                      | 7 months ago |
    | advice.c    | advice: allow disabling default branch name advice      | 4 months ago |
    | advice.h    | advice: allow disabling default branch name advice      | 4 months ago |
    | alias.h     | rebase -m: fix serialization of strategy options        | 2 years      |
    | alloc.h     | git-compat-util: move alloc macros to git-compat-util.h | 2 years ago  |
    | apply.c     | apply: only write intents to add for new files          | 8 days ago   |
    | archive.c   | Merge branch 'ps/parse-options-integers'                | 3 months ago |
    | archive.h   | archive.h: remove unnecessary include                   | 1 year       |
    | attr.h      | fuzz: port fuzz-parse-attr-line from OSS-Fuzz           | 9 months ago |
    | banned.h    | banned.h: mark `strtok()` and `strtok_r()` as banned    | 2 years      |

This series adds the git-last-modified(1) to feed this view. In the past
the subcommand was proposed[1] to be named git-blame-tree(1). This
version is based on the patches shared by the kind people at GitHub[2].

What is different from the series shared by GitHub:

* Renamed the subcommand from `blame-tree` to `last-modified`. There was
  some consensus[5] this name works better, so let's give it a try and
  see how this name feels.

* Patches for --max-depth are excluded. I've submitted them as a separate patch
  series[6].

* The last-modified command isn't recursive by default. If you want
  recurse into subtrees, you need to pass `-r`.

* The patches in 'tb/blame-tree' at Taylor's fork[4] implements a
  caching layer. This feature reads/writes cached results in
  `.git/blame-tree/<hash>.btc`. To keep this series to a reviewable
  size, that feature is excluded from this series. I think it's better
  to submit this as a separate series.

* All the new last-modified machinery is no longer implemented in a library
  layer (at the root of the project), but directly in the builtin. So far the
  code is fairly small (little over 300 lines of code) and there are no other
  users of this code anyway. Also the library level code taken from Taylor's
  fork required to pass `argc` and `argv` into it. It's quite awkward the
  library code was so tightly coupled with user interaction.

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

I've set myself as the author and added Based-on-patch-by trailers to
credit the original authors. Let me know if you disagree.

Again thanks to Taylor and the people at GitHub for sharing these
patches. I hope we can work together to get this upstreamed.

[1]: https://lore.kernel.org/git/patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com/
[2]: https://lore.kernel.org/git/Z+XJ+1L3PnC9Dyba@nand.local/
[3]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-3-4173133f3786@iotcl.com/
[4]: git@github.com:ttaylorr/git.git
[5]: https://lore.kernel.org/git/aCbBKj7O9LjO3SMK@pks.im/
[6]: https://lore.kernel.org/git/20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com/

---
Changes in v7:
- Fix case when bloom filters were used and a commit range was given. This bug
  was uncovered in CI.
- Rename the long option for `-t` to `--show-trees`. This option no longer
  implies option `-r`. And resemble these changes in the documentation, with a
  few other small documentation tweaks.
- Move prepare_commit_graph() into get_bloom_filter_settings() which no longer
  requires last-modified to worry about it itself. This is similar to
  repo_find_commit_pos_in_graph() and lookup_commit_in_graph()
- Bring back the call to commit_graph_generation() in maybe_changed_path(). This
  is also called in the same function in blame.c and in
  check_maybe_different_in_bloom_filter() in revision.c. I couldn't find a test
  case that triggers this exit condition, but it should not have negative
  side-effects.
- No longer call diff_free() on the copy we make when populating the `paths` of
  `struct last_modified`. Because we weren't doing a deep copy, this could clean
  up fields used later on by the original. Instead only call clear_pathspec(). A
  comment to clarify this mechanism better is added.
- Add BUG() call to exit condition that shouldn't happen.
- Switch some int types to bool types.

Changes in v6:
- Only the first 3 patches are kept. The last 3 patches worked toward adding an
  extra option `--format`. The way it was implemented was heavily debatable and
  in the end it is not required for a first iteration, so they are dropped.
- Function prepare_commit_graph() is exported and used in
  generation_numbers_enabled().
- Since the library layer was removed and all the code was moved into the
  builtin, there was still some leftovers from using a callback mechanism to
  display the results. This is removed (as far as possible) and instead
  last_modified_emit() always, this function was called show_entry() previously.
- Code is rebased to use refactoring in the bloom filter API.

Changes in v5:
- Added a patch to allow for an "extended" format. The name for this option is
  open for debate (please, all input is welcome). But the main goal of this
  series is to provide the data needed for the "forge tree view" as demoed at
  the top of this cover letter. With this extra patch (and the prepatory patch
  to pretty.[ch]), I hope the use-case because more clear. But because it wasn't
  included in previous 4 versions I also wouldn't mind sending a separate patch
  series for it.
- Removed the call to sort(1) the t8020 tests. This was needed for the tests for
  --extended.
- I'm adding a fixup! commit to be compatible with in-flight patches for bloom
  filter optimizations:
  https://lore.kernel.org/git/20250712093517.17907-1-yldhome2d2@gmail.com/
  This patch can be dropped if current series lands before those.

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
 Documentation/git-last-modified.adoc |  54 +++++
 Documentation/meson.build            |   1 +
 Makefile                             |   1 +
 builtin.h                            |   1 +
 builtin/last-modified.c              | 325 +++++++++++++++++++++++++++
 command-list.txt                     |   1 +
 commit-graph.c                       |   7 +-
 git.c                                |   1 +
 meson.build                          |   1 +
 t/meson.build                        |   2 +
 t/perf/p8020-last-modified.sh        |  22 ++
 t/t8020-last-modified.sh             | 210 +++++++++++++++++
 13 files changed, 626 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-last-modified.adoc
 create mode 100644 builtin/last-modified.c
 create mode 100755 t/perf/p8020-last-modified.sh
 create mode 100755 t/t8020-last-modified.sh

Range-diff against v6:
1:  9d5ce06460 < -:  ---------- last-modified: new subcommand to show when files were last modified
-:  ---------- > 1:  d5a2359633 last-modified: new subcommand to show when files were last modified
2:  7c921d4344 = 2:  7537f0e597 t/perf: add last-modified perf script
3:  3c42043682 < -:  ---------- commit-graph: export prepare_commit_graph()
4:  e3c2d5e3c1 ! 3:  ebc7b061df last-modified: use Bloom filters when available
    @@ builtin/last-modified.c: static void last_modified_diff(struct diff_queue_struct
      	}
      }

    -+static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
    ++static bool maybe_changed_path(struct last_modified *lm, struct commit *origin)
     +{
     +	struct bloom_filter *filter;
     +	struct last_modified_entry *ent;
     +	struct hashmap_iter iter;
     +
     +	if (!lm->rev.bloom_filter_settings)
    -+		return 1;
    ++		return true;
    ++
    ++	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
    ++		return true;
     +
     +	filter = get_bloom_filter(lm->rev.repo, origin);
     +	if (!filter)
    -+		return 1;
    ++		return true;
     +
     +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
     +		if (bloom_filter_contains(filter, &ent->key,
     +					  lm->rev.bloom_filter_settings))
    -+			return 1;
    ++			return true;
     +	}
    -+	return 0;
    ++	return false;
     +}
     +
      static int last_modified_run(struct last_modified *lm)
      {
      	struct last_modified_callback_data data = { .lm = lm };
     @@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
    - 	lm->rev.diffopt.format_callback_data = &data;
    -
    - 	prepare_revision_walk(&lm->rev);
    -+	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
    -
    - 	while (hashmap_get_size(&lm->paths)) {
    - 		data.commit = get_revision(&lm->rev);
    - 		if (!data.commit)
    - 			break;
    -
    + 				      &data.commit->object.oid, "",
    + 				      &lm->rev.diffopt);
    + 			diff_flush(&lm->rev.diffopt);
    +-		} else {
    +-			log_tree_commit(&lm->rev, data.commit);
    ++
    ++			break;
    + 		}
    ++
     +		if (!maybe_changed_path(lm, data.commit))
     +			continue;
     +
    - 		if (data.commit->object.flags & BOUNDARY) {
    - 			diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
    - 				      &data.commit->object.oid, "",
    ++		log_tree_commit(&lm->rev, data.commit);
    + 	}
    +
    + 	return 0;
     @@ builtin/last-modified.c: static int last_modified_init(struct last_modified *lm, struct repository *r,
      		return argc;
      	}

    -+	prepare_commit_graph(lm->rev.repo);
     +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
     +
      	if (populate_paths_from_revs(lm) < 0)
      		return error(_("unable to setup last-modified"));

    +
    + ## commit-graph.c ##
    +@@ commit-graph.c: int corrected_commit_dates_enabled(struct repository *r)
    +
    + struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
    + {
    +-	struct commit_graph *g = r->objects->commit_graph;
    ++	struct commit_graph *g;
    ++
    ++	if (!prepare_commit_graph(r))
    ++	       return NULL;
    ++
    ++	g = r->objects->commit_graph;
    + 	while (g) {
    + 		if (g->bloom_filter_settings)
    + 			return g->bloom_filter_settings;

base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
--
2.50.1.327.g047016eb4a
