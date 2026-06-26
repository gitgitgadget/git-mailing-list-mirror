Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A307389E13
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452909; cv=none; b=JBir1Bx7xJfY6Y7J5dZd0RF9FCu8+mu1a32TUDbNu5+rJFRXtPBM3+0Zfu7rFR/BxcOvNrLiUJcTC1B6dygAG0oDr2mVLvkg8gcoQ6pZ/+iaul0gydMxH5tCm8TyD4OS/EA6yodzEUGP176gN16+MNcpPGlLOU94XOZ5WlM9dUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452909; c=relaxed/simple;
	bh=F3tzZW77+QZHVetmuvD/zMpOe3trRD8cGsTK3wfYRxQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=IxaQteXTBcvDnpIEnmnCnUxfOYYCXyn4z7Z2/pL1xtIploVtcsQ5EufMk7iYLhKOfDQ7/jd4AT7zhTQox7+rwcBB6H55yhXrCv3NxJmGEYwiLrjZt+OLkZUOgvIg5z9YQgcHUlenKAvbLbEc8xegu1d9k3RtsITLct7zyVKJbyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oEPfbd/c; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oEPfbd/c"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782452904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aSLDf1YYOzr5jAwuvvXf6mOWUsCr+sZire5rsPnGVo=;
	b=oEPfbd/c4Y8lOjssHQ9TvSLMCbudAlNCvS6uDIAsh6bk2seyIAn8YxEV66Y6TPZvwGfO3E
	HQK5xdh4bcF4m6qdLNetHZ2ufMSzWNxZ1iQD/EOL9iTCuFd4JQo7scfO/XoHDKG8/rCykE
	xglcaDFKYPqGkRsyly0VP4K63SfRHC0=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v5 0/3] Teach git-replay(1) to linearize merge commits
Date: Fri, 26 Jun 2026 07:48:10 +0200
Message-Id: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Ny2rDMBCF4VcJWneKRhfL6qrvUbqw5ZGjklhGU
 k1D8LtXTimYLLw8cPj+O8uUAmX2drqzREvIIU516JcTc+duGgnCUDcTXDS84QpKjBOMoUCi+dL
 dYEhxhiulkTK03PiO83aQVrMqzIl8+HnoH59/O3/3X+TKRm6Pc8glptsjv+D2+y+1h6UFgQNJI
 oPekenVe4jFXV5dvLKttIidhfzYEtXSBlVn0DVDK58tubeaY0tWC7UkS721jvDZUjtLiGNLVct
 7oY3XUkm0e2td1184SPBvvAEAAA==
X-Change-ID: 20260604-toon-git-replay-drop-merges-807fa008d395
In-Reply-To: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
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

---
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
      replay: add helper to put entry into mapped_commits
      replay: better explain how pick_regular_commit() picks a base

 Documentation/git-replay.adoc |  8 ++++-
 builtin/replay.c              |  6 +++-
 replay.c                      | 69 ++++++++++++++++++++++++++---------
 replay.h                      |  5 +++
 t/t3650-replay-basics.sh      | 84 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 152 insertions(+), 20 deletions(-)

Range-diff versus v4:

