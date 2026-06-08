Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0F3DCDBD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943887; cv=none; b=AKlrPqQF0h+AgpoYs5fzEhDjbEBFF52OAeMkGG/BoEbe9AcutVoPsLyTcW3YAaetnYGqhhx1h5E884LeF0M2PNONeKIiLBPFva5a9MUzoNDx1Ff6AgSlROex9BruZxPFf5i+tLcZfzb+z4MuGJ6PS4MWnMdyv3S8pTflS+Eensw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943887; c=relaxed/simple;
	bh=sPBgY6XNxfMo6GEMa4kgRYAOQDA6EjU5GjqziNLVZzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ul19JEwchNIXeBkVNwPyEKJ+AY0m59/3KrNSdzEv2oTeSwBPQ9gKs3IDhe/K4LmtDSdcN2KLANh+6iJp8NIrmqVFMXFDHEvuZBTOlVn7mmVSFSEeBpGtYoQILiPJngk+TeL1n/wiJEPMqMBIewG6my4in3G7n6/RUuuguJ/TAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ClwzSp7J; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ClwzSp7J"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1780943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2p9XhgHbnM8jAo/mFoEcNWuAheMPgAJIYPgRNfVScYA=;
	b=ClwzSp7J8T8zr+e890vhP4xBLpPdRyUt1D7Zhtyg1qJGwIXNYe4MeCCbeoz5CrIz5wforh
	CmJjbwqPiaexWQAMoAl4yJWnUgE1bZ07cs6pGT3A7T50JhDzZAf7eQrjwfvtotJP7PuOa5
	MAETF2ZLbMq3bAqbt0+AdnOQvUzFgz4=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 08 Jun 2026 20:37:21 +0200
Subject: [PATCH 3/3] replay: offer an option to linearize the commit
 topology
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-toon-git-replay-drop-merges-v1-3-e3ee71fce7b4@iotcl.com>
References: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
In-Reply-To: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Migadu-Flow: FLOW_OUT

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

One of the stated goals of git-replay(1) is to allow implementing the
git-rebase(1) functionality on the server side.

The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
was given. This mode drops merge commits instead of replaying them, and
linearized the commit history into a sequence of the
regular (single-parent) commits.

Add option `--linearize` to git-replay(1) do the same.

Co-authored-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-replay.adoc |  5 +++++
 builtin/replay.c              |  4 ++++
 replay.c                      | 25 +++++++++++++++++++------
 replay.h                      |  5 +++++
 t/t3650-replay-basics.sh      | 22 ++++++++++++++++++++++
 5 files changed, 55 insertions(+), 6 deletions(-)

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
index 7921d7dba3..3e36908131 100644
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
 
@@ -430,12 +435,20 @@ int replay_revisions(struct rev_info *revs,
 	while ((commit = get_revision(revs))) {
 		const struct name_decoration *decoration;
 
-		if (commit->parents && commit->parents->next)
+		if (opts->linearize && (!commit->parents || commit->parents->next))
+			; /* map current commit to the same as the previous commit */
+		else if (commit->parents && commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
+		else {
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
index 3353bc4a4d..c781a3bb1b 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -565,4 +565,26 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
 	test_grep "cannot be used with multiple revision ranges" err
 '
 
+test_expect_success 'linearize the commit topology' '
+	test_tick &&
+	N=$(git commit-tree -m N -p L -p I L:) &&
+	N=$(git commit-tree -m N-child -p $N L:) &&
+	git update-ref refs/heads/N $N &&
+
+	git replay --ref-action=print --linearize \
+		--onto A B..refs/heads/N >out &&
+
+	test_line_count = 1 out &&
+	read N1 N2 N3 N4 <out &&
+
+	cat >expect <<-EOF &&
+	* N-child
+	* I
+	* L
+	o A
+	EOF
+	git log --format=%s --graph --boundary A...$N3 >actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.53.0.1323.g189a785ab5

