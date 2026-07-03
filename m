Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6C380FDF
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076072; cv=none; b=qsX8Oua7ZUZLPHum4enfwpktVrLut1aeeAzLUYvRDAi7DUrk2NF5GMljROBgArJ+XqhT15JVNLD4PfR8UTcsTebfXNLl1nakE9WHxRQTrUK6ZXzPR1+BVzyMFH0IqmX86UTVHnumCUltkqGe9BsqBCLHn024RQRTpVHpXnxf2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076072; c=relaxed/simple;
	bh=JbiP281XTr5AqvGrpTlf4itvSnRj+wcU1XxiIQahjW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s+xYy2ZRZR3erZg6lkBs4ELBD/XVT03IoX7GEknMGvPi23pZXtjwgdqey3wIpyRPAiQL+0mGJ337bRbYSqzbZPeykBF5ga3lat8OqeupF3epBmXTDGqnxV05pljpQRwTkUqlxKikc52YScAITsQHQsJ+/82OTQ1deHTojq8SuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Nufq0P+n; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Nufq0P+n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783076066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lx+/Zuh8XilHkKkB834rESZ+3EJPqflduqR15Ke3a8c=;
	b=Nufq0P+n2orso96QTzet0gCCx9E13E64RMcw98EMh6pl76bVkWMW90+wE6FKMedse4R+La
	SWkTjUmISG+Y3TtfYtPAUinvrwUg1caCl7Ne+SB/1AKIlsfSJm0G2BrMTGAAsInOrO0qcy
	5z8TZSfg5uGcxirYW4H+UqyPwWzlHIM=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/5] builtin/refs: add "delete" subcommand
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-2-deb04de1ecef@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
 <20260630-pks-refs-writing-subcommands-v3-2-deb04de1ecef@pks.im>