1:  a08bc22330 < -:  ---------- replay: refactor enum replay_mode into a bool
2:  3117fddcc5 = 1:  bbd5a710bd replay: add helper to put entry into mapped_commits
-:  ---------- > 2:  e08c7b46c0 replay: better explain how pick_regular_commit() picks a base
3:  acbb1df6a9 ! 3:  043cf63c1c replay: offer an option to linearize the commit topology
    @@ builtin/replay.c: int cmd_replay(int argc,
      	ref_mode = get_ref_action_mode(repo, ref_action);
     
      ## replay.c ##
    -@@ replay.c: static struct commit *pick_regular_commit(struct repository *repo,
    - 					  struct commit *onto,
    - 					  struct merge_options *merge_opt,
    - 					  struct merge_result *result,
    -+					  struct commit *replayed_base,
    - 					  bool reverse,
    - 					  enum replay_empty_commit_action empty)
    - {
    --	struct commit *base, *replayed_base;
    -+	struct commit *base;
    - 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
    - 
    -+	if (replayed_base && reverse)
    -+		BUG("Linearizing commits is not supported when replaying in reverse");
    -+
    - 	if (pickme->parents) {
    - 		base = pickme->parents->item;
    - 		base_tree = repo_get_commit_tree(repo, base);
    -@@ replay.c: static struct commit *pick_regular_commit(struct repository *repo,
    - 		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
    - 	}
    - 
    --	replayed_base = get_mapped_commit(replayed_commits, base, onto);
    -+	if (!replayed_base)
    -+		replayed_base = get_mapped_commit(replayed_commits, base, onto);
    - 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
    - 	pickme_tree = repo_get_commit_tree(repo, pickme);
    - 
     @@ replay.c: int replay_revisions(struct rev_info *revs,
      	while ((commit = get_revision(revs))) {
      		const struct name_decoration *decoration;
      
    +-		/*
    +-		 * pick_regular_commit() looks up the parent of `commit` in
    +-		 * `replayed_commits` to determine the ancestor to replay onto.
    +-		 * The `default_base` parameter is used when no ancestor is found,
    +-		 * which happens for the first commit in the revision range.
    +-		 * When reverting, commits are replayed in reverse order, so the
    +-		 * lookup never succeeds, and we need to pass `last_commit`.
    +-		 */
    +-		struct commit *base = onto;
    +-		if (mode == REPLAY_MODE_REVERT)
    +-			base = last_commit;
    +-
     -		if (commit->parents && commit->parents->next)
     -			die(_("replaying merge commits is not supported yet!"));
    +-
    +-		last_commit = pick_regular_commit(revs->repo, commit, base,
    +-						  replayed_commits,
    +-						  &merge_opt, &result, mode, opts->empty);
     +		if (commit->parents && commit->parents->next) {
     +			if (!opts->linearize)
     +				die(_("replaying merge commits is not supported yet!"));
     +			/*
    -+			 * Drop the merge commit: do not pick it and leave
    -+			 * last_commit unchanged, so its children (and any ref
    -+			 * pointing at it) are reparented onto the previous
    -+			 * non-merge commit, which the ref-update loop below uses.
    ++			 * Drop the merge commit: do not pick it, leave
    ++			 * `last_commit` unchanged, and fall through to the
    ++			 * rest of the loop. As a result:
    ++			 * - the merge commit is mapped to `last_commit` in
    ++			 *   `replayed_commits`, this will become the parent for
    ++			 *   the child commits.
    ++			 * - refs previously pointing to the merge commit are
    ++			 *   rewritten to point to the previous non-merge commit.
     +			 */
     +		} else {
    -+			struct commit *to_pick = reverse ? last_commit : onto;
    -+			last_commit =
    -+				pick_regular_commit(revs->repo, commit,
    -+						    replayed_commits, to_pick,
    -+						    &merge_opt, &result,
    -+						    opts->linearize ? last_commit : NULL,
    -+						    reverse, opts->empty);
    ++			/*
    ++			 * pick_regular_commit() looks up the parent of `commit` in
    ++			 * `replayed_commits` to determine the ancestor to replay onto.
    ++			 * The `default_base` parameter is used when no ancestor is found,
    ++			 * which happens for the first commit in the revision range.
    ++			 * When reverting, commits are replayed in reverse order, so the
    ++			 * lookup never succeeds, and we need to pass `last_commit`.
    ++			 */
    ++			struct commit *base = onto;
    ++			if (mode == REPLAY_MODE_REVERT)
    ++				base = last_commit;
    ++
    ++			last_commit = pick_regular_commit(revs->repo, commit, base,
    ++							  replayed_commits,
    ++							  &merge_opt, &result,
    ++							  mode, opts->empty);
     +		}
    - 
    --		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
    --						  reverse ? last_commit : onto,
    --						  &merge_opt, &result, reverse, opts->empty);
    ++
      		if (!last_commit)
      			break;
      
    @@ t/t3650-replay-basics.sh: test_expect_success '--onto with --ref rejects multipl
     +	git log --oneline main..$tip >out &&
     +	test_line_count = 3 out
     +'
    ++
    ++test_expect_success 'replay with --linearize to rebase multiple divergent branches' '
    ++	git replay --ref-action=print --linearize \
    ++		--onto main ^B topic2 topic-with-merge >result &&
    ++
    ++	test_line_count = 2 result &&
    ++	cut -f 3 -d " " result >new-branch-tips &&
    ++
    ++	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
    ++	test_write_lines E D C M L B A >expect &&
    ++	test_cmp expect actual &&
    ++
    ++	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
    ++	test_write_lines O N J I M L B A >expect &&
    ++	test_cmp expect actual
    ++'
     +
      test_done


---
base-commit: ab776a62a78576513ee121424adb19597fbb7613
change-id: 20260604-toon-git-replay-drop-merges-807fa008d395

