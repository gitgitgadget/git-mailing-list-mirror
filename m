Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403E397699
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602026; cv=none; b=g89wmD5uHaK8b5ft+YTCCEJC7Zf2M009yCsWcVYqRElao90pmcP9I+nV3f0EhViJnDQdgKF3Y/xSO0sSayjwtSzhzO1EG24QIx2WKJclY3UwMPWR6RfD0qP/C04MzYEi0n5RoWHjKDDlI9eVyeJoz9cGAcS2i8/N6EbzY9dKRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602026; c=relaxed/simple;
	bh=iZ/ffeHd1pFAOwgisQ7fKOmxqCqWB65pbb6Js0vvLQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=S1jWPzvkC2MD/fiPhEbGOcnm5gixbzJkbhY4JFSbTomOllk4C0Wr1Tha6XkPqPsPOwS0xvrSf1KQ/virxC3TqfHsjTdD9nPxELwdq5cNy0/T+MJFT7QIFpyrgrhTwh32BTYCVGzfQNPm01aqqvd60SnQ3YsZXFlVXCvxUVviBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=GCYgXDaz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="GCYgXDaz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781602021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZgZD96GQUjOmQZJdCRbAyZZrpViAQWbkOUWTwflVcA=;
	b=GCYgXDazWHfZ1uPaDD3sygFFn+U+sHxTRzfDosK/SQ/45RQJmkU+m0HU4kSY3tjCziv0Jl
	GbIvwjZoCpGCDtjruYmLP0h0AxZ/g+YysPmDKgMJ+9mIft2HyiY/IYkUP2wMopyzKbsNPO
	tkEjUqiAd9cX7FzHGg9Uppl/wCG60xc=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v3 0/3] Teach git-replay(1) to linearize merge commits
Date: Tue, 16 Jun 2026 11:26:34 +0200
Message-Id: <20260616-toon-git-replay-drop-merges-v3-0-153e9eb99ce1@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NSwqDMBSF4a1Ixr0lDzVpR91H6UDjVVOskSSVi
 rj3RkvBkcMDh++fiUdn0JNrMhOHo/HG9nGIU0J0W/QNgqniJpzynOY0hWBtD40J4HDoigkqZwd
 4oWvQg6KyLihVlbhkJAqDw9p8Nv3++G3/Lp+ow0quj9b4YN205Ue2/v4ldVgaGVBAgShZrVGW6
 c3YoLuzti+ylka+sxg9tni0MsnSQjKdV0rsrWVZvh+mlgIkAQAA
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
In-Reply-To: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
References: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

As an alternative to dscho's patch series to replay merges[1], add
option to git-replay(1) to linearize merges. This mimics what
git-rebase(1) does too with --no-rebase-merges (the default).

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

Signed-off-by: Toon Claes <toon@iotcl.com>
---
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
      replay: refactor enum replay_mode into a bool
      replay: add helper to put entry into mapped_commits

 Documentation/git-replay.adoc |   8 ++-
 builtin/replay.c              |   6 ++-
 replay.c                      | 116 ++++++++++++++++++++++++------------------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      |  68 ++++++++++++++++++++++++-
 5 files changed, 151 insertions(+), 52 deletions(-)

Range-diff versus v2:

1:  2075988ef1 = 1:  542b1c9267 replay: refactor enum replay_mode into a bool
2:  93ff03be65 = 2:  62f6df8375 replay: add helper to put entry into mapped_commits
3:  ef56010c96 ! 3:  768646ee24 replay: offer an option to linearize the commit topology
    @@ Commit message
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## Documentation/git-replay.adoc ##
    +@@ Documentation/git-replay.adoc: SYNOPSIS
    + --------
    + [verse]
    + (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
    +-			     [--ref=<ref>] [--ref-action=<mode>] <revision-range>
    ++			     [--ref=<ref>] [--ref-action=<mode>] [--linearize] <revision-range>
    + 
    + DESCRIPTION
    + -----------
     @@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modifier for `--onto` only).
      +
      The default mode can be configured via the `replay.refAction` configuration variable.
    @@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modif
     +	In this mode, `git replay` imitates `git rebase --no-rebase-merges`,
     +	i.e. it cherry-picks only non-merge commits, each one on top of the
     +	previous one.
    ++	This option is incompatible with `--revert`.
     +
      <revision-range>::
      	Range of commits to replay; see "Specifying Ranges" in
      	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
     
      ## builtin/replay.c ##
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 	const char *const replay_usage[] = {
    + 		N_("(EXPERIMENTAL!) git replay "
    + 		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
    +-		   "[--ref=<ref>] [--ref-action=<mode>] <revision-range>"),
    ++		   "[--ref=<ref>] [--ref-action=<mode>] [--linearize] <revision-range>"),
    + 		NULL
    + 	};
    + 	struct option replay_options[] = {
     @@ builtin/replay.c: int cmd_replay(int argc,
      			     N_("mode"),
      			     N_("control ref update behavior (update|print)"),
      			     PARSE_OPT_NONEG),
     +		OPT_BOOL(0, "linearize", &opts.linearize,
    -+			 N_("ignore merge commits instead of replaying them")),
    ++			 N_("drop merge commits, replaying only non-merge commits")),
      		OPT_END()
      	};
      
    @@ replay.c: int replay_revisions(struct rev_info *revs,
     +			if (!opts->linearize)
     +				die(_("replaying merge commits is not supported yet!"));
     +			/*
    -+			 * When linearizing, a merge commit itself is not picked,
    -+			 * but refs that point to it might need updating.
    ++			 * Drop the merge commit: do not pick it and leave
    ++			 * last_commit unchanged, so its children (and any ref
    ++			 * pointing at it) are reparented onto the previous
    ++			 * non-merge commit, which the ref-update loop below uses.
     +			 */
     +		} else {
     +			struct commit *to_pick = reverse ? last_commit : onto;
    @@ replay.h: struct replay_revisions_options {
      /* This struct is used as an out-parameter by `replay_revisions()`. */
     
      ## t/t3650-replay-basics.sh ##
    -@@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multiple revision ranges' '
    - 	test_grep "cannot be used with multiple revision ranges" err
    +@@ t/t3650-replay-basics.sh: test_expect_success 'setup' '
    + 	test_merge P O --no-ff &&
    + 	git switch main &&
    + 
    ++	git switch --orphan unrelated &&
    ++	test_commit unrelated-root &&
    ++
    + 	git switch -c conflict B &&
    +-	test_commit C.conflict C.t conflict
    ++	test_commit C.conflict C.t conflict &&
    ++	git branch -D unrelated
      '
      
    -+test_expect_success 'replay merge commit fails' '
    -+	echo "fatal: replaying merge commits is not supported yet!" >expect &&
    -+	test_must_fail git replay --ref-action=print --onto main I..P 2>actual &&
    -+	test_cmp expect actual
    + test_expect_success 'setup bare' '
    +@@ t/t3650-replay-basics.sh: test_expect_success '--advance and --contained cannot be used together' '
    + 	test_grep "cannot be used together" actual
    + '
    + 
    ++test_expect_success '--revert and --linearize cannot be used together' '
    ++	test_must_fail git replay --revert=main --linearize \
    ++		topic1..topic2 2>actual &&
    ++	test_grep "cannot be used together" actual
     +'
     +
    + test_expect_success 'cannot advance target ... ordering would be ill-defined' '
    + 	echo "fatal: ${SQ}--advance${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined" >expect &&
    + 	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
    +@@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multiple revision ranges' '
    + 	test_grep "cannot be used with multiple revision ranges" err
    + '
    + 
     +test_expect_success 'replay to rebase merge commit with --linearize' '
    -+	git replay --ref-action=print --linearize --onto main I..topic-with-merge >result &&
    ++	git replay --ref-action=print --linearize \
    ++		--onto main I..topic-with-merge >result &&
     +
     +	test_line_count = 1 result &&
     +
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'replay to rebase merge commit with --linearize down to root commit' '
    -+	git replay --ref-action=print --linearize --onto main A..topic-with-merge >result &&
    ++test_expect_success 'replay to rebase merge commit with --linearize down to the root commit' '
    ++	git replay --ref-action=print --linearize \
    ++		--onto unrelated-root topic-with-merge >result &&
     +
     +	test_line_count = 1 result &&
     +
     +	git log --format=%s $(cut -f 3 -d " " result) >actual &&
    -+	test_write_lines O N J I M L B A >expect &&
    ++	test_write_lines O N J I B A unrelated-root >expect &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'replay to cherry-pick merge commit with --linearize' '
    ++	git replay --ref-action=print --linearize \
    ++		--advance main I..topic-with-merge >result &&
    ++
    ++	test_line_count = 1 result &&
    ++
    ++	git log --format=%s $(cut -f 3 -d " " result) >actual &&
    ++	test_write_lines O N J M L B A >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	printf "update refs/heads/main " >expect &&
    ++	printf "%s " $(cut -f 3 -d " " result) >>expect &&
    ++	git rev-parse main >>expect &&
    ++	test_cmp expect result
    ++'
    ++
    ++test_expect_success 'replay --linearize produces the same patches' '
    ++	git replay --ref-action=print --linearize \
    ++		--onto main I..topic-with-merge >result &&
    ++
    ++	test_line_count = 1 result &&
    ++	tip=$(cut -f 3 -d " " result) &&
    ++
    ++	# range-diff does not care about the dropped merge,
    ++	# so the original commits (I..topic-with-merge)
    ++	# and the replayed chain (main..tip) must produce identical patches.
    ++	git range-diff I..topic-with-merge main..$tip >out &&
    ++	test_file_not_empty out &&
    ++	! grep -v "=" out &&
    ++
    ++	git log --oneline main..$tip >out &&
    ++	test_line_count = 3 out
    ++'
     +
      test_done


---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