Date: Fri, 03 Jul 2026 12:54:17 +0200
Message-ID: <87tsqg2vja.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Reference-related functionality in Git is currently spread across many
> different commands: git-update-ref(1), git-for-each-ref(1),
> git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
> hard for users to discover what functionality we have available to work
> with references.
>
> We have thus started to consolidate this functionality into git-refs(1),
> which is a toolbox of everything related to references. Until now, the
> command doesn't handle functionality of git-update-ref(1).
>
> Fix this gap by introducing a new "delete" subcommand, which is the
> equivalent of `git update-ref -d`.
>
> Note that we're intentionally not using a generic "write" subcommand
> with a "-d" flag. This is rather harder to discover, and subcommands
> that are implmented as flags tend to be hard to reason about in the code
> as we'd have to handle mutually-exclusive flags that stem from the other
> subcommand-like modes.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-refs.adoc |  17 ++++++
>  builtin/refs.c              |  51 +++++++++++++++++
>  t/meson.build               |   1 +
>  t/t1464-refs-delete.sh      | 130 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 199 insertions(+)
>
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index fa33680cc7..2633934463 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -20,6 +20,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
>  		   [ --stdin | (<pattern>...)]
>  git refs exists <ref>
>  git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
> +git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
>  
>  DESCRIPTION
>  -----------
> @@ -51,6 +52,12 @@ optimize::
>  	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
>  	offers identical functionality.
>  
> +delete::
> +	Delete the given reference. This subcommand mirrors `git update-ref -d`
> +	(see linkgit:git-update-ref[1]). When `<old-value>` is given, the
> +	reference is only deleted after verifying that it currently contains
> +	`<old-value>`.
> +
>  OPTIONS
>  -------
>  
> @@ -90,6 +97,16 @@ The following options are specific to 'git refs optimize':
>  
>  include::pack-refs-options.adoc[]
>  
> +The following options are specific to commands which write references:
> +
> +`--message=<reason>`::
> +	Use the given <reason> string for the reflog entry associated with the
> +	update. An empty message is rejected.
> +
> +`--no-deref`::
> +	Operate on <ref> itself rather than the reference it points to via a
> +	symbolic ref.
> +
>  KNOWN LIMITATIONS
>  -----------------
>  
> diff --git a/builtin/refs.c b/builtin/refs.c
> index f0faabf45a..edb7d61663 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -21,6 +21,9 @@
>  #define REFS_OPTIMIZE_USAGE \
>  	N_("git refs optimize " PACK_REFS_OPTS)
>  
> +#define REFS_DELETE_USAGE \
> +	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]")
> +
>  static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
>  			    struct repository *repo)
>  {
> @@ -175,6 +178,52 @@ static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
>  	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
>  }
>  
> +static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo)
> +{
> +	static char const * const refs_delete_usage[] = {
> +		REFS_DELETE_USAGE,
> +		NULL
> +	};
> +	const char *message = NULL;
> +	unsigned flags = 0;
> +	struct option opts[] = {
> +		OPT_STRING(0, "message", &message, N_("reason"),
> +			   N_("reason of the update")),
> +		OPT_BIT(0 ,"no-deref", &flags,
> +			N_("update <refname> not the one it points to"),
> +			REF_NO_DEREF),

Would it make sense to allow both --deref and --no-deref? (and --deref
being the default)

> +		OPT_END(),
> +	};
> +	struct object_id oldoid;
> +	const char *refname;
> +	int ret;
> +
> +	argc = parse_options(argc, argv, prefix, opts, refs_delete_usage, 0);
> +	if (argc < 1 || argc > 2)
> +		usage(_("delete requires reference name and an optional old object ID"));
> +
> +	if (message && !*message)
> +		die(_("refusing to perform update with empty message"));
> +
> +	repo_config(repo, git_default_config, NULL);
> +
> +	refname = argv[0];
> +	if (argc == 2) {
> +		if (repo_get_oid_with_flags(repo, argv[1], &oldoid, GET_OID_SKIP_AMBIGUITY_CHECK))
> +			die(_("invalid old object ID: '%s'"), argv[1]);
> +		if (is_null_oid(&oldoid))
> +			die(_("cannot delete reference with null old object ID"));
> +	}
> +
> +	ret = refs_delete_ref(get_main_ref_store(repo), message, refname,
> +			      argc == 2 ? &oldoid : NULL, flags);
> +
> +	if (ret < 0)
> +		ret = 1;
> +	return ret;
> +}
> +
>  int cmd_refs(int argc,
>  	     const char **argv,
>  	     const char *prefix,
> @@ -186,6 +235,7 @@ int cmd_refs(int argc,
>  		"git refs list " COMMON_USAGE_FOR_EACH_REF,
>  		REFS_EXISTS_USAGE,
>  		REFS_OPTIMIZE_USAGE,
> +		REFS_DELETE_USAGE,
>  		NULL,
>  	};
>  	parse_opt_subcommand_fn *fn = NULL;
> @@ -195,6 +245,7 @@ int cmd_refs(int argc,
>  		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
>  		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
>  		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
> +		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
>  		OPT_END(),
>  	};
>  
> diff --git a/t/meson.build b/t/meson.build
> index c5832fee05..1ccf08a3b5 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -223,6 +223,7 @@ integration_tests = [
>    't1461-refs-list.sh',
>    't1462-refs-exists.sh',
>    't1463-refs-optimize.sh',
> +  't1464-refs-delete.sh',
>    't1500-rev-parse.sh',
>    't1501-work-tree.sh',
>    't1502-rev-parse-parseopt.sh',
> diff --git a/t/t1464-refs-delete.sh b/t/t1464-refs-delete.sh
> new file mode 100755
> index 0000000000..efff7d0574
> --- /dev/null
> +++ b/t/t1464-refs-delete.sh
> @@ -0,0 +1,130 @@
> +#!/bin/sh
> +
> +test_description='git refs delete'
> +
> +. ./test-lib.sh
> +
> +setup_repo () {
> +	git init "$1" &&
> +	test_commit -C "$1" A &&
> +	test_commit -C "$1" B
> +}
> +
> +test_expect_success 'delete without oldvalue verification' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	A=$(git -C repo rev-parse A) &&
> +	git -C repo update-ref refs/heads/foo $A &&
> +	git -C repo refs delete refs/heads/foo &&
> +	test_must_fail git -C repo show-ref --verify -q refs/heads/foo

Why not use `git refs exists` here? And why use `git -C repo` in this
test, and `cd repo` in the other?

> +'
> +
> +test_expect_success 'delete with matching oldvalue' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git update-ref refs/heads/foo $A &&
> +		git refs delete refs/heads/foo $A &&
> +		test_must_fail git refs exists refs/heads/foo
> +	)
> +'
> +
> +test_expect_success 'delete with stale oldvalue fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		B=$(git rev-parse B) &&
> +		git update-ref refs/heads/foo $A &&
> +		test_must_fail git refs delete refs/heads/foo $B 2>err &&
> +		test_grep " but expected " err &&
> +		git refs exists refs/heads/foo
> +	)
> +'
> +
> +test_expect_success 'delete with null oldvalue fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git update-ref refs/heads/foo $A &&
> +		test_must_fail git refs delete refs/heads/foo $ZERO_OID 2>err &&
> +		test_grep "null old object ID" err &&
> +		git refs exists refs/heads/foo
> +	)
> +'
> +
> +test_expect_success 'delete with invalid oldvalue fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git update-ref refs/heads/foo $A &&
> +		test_must_fail git refs delete refs/heads/foo invalid-oid 2>err &&
> +		test_grep "invalid old object ID" err &&
> +		git refs exists refs/heads/foo
> +	)
> +'
> +
> +test_expect_success 'delete symref with --no-deref leaves target intact' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git update-ref refs/heads/foo $A &&
> +		git symbolic-ref refs/heads/symref refs/heads/foo &&
> +		git refs delete --no-deref refs/heads/symref &&
> +		test_must_fail git refs exists refs/heads/symref &&
> +		git refs exists refs/heads/foo
> +	)

What happens if you delete a symref and provide an <old-value>?

> +'
> +
> +test_expect_success 'delete with message records reason in reflog' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git update-ref refs/heads/foo $A &&
> +		git symbolic-ref HEAD refs/heads/foo &&
> +		git refs delete --message=delete-reason refs/heads/foo &&
> +		test_must_fail git refs exists refs/heads/foo &&
> +		test-tool ref-store main for-each-reflog-ent HEAD >actual &&
> +		test_grep "delete-reason$" actual
> +	)
> +'
> +
> +test_expect_success 'delete with empty message fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git update-ref refs/heads/foo $A &&
> +		test_must_fail git refs delete --message= refs/heads/foo 2>err &&
> +		test_grep "empty message" err &&
> +		git refs exists refs/heads/foo
> +	)
> +'
> +
> +test_expect_success 'delete without arguments fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	test_must_fail git -C repo refs delete 2>err &&
> +	test_grep "requires reference name" err
> +'
> +
> +test_expect_success 'delete with too many arguments fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	test_must_fail git refs delete one two three 2>err &&
> +	test_grep "requires reference name" err
> +'
> +
> +test_done
>
> -- 
> 2.55.0.795.g602f6c329a.dirty
>
>

-- 
Cheers,
Toon
