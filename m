Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FE3939D2
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015139; cv=none; b=odqkp9mjdCNEM0XD7tTs6htJ42BEiYsXYVzr3bBSIr1tz5GiyQsR8nlE7sP3GA8vkqcFx8qS+DDuqRvd5ApBAVlWNAugjiyFEQP7WXGUZ7zI3+lpbk2xEBAWd7t1FxVRbJ04RDXO7hrBgxwjnONpW20grqAnsaINbnjhVXHv3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015139; c=relaxed/simple;
	bh=W+D5uYv6H1LT/1P/XVgXX2cHqdRpNkIZfl03n0kw1w4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=at9Qtd3JJZLCgxd7WU+i3GiXwaQ9erCB8OIaPKozIS9VRgVMFIeArQhPsNFZZfJgXvjuAt4cVc9CY5Xv6NmavkWapDpZNGMlOrbJQgjDvp6xbOAVhTdbb5uQTqSFnwl6+314DcT2Tdc2c63N4nXIIqCyzW39cs5/j+hvSY/3ezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=DDcHbnYz; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="DDcHbnYz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783015132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPUEUDE7fa9ZA0q/4w9o7m3Dk8avcYdVpgudTN4HadY=;
	b=DDcHbnYzUL2VD3dh1TD8EjCNnCzS2BKzHrLUjbg8k2o0U35PMu66wVCRJ5uD8ixusoJEUY
	PHaKSdKsovNcWxSMpEUxb5A9DES6AaeSB3ihFllD7OLjeGw6OT9BBKWWw8MNJGDnCy7o1e
	CANQpolrZkEQnfw7DqhzRUADaYE79GQ=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v6 0/3] Teach git-replay(1) to linearize merge commits
Date: Thu, 02 Jul 2026 19:58:42 +0200
Message-Id: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPTWrDMBAF4KsErasy+rOsrHqP0oUtjxyVxDKSa
 hqC7145pSC8cJcPHt+beZCE0WMi59ODRFx88mEqoXk5EXvpphGpH0omHHgDDUiaQ5jo6DONOF+
 7Ox1imOkN44iJtqBdB9AOwihShDmi899P/f3jN6ev/hNt3sitcfEph3h/zi9s6/0ttYdLC6NAU
 SBq5izqXr75kO311YYb2ZYWXlkMji1eLKWZ7DSzzdCKvSVqqzm2RLGYEmiwN8Yi21uysjg/tmS
 xnONKOyWkYGZvqdr65y61/YiMgxZtbwaorXVdfwB4NhSgCAIAAA==
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
In-Reply-To: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
References: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

As an alternative to dscho's patch series to replay merges[1], add
an option to git-replay(1) to linearize merges. This mimics what
git-rebase(1) does with --no-rebase-merges (the default).

The first two patches do some refactoring. The third patch implements
the actual change. This patch was kindly provided by Dscho, which I've
tweaked to be upstreamed.

The --linearize option is only added to git-replay(1) and not to
git-history(1) because in my opinion it doesn't make much sense to do
so, but I'm happy to hear if anyone disagrees.

This series might conflict with Kristoffer's series to make
documentation changes[2], but should be trivial to resolve. And I don't
think there's a conflict with Patrick's series on adding "drop" to
git-history(1)[3].

dscho's series to replay merges[1] needs a bit of rework to fit on top
of this, but I'm happy to help figuring that out. We've been discussing
to either name the option --flatten or --linearize, but I've decided on
"linearize" because the documentation of git-rebase(1) also mentions
"linearize".

[1]: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
[2]: <V2_CV_doc_replay_config.767@msgid.xyz>
[3]: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>

---
Changes in v6:
- Reworked the second commit that moves picking the base completely
  outside pick_regular_commit(), instead of adding more explanation.
- Drastically extended the commit message on commit #3.
- Extended docs on flattening multiple revision ranges and how it's
  different from git-rebase(1)'s --no-rebase-merges.
- Added a bunch of tests to cover various scenarios.
- Remove newline from BUG() message.
- Link to v5: https://patch.msgid.link/20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com

Changes in v5:
- Dropped the enum->bool patch and instead added a patch that better
  explains how pick_regular_commit() picks a base.
- Order of commits is shuffled.
- (BIGGEST CHANGE) When working on a refactor to undo the enum->bool
  patch, I extended the code comments to explain how things work. This
  made me realize the use of the "replayed_base" was incorrect when
  multiple branches are rebased with --onto. This is fixed now and a
  test is added for this scenario.
