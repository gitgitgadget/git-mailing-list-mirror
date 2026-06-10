Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF813290C9
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103018; cv=none; b=CmwFwW2k9FVFc2asRxPMkFR/79wvxkgI5ET/z2iWkivv8rV9TIkq8Zh6GtJP3qLkAvZaoodma3y4/SIk3qd6vRo0qvDMhAZeZ03fQJHh81cstAhBlQoVWx8l8P86JTCiUqcDsJKWhzgZpy0P2mSvKrAqOdJz4a+TJXk7NwQsHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103018; c=relaxed/simple;
	bh=Qzd68nybbZtoaXDmqMjBtM5mM7051ucy3GJq2fuUCTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyOVp/HVvwPpmDe4PI5yiX1thSKGIYUM6lY/wX4LjJna+qaISTI4LdpXWOUh/5l8DCkWO8EVIXF6EdSljwGFp8a8LJVMv7ip8gS4o3oezUDu5zrHTNNvdoKIYZdkH5CDqLrzmF6bIMueYk6Hx0VFdZSw2OnvSiMkuHjAYgPTp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=veq0VW5n; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="veq0VW5n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781103015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbeB42mHJ18h0spOyiLjhu/UUyL4qbMq06zubWOdJIc=;
	b=veq0VW5nXtvTz1cEr31XM6Un1dz8RUfqf58/8DrCca5JD2R2Od9Hm9JFODzaFSsH8/njqf
	yNZtKqVsMcYrD6cF9+jlj31izGVVL4BmFgjbSc0ed79+PcaNDcr2oXHZS4SmYhYtOjWYmb
	Zj19o/hIfmS1/laUqOVKsjBsJiRKNMQ=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 10 Jun 2026 16:49:14 +0200
Subject: [PATCH v2 3/3] replay: offer an option to linearize the commit
 topology
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-toon-git-replay-drop-merges-v2-3-5714a71c6d83@iotcl.com>
References: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
In-Reply-To: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
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
 Documentation/git-replay.adoc |  5 +++++
 builtin/replay.c              |  4 ++++
 replay.c                      | 30 +++++++++++++++++++++++-------
 replay.h                      |  5 +++++
 t/t3650-replay-basics.sh      | 26 ++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index a32f72aead..41c96c7061 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -88,6 +88,11 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
 
+--linearize::
+	In this mode, `git replay` imitates `git rebase --no-rebase-merges`,
+	i.e. it cherry-picks only non-merge commits, each one on top of the
+	previous one.
+
 <revision-range>::
 	Range of commits to replay; see "Specifying Ranges" in
 	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
diff --git a/builtin/replay.c b/builtin/replay.c
index 39e3a86f6c..fedfe46dc6 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -111,6 +111,8 @@ int cmd_replay(int argc,
 			     N_("mode"),
 			     N_("control ref update behavior (update|print)"),
 			     PARSE_OPT_NONEG),
+		OPT_BOOL(0, "linearize", &opts.linearize,
+			 N_("ignore merge commits instead of replaying them")),
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
index 7921d7dba3..81033fb889 100644
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
 
@@ -430,12 +435,23 @@ int replay_revisions(struct rev_info *revs,
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
 
-		if (commit->parents && commit->parents->next)
-			die(_("replaying merge commits is not supported yet!"));
+		if (commit->parents && commit->parents->next) {
+			if (!opts->linearize)
+				die(_("replaying merge commits is not supported yet!"));
+			/*
+			 * When linearizing, a merge commit itself is not picked,
+			 * but refs that point to it might need updating.
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
index 3353bc4a4d..64e0731188 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -565,4 +565,30 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
 	test_grep "cannot be used with multiple revision ranges" err
 '
 
+test_expect_success 'replay merge commit fails' '
+	echo "fatal: replaying merge commits is not supported yet!" >expect &&
+	test_must_fail git replay --ref-action=print --onto main I..P 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay to rebase merge commit with --linearize' '
+	git replay --ref-action=print --linearize --onto main I..topic-with-merge >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines O N J M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replay to rebase merge commit with --linearize down to root commit' '
+	git replay --ref-action=print --linearize --onto main A..topic-with-merge >result &&
+
+	test_line_count = 1 result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines O N J I M L B A >expect &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.53.0.1323.g189a785ab5

