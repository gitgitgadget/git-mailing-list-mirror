Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34414534B7
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451288; cv=none; b=Jqdm+e8nHw6uP4vt1R+ewXhFB9bpyqYIiHlJ/ebvR9FBJCAWt+Bs02yrzT6qnQOjDQe3SYmUNuyirFRHqxVPk6GO/JihNL77QgMZVjEWn7UYaCQ3uQ+ZktsClCmJkZaHqsZN5Aw+Ixpyx0FFKo9sEVOHJh/u29VWIcQ7LMpVV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451288; c=relaxed/simple;
	bh=eqLQEJZKo+T6N6tNK8bxV3xkuTwCpXTvK7qHOYtY0cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUgJYH061IuuYvq+RZoi0Mu2BY2z91GF95mMQeMNaM+FwCuFSS54t8nj72pxiTi3JShLIMAqGUGCAL2NI8bfKqZ+SEFK5r5LFuFNesIuPChpezSAJ78vN1GtahAQMMAkSmtXn5MFdcWRMzFcVtnJGqir8/iYzhlqNSmwm38yyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=u6w43LKA; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="u6w43LKA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783451278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHGrXykZMlvDIT+YOl6+jAsi2aoVlJYRnG566E+VPE8=;
	b=u6w43LKA4yVLqbuBCwbw3ipAKHyQnKvoVEOxmlDAla408GFijlfiLgNN2SY8UPoFEMdUzZ
	YH8njAXYaj3SBHYXa3g0dKbsOY/ZIieDyNmteJg3bffykw15augSvTpssfai5eJmzgUFMw
	L2A/b8QJ8BpCoLu8NC8mwguMp4P7SKI=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 07 Jul 2026 21:07:27 +0200
Subject: [PATCH v7 3/3] replay: offer an option to linearize the commit
 topology
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
In-Reply-To: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

One of the stated goals of git-replay(1) is to allow implementing the
git-rebase(1) functionality on the server side.

The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
was given. This mode drops merge commits instead of replaying them, and
linearizes the history into a sequence of regular (single-parent)
commits.

Add option `--linearize` to git-replay(1) to do the same. Each replayed
commit is stacked on top of the previously replayed one. When a merge is
encountered, the commits reachable from all of its sides are replayed
into the single line and the merge itself is dropped.

If a ref was pointing to a merge commit, that ref is updated to the
merge's last replayed ancestor.

git-replay(1) accepts multiple revision ranges, for example:

    $ git replay --onto main topic1 topic2

Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
independently and updates both refs.

With `--linearize` the whole set is flattened into one line: the ranges
are stacked on top of each other rather than replayed side by side, so
both refs end up pointing at different points along that single history.

Replaying all revision ranges into one single linear history is
intentional and it's the only way to ensure predictable results. A user
who wants to linearize ranges independently is advised to use separate
git-replay(1) invocations.

Linearizing is a distinct operation, and flattening merge commits is
just one aspect of that. Recreating merges would be a separate mode, so
rather than mirror git-rebase(1)'s `--rebase-merges[=<mode>]` interface,
git-replay(1) uses its own `--linearize` option.

Based-on-patches-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-replay.adoc |  19 +++++-
 builtin/replay.c              |   4 +-
 replay.c                      |  54 ++++++++++------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      | 140 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 199 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index a32f72aead..98e20c1c6e 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
-			     [--ref=<ref>] [--ref-action=<mode>] <revision-range>
+			     [--ref=<ref>] [--ref-action=<mode>] [--linearize] <revision-range>
 
 DESCRIPTION
 -----------
@@ -88,6 +88,23 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
 
+--linearize::
+	In this mode, each replayed commit is stacked on top of the
+	previously replayed one, so all replayed commits are flattened into
+	a single linear history.
++
+When a merge commit is encountered, the behavior of git-rebase(1)'s
+option `--no-rebase-merges` is imitated. All commits in the range
+reachable from the merge commit are replayed into a linear history, and
+the merge commit itself is dropped. A ref that pointed to a merge commit
+is updated to the merge's last replayed ancestor.
++
+This flattens the `<revision-range>` as a whole. When multiple revision
+ranges are given they are stacked on top of each other into one linear
+history. Each of their refs is updated to point to its position in that
+history. To linearize ranges separately, replay them in separate `git
+replay` invocations.
+
 <revision-range>::
 	Range of commits to replay; see "Specifying Ranges" in
 	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
