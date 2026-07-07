Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43148BD57
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451271; cv=none; b=Xxob4pkl0iYBr1WsmeM6zEIpfjIiyBOSGYkXsqzo9eag5iXKUXcZzFNxRZMRjAutYuxmt9WfOxtoiltHQQDkPhNidlWrqgavcVlVgMxvDF1RkmU1QGxsa5DdG+jwxdeSpavlCyCUQSEWu9nVyxNZMDUPRFb6YjYASWAFWT5BmSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451271; c=relaxed/simple;
	bh=eXT5DvOAHeyy8RJb/h+wtoSGNdRhRPGJnefapmzQqh4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=SSmiDXqSKDJJeYmEv1Me2Ht0ixMmTVDwqVDyCHZ+nVw9y+dXolkNYnnvFqMASYbcZf3QzuulIS65S36LB2jKeR8s46cGh/BZZ5LtiGbG1d8CMXPwskimHObfyp1B7fCd7A/FlhRyPy1yr2YOUDs3CWkwRN7DnH+P8GMcP8COXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=PW9wubjO; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="PW9wubjO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783451253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nRIgoKXYksvtfbxvabnUeguAwGB3aP1TexF/PPfK5k=;
	b=PW9wubjOAKl7OwWXmYY+ZGHTxMDQJ7N8uw1HF5jzPNoPrqTvb53biw8THInGzUkBlly15s
	wPwj6xMFk/4sEpU0zuUo9Fp10QyiZh5iEubmwusJkCDU0KbwHcPkWtEW5WfZoJiUnf58bq
	ouq9c2XR6gbYJoDExG7Wsv814i0Aaic=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v7 0/3] Teach git-replay(1) to linearize merge commits
Date: Tue, 07 Jul 2026 21:07:24 +0200
Message-Id: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPTWrDMBAF4KsErasykqy/rHqP0oUtjRKVxDKSa
 xqC7145pdR44SwfDN97cycFc8RCjoc7yTjFElNfg345EHdu+xPS6GsmHLgCBQ0dU+rpKY4043B
 pb9TnNNAr5hMWakCHFsB4YSWpwpAxxO+H/v7xm8tX94luXMjl4hzLmPLtUT+x5e6vyew2TYwCR
 YGoWXCou+YtptFdXl26kqVp4iuLwb7FqyU1a1rNnPJGbC2xttS+JarFpECLnbUO2dZqVhbn+1Z
 TrRC41EGKRjC7teTaerJLLj8i46CF6ayHraX+LQ1PdqlqadOCdt6DMHxtzfP8A77UkmhUAgAA
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
In-Reply-To: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
References: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
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
[2]: <V3_CV_doc_replay_config.780@msgid.xyz>
[3]: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>

---
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

 Documentation/git-replay.adoc |  19 +++++-
 builtin/replay.c              |   4 +-
 replay.c                      |  81 ++++++++++++++++--------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      | 140 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 221 insertions(+), 28 deletions(-)

Range-diff versus v6:

1:  96637c42a9 ! 1:  ce24fba6d6 replay: add helper to put entry into replayed_commits
    @@ Commit message
         replay: add helper to put entry into replayed_commits
     
         The function replay_revisions() in replay.c is rather lengthy. Extract
    -    the logic to put a commit entry into mapped_commits into a helper
    -    function put_mapped_commit().
    +    the logic to put a commit entry into a `struct mapped_commits` into a
    +    helper function put_mapped_commit().
     
         While at it, rename mapped_commit() to get_mapped_commit() to pair with
         this new function.
2:  ae6c27aee6 ! 2:  6a39274c1c replay: resolve the replay base outside pick_regular_commit()
    @@ Commit message
     
         Move the base selection completely into the caller: replay_revisions().
         This bundles all the logic of deciding on the base together. Also, this
    -    reduces the number of parameters of pick_regular_commit(), making it's
    +    reduces the number of parameters of pick_regular_commit(), making its
         interface cleaner.
     
         This refactoring doesn't bring any behavior changes.
