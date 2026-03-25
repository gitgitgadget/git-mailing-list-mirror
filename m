Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAD3ED122
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454414; cv=none; b=eST6ykyhdmsflS3+8XQJdRoV09pxXoQQQ8NVhaXM+KpGqf0L6oAmzO9VtQh8U4Ow6FknboS5t7nUvlddV92DCEh93l/KzDickeZ0pMvtweTvz6u44KWYH6tv1W4dzmCP32GWHVPjr1t0cuKhhfKlLoP8opl+80zPUTaQihE5FM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454414; c=relaxed/simple;
	bh=KifXiXpfo61p4T/QJ+RlDFeJc9Ts6BwXB2cnXk9TUfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mj3ZUsA8V03kI9g35C0uwy2GfJ62wJKN7nIFd2HdVTRKAoD4TDf9mQPriruiJgxbd/9KuqmGeUlwB2PPy7vx/jVqNMHxtaPqEimwfssdOVrE1tG58bWzfc8+HVZfJl+NaSHjKtBxEptNaG5aeiV/UIitLHCUayndGoIwuPS5b3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Pukeha94; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Pukeha94"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774454411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ix73S7LiM6hzk8b0WxJ7CtE5DWOsbFof1V3ilXD5es=;
	b=Pukeha9481qeqyySZlv4XRIB2GwRh8qNmE2hiTAVBhN3mnDY7XQStY2MZkDFf2U680tLq8
	BQCLSgf27ZvpPj6uXnildEzXX198tUg5Uavj2uqIJv4pNp/hXiXJGdPaEpNkfry9S9QoSC
	0GYhKnMy+eY2WRoW+ccSfC+5ZwSRtv4=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 25 Mar 2026 16:59:31 +0100
Subject: [PATCH v2 3/3] replay: allow to specify a ref with option --ref
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-toon-replay-arbitrary-ref-v2-3-553038702c9c@iotcl.com>
References: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
In-Reply-To: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When option '--onto' is passed to git-replay(1), the command will update
refs from the <revision-range> passed to the command. When using option
'--advance' or '--revert', the argument of that option is a ref that
will be updated.

To enable users to specify which ref to update, add option '--ref'. When
using option '--ref', the refs described above are left untouched and
instead the argument of this option is updated instead.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-replay.adoc | 21 +++++++++++++-
 builtin/replay.c              |  8 +++++-
 replay.c                      | 33 +++++++++++++++++-----
 replay.h                      |  7 +++++
 t/t3650-replay-basics.sh      | 66 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 7e749a0477..5952ecb50d 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
-			     [--ref-action=<mode>] <revision-range>
+			     [--ref=<branch>] [--ref-action=<mode>] <revision-range>
 
 DESCRIPTION
 -----------
@@ -66,6 +66,15 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Update all branches that point at commits in
 	<revision-range>. Requires `--onto`.
 
+--ref=<branch>::
+	Override which reference is updated with the result of the replay.
+	When used with `--onto`, the `<revision-range>` should have a
+	single tip and only the specified reference is updated instead of
+	inferring refs from the revision range.
+	When used with `--advance` or `--revert`, the specified reference is
+	updated instead of the branch given to those options. This option is
+	incompatible with `--contained`.
+
 --ref-action[=<mode>]::
 	Control how references are updated. The mode can be:
 +
