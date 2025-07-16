Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B21C8626
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672794; cv=none; b=jxSxr5rLqizZa23K9WJnZTCphHvnLHIqbV/TeLqbddRtAAsO65NsLeIGWS20bcPkpqroEFoyd4prCvrVBGWLUpl+pT2fFvvGQC2kKuHgZgPF+S4RvO+avsGzwa8/Bjxw+8hNJ4WAJSQAngBLqFc9QuvgnuyCzgbM5UOWvP3haXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672794; c=relaxed/simple;
	bh=kJ1se5bVMUCtwozQDjjC70waxVJ7gQJqENS0sknuI9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGWOkFRLYx1oK2Pq1wRfqV9vN8X2hSvG5SFOSQrmsxobSMe0zIOrqxRRSkeF10hWKlCfU2nggeNk2YSSaUlXV/f+HfI/RpMPvWZ6vBrBEctY7kGTNuwzbMNKr6PhLLae7YUgnP1jWYlpnkBdCtSwvR+MES1lBkrHJlDMrhSxfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VIGqgvj8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VIGqgvj8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752672786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uw6I2qY+1sVmJq9LP5vkVNwGMiCXH70A0YM45PcO7/I=;
	b=VIGqgvj89OQZu809rY5ZcFvL+89LxBWDPXyUtz9k9thrYvVrt/bwrgp6aDVQDbsB3Gonqx
	9ahaboJjhhTgF1+tWPoYAsaIezh7BVs+5VK50tvD9mOv1nwV6xUjfrlEswV5el/s2SZxzj
	51ovCLuPgrAiXSzevZ/+QyQwCtBh5Ug=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v5 0/6] Introduce git-last-modified(1) command
Date: Wed, 16 Jul 2025 15:32:00 +0200
Message-ID: <20250716133206.1787549-1-toon@iotcl.com>
In-Reply-To: <20250709152628.1644521-1-toon@iotcl.com>
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

* Patches for --max-depth are excluded. I think it's a separate topic to
  discuss and I'm not sure it needs to be part of series anyway. The
  main patch was submitted in the previous attempt[3] and if people
  consider it valuable, I'm happy to discuss that in a separate patch
  series.

* The last-modified command isn't recursive by default. If you want
  recurse into subtrees, you need to pass `-r`.

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

I've set myself as the author and added Based-on-patch-by trailers to
credit the original authors. Let me know if you disagree.

Again thanks to Taylor and the people at GitHub for sharing these
patches. I hope we can work together to get this upstreamed.

[1]: https://lore.kernel.org/git/patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com/
[2]: https://lore.kernel.org/git/Z+XJ+1L3PnC9Dyba@nand.local/
[3]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-3-4173133f3786@iotcl.com/
[4]: git@github.com:ttaylorr/git.git
[5]: https://lore.kernel.org/git/aCbBKj7O9LjO3SMK@pks.im/

---
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

Toon Claes (6):
  last-modified: new subcommand to show when files were last modified
  t/perf: add last-modified perf script
  last-modified: use Bloom filters when available
  pretty: allow caller to disable indentation
  last-modified: support --extended format
  fixup! last-modified: use Bloom filters when available

 .gitignore                           |   1 +
 Documentation/git-last-modified.adoc |  95 +++++++
 Documentation/meson.build            |   1 +
 Makefile                             |   1 +
 builtin.h                            |   1 +
 builtin/last-modified.c              | 366 +++++++++++++++++++++++++++
 command-list.txt                     |   1 +
 git.c                                |   1 +
 meson.build                          |   1 +
 pretty.c                             |   2 +-
 pretty.h                             |   1 +
 t/meson.build                        |   2 +
 t/perf/p8020-last-modified.sh        |  21 ++
 t/t8020-last-modified.sh             | 225 ++++++++++++++++
 14 files changed, 718 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-last-modified.adoc
 create mode 100644 builtin/last-modified.c
 create mode 100755 t/perf/p8020-last-modified.sh
 create mode 100755 t/t8020-last-modified.sh

Range-diff against v4:
1:  0cc625f3f5 ! 1:  da0e391faa last-modified: new subcommand to show when files were last modified
    @@ t/t8020-last-modified.sh (new)
     +	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
     +	git name-rev --annotate-stdin --name-only --tags \
     +		<tmp.1 >tmp.2 &&
    -+	tr '\t' ' ' <tmp.2 >tmp.3 &&
    -+	sort tmp.3 >actual &&
    ++	tr '\t' ' ' <tmp.2 >actual &&
     +	test_cmp expect actual
     +}
     +
     +test_expect_success 'last-modified non-recursive' '
     +	check_last_modified <<-\EOF
    -+	1 file
     +	3 a
    ++	1 file
     +	EOF
     +'
     +
     +test_expect_success 'last-modified recursive' '
     +	check_last_modified -r <<-\EOF
    -+	1 file
    -+	2 a/file
     +	3 a/b/file
    ++	2 a/file
    ++	1 file
     +	EOF
     +'
     +
     +test_expect_success 'last-modified recursive with tree' '
     +	check_last_modified -t <<-\EOF
    -+	1 file
    -+	2 a/file
     +	3 a
     +	3 a/b
     +	3 a/b/file
    ++	2 a/file
    ++	1 file
     +	EOF
     +'
     +
    @@ t/t8020-last-modified.sh (new)
     +
     +test_expect_success 'last-modified subdir recursive' '
     +	check_last_modified -r a <<-\EOF
    -+	2 a/file
     +	3 a/b/file
    ++	2 a/file
     +	EOF
     +'
     +
     +test_expect_success 'last-modified from non-HEAD commit' '
     +	check_last_modified HEAD^ <<-\EOF
    -+	1 file
     +	2 a
    ++	1 file
     +	EOF
     +'
     +
     +test_expect_success 'last-modified from subdir defaults to root' '
     +	check_last_modified -C a <<-\EOF
    -+	1 file
     +	3 a
    ++	1 file
     +	EOF
     +'
     +
    @@ t/t8020-last-modified.sh (new)
     +	test_commit m2 &&
     +	git merge m1 &&
     +	check_last_modified <<-\EOF
    -+	m1 m1.t
     +	m2 m2.t
    ++	m1 m1.t
     +	EOF
     +'
     +
    @@ t/t8020-last-modified.sh (new)
     +	git checkout b2 -- file &&
     +	git merge --continue &&
     +	check_last_modified <<-\EOF
    -+	b2 file
     +	b5 file2
    ++	b2 file
     +	EOF
     +'
     +
2:  a017f2c81c = 2:  9182f86440 t/perf: add last-modified perf script
3:  c739a7dbcc = 3:  b4fa376572 last-modified: use Bloom filters when available
-:  ---------- > 4:  3df7833d59 pretty: allow caller to disable indentation
-:  ---------- > 5:  c2ac21c057 last-modified: support --extended format
-:  ---------- > 6:  0be24d898d fixup! last-modified: use Bloom filters when available

base-commit: 32571a0222eb85ef265e136f27e44c302302b45c
--
2.50.1.327.g047016eb4a
