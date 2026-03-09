Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA340F8DE
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084679; cv=none; b=JcQyDZdtjhm5qzACUX/7k5+RR81fkUHKaJykeKzYCgvQMMOaWNOhqPdjo1E5kvTTOp0czgJFQ6ZU3NQm3o/dT1817RB3Zzh7oeUEjwaosgsWWo5KlpevR61c0lVDGWLX7Qq20gOpdLj6dl2uAyLdWQ2Ugf1ntQ7t2vCJDBRXLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084679; c=relaxed/simple;
	bh=Jq7IhHjRpD6WM5cnLtB/hPpyu8GX41MdT8+GKqu5RVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bMJMte2g3R7ull5mdSkCy4+UHtFLGvccEVt8sM/6/oIG5Jv6tBg1KFCK2L8r0Mt2vL9xoCxzwdTjQqitmTn9q/BExFyK/5M1PLT0I9cR5TNBoOod50Bn2vH588Va11iFoMwUbkpIAoOcWcZCckt0PU6bI8ljKQg7zZ1TQ5KW6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sXPUHdqz; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sXPUHdqz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773084672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8P0NU5Mo8FdwaCe40+4JaPnTeBsGJ9GNHSMCJghIRFo=;
	b=sXPUHdqzz2sy2kWzdxs74c3Ub9T0ELGZpwZr06g9+b59tyflEKM7Jk4ONzzNVS7muRmKqx
	aHrmIonOgowqwBY8V+8grW7Ia2UxdZUGLTV+oO3aedKLHckXswFxFM2yia1+f6h8/uXn+r
	zmruwrJ9URGp+f4Fv3TFFajnK1Q/t2s=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 09 Mar 2026 20:30:57 +0100
Subject: [PATCH RFC] git-replay: implement subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-toon-replay-subcommands-v1-1-864ec82ef68a@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB1Io6S2VxEXMY51RBPJ2NIi3
 t1Ylx+8928gFJkEntkGkT4sHHzCLc/ADda/CLlLBq20UYV64BqCx0jLZH8o79aFeba+E6zKsi0
 c3bXRBtJ7idTz91+um8tpPpJbzxzs+wHLgakEewAAAA==
X-Change-ID: 20260309-toon-replay-subcommands-844b3ce72626
To: git@vger.kernel.org
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

git-replay(1) has various operation modes. The mode depends on which of
the options `--onto`, `--advance`, or `--revert` is given. These options
are mutually exclusive. This usage pattern is counterintuitive and
uncommon for Git commands to behave this way.

Implement subcommands into git-replay(1):

* `rebase`: This replaces what `--onto=` used to do.
* `pick`: This replaces what `--advance=` used to do.
* `revert`: This replaces what `--revert=` used to do.

Option `--onto` is still accepted. It's mandatory for the `rebase`
subcommand and needs to be used in the exact same way.

Option `--ref` is added and required for the `pick` and `revert`
subcommands. This replaces what `--advance` and `--revert` used to do,
but as a single uniform option for all subcommands.

The `rebase` subcommand also accepts option `--ref`, and when given this
is the ref that's updated with the outcome of the git-replay(1) command.
Thus following commands are identical:

    $ git replay rebase --onto=master master..branch-1

    $ git replay rebase --onto=master master..branch-1^{0} --ref=refs/heads/branch-1

In the second example the upper boundary of the revision range is peeled
down to a commit (using '^{0}'). Without option `--ref`, git-replay(1)
doesn't know which ref to update, that's why `--ref` is passed
explicitly.

For the subcommands `pick` and `revert` it's also possible to combine
`--ref` and `--onto`. Here are again two identical examples:

    $ git replay pick --onto=branch-1 master..aabbccdd

    $ git replay pick --onto=branch-1^{0} master..aabbccdd --ref=refs/heads/branch-1

In the latter the argument for `--onto` is peeled down to a commit, so
the command doesn't know which ref to update. To inform git-replay(1)
which refs should be updated, it's passed explicitly as option `--ref`.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
In the patch series by Siddharth Asthana[1] the option `--revert` is
added to git-replay(1). This is implemented as option `--revert`, next
to the existing options `--advance` and `--onto`.

The usage of these options is mutually exclusive, so the user can only
use one of them, and depending on which one, git-replay(1) selects a
"mode of operating".

Various people have raised this behavior is somewhat confusing. In this
series we attempt to make the usage of git-replay(1) more intuitive and
user-friendly by implementing the modes as subcommands.

This patch is submitted as an RFC to gather feedback about the design.
All changes are implemented as a single patch right now, and thus
reviewing the changes might be challenging. When we got people aligned
on the direction, I'll work toward cleaner patches.

These changes are based on 'master' at 864f55e190 (The second batch,
2026-02-09) with the patches of Siddharth[1] applied: 'sa/replay-revert'
at f79189a653 (replay: add --revert mode to reverse commit changes,
2026-02-19)

[1]: 20260218234215.89326-3-siddharthasthana31@gmail.com
---
 Documentation/git-replay.adoc | 124 ++++++++++++++++----------
 builtin/replay.c              | 150 ++++++++++++++++++++++++-------
 replay.c                      |  66 +++++++-------
 replay.h                      |  31 +++----
 t/t3650-replay-basics.sh      | 199 +++++++++++++++++++++++-------------------
 5 files changed, 349 insertions(+), 221 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index ffdf790278..a7e8dac23f 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -8,8 +8,13 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 
 SYNOPSIS
 --------