@@ -188,6 +197,16 @@ NOTE: For reverting an entire merge request as a single commit (rather than
 commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
 which can avoid unnecessary merge conflicts.
 
+To replay onto a specific commit while updating a different reference:
+
+------------
+$ git replay --onto=112233 --ref=refs/heads/mybranch aabbcc..ddeeff
+------------
+
+This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
+`refs/heads/mybranch` to point at the result. This can be useful when you want
+to use bare commit IDs instead of branch names.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index a5f81b67d4..876026549e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -84,7 +84,7 @@ int cmd_replay(int argc,
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
-		   "[--ref-action=<mode>] <revision-range>"),
+		   "[--ref=<branch>] [--ref-action=<mode>] <revision-range>"),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -102,6 +102,10 @@ int cmd_replay(int argc,
 			     N_("branch"),
 			     N_("revert commits onto given branch"),
 			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "ref", &opts.ref,
+			     N_("branch"),
+			     N_("reference to update with result"),
+			     PARSE_OPT_NONEG),
 		OPT_STRING_F(0, "ref-action", &ref_action,
 			     N_("mode"),
 			     N_("control ref update behavior (update|print)"),
@@ -121,6 +125,8 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt3(!!opts.onto, "--onto",
 				  !!opts.advance, "--advance",
 				  !!opts.revert, "--revert");
+	die_for_incompatible_opt2(!!opts.ref, "--ref",
+				  !!opts.contained, "--contained");
 	if (opts.contained && !opts.onto)
 		die(_("--contained requires --onto"));
 
diff --git a/replay.c b/replay.c
index 199066f6b3..63cec56d48 100644
--- a/replay.c
+++ b/replay.c
@@ -348,6 +348,8 @@ int replay_revisions(struct rev_info *revs,
 	bool detached_head;
 	char *advance;
 	char *revert;
+	const char *ref;
+	struct object_id old_oid;
 	enum replay_mode mode = REPLAY_MODE_PICK;
 	int ret;
 
@@ -358,6 +360,27 @@ int replay_revisions(struct rev_info *revs,
 	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
 			   &detached_head, &advance, &revert, &onto, &update_refs);
 
+	if (opts->ref) {
+		struct object_id oid;
+
+		if (update_refs && strset_get_size(update_refs) > 1) {
+			ret = error(_("'--ref' cannot be used with multiple revision ranges"));
+			goto out;
+		}
+		if (check_refname_format(opts->ref, 0) || !starts_with(opts->ref, "refs/")) {
+			ret = error(_("'%s' is not a valid refname"), opts->ref);
+			goto out;
+		}
+		ref = opts->ref;
+		if (!refs_read_ref(get_main_ref_store(revs->repo), opts->ref, &oid))
+			oidcpy(&old_oid, &oid);
+		else
+			oidclr(&old_oid, revs->repo->hash_algo);
+	} else {
+		ref = advance ? advance : revert;
+		oidcpy(&old_oid, &onto->object.oid);
+	}
+
 	/* FIXME: Should allow replaying commits with the first as a root commit */
 
 	if (prepare_revision_walk(revs) < 0) {
@@ -393,7 +416,7 @@ int replay_revisions(struct rev_info *revs,
 		kh_value(replayed_commits, pos) = last_commit;
 
 		/* Update any necessary branches */
-		if (advance || revert)
+		if (ref)
 			continue;
 
 		for (decoration = get_name_decoration(&commit->object);
@@ -427,13 +450,9 @@ int replay_revisions(struct rev_info *revs,
 		goto out;
 	}
 
-	/* In --advance or --revert mode, update the target ref */
-	if (advance || revert) {
-		const char *ref = advance ? advance : revert;
-		replay_result_queue_update(out, ref,
-					   &onto->object.oid,
+	if (ref)
+		replay_result_queue_update(out, ref, &old_oid,
 					   &last_commit->object.oid);
-	}
 
 	ret = 0;
 
diff --git a/replay.h b/replay.h
index e916a5f975..0ab74b9805 100644
--- a/replay.h
+++ b/replay.h
@@ -24,6 +24,13 @@ struct replay_revisions_options {
 	 */
 	const char *onto;
 
+	/*
+	 * Reference to update with the result of the replay. This will not
+	 * update any refs from `onto`, `advance`, or `revert`. Ignores
+	 * `contained`.
+	 */
+	const char *ref;
+
 	/*
 	 * Starting point at which to create revert commits; must be a branch
 	 * name. The branch will be updated to point to the revert commits.
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 0c1e03e0fb..938be64770 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -500,4 +500,70 @@ test_expect_success 'git replay --revert incompatible with --advance' '
 	test_grep "cannot be used together" error
 '
 
+test_expect_success 'using --onto with --ref' '
+	git branch test-ref-onto topic2 &&
+	test_when_finished "git branch -D test-ref-onto" &&
+
+	git replay --ref-action=print --onto=main --ref=refs/heads/test-ref-onto topic1..topic2 >result &&
+
+	test_line_count = 1 result &&
+	test_grep "^update refs/heads/test-ref-onto " result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'using --advance with --ref' '
+	git branch test-ref-advance main &&
+	git branch test-ref-target main &&
+	test_when_finished "git branch -D test-ref-advance test-ref-target" &&
+
+	git replay --ref-action=print --advance=test-ref-advance --ref=refs/heads/test-ref-target topic1..topic2 >result &&
+
+	test_line_count = 1 result &&
+	test_grep "^update refs/heads/test-ref-target " result
+'
+
+test_expect_success 'using --revert with --ref' '
+	git branch test-ref-revert topic4 &&
+	git branch test-ref-revert-target topic4 &&
+	test_when_finished "git branch -D test-ref-revert test-ref-revert-target" &&
+
+	git replay --ref-action=print --revert=test-ref-revert --ref=refs/heads/test-ref-revert-target topic4~1..topic4 >result &&
+
+	test_line_count = 1 result &&
+	test_grep "^update refs/heads/test-ref-revert-target " result
+'
+
+test_expect_success '--ref is incompatible with --contained' '
+	test_must_fail git replay --onto=main --ref=refs/heads/main --contained topic1..topic2 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success '--ref with nonexistent fully-qualified ref' '
+	test_when_finished "git update-ref -d refs/heads/new-branch" &&
+
+	git replay --onto=main --ref=refs/heads/new-branch topic1..topic2 &&
+
+	git log --format=%s -2 new-branch >actual &&
+	test_write_lines E D >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--ref must be a valid refname' '
+	test_must_fail git replay --onto=main --ref="refs/heads/bad..ref" topic1..topic2 2>err &&
+	test_grep "is not a valid refname" err
+'
+
+test_expect_success '--ref requires fully qualified ref' '
+	test_must_fail git replay --onto=main --ref=main topic1..topic2 2>err &&
+	test_grep "is not a valid refname" err
+'
+
+test_expect_success '--onto with --ref rejects multiple revision ranges' '
+	test_must_fail git replay --onto=main --ref=refs/heads/topic2 ^topic1 topic2 topic4 2>err &&
+	test_grep "cannot be used with multiple revision ranges" err
+'
+
 test_done

-- 
2.53.0.310.g728cabbaf7

