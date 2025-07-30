Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60E2E0914
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898138; cv=none; b=pijsjPU4ZafpxqBL3+YPiW5DqwmSF1mXUWY52LMGmra0pP3M4fawtPKGgUNUDNw3FFxdDreTrksYPFjHnSA/On3N8/fMOmjF3mD9177BfawJ7uc32azCBCECn74jYohXnLfpbY3Uhelj6BXazZXZrJTuewIuByhwBM3vD5Z+aak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898138; c=relaxed/simple;
	bh=cH3aVRasyrO4L5+9GO6z+v/sPo1K1o2BgofvKYq6kMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYq75/RZhb/7vP5ANJSqzK9anNX5DmJlrn8cyibuVCbhwsY7LuMsxzGQS2Ft4Yw15ZiFOVQ+PkFAOzIn3cdFqMmQ+7/mrciRA6wWeE9l0iiLVxWdLdhOxu2ZsGmSoBtKiO9wO5yH+RgQsqUjb8qeE/ueJITL18pq26PBxbdJHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yiHmOfBP; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yiHmOfBP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753898130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0Mv6miafOGIIVZGgeYtBc1rYSjNl2d9t9h4jFlWA3Q=;
	b=yiHmOfBPSiMISJP8x5iltfFuQ3YbQM57lSU0960+XcykDsMYhHBKCov1llo0XjekmIav2n
	ZpopVV/1qJVSib0Seat0vlMIOFZCBncGlsZfEbRRNgW6HHGvhXY2lI6dw7JCofVwTM6Vt4
	kcoPe4Aq6ytMx8+wwJgzbdYVLGevD1w=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v6 0/4] Introduce git-last-modified(1) command
Date: Wed, 30 Jul 2025 19:55:06 +0200
Message-ID: <20250730175510.987383-1-toon@iotcl.com>
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

Toon Claes (4):
  last-modified: new subcommand to show when files were last modified
  t/perf: add last-modified perf script
  commit-graph: export prepare_commit_graph()
  last-modified: use Bloom filters when available

 .gitignore                           |   1 +
 Documentation/git-last-modified.adoc |  49 +++++
 Documentation/meson.build            |   1 +
 Makefile                             |   1 +
 builtin.h                            |   1 +
 builtin/last-modified.c              | 318 +++++++++++++++++++++++++++
 command-list.txt                     |   1 +
 commit-graph.c                       |   8 +-
 commit-graph.h                       |   8 +
 git.c                                |   1 +
 meson.build                          |   1 +
 t/meson.build                        |   2 +
 t/perf/p8020-last-modified.sh        |  22 ++
 t/t8020-last-modified.sh             | 203 +++++++++++++++++
 14 files changed, 610 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/git-last-modified.adoc
 create mode 100644 builtin/last-modified.c
 create mode 100755 t/perf/p8020-last-modified.sh
 create mode 100755 t/t8020-last-modified.sh

