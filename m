Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D5411681
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102969; cv=none; b=MEPjjuUlL57BtDuu+RzkYsnymnW0BtEBAx/9yAhi1FeLbXydWlE7GiByCtv6uZW0GJF2rh5dz+pjhf2Dum3buafqZgVWZgmrn6p9Me91XWwJKelF+Ri/zmc6kZESxpjL9PLPWfiaJscpqFidfuglfkRTOZEJwJQwcJyLpq183MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102969; c=relaxed/simple;
	bh=fBcwUeknNkb/6nuiA5HQ6/pX04eyutyCFB3prRHHHR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rzQK46BOR7xkNhOkQMWU1Wxw/+KEvRVMVzwo9hrRf5va0pXHI8DJWbT/MdcfblD57tjWYfii8vYfJNbvOCMty39VIgMzHxh4YeBV211TTpR2QmY8ybG1fn/69V25OurEDA3a0og9SROG62H3lLrlEtg6FfF0pcg6szsT4zRBXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=QEG54w3m; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="QEG54w3m"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781102964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkOh6qKIdoFyBc0cR2/MgWgtiGkIJBTGMNw3tXaojq8=;
	b=QEG54w3mdWLvXMA2zaKXzFBMvWyCHujTy3fSwaCJYc7QsTFqutRNynCWd2s0gUWjzEh6YV
	lBGwYeLQwDqLzQxop60xS30egYXyTZM8+r8AU5gKuuja7EXA0mXBJoksdQuMoB7vk0todl
	KjWt7qvpvURHfIEjR/RngHwgEU2KDIA=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/3] Teach git-replay(1) to linearize merge commits
Date: Wed, 10 Jun 2026 16:49:11 +0200
Message-Id: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBAAf4Xs2TXlIaAn/8NwgLLAGuiSthIJ4
 d8FjFePk0xmFnBkmRzcggUsTexYzAbRKQDdlaYl5HpjiFSUqlQl6EUMtuzR0tiXM9ZWRhzItuQ
 wV1lTKpXX8fUCW2G01PD7qD+KL7tX9STt9+RudOy82PnYT+Hu/U7539MUokKKibKw0ZRVyZ3F6
 /6sZYBiXdcPLLwfSdgAAAA=
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
In-Reply-To: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
References: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

As an alternative to dscho's patch series to replay merges[1], add
option to git-replay(1) to linearize merges. This mimics wath
git-rebase(1) does too with --no-rebase-merges (the default).

The first two patches do some refactoring. The third patch implements
the actual change. I was kindly helped by dscho to implement this
change.

The --linearize option is only added to git-replay(1) and not to
git-history(1) because in my opinion doesn't make much sense to do so,
but I'm happy to hear if anyone disagrees.

This series might conflict with Kristoffer's series to make
documentation changes[2], but should be trivial to resolve. And I don't
think there's a conflict with Patrick's series on adding "drop" to
git-history(1)[3].

dscho's series to replay merges[1] need a bit of rework to fit on top of
this, but I'm happy to help figuring that out. We've been discussing to
either name the option --flatten or --linearize, but I've decided on
"linearize" because the documentation of git-rebase(1) also mentions
"linearize".

[1]: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
[2]: <V2_CV_doc_replay_config.767@msgid.xyz>
[3]: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>

Signed-off-by: Toon Claes <toon@iotcl.com>
---
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

 Documentation/git-replay.adoc |   5 ++
 builtin/replay.c              |   4 ++
 replay.c                      | 114 ++++++++++++++++++++++++------------------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      |  26 ++++++++++
 5 files changed, 105 insertions(+), 49 deletions(-)

Range-diff versus v1:

1:  7f3bc6f425 ! 1:  0975b142e3 replay: refactor enum replay_mode into a bool
    @@ Commit message
     
          - The value `REPLAY_MODE_REVERT` is used when option `--revert` is
            passed to git-replay(1). When using this value the commits are
    -       possible in reverse order and the inverse of the changes are applied.
    +       processed in reverse order and the inverse of the changes are
    +       applied.
     
          - The value `REPLAY_MODE_PICK` is used when either option `--onto` or
    -       `--advance` is used. In both cases the commits are pocessed in normal
    -       order, and the changes are applied as-is.
    +       `--advance` is used. In both cases the commits are processed in
    +       normal order, and the changes are applied as-is.
     
         Since there are only two possible values of this enum, simplify the code
    -    by converting the enum into a bool. This avoid adding code paths that
    -    check for invalid vaues of the enum, and shortens code where the value
    +    by converting the enum into a bool. This avoids adding code paths that
    +    check for invalid values of the enum, and shortens code where the value
         is checked with a ternary operator.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
