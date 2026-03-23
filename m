Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929303B8BD5
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282237; cv=none; b=SOMajyEqZE17xMeLV15yRfTmVfu+DmrQDKok/7P5+NJiDT+zhCiulKBsMZOU2EhQ6ndTOQlw2OEcltZn/BpGq4luFvZ3lW7epoXi3y+PPAJzMNqwYQLRvQxI4KsLtq5SMgElKQQqN9X4rcGhZUxsopPJYLCCBJgZGHeXE8x2ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282237; c=relaxed/simple;
	bh=Pj3bNvUCeaaVRw9jPbI6K3ZX9gPHejua20APAze7310=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwrhzgnRZoxM6E+t9QZl+O5MRwt4EAAuNZfqwFLUIaPe4kLwyJDat+eu2q2xNBj4uY6nSMm+n9hHCodk/uuNFsOmRT2qu/j2uL1yVg6rGJ5wRPK65ZhHXoiGGJFD3yV9bw34w679rqgqupmWH2+XXY4wcJmH+NPoOgJlVqj+4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2mkN9Fsl; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2mkN9Fsl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774282233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JvPVliZcdPwY63j06JpRaurpk0BipTJs5nD0MO1pESI=;
	b=2mkN9FslHuamDH426PVuoICwJKGbK5QShuf9Ef93Zg2hfUM11RRoaBNy7u/GZ5pFd/3QRr
	W3OWAX9uUwUnR6ihW4N++1SA+aG18v/d5OC/Y5VgGDxXJZ0iew5omlCxZmDkU09doYYqUJ
	tGS8PRH0VbF3U/QYxrrqZ4dcV8juzTc=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 23 Mar 2026 17:09:52 +0100
Subject: [PATCH 3/3] replay: allow to specify a ref with option --ref
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-toon-replay-arbitrary-ref-v1-3-5c7172f675ec@iotcl.com>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
In-Reply-To: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

To enable users to replay commits without having refs in
<revision-range> or as the value for --advance and --revert, start
accepting option --ref. When the user specifies a --ref, the refs from
the other option are ignored, and only the ref is acted on.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-replay.adoc | 21 ++++++++++++++-
 builtin/replay.c              |  9 ++++++-
 replay.c                      | 29 +++++++++++++++-----
 replay.h                      |  7 +++++
 t/t3650-replay-basics.sh      | 61 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index e4fef548e0..f90d93ae31 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
-			     [--ref-action=<mode>] <revision-range>
+			     [--ref=<branch>] [--ref-action=<mode>]
+			     <revision-range>
 
 DESCRIPTION
 -----------
@@ -62,6 +63,14 @@ the current user as the author, matching the behavior of `git revert`.
 This option is mutually exclusive with `--onto` and `--advance`. It is also
 incompatible with `--contained` (which is a modifier for `--onto` only).
 
+--ref <branch>::
+	Override which reference is updated with the result of the
+	replay. When used with `--onto`, only the specified reference
+	is updated instead of inferring refs from the revision range.
+	When used with `--advance` or `--revert`, the specified
+	reference is updated instead of the branch given to those
+	options. This option is incompatible with `--contained`.
+
 --contained::
 	Update all branches that point at commits in
 	<revision-range>. Requires `--onto`.
@@ -184,6 +193,16 @@ top of `main`, and updates `main` to point at the result. This is useful when
 commits from `topic` were previously merged or cherry-picked into `main` and
 need to be undone.
 
+To replay onto a specific commit while updating a different reference:
+
+------------
+$ git replay --onto 112233 --ref refs/heads/mybranch aabbcc..ddeeff
+------------
+
+This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
+`refs/heads/mybranch` to point at the result. This is useful when you want
+to use bare commit IDs instead of branch names.
+
 NOTE: For reverting an entire merge request as a single commit (rather than
 commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
 which can avoid unnecessary merge conflicts.
diff --git a/builtin/replay.c b/builtin/replay.c
index 2e9fd6281d..f4fc18d16f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -84,7 +84,8 @@ int cmd_replay(int argc,
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
-		   "[--ref-action=<mode>] <revision-range>"),
+		   "[--ref=<branch>] [--ref-action=<mode>]\n"
+		   "<revision-range>"),
 		NULL
 	};
 	struct option replay_options[] = {
@@ -102,6 +103,10 @@ int cmd_replay(int argc,
 			     PARSE_OPT_NONEG),
 		OPT_BOOL(0, "contained", &opts.contained,
 			 N_("update all branches that point at commits in <revision-range>")),
+		OPT_STRING_F(0, "ref", &opts.ref,
+			     N_("branch"),
+			     N_("reference to update with result"),
+			     PARSE_OPT_NONEG),
 		OPT_STRING_F(0, "ref-action", &ref_action,
 			     N_("mode"),
 			     N_("control ref update behavior (update|print)"),
@@ -121,6 +126,8 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt3(!!opts.onto, "--onto",
 				  !!opts.advance, "--advance",
 				  !!opts.revert, "--revert");
+	die_for_incompatible_opt2(!!opts.ref, "--ref",
+				  !!opts.contained, "--contained");
 	if (opts.contained && !opts.onto)
 		die(_("--contained requires --onto"));
 
diff --git a/replay.c b/replay.c
index 199066f6b3..07b94cddde 100644
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
 
@@ -358,6 +360,23 @@ int replay_revisions(struct rev_info *revs,
 	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
 			   &detached_head, &advance, &revert, &onto, &update_refs);
 
+	if (opts->ref) {
+		struct object_id oid;
+
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
@@ -393,7 +412,7 @@ int replay_revisions(struct rev_info *revs,
 		kh_value(replayed_commits, pos) = last_commit;
 
 		/* Update any necessary branches */
-		if (advance || revert)
+		if (ref)
 			continue;
 
 		for (decoration = get_name_decoration(&commit->object);
@@ -427,13 +446,9 @@ int replay_revisions(struct rev_info *revs,
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
index e916a5f975..99933f2268 100644
--- a/replay.h
+++ b/replay.h
@@ -24,6 +24,13 @@ struct replay_revisions_options {
 	 */
 	const char *onto;
 
+	/*
+	 * Reference to update with the result of the replay. This stops replay
+	 * from taking refs from `onto`, `advance`, and `revert`. Ignores
+	 * `contained`.
+	 */
+	const char *ref;
+
 	/*
 	 * Starting point at which to create revert commits; must be a branch
 	 * name. The branch will be updated to point to the revert commits.
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 47811b3197..b7465b5f18 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -500,4 +500,65 @@ test_expect_success 'git replay --revert incompatible with --advance' '
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
 test_done

-- 
2.53.0.310.g728cabbaf7

