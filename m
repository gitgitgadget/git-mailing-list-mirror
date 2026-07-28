Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9733F582
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253582; cv=none; b=VJUNvhgd4kEHIyDl9ZStXh9vFdFhJQMWjIgS5zexvOHG1ggv5YAvIJwaXK5jCRTiE8qVT/9rI8T46kQu32sGwT4FI9SGf8Vog4gKh4/giIGe6BZWIX0TyGFtJ5wk70+73gRcZ5avvhVxwl+Qqt6GOd8LZmutMe7AYgCTjwA/BEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253582; c=relaxed/simple;
	bh=02scJ5OsSan1Ek9DyOdwpe3SusAd9ojPzh4OtPVXIJw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=lIFR3zHwNmuom88q6L4Rs6ZrYk4/W9h9vUm5mMc9FYOH0p4Uj46FpWsDvwG2JZj8vvhIjyCv08E2XhvaanvxC+LavAbBK36v3Ll5kKjxcQpCkQO0l4LXAmxy6IrfIMWob0UqF0vRXY0s/8OyFMxjXHvKt2rCc+1SetfGXjg6wY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v8 0/3] Teach git-replay(1) to linearize merge commits
Date: Tue, 28 Jul 2026 17:45:50 +0200
Message-Id: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPTWrDMBAF4KsErasy+pey6j1KF7I0SlQSK8iua
 Qi5e+WUUuOFs3wwfO/NjQxYMw5kv7uRilMeculbsC87Eo6+PyDNsWXCgWvQIOlYSk8PeaQVLyd
 /pbGWCz1jPeBALZjkAWwUTpEmXCqm/P3Q3z9+8/DVfWIYZ3K+OOZhLPX6qJ/YfPfXZDebJkaBo
 kA0LAU0nXzLZQyn11DOZG6a+MJisG3xZinDpDcs6GjF2hJLS29bollMCXTYOReQrS25sDjftmS
 zUuLKJCWkYG5tqaX1ZJeaf0TGwQjbuQhrS/9bBp7s0s0y1oMJMYKwfG2ZpWW2LdMsC9Z3rpM+e
 b207vf7D1gzVzmgAgAA
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
In-Reply-To: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

As an alternative to dscho's patch series to replay merges[1], add
an option to git-replay(1) to linearize merges. This mimics what
git-rebase(1) does with --no-rebase-merges (the default).

The first two patches do some refactoring. The third patch implements
the actual change. The original patch was kindly provided by Dscho,
which I've tweaked to be upstreamed.

The --linearize option is only added to git-replay(1) and not to
git-history(1) because in my opinion it doesn't make much sense to do
so, but I'm happy to hear if anyone disagrees.

Dscho's series to replay merges[1] needs a bit of rework to fit on top
of this, but I'm happy to help figuring that out. We've been discussing
to either name the option --flatten or --linearize, but I've decided on
"linearize" because the documentation of git-rebase(1) also mentions
"linearize".

[1]: <pull.2106.git.1778107405.gitgitgadget@gmail.com>

---
Changes in v8:
- Disallow multiple revision ranges with --linearize.
- Disallow --contained with --linearize.
- Link to v7: https://patch.msgid.link/20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com

Changes in v7:
- Allow --revert and --linearize to be used together.
- Because quite a lot of changes have been made since the original
  patch, change author from Johannes to Toon for the last commit.
  Johannes already told me he doesn't really care about authorship when
  he initially shared the patch with me.
- Link to v6: https://patch.msgid.link/20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com

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
Toon Claes (3):
      replay: add helper to put entry into replayed_commits
      replay: resolve the replay base outside pick_regular_commit()
      replay: offer an option to linearize the commit topology

 Documentation/git-replay.adoc |  19 +++++++-
 builtin/replay.c              |   6 ++-
 replay.c                      |  87 +++++++++++++++++++++++----------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      | 109 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 198 insertions(+), 28 deletions(-)

Range-diff versus v7:

