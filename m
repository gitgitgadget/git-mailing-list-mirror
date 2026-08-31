Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CAF33D4E9
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182059; cv=none; b=f/i25+KcDjMVg18/P0mYJuASwnwYyTYbQCXEr/knL3giytPl5dFy8PViip33lYs9pmxRFXfa8ibAbZNqYxojiZk9UB++qCFagpHQtRQl0ubR2GHTolgGQfVgF0n4rjXfWVIhzkzmW8VM6oyilW9JsCluGX0aofqtrt2C/7QqE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182059; c=relaxed/simple;
	bh=hNRgz0g6A3HgNctHdyroKbT1pJ6RjFyr06bY1ShmT7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHVDMO4Gan+T/EQdgROUGO/4+ZG0ALBtbLZBtSj2iHW7gIW+7SNAH4y4RLO+Vwjgfyuj/AElbXCk/rDxuTaGabvliQLJD/eVo614sNQd4bWi4ygk0cj0OQvDDrNGIsmYzF1tKjxD8drotOqt/FKPTyWeLXTZ+PDHhESEhpyQpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=K/C/81uZ; arc=none smtp.client-ip=91.218.175.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="K/C/81uZ"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hNRgz0g6A3HgNctHdyroKbT1pJ6RjFyr06bY1ShmT7s=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788182055; v=1; x=1788786855;
 b=K/C/81uZCo7hgmob6rmREZUF5eStYXNXH7ZaE6dP9AnQm/bic0xnQ/pEQVexVujC6usMaXKt
 qA1yhQ0WVUm9XGi0ch9Fi7FYwzHB/v55baxiQ1kDcoe2TDZXzucoYjuw2KLsODHZhz2yoVY76PA
 hYmEuq9+XfHgPSBtXlse7vLE=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2f2b1e2c2b7dfe35;
	Mon, 31 Aug 2026 13:14:15 +0000
X-Mizu-Trace-ID: 2f2b1e2c2b7dfe35
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Mon, 31 Aug 2026 15:13:49 +0200
Subject: [PATCH v9 3/3] replay: offer an option to linearize the commit
 topology
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-toon-git-replay-drop-merges-v9-3-61c4232c6f36@iotcl.com>
References: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
In-Reply-To: <20260831-toon-git-replay-drop-merges-v9-0-61c4232c6f36@iotcl.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.16-dev-9febb

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

git-replay(1) accepts multiple branches, for example:

    $ git replay --onto main topic1 topic2

Without `--linearize` this replays 'topic1' and 'topic2' onto 'main'
(keeping shared portions of history shared and divergent parts
divergent) and updates both refs.

Due to current implementation limitations, replaying multiple branches
with `--linearize` is disallowed to avoid concatenating unrelated
histories into a single line. For the same reason disallow the use of
`--contained` with `--linearize`.

Users who want to linearize multiple branches are advised to do this in
separate git-replay(1) invocations. Linearizing multiple branches at
once might be added later.

Note that `--linearize` is not modeled after git-rebase(1)'s
`--rebase-merges[=<mode>]` interface. Recreating merges, by preserving
their topology, is a distinct operation that would be a separate mode.
`--linearize` only drops merges and replays commits linearly. So
git-replay(1) uses its own option rather than reusing that interface.

Based-on-patches-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-replay.adoc |  17 ++++++-
 builtin/replay.c              |   6 ++-
 replay.c                      |  60 +++++++++++++++--------
 replay.h                      |   5 ++
 t/t3650-replay-basics.sh      | 109 +++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 174 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index ea4d14badd..58b4c0c470 100644
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
@@ -91,6 +91,21 @@ Expanded description list compared to 'replay.refAction'.
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
 
+--linearize::
+	In this mode, each replayed commit is stacked on top of the
+	previously replayed one, so all replayed commits are flattened into
+	a single linear history.
++
+When a merge commit is encountered, all commits in the range reachable
+from the merge commit are replayed into the linear history, and the
+merge commit itself is dropped. A ref that pointed to a merge commit is
+updated to the merge's last replayed ancestor. (This matches the
+behavior of git-rebase(1)'s `--no-rebase-merges` option.)
++
+`--linearize` cannot be combined with multiple branches or with
+`--contained`. To linearize several branches, replay them in separate
+`git replay` invocations.
+
 <revision-range>::
 	Range of commits to replay; see "Specifying Ranges" in
 	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
diff --git a/builtin/replay.c b/builtin/replay.c
index 39e3a86f6c..d39626a37d 100644
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
+	die_for_incompatible_opt2(opts.linearize, "--linearize",
+				  !!opts.contained, "--contained");
 
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
diff --git a/replay.c b/replay.c
index 7e35f40d37..6565e4d215 100644
--- a/replay.c
+++ b/replay.c
@@ -404,6 +404,12 @@ int replay_revisions(struct rev_info *revs,
 	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
 			   &detached_head, &advance, &revert, &onto, &update_refs);
 
+	if (opts->linearize &&
+	    update_refs && strset_get_size(update_refs) > 1) {
+		ret = error(_("'--linearize' cannot be used with multiple branches"));
+		goto out;
+	}
+
 	if (opts->ref) {
 		struct object_id oid;
 
@@ -437,26 +443,40 @@ int replay_revisions(struct rev_info *revs,
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
index 491db145e3..2c71afbfde 100644
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
index 3353bc4a4d..d3409b9bb1 100755
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
@@ -565,4 +576,100 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
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
+test_expect_success '--linearize rejects multiple branches' '
+	test_must_fail git replay --ref-action=print --linearize \
+		--onto main ^B topic2 topic3 topic4 2>err &&
+	test_grep "cannot be used with multiple branches" err
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
+test_expect_success '--linearize and --contained cannot be used together' '
+	test_must_fail git replay --ref-action=print --linearize --contained \
+		--onto main ^B topic-with-merge 2>err &&
+	test_grep "cannot be used together" err
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
2.55.0.679.g6767b8d81c