2:  0868871c78 ! 2:  db88193624 replay: add helper to put entry into mapped_commits
    @@ Commit message
         replay: add helper to put entry into mapped_commits
     
         The function replay_revisions() in replay.c is rather lengthy. Extract
    -    the logic to put commit entry into mapped_commits into a helper
    -    function.
    +    the logic to put a commit entry into mapped_commits into a helper
    +    function put_mapped_commit().
    +
    +    While at it, rename mapped_commit() to get_mapped_commit() to pair with
    +    this new function.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
3:  a432ae753b ! 3:  d0c220ec8e replay: offer an option to linearize the commit topology
    @@ Commit message
     
         The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
         was given. This mode drops merge commits instead of replaying them, and
    -    linearized the commit history into a sequence of the
    +    linearizes the commit history into a sequence of the
         regular (single-parent) commits.
     
    -    Add option `--linearize` to git-replay(1) do the same.
    +    Add option `--linearize` to git-replay(1) to do the same.
     
         Co-authored-by: Toon Claes <toon@iotcl.com>
    +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## Documentation/git-replay.adoc ##
     @@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modifier for `--onto` only).
    @@ replay.c: int replay_revisions(struct rev_info *revs,
      		const struct name_decoration *decoration;
      
     -		if (commit->parents && commit->parents->next)
    -+		if (opts->linearize && (!commit->parents || commit->parents->next))
    -+			; /* map current commit to the same as the previous commit */
    -+		else if (commit->parents && commit->parents->next)
    - 			die(_("replaying merge commits is not supported yet!"));
    -+		else {
    +-			die(_("replaying merge commits is not supported yet!"));
    ++		if (commit->parents && commit->parents->next) {
    ++			if (!opts->linearize)
    ++				die(_("replaying merge commits is not supported yet!"));
    ++			/*
    ++			 * When linearizing, a merge commit itself is not picked,
    ++			 * but refs that point to it might need updating.
    ++			 */
    ++		} else {
     +			struct commit *to_pick = reverse ? last_commit : onto;
     +			last_commit =
     +				pick_regular_commit(revs->repo, commit,
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
      	test_grep "cannot be used with multiple revision ranges" err
      '
      
    -+test_expect_success 'linearize the commit topology' '
    -+	test_tick &&
    -+	N=$(git commit-tree -m N -p L -p I L:) &&
    -+	N=$(git commit-tree -m N-child -p $N L:) &&
    -+	git update-ref refs/heads/N $N &&
    ++test_expect_success 'replay merge commit fails' '
    ++	echo "fatal: replaying merge commits is not supported yet!" >expect &&
    ++	test_must_fail git replay --ref-action=print --onto main I..P 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'replay to rebase merge commit with --linearize' '
    ++	git replay --ref-action=print --linearize --onto main I..topic-with-merge >result &&
    ++
    ++	test_line_count = 1 result &&
    ++
    ++	git log --format=%s $(cut -f 3 -d " " result) >actual &&
    ++	test_write_lines O N J M L B A >expect &&
    ++	test_cmp expect actual
    ++'
     +
    -+	git replay --ref-action=print --linearize \
    -+		--onto A B..refs/heads/N >out &&
    ++test_expect_success 'replay to rebase merge commit with --linearize down to root commit' '
    ++	git replay --ref-action=print --linearize --onto main A..topic-with-merge >result &&
     +
    -+	test_line_count = 1 out &&
    -+	read N1 N2 N3 N4 <out &&
    ++	test_line_count = 1 result &&
     +
    -+	cat >expect <<-EOF &&
    -+	* N-child
    -+	* I
    -+	* L
    -+	o A
    -+	EOF
    -+	git log --format=%s --graph --boundary A...$N3 >actual &&
    ++	git log --format=%s $(cut -f 3 -d " " result) >actual &&
    ++	test_write_lines O N J I M L B A >expect &&
     +	test_cmp expect actual
     +'
     +


---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