1:  4faca15008 = 1:  0dc78a2a4b replay: add helper to put entry into replayed_commits
2:  a32f28e1ec = 2:  7522f5940f replay: resolve the replay base outside pick_regular_commit()
3:  2a689c90eb ! 3:  6f27442866 replay: offer an option to linearize the commit topology
    @@ Commit message
         Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
         independently and updates both refs.
     
    -    With `--linearize` the whole set is flattened into one line: the ranges
    -    are stacked on top of each other rather than replayed side by side, so
    -    both refs end up pointing at different points along that single history.
    +    For now this is disallowed with option `--linearize`. Linearizing more
    +    than one branch at once would concatenate unrelated histories into a
    +    single line, and update each branch to some point in that line. That
    +    won't be the result most users want, especially because the order
    +    depends on the order of the revision walk, not the order of the branch
    +    names on the command line.
     
    -    Replaying all revision ranges into one single linear history is
    -    intentional and it's the only way to ensure predictable results. A user
    -    who wants to linearize ranges independently is advised to use separate
    -    git-replay(1) invocations.
    +    For the same reason disallow the use of `--contained` with
    +    `--linearize`.
     
    -    Linearizing is a distinct operation, and flattening merge commits is
    -    just one aspect of that. Recreating merges would be a separate mode, so
    -    rather than mirror git-rebase(1)'s `--rebase-merges[=<mode>]` interface,
    -    git-replay(1) uses its own `--linearize` option.
    +    Users who want to linearize multiple branches are advised to do this in
    +    separate git-replay(1) invocations. Linearizing multiple branches at
    +    once might be added later.
    +
    +    Note that `--linearize` is not modeled after git-rebase(1)'s
    +    `--rebase-merges[=<mode>]` interface. Recreating merges, by preserving
    +    their topology, is a distinct operation that would be a separate mode.
    +    `--linearize` only drops merges and replays commits linearly. So
    +    git-replay(1) uses its own option rather than reusing that interface.
     
         Based-on-patches-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Toon Claes <toon@iotcl.com>
    @@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modif
     +the merge commit itself is dropped. A ref that pointed to a merge commit
     +is updated to the merge's last replayed ancestor.
     ++
    -+This flattens the `<revision-range>` as a whole. When multiple revision
    -+ranges are given they are stacked on top of each other into one linear
    -+history. Each of their refs is updated to point to its position in that
    -+history. To linearize ranges separately, replay them in separate `git
    ++Only a single branch can be linearized at a time: `--linearize` cannot
    ++be combined with multiple positive revisions or with `--contained`,
    ++because that would concatenate otherwise unrelated histories into one
    ++line. To linearize several branches, replay them in separate `git
     +replay` invocations.
     +
      <revision-range>::
    @@ builtin/replay.c: int cmd_replay(int argc,
      		OPT_END()
      	};
      
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 				  opts.contained, "--contained");
    + 	die_for_incompatible_opt2(!!opts.ref, "--ref",
    + 				  !!opts.contained, "--contained");
    ++	die_for_incompatible_opt2(opts.linearize, "--linearize",
    ++				  !!opts.contained, "--contained");
    + 
    + 	/* Parse ref action mode from command line or config */
    + 	ref_mode = get_ref_action_mode(repo, ref_action);
     
      ## replay.c ##
    +@@ replay.c: int replay_revisions(struct rev_info *revs,
    + 	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
    + 			   &detached_head, &advance, &revert, &onto, &update_refs);
    + 
    ++	if (opts->linearize &&
    ++	    update_refs && strset_get_size(update_refs) > 1) {
    ++		ret = error(_("'--linearize' cannot be used with multiple revision ranges"));
    ++		goto out;
    ++	}
    ++
    + 	if (opts->ref) {
    + 		struct object_id oid;
    + 
     @@ replay.c: int replay_revisions(struct rev_info *revs,
      	while ((commit = get_revision(revs))) {
      		const struct name_decoration *decoration;
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +	test_line_count = 3 out
     +'
     +
    -+test_expect_success 'replay with --linearize rebase multiple divergent branches into a single line' '
    -+	git replay --ref-action=print --linearize \
    -+		--onto main ^B topic2 topic3 topic4 >result &&
    -+
    -+	test_line_count = 3 result &&
    -+	cut -f 3 -d " " result >new-branch-tips &&
    -+
    -+	>expect &&
    -+	for i in 2 3 4
    -+	do
    -+		printf "update refs/heads/topic$i " >>expect &&
    -+		printf "%s " $(grep topic$i result | cut -f 3 -d " ") >>expect &&
    -+		git rev-parse topic$i >>expect || return 1
    -+	done &&
    -+
    -+	test_cmp expect result &&
    -+
    -+	test_write_lines           E D C M L B A >expect2 &&
    -+	test_write_lines     H G F E D C M L B A >expect3 &&
    -+	test_write_lines J I H G F E D C M L B A >expect4 &&
    -+
    -+	for i in 2 3 4
    -+	do
    -+		git log --format=%s $(grep topic$i result | cut -f 3 -d " ") >actual &&
    -+		test_cmp expect$i actual || return 1
    -+	done
    ++test_expect_success '--linearize rejects multiple revision ranges' '
    ++	test_must_fail git replay --ref-action=print --linearize \
    ++		--onto main ^B topic2 topic3 topic4 2>err &&
    ++	test_grep "cannot be used with multiple revision ranges" err
     +'
     +
     +test_expect_success 'replay with --linearize of a divergent merge keeps both sides' '
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success '--linearize with --contained updates contained refs' '
    -+	git replay --ref-action=print --linearize --contained \
    -+		--onto main ^B topic-with-merge >result &&
    -+
    -+	test_line_count = 2 result &&
    -+
    -+	git log --format=%s $(head -n 1 result | cut -f 3 -d " ") >actual &&
    -+	test_write_lines J I M L B A >expect &&
    -+	test_cmp expect actual &&
    -+
    -+	git log --format=%s $(tail -n 1 result | cut -f 3 -d " ") >actual &&
    -+	test_write_lines O N J I M L B A >expect &&
    -+	test_cmp expect actual
    ++test_expect_success '--linearize and --contained cannot be used together' '
    ++	test_must_fail git replay --ref-action=print --linearize --contained \
    ++		--onto main ^B topic-with-merge 2>err &&
    ++	test_grep "cannot be used together" err
     +'
     +
     +test_expect_success 'replay --revert with --linearize reverts a range containing a merge' '


---
base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

