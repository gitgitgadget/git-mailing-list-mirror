Received: from mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FB1DE8AD
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182053; cv=none; b=HP89hnnXtA+zBdwX1uugJXERfqg1OySdRu4Q0kjYgXi5gFgZMMc12yaZqmVW2RzVdXhPxuXNR7kbntbQA3srKYM1my2M7P2Od+E3lDk1AeAaanZvwW3JcKXz7icv29q+8UE3c8QGzbLJautkKWlzdNC6ASkURkNSyJP5qugn7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182053; c=relaxed/simple;
	bh=7GoM7p+sGXhDIj0zqKX84wHkni5X/MjVNn6laJmFAKk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=e8e6M0h1ovBiUuBiSXY1msESywOnlK62yY2ULgrw3YO4JVTxuL7JEmSmCQTImDWR3j68gPzIbNi0fkd1euYjKoQgXEEgPS8yAcqPK6pKZbUSZAPx6tiMxlbq6YybPGjleaT0AU7Fdmat8qbCgFWaUwARhHrfP9Y+QzKFwLb/zUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Ks0iWrDG; arc=none smtp.client-ip=91.218.175.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Ks0iWrDG"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7GoM7p+sGXhDIj0zqKX84wHkni5X/MjVNn6laJmFAKk=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788182048; v=1; x=1788786848;
 b=Ks0iWrDG9RQP1QUDA0STCVNptPLPFl0L8J0a9srEjgNCHZjfU92OqufnhaQIx9yKAflUKxsL
 FP6ncaRfeGrqgp/QiXknzGTYl2LEF0vFT9rSZ10+iwUJXOs+OFazlIUOiSg6oyjTTAd36QCJVL+
 84bUibnB9vBUb9Muv7XBwWaw=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 13c3fb6e078057c3;
	Mon, 31 Aug 2026 13:14:07 +0000
X-Mizu-Trace-ID: 13c3fb6e078057c3
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v9 0/3] Teach git-replay(1) to linearize merge commits
Date: Mon, 31 Aug 2026 15:13:46 +0200
Message-Id: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XSTW7DIBAF4KtErEs1/ENXvUfVBYYhoUpMhF2rU
 ZS7F6eq6nrhLJ80+t6A5koGrBkH8rK7kopTHnLpW3BPOxIOvt8jzbFlwoFr0CDpWEpP93mkFc9
 Hf6GxljM9Yd3jQC2Y5AFsFE6RJpwrpvx119/ef/Lw2X1gGGdynjjkYSz1cq+f2Dz322Q3myZGg
 aJANCwFNJ18zWUMx+dQTmRumvjCYrBt8WYpw6Q3LOhoxdoSS0tvW6JZTAl02DkXkK0tubA437Z
 ks1LiyiQlpGBubaml9WAvNb8RGQcjbOcirC39Zxl4sJdulrEeTIgRhOVryywts22ZZlmwvnOd9
 MnrtWUXFn9wE7ZZASNjMSU08t9/3W63b/d4l4nsAgAA
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
In-Reply-To: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
References: <20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.16-dev-9febb

Hi,

I'm back with another iteration of the patch series to implement
--linearize into git-replay(1). My apologies for the long period of
radio silence, but this topic was stalled on reviews for a while, and
when I got some feedback I was on leave, so I'm finally back.

As far as I could tell there weren't any remaining comments on the
implementation itself, only on commit message and docs.

Laters,
Toon

Original cover letter:
===

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
Changes in v9:
- Rephrase "multiple revision ranges" to "multiple branches".
- Reword some things in the commit message.
- Tweak wording in replay.adoc.
- Link to v8: https://patch.msgid.link/20260728-toon-git-replay-drop-merges-v8-0-ced11dffe749@iotcl.com

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

 Documentation/git-replay.adoc |  17 ++++++-
 builtin/replay.c              |   6 ++-
 replay.c                      |  87 +++++++++++++++++++++++----------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      | 109 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 196 insertions(+), 28 deletions(-)

Range-diff versus v8:

1:  9fd3641eaf = 1:  3ea73d7c98 replay: add helper to put entry into replayed_commits
2:  0bd4cd9b9c = 2:  4a40c42684 replay: resolve the replay base outside pick_regular_commit()
3:  45faa926f8 ! 3:  d6247ea743 replay: offer an option to linearize the commit topology
    @@ Commit message
         If a ref was pointing to a merge commit, that ref is updated to the
         merge's last replayed ancestor.
     
    -    git-replay(1) accepts multiple revision ranges, for example:
    +    git-replay(1) accepts multiple branches, for example:
     
             $ git replay --onto main topic1 topic2
     
         Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
    -    independently and updates both refs.
    +    (keeping shared portions of history shared and divergent parts
    +    divergent) and updates both refs.
     
    -    For now this is disallowed with option `--linearize`. Linearizing more
    -    than one branch at once would concatenate unrelated histories into a
    -    single line, and update each branch to some point in that line. That
    -    won't be the result most users want, especially because the order
    -    depends on the order of the revision walk, not the order of the branch
    -    names on the command line.
    -
    -    For the same reason disallow the use of `--contained` with
    -    `--linearize`.
    +    Due to current implementation limitations, replaying multiple branches
    +    with `--linearize` is disallowed to avoid concatenating unrelated
    +    histories into a single line. For the same reason disallow the use of
    +    `--contained` with `--linearize`.
     
         Users who want to linearize multiple branches are advised to do this in
         separate git-replay(1) invocations. Linearizing multiple branches at
    @@ Documentation/git-replay.adoc: SYNOPSIS
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modifier for `--onto` only).
    +@@ Documentation/git-replay.adoc: Expanded description list compared to 'replay.refAction'.
      +
      The default mode can be configured via the `replay.refAction` configuration variable.
      
    @@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modif
     +	previously replayed one, so all replayed commits are flattened into
     +	a single linear history.
     ++
    -+When a merge commit is encountered, the behavior of git-rebase(1)'s
    -+option `--no-rebase-merges` is imitated. All commits in the range
    -+reachable from the merge commit are replayed into a linear history, and
    -+the merge commit itself is dropped. A ref that pointed to a merge commit
    -+is updated to the merge's last replayed ancestor.
    ++When a merge commit is encountered, all commits in the range reachable
    ++from the merge commit are replayed into the linear history, and the
    ++merge commit itself is dropped. A ref that pointed to a merge commit is
    ++updated to the merge's last replayed ancestor. (This matches the
    ++behavior of git-rebase(1)'s `--no-rebase-merges` option.)
     ++
    -+Only a single branch can be linearized at a time: `--linearize` cannot
    -+be combined with multiple positive revisions or with `--contained`,
    -+because that would concatenate otherwise unrelated histories into one
    -+line. To linearize several branches, replay them in separate `git
    -+replay` invocations.
    ++`--linearize` cannot be combined with multiple branches or with
    ++`--contained`. To linearize several branches, replay them in separate
    ++`git replay` invocations.
     +
      <revision-range>::
      	Range of commits to replay; see "Specifying Ranges" in
    @@ replay.c: int replay_revisions(struct rev_info *revs,
      
     +	if (opts->linearize &&
     +	    update_refs && strset_get_size(update_refs) > 1) {
    -+		ret = error(_("'--linearize' cannot be used with multiple revision ranges"));
    ++		ret = error(_("'--linearize' cannot be used with multiple branches"));
     +		goto out;
     +	}
     +
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +	test_line_count = 3 out
     +'
     +
    -+test_expect_success '--linearize rejects multiple revision ranges' '
    ++test_expect_success '--linearize rejects multiple branches' '
     +	test_must_fail git replay --ref-action=print --linearize \
     +		--onto main ^B topic2 topic3 topic4 2>err &&
    -+	test_grep "cannot be used with multiple revision ranges" err
    ++	test_grep "cannot be used with multiple branches" err
     +'
     +
     +test_expect_success 'replay with --linearize of a divergent merge keeps both sides' '


---
base-commit: c73e85354c275c9d409b26445089bc16940fc527
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