- Link to v4: https://patch.msgid.link/20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com

Changes in v4:
- Use test_grep instead of a bare grep in the range-diff test, to
  prepare for mm/test-grep-lint.
- Link to v3: https://patch.msgid.link/20260616-toon-git-replay-drop-merges-v3-0-153e9eb99ce1@iotcl.com

Changes in v3:
- Add --linearize to Documentation SYNOPSIS, and mention it's
  incompatible with --revert.
- Small language change in help message for --linearize.
- Rephrase comment to include last_commit isn't modified when
  linearizing merges.
- Remove test that was added in earlier versions, but actually is
  a duplicate of 'replaying merge commits is not supported yet'.
- Add test to verify --revert and --linearize are incompatible.
- Properly test that replaying down to root with --linearize works.
- Add test for --linearize with --advance.
- Add test that uses git-range-diff(1) to verify the patches created by
  --linearize are correct.
- Link to v2: https://patch.msgid.link/20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com

Changes in v2:
- Restructured the conditions to detect merge commits and added a line
  of comment why the loop continues.
- Rewrote tests to use the history from the setup step and added a few
  test cases.
- Re-added Johannes's Signed-off-by trailer. Johannes gave me the
  patches with this trailer, and if I understand correctly, I can keep
  it. Please let me know if that wrong.
- Link to v1: https://patch.msgid.link/20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com

---
Johannes Schindelin (1):
      replay: offer an option to linearize the commit topology

Toon Claes (2):
      replay: add helper to put entry into replayed_commits
      replay: resolve the replay base outside pick_regular_commit()

 Documentation/git-replay.adoc |  21 ++++++-
 builtin/replay.c              |   6 +-
 replay.c                      |  81 ++++++++++++++++--------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      | 140 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 225 insertions(+), 28 deletions(-)

Range-diff versus v5:

1:  b4512eb233 ! 1:  b957989fd9 replay: add helper to put entry into mapped_commits
    @@ Metadata
     Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
    -    replay: add helper to put entry into mapped_commits
    +    replay: add helper to put entry into replayed_commits
     
         The function replay_revisions() in replay.c is rather lengthy. Extract
         the logic to put a commit entry into mapped_commits into a helper
    @@ replay.c: static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
     +
     +	pos = kh_put_oid_map(replayed_commits, commit->object.oid, &ret);
     +	if (ret == 0)
    -+		BUG("Duplicate rewritten commit: %s\n",
    ++		BUG("Duplicate rewritten commit: %s",
     +		    oid_to_hex(&commit->object.oid));
     +
     +	kh_value(replayed_commits, pos) = new_commit;
2:  91ed61bafd < -:  ---------- replay: better explain how pick_regular_commit() picks a base
-:  ---------- > 2:  6d457e8c39 replay: resolve the replay base outside pick_regular_commit()
3:  eb6a3b0d72 ! 3:  af39c0ae44 replay: offer an option to linearize the commit topology
    @@ Commit message
     
         The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
         was given. This mode drops merge commits instead of replaying them, and
    -    linearizes the commit history into a sequence of the
    -    regular (single-parent) commits.
    +    linearizes the history into a sequence of regular (single-parent)
    +    commits.
     
    -    Add option `--linearize` to git-replay(1) to do the same.
    +    Add option `--linearize` to git-replay(1) to do the same. Each replayed
    +    commit is stacked on top of the previously replayed one. When a merge is
    +    encountered, the commits reachable from all of its sides are replayed
    +    into the single line and the merge itself is dropped.
    +
    +    If a ref was pointing to a merge commit, that ref is updated to the
    +    merge's last replayed ancestor.
    +
    +    git-replay(1) accepts multiple revision ranges, for example:
    +
    +        $ git replay --onto main topic1 topic2
    +
    +    Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
    +    independently and updates both refs.
    +
    +    With `--linearize` the whole set is flattened into one line: the ranges
    +    are stacked on top of each other rather than replayed side by side, so
    +    both refs end up pointing at different points along that single history.
    +
    +    Replaying all revision ranges into one single linear history is
    +    intentional and it's the only way to ensure predictable results. A user
    +    who wants to linearize ranges independently is advised to use separate
    +    git-replay(1) invocations.
    +
    +    Linearizing is a distinct operation, and flattening merge commits is
    +    just one aspect of that. Recreating merges would be a separate mode, so
    +    rather than mirror git-rebase(1)'s `--rebase-merges[=<mode>]` interface,
    +    git-replay(1) uses its own `--linearize` option.
     
         Co-authored-by: Toon Claes <toon@iotcl.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    @@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modif
      The default mode can be configured via the `replay.refAction` configuration variable.
      
     +--linearize::
    -+	In this mode, `git replay` imitates `git rebase --no-rebase-merges`,
    -+	i.e. it cherry-picks only non-merge commits, each one on top of the
    -+	previous one.
    -+	This option is incompatible with `--revert`.
    ++	In this mode, each replayed commit is stacked on top of the
    ++	previously replayed one, so all replayed commits are flattened into
    ++	a single linear history.
    +++
    ++When a merge commit is encountered, the behavior of git-rebase(1)'s
    ++option `--no-rebase-merges` is imitated. All commits in the range
    ++reachable from the merge commit are replayed into a linear history, and
    ++the merge commit itself is dropped. A ref that pointed to a merge commit
    ++is updated to the merge's last replayed ancestor.
    +++
    ++This flattens the `<revision-range>` as a whole. When multiple revision
    ++ranges are given they are stacked on top of each other into one linear
    ++history. Each of their refs is updated to point to its position in that
    ++history. To linearize ranges separately, replay them in separate `git
    ++replay` invocations.
    +++
    ++This option is incompatible with `--revert`.
     +
      <revision-range>::
      	Range of commits to replay; see "Specifying Ranges" in
    @@ replay.c: int replay_revisions(struct rev_info *revs,
      		const struct name_decoration *decoration;
      
     -		/*
    --		 * pick_regular_commit() looks up the parent of `commit` in
    --		 * `replayed_commits` to determine the ancestor to replay onto.
    --		 * The `default_base` parameter is used when no ancestor is found,
    --		 * which happens for the first commit in the revision range.
    --		 * When reverting, commits are replayed in reverse order, so the
    --		 * lookup never succeeds, and we need to pass `last_commit`.
    +-		 * Decide where to replay this commit on.
    +-		 * If the parent commit was replayed already, the replayed result
    +-		 * can be found in `replayed_commits`. Otherwise fall back to `onto`.
    +-		 * When reverting, commits are replayed in reverse order and thus
    +-		 * its parent isn't replayed yet. Therefore revert commits are
    +-		 * always replayed onto `last_commit`.
     -		 */
    --		struct commit *base = onto;
    +-		struct commit *parent = commit->parents ? commit->parents->item : NULL;
    +-		struct commit *base = get_mapped_commit(replayed_commits, parent, onto);
    +-
     -		if (mode == REPLAY_MODE_REVERT)
     -			base = last_commit;
     -
    @@ replay.c: int replay_revisions(struct rev_info *revs,
     -			die(_("replaying merge commits is not supported yet!"));
     -
     -		last_commit = pick_regular_commit(revs->repo, commit, base,
    --						  replayed_commits,
    --						  &merge_opt, &result, mode, opts->empty);
    +-						  &merge_opt, &result,
    +-						  mode, opts->empty);
     +		if (commit->parents && commit->parents->next) {
     +			if (!opts->linearize)
     +				die(_("replaying merge commits is not supported yet!"));
    @@ replay.c: int replay_revisions(struct rev_info *revs,
     +			 * Drop the merge commit: do not pick it, leave
     +			 * `last_commit` unchanged, and fall through to the
     +			 * rest of the loop. As a result:
    -+			 * - the merge commit is mapped to `last_commit` in
    -+			 *   `replayed_commits`, this will become the parent for
    -+			 *   the child commits.
    -+			 * - refs previously pointing to the merge commit are
    -+			 *   rewritten to point to the previous non-merge commit.
    ++			 * - refs pointing to the merge commit will be updated
    ++			 *   to `last_commit`.
    ++			 * - the next replayed commit uses `last_commit` as its
    ++			 *   `base`.
     +			 */
     +		} else {
     +			/*
    -+			 * pick_regular_commit() looks up the parent of `commit` in
    -+			 * `replayed_commits` to determine the ancestor to replay onto.
    -+			 * The `default_base` parameter is used when no ancestor is found,
    -+			 * which happens for the first commit in the revision range.
    -+			 * When reverting, commits are replayed in reverse order, so the
    -+			 * lookup never succeeds, and we need to pass `last_commit`.
    ++			 * Decide where to replay this commit onto.
    ++			 * If the parent commit was replayed already, the replayed result
    ++			 * can be found in `replayed_commits`. Otherwise fall back to `onto`.
    ++			 * When reverting, commits are replayed in reverse order and thus
    ++			 * its parent isn't replayed yet. Therefore revert commits are
    ++			 * always replayed onto `last_commit`.
    ++			 * Also when opts->linearize is true, set the base to
    ++			 * `last_commit` to create a single linear history.
     +			 */
    -+			struct commit *base = onto;
    -+			if (mode == REPLAY_MODE_REVERT)
    ++			struct commit *parent = commit->parents ? commit->parents->item : NULL;
    ++			struct commit *base = get_mapped_commit(replayed_commits, parent, onto);
    ++
    ++			if (opts->linearize || mode == REPLAY_MODE_REVERT)
     +				base = last_commit;
     +
     +			last_commit = pick_regular_commit(revs->repo, commit, base,
    -+							  replayed_commits,
     +							  &merge_opt, &result,
     +							  mode, opts->empty);
     +		}
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +	test_line_count = 3 out
     +'
     +
    -+test_expect_success 'replay with --linearize to rebase multiple divergent branches' '
    ++test_expect_success 'replay with --linearize rebase multiple divergent branches into a single line' '
     +	git replay --ref-action=print --linearize \
    -+		--onto main ^B topic2 topic-with-merge >result &&
    ++		--onto main ^B topic2 topic3 topic4 >result &&
     +
    -+	test_line_count = 2 result &&
    ++	test_line_count = 3 result &&
     +	cut -f 3 -d " " result >new-branch-tips &&
     +
    -+	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
    -+	test_write_lines E D C M L B A >expect &&
    ++	>expect &&
    ++	for i in 2 3 4
    ++	do
    ++		printf "update refs/heads/topic$i " >>expect &&
    ++		printf "%s " $(grep topic$i result | cut -f 3 -d " ") >>expect &&
    ++		git rev-parse topic$i >>expect || return 1
    ++	done &&
    ++
    ++	test_cmp expect result &&
    ++
    ++	test_write_lines           E D C M L B A >expect2 &&
    ++	test_write_lines     H G F E D C M L B A >expect3 &&
    ++	test_write_lines J I H G F E D C M L B A >expect4 &&
    ++
    ++	for i in 2 3 4
    ++	do
    ++		git log --format=%s $(grep topic$i result | cut -f 3 -d " ") >actual &&
    ++		test_cmp expect$i actual || return 1
    ++	done
    ++'
    ++
    ++test_expect_success 'replay with --linearize of a divergent merge keeps both sides' '
    ++	test_when_finished "git update-ref -d refs/heads/divergent-x" &&
    ++	test_when_finished "git update-ref -d refs/heads/divergent-y" &&
    ++
    ++	# Build a real merge of two commits that diverged from a common base:
    ++	#
    ++	#       X - Z (divergent-x)
    ++	#      /   /
    ++	#  M  -  Y (divergent-y)
    ++	#
    ++	git switch -c divergent-x main &&
    ++	test_commit X &&
    ++	git switch -c divergent-y main &&
    ++	test_commit Y &&
    ++	git switch divergent-x &&
    ++	test_merge Z divergent-y --no-ff &&
    ++
    ++	git replay --ref-action=print --linearize \
    ++		--onto main main..divergent-x >result &&
    ++	test_line_count = 1 result &&
    ++	tip=$(cut -f 3 -d " " result) &&
    ++
    ++	# The merge Z is dropped, but both X and Y are linearized onto main;
    ++	# neither side is lost.
    ++	git log --format=%s main..$tip >actual &&
    ++	test_write_lines Y X >expect &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success '--linearize with --contained updates contained refs' '
    ++	git replay --ref-action=print --linearize --contained \
    ++		--onto main ^B topic-with-merge >result &&
    ++
    ++	test_line_count = 2 result &&
    ++
    ++	git log --format=%s $(head -n 1 result | cut -f 3 -d " ") >actual &&
    ++	test_write_lines J I M L B A >expect &&
     +	test_cmp expect actual &&
     +
    -+	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
    ++	git log --format=%s $(tail -n 1 result | cut -f 3 -d " ") >actual &&
     +	test_write_lines O N J I M L B A >expect &&
     +	test_cmp expect actual
     +'


---
base-commit: ab776a62a78576513ee121424adb19597fbb7613
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

