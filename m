Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCD394E93
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132147; cv=none; b=WeZ++XOqrX1r3v069WXyYPNTmBzk4WF/VdkiYusyz9Txn12jNS5ifz/PEtBZqKGDLblP9JTsfakNwkelprsmB3yM3qlLoS7XUO45i/sUIxXjVewJ7wKwkrqPESz7S6M8dMLqvZBqIGUv/aTcqOA6CFPxuEREqDaJqjxclOyO5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132147; c=relaxed/simple;
	bh=9wECkWtAs6rTpXotu0lPdzbXGLtPgTNLf5t4dkj9q24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQSW1ifMLYuasZk0e8RVGH7j+eKGbXh4WbLruv4vV7xuQ8Nf8uTije8PIX7H+vCLx2XHZ5Mcah1golonu36HYIfxSYKo3ucWOzagsCC8Sj0z7rE9Vz1sLLTZyaWd7v1SfHSUtg9mk/98Jvap1UoTmy5g8mm4KplvApdLLtqsp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=apc66ssm; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="apc66ssm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782132144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HhM1dKzqOqqZdDoXjC8eLDFxx9LFIw9k6LdZfhdY0c=;
	b=apc66ssmWMKSucNU9DuQl0VLQTKPppaPYBnwKCi/hbhvC7dU1acpmLzQllmLrvwqUKeP7c
	7Y+7XmywxTyDkGvN4HIUoS2vnoH6W787XawJEvlhudoGfTpTlsUdvn4AMS0kJJ1EJWy1xr
	1/2lv/NvCNIKTjLb48irRS6lIqKe/fc=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 22 Jun 2026 14:41:57 +0200
Subject: [PATCH v4 3/3] replay: offer an option to linearize the commit
 topology
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-toon-git-replay-drop-merges-v4-3-ff257f534319@iotcl.com>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
In-Reply-To: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
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
 replay.c                      | 32 +++++++++++++++-----
 replay.h                      |  5 ++++
 t/t3650-replay-basics.sh      | 68 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 109 insertions(+), 10 deletions(-)

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
index 7921d7dba3..5539daff00 100644
--- a/replay.c
+++ b/replay.c
@@ -277,12 +277,16 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct commit *onto,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
+					  struct commit *replayed_base,
 					  bool reverse,
 					  enum replay_empty_commit_action empty)
 {
-	struct commit *base, *replayed_base;
+	struct commit *base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
+	if (replayed_base && reverse)
+		BUG("Linearizing commits is not supported when replaying in reverse");
+
 	if (pickme->parents) {
 		base = pickme->parents->item;
 		base_tree = repo_get_commit_tree(repo, base);
@@ -291,7 +295,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		base_tree = lookup_tree(repo, repo->hash_algo->empty_tree);
 	}
 
-	replayed_base = get_mapped_commit(replayed_commits, base, onto);
+	if (!replayed_base)
+		replayed_base = get_mapped_commit(replayed_commits, base, onto);
 	replayed_base_tree = repo_get_commit_tree(repo, replayed_base);
 	pickme_tree = repo_get_commit_tree(repo, pickme);
 
@@ -430,12 +435,25 @@ int replay_revisions(struct rev_info *revs,
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
 
-		if (commit->parents && commit->parents->next)
-			die(_("replaying merge commits is not supported yet!"));
+		if (commit->parents && commit->parents->next) {
+			if (!opts->linearize)
+				die(_("replaying merge commits is not supported yet!"));
+			/*
+			 * Drop the merge commit: do not pick it and leave
+			 * last_commit unchanged, so its children (and any ref
+			 * pointing at it) are reparented onto the previous
+			 * non-merge commit, which the ref-update loop below uses.
+			 */
+		} else {
+			struct commit *to_pick = reverse ? last_commit : onto;
+			last_commit =
+				pick_regular_commit(revs->repo, commit,
+						    replayed_commits, to_pick,
+						    &merge_opt, &result,
+						    opts->linearize ? last_commit : NULL,
+						    reverse, opts->empty);
+		}
 
-		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
-						  reverse ? last_commit : onto,
-						  &merge_opt, &result, reverse, opts->empty);
 		if (!last_commit)
 			break;
 
diff --git a/replay.h b/replay.h
index 1851a07705..07e6fdcca3 100644
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
index 3353bc4a4d..b9ce6c4868 100755
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
@@ -565,4 +575,60 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
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
 test_done

-- 
2.53.0.1323.g189a785ab5