Range-diff against v5:
1:  8c6493d1d1 ! 1:  9d5ce06460 last-modified: new subcommand to show when files were last modified
    @@ builtin/last-modified.c (new)
     +struct last_modified {
     +	struct hashmap paths;
     +	struct rev_info rev;
    -+	int recursive, tree_in_recursive;
    ++	int recursive;
    ++	int tree_in_recursive;
     +};
     +
     +static void last_modified_release(struct last_modified *lm)
    @@ builtin/last-modified.c (new)
     +	release_revisions(&lm->rev);
     +}
     +
    -+typedef void (*last_modified_callback)(const char *path,
    -+				       const struct commit *commit, void *data);
    -+
     +struct last_modified_callback_data {
    ++	struct last_modified *lm;
     +	struct commit *commit;
    -+	struct hashmap *paths;
    -+
    -+	last_modified_callback callback;
    -+	void *callback_data;
     +};
     +
     +static void add_path_from_diff(struct diff_queue_struct *q,
    @@ builtin/last-modified.c (new)
     +			continue;
     +
     +		if (num_interesting++)
    -+			return error(_("can only get last-modified one tree at a time"));
    ++			return error(_("last-modified can only operate on one tree at a time"));
     +
     +		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
     +			      &obj->item->oid, "", &diffopt);
    @@ builtin/last-modified.c (new)
     +	return 0;
     +}
     +
    ++static void last_modified_emit(struct last_modified *lm,
    ++			       const char *path, const struct commit *commit)
    ++
    ++{
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
     +static void mark_path(const char *path, const struct object_id *oid,
     +		      struct last_modified_callback_data *data)
     +{
     +	struct last_modified_entry *ent;
     +
     +	/* Is it even a path that we are interested in? */
    -+	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
    ++	ent = hashmap_get_entry_from_hash(&data->lm->paths, strhash(path), path,
     +					  struct last_modified_entry, hashent);
     +	if (!ent)
     +		return;
    @@ builtin/last-modified.c (new)
     +	if (!oideq(oid, &ent->oid))
     +		return;
     +
    -+	if (data->callback)
    -+		data->callback(path, data->commit, data->callback_data);
    ++	last_modified_emit(data->lm, path, data->commit);
     +
    -+	hashmap_remove(data->paths, &ent->hashent, path);
    ++	hashmap_remove(&data->lm->paths, &ent->hashent, path);
     +	free(ent);
     +}
     +
    @@ builtin/last-modified.c (new)
     +	}
     +}
     +
    -+static int last_modified_run(struct last_modified *lm,
    -+			     last_modified_callback cb, void *cbdata)
    ++static int last_modified_run(struct last_modified *lm)
     +{
    -+	struct last_modified_callback_data data;
    -+
    -+	data.paths = &lm->paths;
    -+	data.callback = cb;
    -+	data.callback_data = cbdata;
    ++	struct last_modified_callback_data data = { .lm = lm };
     +
     +	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
     +	lm->rev.diffopt.format_callback = last_modified_diff;
    @@ builtin/last-modified.c (new)
     +	return 0;
     +}
     +
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
     +static int last_modified_init(struct last_modified *lm, struct repository *r,
     +			      const char *prefix, int argc, const char **argv)
     +{
    @@ builtin/last-modified.c (new)
     +		goto out;
     +	}
     +
    -+	if ((ret = last_modified_run(&lm, show_entry, &lm)))
    ++	if ((ret = last_modified_run(&lm)))
     +		goto out;
     +
     +out:
2:  dc34010bfb ! 2:  7c921d4344 t/perf: add last-modified perf script
    @@ t/perf/p8020-last-modified.sh (new)
     +'
     +
     +test_perf 'subdir last-modified' '
    -+	path=$(git ls-tree HEAD | grep ^040000 | head -n 1 | cut -f2)
    ++	git ls-tree -d HEAD >subtrees &&
    ++	path="$(head -n 1 subtrees | cut -f2)" &&
     +	git last-modified -r HEAD -- "$path"
     +'
     +
-:  ---------- > 3:  3c42043682 commit-graph: export prepare_commit_graph()
3:  8cd05437f0 ! 4:  4d7376a46d last-modified: use Bloom filters when available
    @@ builtin/last-modified.c: static void add_path_from_diff(struct diff_queue_struct
      		hashmap_add(&lm->paths, &ent->hashent);
      	}
     @@ builtin/last-modified.c: static void mark_path(const char *path, const struct object_id *oid,
    - 		data->callback(path, data->commit, data->callback_data);
    + 	last_modified_emit(data->lm, path, data->commit);

    - 	hashmap_remove(data->paths, &ent->hashent, path);
    + 	hashmap_remove(&data->lm->paths, &ent->hashent, path);
     +	bloom_key_clear(&ent->key);
      	free(ent);
      }
    @@ builtin/last-modified.c: static void last_modified_diff(struct diff_queue_struct
      	}
      }

    -+
     +static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
     +{
     +	struct bloom_filter *filter;
    @@ builtin/last-modified.c: static void last_modified_diff(struct diff_queue_struct
     +	return 0;
     +}
     +
    - static int last_modified_run(struct last_modified *lm,
    - 			     last_modified_callback cb, void *cbdata)
    + static int last_modified_run(struct last_modified *lm)
      {
    -@@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm,
    + 	struct last_modified_callback_data data = { .lm = lm };
    +@@ builtin/last-modified.c: static int last_modified_run(struct last_modified *lm)
      		if (!data.commit)
      			break;

    @@ builtin/last-modified.c: static int last_modified_init(struct last_modified *lm,
      		return argc;
      	}

    -+	/*
    -+	 * We're not interested in generation numbers here,
    -+	 * but calling this function to prepare the commit-graph.
    -+	 */
    -+	(void)generation_numbers_enabled(lm->rev.repo);
    ++	prepare_commit_graph(lm->rev.repo);
     +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
     +
      	if (populate_paths_from_revs(lm) < 0)

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
--
2.50.1.327.g047016eb4a