diff --git a/builtin/replay.c b/builtin/replay.c
index 39e3a86f6c..5e6ff4191a 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -85,7 +85,7 @@ int cmd_replay(int argc,
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
-		   "[--ref=<ref>] [--ref-action=<mode>] <revision-range>"),
+		   "[--ref=<ref>] [--ref-action=<mode>] [--linearize] <revision-range>"),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -111,6 +111,8 @@ int cmd_replay(int argc,
 			     N_("mode"),
 			     N_("control ref update behavior (update|print)"),
 			     PARSE_OPT_NONEG),
+		OPT_BOOL(0, "linearize", &opts.linearize,
+			 N_("drop merge commits, replaying only non-merge commits")),
 		OPT_END()
 	};
 
diff --git a/replay.c b/replay.c
index 5aee0eafbc..bd1f3bb898 100644
--- a/replay.c
+++ b/replay.c
@@ -433,26 +433,40 @@ int replay_revisions(struct rev_info *revs,
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
 
-		/*
-		 * Decide where to replay this commit on.
-		 * If the parent commit was replayed already, the replayed result
-		 * can be found in `replayed_commits`. Otherwise fall back to `onto`.
-		 * When reverting, commits are replayed in reverse order and thus
-		 * its parent isn't replayed yet. Therefore revert commits are
-		 * always replayed onto `last_commit`.
-		 */
-		struct commit *parent = commit->parents ? commit->parents->item : NULL;
-		struct commit *base = get_mapped_commit(replayed_commits, parent, onto);
-
-		if (mode == REPLAY_MODE_REVERT)
-			base = last_commit;
-
-		if (commit->parents && commit->parents->next)
-			die(_("replaying merge commits is not supported yet!"));
-
-		last_commit = pick_regular_commit(revs->repo, commit, base,
-						  &merge_opt, &result,
-						  mode, opts->empty);
+		if (commit->parents && commit->parents->next) {
+			if (!opts->linearize)
+				die(_("replaying merge commits is not supported yet!"));
+			/*
+			 * Drop the merge commit: do not pick it, leave
+			 * `last_commit` unchanged, and fall through to the
+			 * rest of the loop. As a result:
+			 * - refs pointing to the merge commit will be updated
+			 *   to `last_commit`.
+			 * - the next replayed commit uses `last_commit` as its
+			 *   `base`.
+			 */
+		} else {
+			/*
+			 * Decide where to replay this commit onto.
+			 * If the parent commit was replayed already, the replayed result
+			 * can be found in `replayed_commits`. Otherwise fall back to `onto`.
+			 * When reverting, commits are replayed in reverse order and thus
+			 * its parent isn't replayed yet. Therefore revert commits are
+			 * always replayed onto `last_commit`.
+			 * Also when opts->linearize is true, set the base to
+			 * `last_commit` to create a single linear history.
+			 */
+			struct commit *parent = commit->parents ? commit->parents->item : NULL;
+			struct commit *base = get_mapped_commit(replayed_commits, parent, onto);
+
+			if (opts->linearize || mode == REPLAY_MODE_REVERT)
+				base = last_commit;
+
+			last_commit = pick_regular_commit(revs->repo, commit, base,
+							  &merge_opt, &result,
+							  mode, opts->empty);
+		}
+
 		if (!last_commit)
 			break;
 
diff --git a/replay.h b/replay.h
index faf95c7459..64f42b6512 100644
--- a/replay.h
+++ b/replay.h
@@ -62,6 +62,11 @@ struct replay_revisions_options {
 	 * Defaults to REPLAY_EMPTY_COMMIT_DROP.
 	 */
 	enum replay_empty_commit_action empty;
+
+	/*
+	 * Whether to linearize the commits (i.e. drop merge commits).
+	 */
+	int linearize;
 };
 
 /* This struct is used as an out-parameter by `replay_revisions()`. */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 3353bc4a4d..4d3d442e8a 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -52,8 +52,19 @@ test_expect_success 'setup' '
 	test_merge P O --no-ff &&
 	git switch main &&
 
+	git switch --orphan unrelated &&
+	test_commit unrelated-root &&
+
 	git switch -c conflict B &&
-	test_commit C.conflict C.t conflict
+	test_commit C.conflict C.t conflict &&
+	git branch -D unrelated &&
+
+	git switch -c divergent-x main &&
+	test_commit X &&
+	git switch -c divergent-y main &&
+	test_commit Y &&
+	git switch divergent-x &&
+	test_merge Z divergent-y --no-ff
 '
 
 test_expect_success 'setup bare' '
@@ -565,4 +576,131 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
 	test_grep "cannot be used with multiple revision ranges" err
 '
 
+test_expect_success 'replay to rebase merge commit with --linearize' '
+	git replay --ref-action=print --linearize \
+		--onto main I..topic-with-merge >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines O N J M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay to rebase merge commit with --linearize down to the root commit' '
+	git replay --ref-action=print --linearize \
+		--onto unrelated-root topic-with-merge >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines O N J I B A unrelated-root >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay to cherry-pick merge commit with --linearize' '
+	git replay --ref-action=print --linearize \
+		--advance main I..topic-with-merge >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines O N J M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/main " >expect &&
+	printf "%s " $(cut -f 3 -d " " result) >>expect &&
+	git rev-parse main >>expect &&
+	test_cmp expect result
+'
+
+test_expect_success 'replay --linearize produces the same patches' '
+	git replay --ref-action=print --linearize \
+		--onto main I..topic-with-merge >result &&
+
+	test_line_count = 1 result &&
+	tip=$(cut -f 3 -d " " result) &&
+
+	# range-diff does not care about the dropped merge,
+	# so the original commits (I..topic-with-merge)
+	# and the replayed chain (main..tip) must produce identical patches.
+	git range-diff I..topic-with-merge main..$tip >out &&
+	test_file_not_empty out &&
+	test_grep ! -v "=" out &&
+
+	git log --oneline main..$tip >out &&
+	test_line_count = 3 out
+'
+
+test_expect_success 'replay with --linearize rebase multiple divergent branches into a single line' '
+	git replay --ref-action=print --linearize \
+		--onto main ^B topic2 topic3 topic4 >result &&
+
+	test_line_count = 3 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	>expect &&
+	for i in 2 3 4
+	do
+		printf "update refs/heads/topic$i " >>expect &&
+		printf "%s " $(grep topic$i result | cut -f 3 -d " ") >>expect &&
+		git rev-parse topic$i >>expect || return 1
+	done &&
+
+	test_cmp expect result &&
+
+	test_write_lines           E D C M L B A >expect2 &&
+	test_write_lines     H G F E D C M L B A >expect3 &&
+	test_write_lines J I H G F E D C M L B A >expect4 &&
+
+	for i in 2 3 4
+	do
+		git log --format=%s $(grep topic$i result | cut -f 3 -d " ") >actual &&
+		test_cmp expect$i actual || return 1
+	done
+'
+
+test_expect_success 'replay with --linearize of a divergent merge keeps both sides' '
+	git replay --ref-action=print --linearize \
+		--onto main main..divergent-x >result &&
+	test_line_count = 1 result &&
+	tip=$(cut -f 3 -d " " result) &&
+
+	# The merge Z is dropped, but both X and Y are linearized onto main;
+	# neither side is lost.
+	git log --format=%s main..$tip >actual &&
+	test_write_lines Y X >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--linearize with --contained updates contained refs' '
+	git replay --ref-action=print --linearize --contained \
+		--onto main ^B topic-with-merge >result &&
+
+	test_line_count = 2 result &&
+
+	git log --format=%s $(head -n 1 result | cut -f 3 -d " ") >actual &&
+	test_write_lines J I M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s $(tail -n 1 result | cut -f 3 -d " ") >actual &&
+	test_write_lines O N J I M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay --revert with --linearize reverts a range containing a merge' '
+	git replay --ref-action=print --revert=divergent-x --linearize \
+		main..divergent-x >result &&
+	test_line_count = 1 result &&
+	tip=$(cut -f 3 -d " " result) &&
+
+	git log --format=%s $tip >actual &&
+	test_write_lines \
+		"Revert \"X\"" "Revert \"Y\"" Z Y X M L B A >expect &&
+	test_cmp expect actual &&
+
+	test_must_fail git cat-file -e $tip:X.t &&
+	test_must_fail git cat-file -e $tip:Y.t
+'
+
 test_done

-- 
2.53.0.1323.g189a785ab5