-[verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
+[synopsis]
+git replay rebase --onto <newbase> [--ref <branch>] [--contained]
+		[--ref-action[=<mode>]] <revision-range>
+git replay pick --ref <branch> [--onto <newbase>]
+		[--ref-action[=<mode>]] <revision-range>
+git replay revert --ref <branch> [--onto <newbase>]
+		[--ref-action[=<mode>]] <revision-range>
 
 DESCRIPTION
 -----------
@@ -23,49 +28,62 @@ instead get update commands that can be piped to `git update-ref --stdin`
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
-OPTIONS
--------
-
---onto <newbase>::
-	Starting point at which to create the new commits.  May be any
-	valid commit, and not just an existing branch name.
-+
-When `--onto` is specified, the branch(es) in the revision range will be
-updated to point at the new commits, similar to the way `git rebase --update-refs`
-updates multiple branches in the affected range.
-
---advance <branch>::
-	Starting point at which to create the new commits; must be a
-	branch name.
-+
-The history is replayed on top of the <branch> and <branch> is updated to
-point at the tip of the resulting history. This is different from `--onto`,
-which uses the target only as a starting point without updating it.
+SUBCOMMANDS
+-----------
 
---revert <branch>::
-	Starting point at which to create the reverted commits; must be a
-	branch name.
-+
-When `--revert` is specified, the commits in the revision range are reverted
-(their changes are undone) and the reverted commits are created on top of
-<branch>. The <branch> is then updated to point at the new commits. This is
-the same as running `git revert <revision-range>` but does not update the
-working tree.
+`rebase`::
+	Replay commits onto a new base, similar to `git rebase`. The
+	`--onto` option is required to specify the new base. When `--ref`
+	is not given, the branch(es) in the revision range will be updated
+	to point at the new commits, similar to the way
+	`git rebase --update-refs` updates multiple branches in the
+	affected range. When `--ref` is given, only that reference is
+	updated.
+
+`pick`::
+	Cherry-pick commits onto a branch. The `--ref` option is required
+	to specify which branch to update. The history is replayed on top
+	of the commit pointed to by `--ref` (or `--onto` if given) and
+	`--ref` is updated to point at the tip of the resulting history.
+
+`revert`::
+	Revert commits onto a branch. The `--ref` option is required to
+	specify which branch to update. The commits in the revision range
+	are reverted (their changes are undone) and the reverted commits
+	are created on top of the commit pointed to by `--ref` (or `--onto`
+	if given). The `--ref` is then updated to point at the new commits.
 +
 The commit messages follow `git revert` conventions: they are prefixed with
 "Revert" and include "This reverts commit <hash>." When reverting a commit
 whose message starts with "Revert", the new message uses "Reapply" instead.
 Unlike cherry-pick which preserves the original author, revert commits use
 the current user as the author, matching the behavior of `git revert`.
+
+OPTIONS
+-------
+
+`--onto=<newbase>`::
+	Starting point at which to create the new commits. May be any
+	valid commit, and not just an existing branch name.
++
+For the `rebase` subcommand, this option is required.
+For the `pick` and `revert` subcommands, this option is optional; when
+omitted, commits are replayed on top of the commit pointed to by `--ref`.
+
+`--ref=<branch>`::
+	Reference to update with the result of the replay. Must be a
+	valid reference name.
 +
-This option is mutually exclusive with `--onto` and `--advance`. It is also
-incompatible with `--contained` (which is a modifier for `--onto` only).
+For the `pick` and `revert` subcommands, this option is required.
+For the `rebase` subcommand, this option is optional; when omitted, refs
+are inferred from the revision range.
 
---contained::
+`--contained`::
 	Update all branches that point at commits in
-	<revision-range>. Requires `--onto`.
+	<revision-range>. Only valid for the `rebase` subcommand when
+	`--ref` is not set.
 
---ref-action[=<mode>]::
+`--ref-action[=<mode>]`::
 	Control how references are updated. The mode can be:
 +
 --
@@ -77,11 +95,11 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
 
-<revision-range>::
+`<revision-range>`::
 	Range of commits to replay; see "Specifying Ranges" in
-	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
+	linkgit:git-rev-parse[1]. In `pick` and `revert` modes, the
 	range should have a single tip, so that it's clear to which tip the
-	advanced <branch> should point. Any commits in the range whose
+	updated `--ref` should point. Any commits in the range whose
 	changes are already present in the branch the commits are being
 	replayed onto will be dropped.
 
@@ -103,10 +121,10 @@ When using `--ref-action=print`, the output is usable as input to
 	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
 
 where the number of refs updated depends on the arguments passed and
-the shape of the history being replayed.  When using `--advance` or
-`--revert`, the number of refs updated is always one, but for `--onto`,
-it can be one or more (rebasing multiple branches simultaneously is
-supported).
+the shape of the history being replayed.  When using `pick` or
+`revert`, the number of refs updated is always one, but for `rebase`
+without `--ref`, it can be one or more (rebasing multiple branches
+simultaneously is supported).
 
 There is no stderr output on conflicts; see the <<exit-status,EXIT
 STATUS>> section below.
@@ -126,7 +144,7 @@ EXAMPLES
 To simply rebase `mybranch` onto `target`:
 
 ------------
-$ git replay --onto target origin/main..mybranch
+$ git replay rebase --onto target origin/main..mybranch
 ------------
 
 The refs are updated atomically and no output is produced on success.
@@ -134,14 +152,14 @@ The refs are updated atomically and no output is produced on success.
 To see what would be updated without actually updating:
 
 ------------
-$ git replay --ref-action=print --onto target origin/main..mybranch
+$ git replay rebase --ref-action=print --onto target origin/main..mybranch
 update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
 ------------
 
 To cherry-pick the commits from mybranch onto target:
 
 ------------
-$ git replay --advance target origin/main..mybranch
+$ git replay pick --ref target origin/main..mybranch
 ------------
 
 Note that the first two examples replay the exact same commits and on
@@ -153,18 +171,18 @@ What if you have a stack of branches, one depending upon another, and
 you'd really like to rebase the whole set?
 
 ------------
-$ git replay --contained --onto origin/main origin/main..tipbranch
+$ git replay rebase --contained --onto origin/main origin/main..tipbranch
 ------------
 
 All three branches (`branch1`, `branch2`, and `tipbranch`) are updated
 atomically.
 
-When calling `git replay`, one does not need to specify a range of
+When calling `git replay rebase`, one does not need to specify a range of
 commits to replay using the syntax `A..B`; any range expression will
 do:
 
 ------------
-$ git replay --onto origin/main ^base branch1 branch2 branch3
+$ git replay rebase --onto origin/main ^base branch1 branch2 branch3
 ------------
 
 This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
@@ -175,12 +193,22 @@ that they have in common, but that does not need to be the case.
 To revert commits on a branch:
 
 ------------
-$ git replay --revert main main~2..main
+$ git replay revert --ref main main~2..main
 ------------
 
 This reverts the last two commits on `main`, creating two revert commits
 on top of `main`, and updates `main` to point at the result.
 
+To rebase onto a specific commit while updating a named ref:
+
+------------
+$ git replay rebase --ref refs/heads/mybranch --onto 112233 aabbcc..ddeeff
+------------
+
+This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
+`refs/heads/mybranch` to point at the result. This is useful when you want
+to use bare commit IDs instead of branch names.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/replay.c b/builtin/replay.c
index 28ce5196db..b7bf64821e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -13,6 +13,24 @@
 #include "replay.h"
 #include "revision.h"
 
+#define REBASE_USAGE \
+	N_("git replay rebase --onto <newbase> [--ref <branch>] [--contained]\n" \
+		"           [--ref-action[=<mode>]] <revision-range>")
+
+#define PICK_USAGE \
+	N_("git replay pick --ref <branch> [--onto <newbase>]\n" \
+		"           [--ref-action[=<mode>]] <revision-range>")
+
+#define REVERT_USAGE \
+	N_("git replay revert --ref <branch> [--onto <newbase>]\n" \
+		"           [--ref-action[=<mode>]] <revision-range>")
+
+enum replay_subcommand {
+	REPLAY_SUBCMD_REBASE,
+	REPLAY_SUBCMD_PICK,
+	REPLAY_SUBCMD_REVERT,
+};
+
 enum ref_action_mode {
 	REF_ACTION_UPDATE,
 	REF_ACTION_PRINT,
@@ -66,10 +84,9 @@ static int handle_ref_update(enum ref_action_mode mode,
 	}
 }
 
-int cmd_replay(int argc,
-	       const char **argv,
-	       const char *prefix,
-	       struct repository *repo)
+static int run_replay(int argc, const char **argv, const char *prefix,
+		      struct repository *repo,
+		      enum replay_subcommand subcommand)
 {
 	struct replay_revisions_options opts = { 0 };
 	struct replay_result result = { 0 };
@@ -81,45 +98,71 @@ int cmd_replay(int argc,
 	struct strbuf reflog_msg = STRBUF_INIT;
 	int ret = 0;
 
-	const char *const replay_usage[] = {
-		N_("(EXPERIMENTAL!) git replay "
-		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
-		   "[--ref-action[=<mode>]] <revision-range>..."),
+	const char *const rebase_usage[] = {
+		REBASE_USAGE,
 		NULL
 	};
+	const char *const pick_usage[] = {
+		PICK_USAGE,
+		NULL
+	};
+	const char *const revert_usage[] = {
+		REVERT_USAGE,
+		NULL
+	};
+
+	const char *const *usage;
+
 	struct option replay_options[] = {
-		OPT_STRING(0, "advance", &opts.advance,
-			   N_("branch"),
-			   N_("make replay advance given branch")),
 		OPT_STRING(0, "onto", &opts.onto,
 			   N_("revision"),
-			   N_("replay onto given commit")),
-		OPT_BOOL(0, "contained", &opts.contained,
-			 N_("update all branches that point at commits in <revision-range>")),
-		OPT_STRING(0, "revert", &opts.revert,
+			   N_("starting point for new commits")),
+		OPT_STRING(0, "ref", &opts.ref,
 			   N_("branch"),
-			   N_("revert commits onto given branch")),
+			   N_("reference to update with result")),
+		OPT_BOOL(0, "contained", &opts.contained,
+			 N_("update all branches contained in <revision-range>")),
 		OPT_STRING(0, "ref-action", &ref_action,
 			   N_("mode"),
 			   N_("control ref update behavior (update|print)")),
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
+	switch (subcommand) {
+	case REPLAY_SUBCMD_REBASE:
+		usage = rebase_usage;
+		break;
+	case REPLAY_SUBCMD_PICK:
+		usage = pick_usage;
+		break;
+	case REPLAY_SUBCMD_REVERT:
+		usage = revert_usage;
+		opts.revert = 1;
+		break;
+	default:
+		BUG("unknown subcommand %d", subcommand);
+	}
+
+	argc = parse_options(argc, argv, prefix, replay_options, usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
-	/* Exactly one mode must be specified */
-	if (!opts.onto && !opts.advance && !opts.revert) {
-		error(_("exactly one of --onto, --advance, or --revert is required"));
-		usage_with_options(replay_usage, replay_options);
+	if (subcommand == REPLAY_SUBCMD_REBASE) {
+		if (!opts.onto) {
+			error(_("--onto is required for 'rebase' subcommand"));
+			usage_with_options(usage, replay_options);
+		}
+		if (opts.contained && opts.ref)
+			die(_("--contained and --ref cannot be used together"));
+	} else {
+		if (!opts.ref) {
+			error(_("--ref is required for '%s' subcommand"),
+			      subcommand == REPLAY_SUBCMD_PICK ? "pick" : "revert");
+			usage_with_options(usage, replay_options);
+		}
+		if (opts.contained)
+			die(_("--contained can only be used with the 'rebase' subcommand"));
 	}
 
-	die_for_incompatible_opt3(!!opts.onto, "--onto",
-				  !!opts.advance, "--advance",
-				  !!opts.revert, "--revert");
-	if (opts.contained && !opts.onto)
-		die(_("--contained requires --onto"));
-
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
 
@@ -179,15 +222,17 @@ int cmd_replay(int argc,
 		goto cleanup;
 
 	/* Build reflog message */
-	if (opts.revert) {
-		strbuf_addf(&reflog_msg, "replay --revert %s", opts.revert);
-	} else if (opts.advance) {
-		strbuf_addf(&reflog_msg, "replay --advance %s", opts.advance);
+	if (opts.ref) {
+		strbuf_addf(&reflog_msg, "replay %s %s",
+			    subcommand == REPLAY_SUBCMD_REVERT ? "revert" :
+			    subcommand == REPLAY_SUBCMD_PICK   ? "pick" :
+							         "rebase",
+			    opts.ref);
 	} else {
 		struct object_id oid;
 		if (repo_get_oid_committish(repo, opts.onto, &oid))
 			BUG("--onto commit should have been resolved beforehand already");
-		strbuf_addf(&reflog_msg, "replay --onto %s", oid_to_hex(&oid));
+		strbuf_addf(&reflog_msg, "replay rebase --onto %s", oid_to_hex(&oid));
 	}
 
 	/* Initialize ref transaction if using update mode */
@@ -236,3 +281,44 @@ int cmd_replay(int argc,
 		exit(128);
 	return ret;
 }
+
+static int cmd_replay_rebase(int argc, const char **argv,
+			     const char *prefix, struct repository *repo)
+{
+	return run_replay(argc, argv, prefix, repo, REPLAY_SUBCMD_REBASE);
+}
+
+static int cmd_replay_pick(int argc, const char **argv,
+			   const char *prefix, struct repository *repo)
+{
+	return run_replay(argc, argv, prefix, repo, REPLAY_SUBCMD_PICK);
+}
+
+static int cmd_replay_revert(int argc, const char **argv,
+			     const char *prefix, struct repository *repo)
+{
+	return run_replay(argc, argv, prefix, repo, REPLAY_SUBCMD_REVERT);
+}
+
+int cmd_replay(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo)
+{
+	const char *const usage[] = {
+		REBASE_USAGE,
+		PICK_USAGE,
+		REVERT_USAGE,
+		NULL
+	};
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option options[] = {
+		OPT_SUBCOMMAND("rebase", &fn, cmd_replay_rebase),
+		OPT_SUBCOMMAND("pick", &fn, cmd_replay_pick),
+		OPT_SUBCOMMAND("revert", &fn, cmd_replay_revert),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	return fn(argc, argv, prefix, repo);
+}
diff --git a/replay.c b/replay.c
index 6f8b5720b3..9d02f2bcc9 100644
--- a/replay.c
+++ b/replay.c
@@ -138,15 +138,15 @@ static void get_ref_information(struct repository *repo,
 
 	/*
 	 * When the user specifies e.g.
-	 *   git replay origin/main..mybranch
-	 *   git replay ^origin/next mybranch1 mybranch2
+	 *   git replay rebase --onto origin/main origin/main..mybranch
+	 *   git replay rebase --onto origin/next ^origin/next mybranch1 mybranch2
 	 * we want to be able to determine where to replay the commits.  In
 	 * these examples, the branches are probably based on an old version
 	 * of either origin/main or origin/next, so we want to replay on the
 	 * newest version of that branch.  In contrast we would want to error
 	 * out if they ran
-	 *   git replay ^origin/master ^origin/next mybranch
-	 *   git replay mybranch~2..mybranch
+	 *   git replay rebase --onto origin/main ^origin/master ^origin/next mybranch
+	 *   git replay rebase --onto target mybranch~2..mybranch
 	 * the first of those because there's no unique base to choose, and
 	 * the second because they'd likely just be replaying commits on top
 	 * of the same commit and not making any difference.
@@ -182,7 +182,6 @@ static void get_ref_information(struct repository *repo,
 
 static void set_up_branch_mode(struct repository *repo,
 			       char **branch_name,
-			       const char *option_name,
 			       struct ref_info *rinfo,
 			       struct commit **onto)
 {
@@ -194,21 +193,20 @@ static void set_up_branch_mode(struct repository *repo,
 		free(*branch_name);
 		*branch_name = fullname;
 	} else {
-		die(_("argument to %s must be a reference"), option_name);
+		die(_("argument to --ref must be a reference"));
 	}
-	*onto = peel_committish(repo, *branch_name, option_name);
+	*onto = peel_committish(repo, *branch_name, "--ref");
 	if (rinfo->positive_refexprs > 1)
-		die(_("cannot %s target with multiple sources because ordering would be ill-defined"),
-		    option_name + 2); /* skip "--" prefix */
+		die(_("cannot replay target with multiple sources because ordering would be ill-defined"));
 }
 
 static void set_up_replay_mode(struct repository *repo,
 			       struct rev_cmdline_info *cmd_info,
-			       const char *onto_name,
+			       struct replay_revisions_options *opts,
 			       bool *detached_head,
-			       char **advance_name,
-			       char **revert_name,
+			       char **ref_name,
 			       struct commit **onto,
+			       struct object_id *ref_old_oid,
 			       struct strset **update_refs)
 {
 	struct ref_info rinfo;
@@ -222,20 +220,19 @@ static void set_up_replay_mode(struct repository *repo,
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
 
-	if (onto_name) {
-		*onto = peel_committish(repo, onto_name, "--onto");
+	if (!opts->ref) {
+		*onto = peel_committish(repo, opts->onto, "--onto");
 		if (rinfo.positive_refexprs <
 		    strset_get_size(&rinfo.positive_refs))
 			die(_("all positive revisions given must be references"));
 		*update_refs = xcalloc(1, sizeof(**update_refs));
 		**update_refs = rinfo.positive_refs;
 		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
-	} else if (*advance_name) {
-		set_up_branch_mode(repo, advance_name, "--advance", &rinfo, onto);
-	} else if (*revert_name) {
-		set_up_branch_mode(repo, revert_name, "--revert", &rinfo, onto);
 	} else {
-		BUG("expected one of onto_name, *advance_name, or *revert_name");
+		set_up_branch_mode(repo, ref_name, &rinfo, onto);
+		oidcpy(ref_old_oid, &(*onto)->object.oid);
+		if (opts->onto)
+			*onto = peel_committish(repo, opts->onto, "--onto");
 	}
 	strset_clear(&rinfo.negative_refs);
 	strset_clear(&rinfo.positive_refs);
@@ -344,19 +341,18 @@ int replay_revisions(struct rev_info *revs,
 		.clean = 1,
 	};
 	bool detached_head;
-	char *advance;
-	char *revert;
+	char *ref;
+	struct object_id ref_old_oid;
 	enum replay_mode mode = REPLAY_MODE_PICK;
 	int ret;
 
-	advance = xstrdup_or_null(opts->advance);
-	revert = xstrdup_or_null(opts->revert);
-	if (revert)
+	ref = xstrdup_or_null(opts->ref);
+	oidclr(&ref_old_oid, the_repository->hash_algo);
+	if (opts->revert)
 		mode = REPLAY_MODE_REVERT;
-	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
-			   &detached_head, &advance, &revert, &onto, &update_refs);
-
-	/* FIXME: Should allow replaying commits with the first as a root commit */
+	set_up_replay_mode(revs->repo, &revs->cmdline, opts,
+			   &detached_head, &ref, &onto, &ref_old_oid,
+			   &update_refs);
 
 	if (prepare_revision_walk(revs) < 0) {
 		ret = error(_("error preparing revisions"));
@@ -372,6 +368,7 @@ int replay_revisions(struct rev_info *revs,
 		khint_t pos;
 		int hr;
 
+		/* FIXME: Should allow replaying commits with the first as a root commit */
 		if (!commit->parents)
 			die(_("replaying down from root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -390,7 +387,7 @@ int replay_revisions(struct rev_info *revs,
 		kh_value(replayed_commits, pos) = last_commit;
 
 		/* Update any necessary branches */
-		if (advance || revert)
+		if (ref)
 			continue;
 
 		for (decoration = get_name_decoration(&commit->object);
@@ -424,13 +421,11 @@ int replay_revisions(struct rev_info *revs,
 		goto out;
 	}
 
-	/* In --advance or --revert mode, update the target ref */
-	if (advance || revert) {
-		const char *ref = advance ? advance : revert;
+	/* In --ref mode, update the target ref */
+	if (ref)
 		replay_result_queue_update(out, ref,
-					   &onto->object.oid,
+					   &ref_old_oid,
 					   &last_commit->object.oid);
-	}
 
 	ret = 0;
 
@@ -441,7 +436,6 @@ int replay_revisions(struct rev_info *revs,
 	}
 	kh_destroy_oid_map(replayed_commits);
 	merge_finalize(&merge_opt, &result);
-	free(advance);
-	free(revert);
+	free(ref);
 	return ret;
 }
diff --git a/replay.h b/replay.h
index e916a5f975..89ed236215 100644
--- a/replay.h
+++ b/replay.h
@@ -11,31 +11,32 @@ struct rev_info;
  */
 struct replay_revisions_options {
 	/*
-	 * Starting point at which to create the new commits; must be a branch
-	 * name. The branch will be updated to point to the rewritten commits.
-	 * This option is mutually exclusive with `onto` and `revert`.
-	 */
-	const char *advance;
-
-	/*
-	 * Starting point at which to create the new commits; must be a
-	 * committish. References pointing at decendants of `onto` will be
-	 * updated to point to the new commits.
+	 * Starting point at which to create the new commits. For
+	 * 'rebase' this is required. For 'pick' and 'revert' it is
+	 * optional; when omitted, defaults to the commit pointed to
+	 * by `ref`. May be any valid committish.
 	 */
 	const char *onto;
 
 	/*
-	 * Starting point at which to create revert commits; must be a branch
-	 * name. The branch will be updated to point to the revert commits.
-	 * This option is mutually exclusive with `onto` and `advance`.
+	 * The ref to update with the result. For 'pick' and 'revert'
+	 * subcommands this is required. For 'rebase' it is optional;
+	 * when omitted, refs are inferred from the revision range.
+	 * Must be a valid reference name.
 	 */
-	const char *revert;
+	const char *ref;
 
 	/*
 	 * Update branches that point at commits in the given revision range.
-	 * Requires `onto` to be set.
+	 * Only valid for the 'rebase' subcommand when `ref` is not set.
 	 */
 	int contained;
+
+	/*
+	 * If set, reverse the effect of the commits being replayed
+	 * rather than cherry-picking them.
+	 */
+	int revert;
 };
 
 /* This struct is used as an out-parameter by `replay_revisions()`. */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index ca517cf607..4fe8f3d736 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -60,54 +60,72 @@ test_expect_success 'setup bare' '
 	git clone --bare . bare
 '
 
-test_expect_success 'argument to --advance must be a reference' '
-	echo "fatal: argument to --advance must be a reference" >expect &&
+test_expect_success 'a subcommand is required' '
+	test_must_fail git replay 2>actual &&
+	test_grep "need a subcommand" actual
+'
+
+test_expect_success 'argument to --ref must be a reference' '
+	echo "fatal: argument to --ref must be a reference" >expect &&
 	oid=$(git rev-parse main) &&
-	test_must_fail git replay --advance=$oid topic1..topic2 2>actual &&
+	test_must_fail git replay pick --ref=$oid topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
-test_expect_success '--onto with invalid commit-ish' '
+test_expect_success 'rebase --onto with invalid commit-ish' '
 	printf "fatal: ${SQ}refs/not-valid${SQ} is not " >expect &&
 	printf "a valid commit-ish for --onto\n" >>expect &&
-	test_must_fail git replay --onto=refs/not-valid topic1..topic2 2>actual &&
+	test_must_fail git replay rebase --onto=refs/not-valid topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'exactly one of --onto, --advance, or --revert is required' '
-	echo "error: exactly one of --onto, --advance, or --revert is required" >expect &&
-	test_might_fail git replay -h >>expect &&
-	test_must_fail git replay topic1..topic2 2>actual &&
-	test_cmp expect actual
+test_expect_success '--onto is required for rebase subcommand' '
+	test_must_fail git replay rebase topic1..topic2 2>actual &&
+	test_grep "is required" actual
+'
+
+test_expect_success '--ref is required for pick subcommand' '
+	test_must_fail git replay pick topic1..topic2 2>actual &&
+	test_grep "is required" actual
+'
+
+test_expect_success '--ref is required for revert subcommand' '
+	test_must_fail git replay revert topic1..topic2 2>actual &&
+	test_grep "is required" actual
 '
 
 test_expect_success 'no base or negative ref gives no-replaying down to root error' '
 	echo "fatal: replaying down from root commit is not supported yet!" >expect &&
-	test_must_fail git replay --onto=topic1 topic2 2>actual &&
+	test_must_fail git replay rebase --onto=topic1 topic2 2>actual &&
 	test_cmp expect actual
 '
 
-test_expect_success '--contained requires --onto' '
-	echo "fatal: --contained requires --onto" >expect &&
-	test_must_fail git replay --advance=main --contained \
+test_expect_success '--contained can only be used with rebase' '
+	test_must_fail git replay pick --ref main --contained \
 		topic1..topic2 2>actual &&
-	test_cmp expect actual
+	test_grep "only be used with" actual
+'
+
+test_expect_success '--contained and --ref cannot be used together' '
+	test_must_fail git replay rebase --onto main --ref main --contained \
+		topic1..topic2 2>actual &&
+	test_grep "cannot be used together" actual
 '
 
-test_expect_success 'cannot advance target ... ordering would be ill-defined' '
-	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
-	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
+test_expect_success 'cannot replay target with multiple sources' '
+	echo "fatal: cannot replay target with multiple sources because ordering would be ill-defined" >expect &&
+	test_must_fail git replay pick --ref main main topic1 topic2 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'replaying merge commits is not supported yet' '
 	echo "fatal: replaying merge commits is not supported yet!" >expect &&
-	test_must_fail git replay --advance=main main..topic-with-merge 2>actual &&
+	test_must_fail git replay pick --ref main main..topic-with-merge 2>actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'using replay to rebase two branches, one on top of other' '
-	git replay --ref-action=print --onto main topic1..topic2 >result &&
+test_expect_success 'using replay rebase to rebase two branches, one on top of other' '
+	git replay rebase --ref-action=print --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -122,26 +140,25 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 	test_cmp expect result
 '
 
-test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
-	git -C bare replay --ref-action=print --onto main topic1..topic2 >result-bare &&
+test_expect_success 'using replay rebase on bare repo to rebase two branches, one on top of other' '
+	git -C bare replay rebase --ref-action=print --onto main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
-test_expect_success 'using replay to rebase with a conflict' '
-	test_expect_code 1 git replay --onto topic1 B..conflict
+test_expect_success 'using replay rebase with a conflict' '
+	test_expect_code 1 git replay rebase --onto topic1 B..conflict
 '
 
-test_expect_success 'using replay on bare repo to rebase with a conflict' '
-	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
+test_expect_success 'using replay rebase on bare repo with a conflict' '
+	test_expect_code 1 git -C bare replay rebase --onto topic1 B..conflict
 '
 
-test_expect_success 'using replay to perform basic cherry-pick' '
+test_expect_success 'using replay pick to perform basic cherry-pick' '
 	# The differences between this test and previous ones are:
-	#   --advance vs --onto
+	#   pick --ref vs rebase --onto
 	# 2nd field of result is refs/heads/main vs. refs/heads/topic2
 	# 4th field of result is hash for main instead of hash for topic2
-
-	git replay --ref-action=print --advance main topic1..topic2 >result &&
+	git replay pick --ref-action=print --ref main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
@@ -156,8 +173,8 @@ test_expect_success 'using replay to perform basic cherry-pick' '
 	test_cmp expect result
 '
 
-test_expect_success 'using replay on bare repo to perform basic cherry-pick' '
-	git -C bare replay --ref-action=print --advance main topic1..topic2 >result-bare &&
+test_expect_success 'using replay pick on bare repo to perform basic cherry-pick' '
+	git -C bare replay pick --ref-action=print --ref main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
 '
 
@@ -168,11 +185,11 @@ test_expect_success 'commits that become empty are dropped' '
 	test_when_finished "git update-ref --stdin <original-branches &&
 		rm original-branches" &&
 	# Cherry-pick tip of topic1 ("F"), from the middle of A..empty, to main
-	git replay --advance main topic1^! &&
+	git replay pick --ref main topic1^! &&
 
 	# Replay all of A..empty onto main (which includes topic1 & thus F
 	# in the middle)
-	git replay --onto main --branches --ancestry-path=empty ^A \
+	git replay rebase --onto main --branches --ancestry-path=empty ^A \
 		>result &&
 	git log --format="%s%d" L..empty >actual &&
 	test_write_lines >expect \
@@ -180,16 +197,16 @@ test_expect_success 'commits that become empty are dropped' '
 	test_cmp expect actual
 '
 
-test_expect_success 'replay on bare repo fails with both --advance and --onto' '
-	test_must_fail git -C bare replay --advance main --onto main topic1..topic2 >result-bare
+test_expect_success 'replay rebase on bare repo fails with both --ref and --contained' '
+	test_must_fail git -C bare replay rebase --ref main --contained --onto main topic1..topic2
 '
 
-test_expect_success 'replay fails when both --advance and --onto are omitted' '
-	test_must_fail git replay topic1..topic2 >result
+test_expect_success 'replay rebase fails without --onto' '
+	test_must_fail git replay rebase topic1..topic2
 '
 
-test_expect_success 'using replay to also rebase a contained branch' '
-	git replay --ref-action=print --contained --onto main main..topic3 >result &&
+test_expect_success 'using replay rebase to also rebase a contained branch' '
+	git replay rebase --ref-action=print --contained --onto main main..topic3 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -212,13 +229,13 @@ test_expect_success 'using replay to also rebase a contained branch' '
 	test_cmp expect result
 '
 
-test_expect_success 'using replay on bare repo to also rebase a contained branch' '
-	git -C bare replay --ref-action=print --contained --onto main main..topic3 >result-bare &&
+test_expect_success 'using replay rebase on bare repo to also rebase a contained branch' '
+	git -C bare replay rebase --ref-action=print --contained --onto main main..topic3 >result-bare &&
 	test_cmp expect result-bare
 '
 
-test_expect_success 'using replay to rebase multiple divergent branches' '
-	git replay --ref-action=print --onto main ^topic1 topic2 topic4 >result &&
+test_expect_success 'using replay rebase to rebase multiple divergent branches' '
+	git replay rebase --ref-action=print --onto main ^topic1 topic2 topic4 >result &&
 
 	test_line_count = 2 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -241,8 +258,8 @@ test_expect_success 'using replay to rebase multiple divergent branches' '
 	test_cmp expect result
 '
 
-test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
-	git -C bare replay --ref-action=print --contained --onto main ^main topic2 topic3 topic4 >result &&
+test_expect_success 'using replay rebase on bare repo to rebase multiple divergent branches, including contained ones' '
+	git -C bare replay rebase --ref-action=print --contained --onto main ^main topic2 topic3 topic4 >result &&
 
 	test_line_count = 4 result &&
 	cut -f 3 -d " " result >new-branch-tips &&
@@ -269,12 +286,12 @@ test_expect_success 'using replay on bare repo to rebase multiple divergent bran
 	done
 '
 
-test_expect_success 'using replay to update detached HEAD' '
+test_expect_success 'using replay rebase to update detached HEAD' '
 	current_head=$(git branch --show-current) &&
 	test_when_finished git switch "$current_head" &&
 	git switch --detach &&
 	test_commit something &&
-	git replay --ref-action=print --onto HEAD~2 --ref-action=print HEAD~..HEAD >updates &&
+	git replay rebase --ref-action=print --onto HEAD~2 --ref HEAD HEAD~..HEAD >updates &&
 	test_grep "update HEAD " updates
 '
 
@@ -297,7 +314,7 @@ test_expect_success 'merge.directoryRenames=false' '
 	git commit -m modified to-rename/add-a-file.t &&
 
 	git -c merge.directoryRenames=false replay \
-		--onto rename-onto rename-onto..rename-from
+		rebase --onto rename-onto rename-onto..rename-from
 '
 
 test_expect_success 'default atomic behavior updates refs directly' '
@@ -306,7 +323,7 @@ test_expect_success 'default atomic behavior updates refs directly' '
 	test_when_finished "git branch -D test-atomic" &&
 
 	# Test default atomic behavior (no output, refs updated)
-	git replay --onto main topic1..test-atomic >output &&
+	git replay rebase --onto main topic1..test-atomic >output &&
 	test_must_be_empty output &&
 
 	# Verify ref was updated
@@ -317,7 +334,7 @@ test_expect_success 'default atomic behavior updates refs directly' '
 	# Verify reflog message includes SHA of onto commit
 	git reflog test-atomic -1 --format=%gs >reflog-msg &&
 	ONTO_SHA=$(git rev-parse main) &&
-	echo "replay --onto $ONTO_SHA" >expect-reflog &&
+	echo "replay rebase --onto $ONTO_SHA" >expect-reflog &&
 	test_cmp expect-reflog reflog-msg
 '
 
@@ -327,7 +344,7 @@ test_expect_success 'atomic behavior in bare repository' '
 	test_when_finished "git -C bare update-ref refs/heads/topic2 $START" &&
 
 	# Test atomic updates work in bare repo
-	git -C bare replay --onto main topic1..topic2 >output &&
+	git -C bare replay rebase --onto main topic1..topic2 >output &&
 	test_must_be_empty output &&
 
 	# Verify ref was updated in bare repo
@@ -336,18 +353,18 @@ test_expect_success 'atomic behavior in bare repository' '
 	test_cmp expect actual
 '
 
-test_expect_success 'reflog message for --advance mode' '
+test_expect_success 'reflog message for pick subcommand' '
 	# Store original state
 	START=$(git rev-parse main) &&
 	test_when_finished "git update-ref refs/heads/main $START" &&
 
-	# Test --advance mode reflog message
-	git replay --advance main topic1..topic2 >output &&
+	# Test pick mode reflog message
+	git replay pick --ref main topic1..topic2 >output &&
 	test_must_be_empty output &&
 
-	# Verify reflog message includes --advance and branch name
+	# Verify reflog message includes subcommand and branch name
 	git reflog main -1 --format=%gs >reflog-msg &&
-	echo "replay --advance main" >expect-reflog &&
+	echo "replay pick main" >expect-reflog &&
 	test_cmp expect-reflog reflog-msg
 '
 
@@ -358,7 +375,7 @@ test_expect_success 'replay.refAction=print config option' '
 
 	# Test with config set to print
 	test_config replay.refAction print &&
-	git replay --onto main topic1..topic2 >output &&
+	git replay rebase --onto main topic1..topic2 >output &&
 	test_line_count = 1 output &&
 	test_grep "^update refs/heads/topic2 " output
 '
@@ -370,7 +387,7 @@ test_expect_success 'replay.refAction=update config option' '
 
 	# Test with config set to update
 	test_config replay.refAction update &&
-	git replay --onto main topic1..topic2 >output &&
+	git replay rebase --onto main topic1..topic2 >output &&
 	test_must_be_empty output &&
 
 	# Verify ref was updated
@@ -386,37 +403,30 @@ test_expect_success 'command-line --ref-action overrides config' '
 
 	# Set config to update but use --ref-action=print
 	test_config replay.refAction update &&
-	git replay --ref-action=print --onto main topic1..topic2 >output &&
+	git replay rebase --ref-action=print --onto main topic1..topic2 >output &&
 	test_line_count = 1 output &&
 	test_grep "^update refs/heads/topic2 " output
 '
 
 test_expect_success 'invalid replay.refAction value' '
 	test_config replay.refAction invalid &&
-	test_must_fail git replay --onto main topic1..topic2 2>error &&
+	test_must_fail git replay rebase --onto main topic1..topic2 2>error &&
 	test_grep "invalid.*replay.refAction.*value" error
 '
 
-test_expect_success 'argument to --revert must be a reference' '
-	echo "fatal: argument to --revert must be a reference" >expect &&
-	oid=$(git rev-parse main) &&
-	test_must_fail git replay --revert=$oid topic1..topic2 2>actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'cannot revert with multiple sources' '
-	echo "fatal: cannot revert target with multiple sources because ordering would be ill-defined" >expect &&
-	test_must_fail git replay --revert main main topic1 topic2 2>actual &&
+	echo "fatal: cannot replay target with multiple sources because ordering would be ill-defined" >expect &&
+	test_must_fail git replay revert --ref main main topic1 topic2 2>actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'using replay --revert to revert commits' '
+test_expect_success 'using replay revert to revert commits' '
 	# Reuse existing topic4 branch (has commits I and J on top of main)
 	START=$(git rev-parse topic4) &&
 	test_when_finished "git branch -f topic4 $START" &&
 
 	# Revert commits I and J
-	git replay --revert topic4 topic4~2..topic4 &&
+	git replay revert --ref topic4 topic4~2..topic4 &&
 
 	# Verify the revert commits were created
 	git log --format=%s -4 topic4 >actual &&
@@ -437,17 +447,17 @@ test_expect_success 'using replay --revert to revert commits' '
 
 	# Verify reflog message
 	git reflog topic4 -1 --format=%gs >reflog-msg &&
-	echo "replay --revert topic4" >expect-reflog &&
+	echo "replay revert topic4" >expect-reflog &&
 	test_cmp expect-reflog reflog-msg
 '
 
-test_expect_success 'using replay --revert in bare repo' '
+test_expect_success 'using replay revert in bare repo' '
 	# Reuse existing topic4 in bare repo
 	START=$(git -C bare rev-parse topic4) &&
 	test_when_finished "git -C bare update-ref refs/heads/topic4 $START" &&
 
 	# Revert commit J in bare repo
-	git -C bare replay --revert topic4 topic4~1..topic4 &&
+	git -C bare replay revert --ref topic4 topic4~1..topic4 &&
 
 	# Verify revert was created
 	git -C bare log -1 --format=%s topic4 >actual &&
@@ -461,11 +471,11 @@ test_expect_success 'revert of revert uses Reapply' '
 	test_when_finished "git branch -f topic4 $START" &&
 
 	# First revert J
-	git replay --revert topic4 topic4~1..topic4 &&
+	git replay revert --ref topic4 topic4~1..topic4 &&
 	REVERT_J=$(git rev-parse topic4) &&
 
 	# Now revert the revert - should become Reapply
-	git replay --revert topic4 topic4~1..topic4 &&
+	git replay revert --ref topic4 topic4~1..topic4 &&
 
 	# Verify Reapply prefix and message format
 	test_commit_message topic4 <<-EOF
@@ -475,24 +485,33 @@ test_expect_success 'revert of revert uses Reapply' '
 	EOF
 '
 
-test_expect_success 'git replay --revert with conflict' '
+test_expect_success 'git replay revert with conflict' '
 	# conflict branch has C.conflict which conflicts with topic1s C
-	test_expect_code 1 git replay --revert conflict B..topic1
+	test_expect_code 1 git replay revert --ref conflict B..topic1
 '
 
-test_expect_success 'git replay --revert incompatible with --contained' '
-	test_must_fail git replay --revert topic4 --contained topic4~1..topic4 2>error &&
-	test_grep "requires --onto" error
-'
+test_expect_success 'using replay rebase with --ref and --onto' '
+	git branch test-ref-onto topic2 &&
+	test_when_finished "git branch -D test-ref-onto" &&
 
-test_expect_success 'git replay --revert incompatible with --onto' '
-	test_must_fail git replay --revert topic4 --onto main topic4~1..topic4 2>error &&
-	test_grep "cannot be used together" error
+	git replay rebase --ref test-ref-onto --onto main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	git log --format=%s test-ref-onto >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
 '
 
-test_expect_success 'git replay --revert incompatible with --advance' '
-	test_must_fail git replay --revert topic4 --advance main topic4~1..topic4 2>error &&
-	test_grep "cannot be used together" error
+test_expect_success 'using replay pick with --onto' '
+	START=$(git rev-parse main) &&
+	test_when_finished "git update-ref refs/heads/main $START" &&
+
+	git replay pick --ref main --onto topic1 topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	git log --format=%s -4 main >actual &&
+	test_write_lines E D F C >expect &&
+	test_cmp expect actual
 '
 
 test_done

---
base-commit: 4bf257a78a32b23e8f95d801e334a8b9f80a88d0
change-id: 20260309-toon-replay-subcommands-844b3ce72626