3:  0208101e9b ! 3:  2960b9fdaf replay: offer an option to linearize the commit topology
    @@
      ## Metadata ##
    -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    +Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
         replay: offer an option to linearize the commit topology
    @@ Commit message
         rather than mirror git-rebase(1)'s `--rebase-merges[=<mode>]` interface,
         git-replay(1) uses its own `--linearize` option.
     
    -    Co-authored-by: Toon Claes <toon@iotcl.com>
    -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Based-on-patches-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## Documentation/git-replay.adoc ##
    @@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modif
     +history. Each of their refs is updated to point to its position in that
     +history. To linearize ranges separately, replay them in separate `git
     +replay` invocations.
    -++
    -+This option is incompatible with `--revert`.
     +
      <revision-range>::
      	Range of commits to replay; see "Specifying Ranges" in
    @@ builtin/replay.c: int cmd_replay(int argc,
      		OPT_END()
      	};
      
    -@@ builtin/replay.c: int cmd_replay(int argc,
    - 				  opts.contained, "--contained");
    - 	die_for_incompatible_opt2(!!opts.ref, "--ref",
    - 				  !!opts.contained, "--contained");
    -+	die_for_incompatible_opt2(!!opts.revert, "--revert",
    -+				  opts.linearize, "--linearize");
    - 
    - 	/* Parse ref action mode from command line or config */
    - 	ref_mode = get_ref_action_mode(repo, ref_action);
     
      ## replay.c ##
     @@ replay.c: int replay_revisions(struct rev_info *revs,
    @@ t/t3650-replay-basics.sh: test_expect_success 'setup' '
      	git switch -c conflict B &&
     -	test_commit C.conflict C.t conflict
     +	test_commit C.conflict C.t conflict &&
    -+	git branch -D unrelated
    ++	git branch -D unrelated &&
    ++
    ++	git switch -c divergent-x main &&
    ++	test_commit X &&
    ++	git switch -c divergent-y main &&
    ++	test_commit Y &&
    ++	git switch divergent-x &&
    ++	test_merge Z divergent-y --no-ff
      '
      
      test_expect_success 'setup bare' '
    -@@ t/t3650-replay-basics.sh: test_expect_success '--advance and --contained cannot be used together' '
    - 	test_grep "cannot be used together" actual
    - '
    - 
    -+test_expect_success '--revert and --linearize cannot be used together' '
    -+	test_must_fail git replay --revert=main --linearize \
    -+		topic1..topic2 2>actual &&
    -+	test_grep "cannot be used together" actual
    -+'
    -+
    - test_expect_success 'cannot advance target ... ordering would be ill-defined' '
    - 	echo "fatal: ${SQ}--advance${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined" >expect &&
    - 	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
     @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multiple revision ranges' '
      	test_grep "cannot be used with multiple revision ranges" err
      '
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +'
     +
     +test_expect_success 'replay with --linearize of a divergent merge keeps both sides' '
    -+	test_when_finished "git update-ref -d refs/heads/divergent-x" &&
    -+	test_when_finished "git update-ref -d refs/heads/divergent-y" &&
    -+
    -+	# Build a real merge of two commits that diverged from a common base:
    -+	#
    -+	#       X - Z (divergent-x)
    -+	#      /   /
    -+	#  M  -  Y (divergent-y)
    -+	#
    -+	git switch -c divergent-x main &&
    -+	test_commit X &&
    -+	git switch -c divergent-y main &&
    -+	test_commit Y &&
    -+	git switch divergent-x &&
    -+	test_merge Z divergent-y --no-ff &&
    -+
     +	git replay --ref-action=print --linearize \
     +		--onto main main..divergent-x >result &&
     +	test_line_count = 1 result &&
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +	test_write_lines O N J I M L B A >expect &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'replay --revert with --linearize reverts a range containing a merge' '
    ++	git replay --ref-action=print --revert=divergent-x --linearize \
    ++		main..divergent-x >result &&
    ++	test_line_count = 1 result &&
    ++	tip=$(cut -f 3 -d " " result) &&
    ++
    ++	git log --format=%s $tip >actual &&
    ++	test_write_lines \
    ++		"Revert \"X\"" "Revert \"Y\"" Z Y X M L B A >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	test_must_fail git cat-file -e $tip:X.t &&
    ++	test_must_fail git cat-file -e $tip:Y.t
    ++'
     +
      test_done


---
base-commit: ab776a62a78576513ee121424adb19597fbb7613
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

