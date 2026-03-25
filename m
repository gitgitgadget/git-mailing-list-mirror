Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8983E716C
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454404; cv=none; b=PPs4ycjNutX+fGSxBiyBimBw6DS+OmZrnHigZ+dqhj+5z9a5kkggJZ6jwa/IxnoMvrK3KhbGDBb9xzVkocYzALGPtTkMLphKvwq08hM8GF2kEfE9lXGklzXTyBQtQfNwGKszOsXN0iECnc7CDbpZ7rcFkcRV+S5pz5ekfkWaWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454404; c=relaxed/simple;
	bh=4oq0nnzjJcEIqdDHE//F3dDbL//VjMdtcZSX3M8C0LA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=QhilieLTjwZYHeQ6ZjHUqY1Fy24TyH0EC+g4K60qj59oIQV5seXegBkrBubXYA03oj2cFgmnZrW8H6O3j+u4ZcBCfbdtPiB5mYc+73+/Zp6xfgu7LQid8IH8O5HPTCuDKisDC1vcAWtgtIaPaqz2S9lef9A3kMEvNjga2WmI3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=TAPRzrtb; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="TAPRzrtb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774454400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Vw+gg7faG2PFpNC1CPh6X4+Zqq5Krl+hYZ2PN7SsME=;
	b=TAPRzrtbZxyAkhLnhn2elsK7EZcrSmZQc3OGCbURo7MlKGREsauyjGR9jf9Fi8P5kzJJt0
	jpnuUKQftBBz03p49x3ccO1sCHK1EsDDWmiGmM4+vOG+1iJPSIizl11DHr/oAiD0fgSwgt
	AXLe4lCSpx+h+kQ9ILPsM6itqAyF+6o=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/3] Add option --ref to git-replay(1)
Date: Wed, 25 Mar 2026 16:59:28 +0100
Message-Id: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr0Jm7RhaUqquvIdhUepUxiAlbSUSw
 t0teAGX7+X7WSBSYIpwKRYINHFkP2SQhwJsZ4YHId8zgyxlXVaywuT9gIHG3sxoQsspmDBn4VC
 Zk3DKnXVtNeT+mCV/9u1b8+P4bp9k0za4JTqOyYd5P5/ElvvnZxJYorJaaOlqrche2SfbH61/Q
 bOu6xeyMovt1AAAAA==
X-Change-ID: 20260323-toon-replay-arbitrary-ref-5a81f5f976c7
In-Reply-To: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In a previous RFC[1] I suggested to implement subcommands into
git-replay(1). While it would be arguable nice to have subcommands for
the different modes, because git-replay(1) is a plumbing commands, it's
fine to keep a status quo.

This series takes one thing for that RFC though: adding option --ref.
This new option is useful if you want to have full control over which
ref is being updated, and not want to rely on the refs that are using
in the <revision-range> or as the value for --advance and --revert.

These changes answer the needs expressed in[2].

This series is based on Siddharth's series[3] to add '--revert' to
git-replay(1) (sa/replay-revert @ ba5c0d03d3).

[1]: https://lore.kernel.org/git/20260309-toon-replay-subcommands-v1-1-864ec82ef68a@iotcl.com/
[2]: https://lore.kernel.org/git/CAHTeOx-SMLh_idKhGczPKzZNOKy04uYXmUhL8Z79yRuNpmE4eA@mail.gmail.com/
[3]: https://lore.kernel.org/git/20260313054035.26605-1-siddharthasthana31@gmail.com/

---
Changes in v2:
- Dropped the test-only consistency patch.
- Separated commit to mark options as not negatable.
- Modified git-replay(1) docs to everywhere use stuck form.
- Added code and test ensure the revision range has a single tip when
  both --onto and --ref are given.
- Rephrased some comments and docs.
- Link to v1: https://patch.msgid.link/20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com

---
Toon Claes (3):
      builtin/replay: mark options as not negatable
      replay: use stuck form in documentation and help message
      replay: allow to specify a ref with option --ref

 Documentation/git-replay.adoc | 42 +++++++++++++++++++--------
 builtin/replay.c              | 38 ++++++++++++++++---------
 replay.c                      | 33 +++++++++++++++++-----
 replay.h                      |  7 +++++
 t/t3650-replay-basics.sh      | 66 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 32 deletions(-)

Range-diff versus v1:

1:  fe4daa4c89 < -:  ---------- t3650: use option with value consistenly with equal sign
2:  3170bcc916 < -:  ---------- builtin/replay: improve documentation on options
-:  ---------- > 1:  61ba35cc08 builtin/replay: mark options as not negatable
-:  ---------- > 2:  19e54b8326 replay: use stuck form in documentation and help message
3:  bdb166a9ff ! 3:  341b94f937 replay: allow to specify a ref with option --ref
    @@ Metadata
      ## Commit message ##
         replay: allow to specify a ref with option --ref
     
    -    To enable users to replay commits without having refs in
    -    <revision-range> or as the value for --advance and --revert, start
    -    accepting option --ref. When the user specifies a --ref, the refs from
    -    the other option are ignored, and only the ref is acted on.
    +    When option '--onto' is passed to git-replay(1), the command will update
    +    refs from the <revision-range> passed to the command. When using option
    +    '--advance' or '--revert', the argument of that option is a ref that
    +    will be updated.
    +
    +    To enable users to specify which ref to update, add option '--ref'. When
    +    using option '--ref', the refs described above are left untouched and
    +    instead the argument of this option is updated instead.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    @@ Documentation/git-replay.adoc: SYNOPSIS
      [verse]
      (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
     -			     [--ref-action=<mode>] <revision-range>
    -+			     [--ref=<branch>] [--ref-action=<mode>]
    -+			     <revision-range>
    ++			     [--ref=<branch>] [--ref-action=<mode>] <revision-range>
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-replay.adoc: the current user as the author, matching the behavior of `git revert`.
    - This option is mutually exclusive with `--onto` and `--advance`. It is also
    - incompatible with `--contained` (which is a modifier for `--onto` only).
    - 
    -+--ref <branch>::
    -+	Override which reference is updated with the result of the
    -+	replay. When used with `--onto`, only the specified reference
    -+	is updated instead of inferring refs from the revision range.
    -+	When used with `--advance` or `--revert`, the specified
    -+	reference is updated instead of the branch given to those
    -+	options. This option is incompatible with `--contained`.
    -+
    - --contained::
    +@@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modifier for `--onto` only).
      	Update all branches that point at commits in
      	<revision-range>. Requires `--onto`.
    -@@ Documentation/git-replay.adoc: top of `main`, and updates `main` to point at the result. This is useful when
    - commits from `topic` were previously merged or cherry-picked into `main` and
    - need to be undone.
    + 
    ++--ref=<branch>::
    ++	Override which reference is updated with the result of the replay.
    ++	When used with `--onto`, the `<revision-range>` should have a
    ++	single tip and only the specified reference is updated instead of
    ++	inferring refs from the revision range.
    ++	When used with `--advance` or `--revert`, the specified reference is
    ++	updated instead of the branch given to those options. This option is
    ++	incompatible with `--contained`.
    ++
    + --ref-action[=<mode>]::
    + 	Control how references are updated. The mode can be:
    + +
    +@@ Documentation/git-replay.adoc: NOTE: For reverting an entire merge request as a single commit (rather than
    + commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
    + which can avoid unnecessary merge conflicts.
      
     +To replay onto a specific commit while updating a different reference:
     +
     +------------
    -+$ git replay --onto 112233 --ref refs/heads/mybranch aabbcc..ddeeff
    ++$ git replay --onto=112233 --ref=refs/heads/mybranch aabbcc..ddeeff
     +------------
     +
     +This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
    -+`refs/heads/mybranch` to point at the result. This is useful when you want
    ++`refs/heads/mybranch` to point at the result. This can be useful when you want
     +to use bare commit IDs instead of branch names.
     +
    - NOTE: For reverting an entire merge request as a single commit (rather than
    - commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
    - which can avoid unnecessary merge conflicts.
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
     
      ## builtin/replay.c ##
     @@ builtin/replay.c: int cmd_replay(int argc,
    @@ builtin/replay.c: int cmd_replay(int argc,
      		N_("(EXPERIMENTAL!) git replay "
      		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
     -		   "[--ref-action=<mode>] <revision-range>"),
    -+		   "[--ref=<branch>] [--ref-action=<mode>]\n"
    -+		   "<revision-range>"),
    ++		   "[--ref=<branch>] [--ref-action=<mode>] <revision-range>"),
      		NULL
      	};
      	struct option replay_options[] = {
     @@ builtin/replay.c: int cmd_replay(int argc,
    + 			     N_("branch"),
    + 			     N_("revert commits onto given branch"),
      			     PARSE_OPT_NONEG),
    - 		OPT_BOOL(0, "contained", &opts.contained,
    - 			 N_("update all branches that point at commits in <revision-range>")),
     +		OPT_STRING_F(0, "ref", &opts.ref,
     +			     N_("branch"),
     +			     N_("reference to update with result"),
    @@ replay.c: int replay_revisions(struct rev_info *revs,
     +	if (opts->ref) {
     +		struct object_id oid;
     +
    ++		if (update_refs && strset_get_size(update_refs) > 1) {
    ++			ret = error(_("'--ref' cannot be used with multiple revision ranges"));
    ++			goto out;
    ++		}
     +		if (check_refname_format(opts->ref, 0) || !starts_with(opts->ref, "refs/")) {
     +			ret = error(_("'%s' is not a valid refname"), opts->ref);
     +			goto out;
    @@ replay.h: struct replay_revisions_options {
      	const char *onto;
      
     +	/*
    -+	 * Reference to update with the result of the replay. This stops replay
    -+	 * from taking refs from `onto`, `advance`, and `revert`. Ignores
    ++	 * Reference to update with the result of the replay. This will not
    ++	 * update any refs from `onto`, `advance`, or `revert`. Ignores
     +	 * `contained`.
     +	 */
     +	const char *ref;
    @@ t/t3650-replay-basics.sh: test_expect_success 'git replay --revert incompatible
     +	test_must_fail git replay --onto=main --ref=main topic1..topic2 2>err &&
     +	test_grep "is not a valid refname" err
     +'
    ++
    ++test_expect_success '--onto with --ref rejects multiple revision ranges' '
    ++	test_must_fail git replay --onto=main --ref=refs/heads/topic2 ^topic1 topic2 topic4 2>err &&
    ++	test_grep "cannot be used with multiple revision ranges" err
    ++'
     +
      test_done


---
base-commit: ba5c0d03d39a8b1798c8f988bdc95f9a08f10fac
change-id: 20260323-toon-replay-arbitrary-ref-5a81f5f976c7

