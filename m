Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CA3C9ECF
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452938; cv=none; b=gUCVqkhq95JD/dXJbcX3r7rjI/zxWbTQXN8AmcY/zRKvQMN+c4+4wgxiMfBk3+G7dTpZILiJJuHVkgDlQHIUgovriGvYDa4gkRvQQ6PccmFZ4lSz4oXfE/qByw/BczmvbNcjBnZUiapKmHCFO7Vm8zoTWa0f5FBh8bzALkP4DhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452938; c=relaxed/simple;
	bh=HSber4ZaM7ThdnafAJc2IafV/4qyUnNB2RqN92L6Mz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qs8QyfDufMpJ5hEFdbmJZFcDCM+4JXNzpsQM15YSf4JD1gc3PpH8yuxi/B5gufhhsb6u8Gig3V1S8iH6nRj5wvxF+r6y1ijaRx9c2pzOMpfy40swhJluWuqvvhDxNW/nHcVHQa6jSB+Fujtl3/dq3edSXNwaYD5wiB9//MHo1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=jQ3aFnIW; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="jQ3aFnIW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782452934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvjfoJLthGkZlHsWgq/EZZYxC5nw6ABWBN83BoA65Ck=;
	b=jQ3aFnIW+UFacytytZHphQmhLqP5FPKH/mUD8pnyjqe6pXsQUYeuFxipmE17sAX01Ab3fm
	BhTrzaoLEV1u7PrWmgUBAvfj9jYadcA9lYHtM4nm+g8CnEegcZDUAgIXPq1sO+zODcJLfD
	8U2VusUwkDJ5mkvijEPaeEuFy6tClAM=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 26 Jun 2026 07:48:13 +0200
Subject: [PATCH v5 3/3] replay: offer an option to linearize the commit
 topology
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-toon-git-replay-drop-merges-v5-3-5e120738b9d0@iotcl.com>
References: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
In-Reply-To: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

One of the stated goals of git-replay(1) is to allow implementing the
git-rebase(1) functionality on the server side.

The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
was given. This mode drops merge commits instead of replaying them, and
linearizes the commit history into a sequence of the
regular (single-parent) commits.

Add option `--linearize` to git-replay(1) to do the same.

Co-authored-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-replay.adoc |  8 ++++-
 builtin/replay.c              |  6 +++-
 replay.c                      | 50 ++++++++++++++++----------
 replay.h                      |  5 +++
 t/t3650-replay-basics.sh      | 84 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 132 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index a32f72aead..ef56ee0f1b 100644
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
@@ -88,6 +88,12 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
 
+--linearize::
+	In this mode, `git replay` imitates `git rebase --no-rebase-merges`,
+	i.e. it cherry-picks only non-merge commits, each one on top of the
+	previous one.
+	This option is incompatible with `--revert`.
+
 <revision-range>::
 	Range of commits to replay; see "Specifying Ranges" in
 	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
diff --git a/builtin/replay.c b/builtin/replay.c
index 39e3a86f6c..62962c73c7 100644
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
 
@@ -132,6 +134,8 @@ int cmd_replay(int argc,
 				  opts.contained, "--contained");
 	die_for_incompatible_opt2(!!opts.ref, "--ref",
 				  !!opts.contained, "--contained");
+	die_for_incompatible_opt2(!!opts.revert, "--revert",
+				  opts.linearize, "--linearize");
 
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
diff --git a/replay.c b/replay.c
index 86fba47fb9..d803e0312f 100644
--- a/replay.c
+++ b/replay.c
@@ -439,24 +439,38 @@ int replay_revisions(struct rev_info *revs,
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
 
-		/*
-		 * pick_regular_commit() looks up the parent of `commit` in
-		 * `replayed_commits` to determine the ancestor to replay onto.
-		 * The `default_base` parameter is used when no ancestor is found,
-		 * which happens for the first commit in the revision range.
-		 * When reverting, commits are replayed in reverse order, so the
-		 * lookup never succeeds, and we need to pass `last_commit`.
-		 */
-		struct commit *base = onto;
-		if (mode == REPLAY_MODE_REVERT)
-			base = last_commit;
-
-		if (commit->parents && commit->parents->next)
-			die(_("replaying merge commits is not supported yet!"));
-
-		last_commit = pick_regular_commit(revs->repo, commit, base,
-						  replayed_commits,
-						  &merge_opt, &result, mode, opts->empty);
+		if (commit->parents && commit->parents->next) {
+			if (!opts->linearize)
+				die(_("replaying merge commits is not supported yet!"));
+			/*
+			 * Drop the merge commit: do not pick it, leave
+			 * `last_commit` unchanged, and fall through to the
+			 * rest of the loop. As a result:
+			 * - the merge commit is mapped to `last_commit` in
+			 *   `replayed_commits`, this will become the parent for
+			 *   the child commits.
+			 * - refs previously pointing to the merge commit are
+			 *   rewritten to point to the previous non-merge commit.
+			 */
+		} else {
+			/*
+			 * pick_regular_commit() looks up the parent of `commit` in
+			 * `replayed_commits` to determine the ancestor to replay onto.
+			 * The `default_base` parameter is used when no ancestor is found,
+			 * which happens for the first commit in the revision range.
+			 * When reverting, commits are replayed in reverse order, so the
+			 * lookup never succeeds, and we need to pass `last_commit`.
+			 */
+			struct commit *base = onto;
+			if (mode == REPLAY_MODE_REVERT)
+				base = last_commit;
+
+			last_commit = pick_regular_commit(revs->repo, commit, base,
+							  replayed_commits,
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
index 3353bc4a4d..34c038eab9 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -52,8 +52,12 @@ test_expect_success 'setup' '
 	test_merge P O --no-ff &&
 	git switch main &&
 
+	git switch --orphan unrelated &&
+	test_commit unrelated-root &&
+
 	git switch -c conflict B &&
-	test_commit C.conflict C.t conflict
+	test_commit C.conflict C.t conflict &&
+	git branch -D unrelated
 '
 
 test_expect_success 'setup bare' '
@@ -97,6 +101,12 @@ test_expect_success '--advance and --contained cannot be used together' '
 	test_grep "cannot be used together" actual
 '
 
+test_expect_success '--revert and --linearize cannot be used together' '
+	test_must_fail git replay --revert=main --linearize \
+		topic1..topic2 2>actual &&
+	test_grep "cannot be used together" actual
+'
+
 test_expect_success 'cannot advance target ... ordering would be ill-defined' '
 	echo "fatal: ${SQ}--advance${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined" >expect &&
 	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
@@ -565,4 +575,76 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
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
+test_expect_success 'replay with --linearize to rebase multiple divergent branches' '
+	git replay --ref-action=print --linearize \
+		--onto main ^B topic2 topic-with-merge >result &&
+
+	test_line_count = 2 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
+	test_write_lines E D C M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
+	test_write_lines O N J I M L B A >expect &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.53.0.1323.g189a785ab5

