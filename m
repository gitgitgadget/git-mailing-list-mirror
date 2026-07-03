Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27DF2C3251
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088411; cv=none; b=WqTux1fl9yTmOkLCJsvouPTZkuqN7DRpq7p4NA0kjzasu5w1IS+MnS5jCZZXz3S3IDzZW/ecHadQTziFkJzIH3aXHlZQQGpMeeh7DA3KzaF/RTrzWIWst4SYNExNHYRL8c2pq3KxTigG8wE32snSsPUB6ozAlrtx5aOL9rIu/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088411; c=relaxed/simple;
	bh=SDjHPJ8QPWEH9b1IJX40/qvK3IPZVZOQYlBE7DiL6dM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U/ci+DMNT0cXFIJzUS6xXIJf3IOS/8a0IQ87meKbjUoCyMVw/eLSyqmq26UmA80F2llqJTY7+2E2l9mS/hQR93bPe44c0YHWLsbDAOqRSHkKi7str0AzIaz9JhElhIzopkJW9ttzZXkU8sSzRe5lPFHA3+Mn4MG52Tx1ClmvJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=R2D4V0qq; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="R2D4V0qq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783088404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pqV9tYAJbMQgBPwMfUhu5T5DkHJyOcs8Cw7mbDaUbE=;
	b=R2D4V0qqAnzjnV7SCLei2aJmLzeW0UyGvrV4nVKfmVntxzMsvFx/v62QcQVf72wdp29kS9
	WZdZ7MyM8zKqajTO9iawHMSsRiUiPrAfNqezIHubNYgTOihG9TEczvEflklrT3q76a8V82
	4uJ/N1FDBqiyV/qEIjGsibF4u7C+jL8=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] builtin/refs: add "create" subcommand
In-Reply-To: <20260630-pks-refs-writing-subcommands-v3-4-deb04de1ecef@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
 <20260630-pks-refs-writing-subcommands-v3-4-deb04de1ecef@pks.im>
Date: Fri, 03 Jul 2026 16:19:58 +0200
Message-ID: <87qzlk2m0h.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The "update" subcommand cannot only update an existing reference, but it
> can also create new branches and delete existing branches by specifying
> the all-zeroes object ID as either old or new value. Despite that, we
> already have the "delete" subcommand as a handy shortcut so that a user
> can easily delete a branch. This relieves them of needing to understand
> the more arcane uses of the "update" command, and of counting the number
> of zeroes they need to pass.
>
> But while we have a "delete" subcommand, we don't have an equivalent
> that would allow the user to create a new branch, which creates a
> certain asymmetry.
>
> Add a new "create" subcommand to plug this gap.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-refs.adoc |   5 ++
>  builtin/refs.c              |  52 +++++++++++++++
>  t/meson.build               |   1 +
>  t/t1466-refs-create.sh      | 151 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 209 insertions(+)
>
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index 6475bdcc62..e6a3528349 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -20,6 +20,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
>  		   [ --stdin | (<pattern>...)]
>  git refs exists <ref>
>  git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
> +git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>
>  git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]
>  git refs update [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value> [<old-value>]
>  
> @@ -53,6 +54,10 @@ optimize::
>  	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
>  	offers identical functionality.
>  
> +create::
> +	Create the given reference, which must not already exist, pointing at
> +	`<new-value>`.
> +
>  delete::
>  	Delete the given reference. This subcommand mirrors `git update-ref -d`
>  	(see linkgit:git-update-ref[1]). When `<old-value>` is given, the
> diff --git a/builtin/refs.c b/builtin/refs.c
> index 08453ae1c8..1ebaf30149 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -21,6 +21,9 @@
>  #define REFS_OPTIMIZE_USAGE \
>  	N_("git refs optimize " PACK_REFS_OPTS)
>  
> +#define REFS_CREATE_USAGE \
> +	N_("git refs create [--message=<reason>] [--no-deref] [--create-reflog] <ref> <new-value>")
> +
>  #define REFS_DELETE_USAGE \
>  	N_("git refs delete [--message=<reason>] [--no-deref] <ref> [<old-value>]")
>  
> @@ -181,6 +184,53 @@ static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
>  	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
>  }
>  
> +static int cmd_refs_create(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo)
> +{
> +	static char const * const refs_create_usage[] = {
> +		REFS_CREATE_USAGE,
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

Can `git refs create --no-deref` be used to create symrefs? Should we
add a test for that? Or can it not

I understand the symmetry, but does it make sense to ask the user to
create symrefs with `--no-deref`? Feels a bit obscure. The docs say:

`--no-deref`::
	Operate on <ref> itself rather than the reference it points to via a
	symbolic ref.

That's far from obvious for a user to realize they need to pass that
option if they want to create a symref.

> +		OPT_BIT(0, "create-reflog", &flags, N_("create a reflog"),
> +			REF_FORCE_CREATE_REFLOG),
> +		OPT_END(),
> +	};
> +	struct object_id newoid;
> +	const char *refname;
> +	int ret;
> +
> +	argc = parse_options(argc, argv, prefix, opts, refs_create_usage, 0);
> +	if (argc != 2)
> +		usage(_("create requires reference name and an object ID"));
> +
> +	if (message && !*message)
> +		die(_("refusing to perform update with empty message"));
> +
> +	repo_config(repo, git_default_config, NULL);
> +
> +	refname = argv[0];
> +	if (repo_get_oid_with_flags(repo, argv[1], &newoid, GET_OID_SKIP_AMBIGUITY_CHECK))
> +		die(_("invalid object ID: '%s'"), argv[1]);
> +	if (is_null_oid(&newoid))
> +		die(_("cannot create reference with null new object ID"));
> +
> +	ret = refs_update_ref(get_main_ref_store(repo), message, refname,
> +			      &newoid, null_oid(repo->hash_algo), flags,
> +			      UPDATE_REFS_MSG_ON_ERR);
> +
> +	if (ret < 0)
> +		ret = 1;
> +	return ret;
> +}
> +
>  static int cmd_refs_delete(int argc, const char **argv, const char *prefix,
>  			   struct repository *repo)
>  {
> @@ -288,6 +338,7 @@ int cmd_refs(int argc,
>  		"git refs list " COMMON_USAGE_FOR_EACH_REF,
>  		REFS_EXISTS_USAGE,
>  		REFS_OPTIMIZE_USAGE,
> +		REFS_CREATE_USAGE,
>  		REFS_DELETE_USAGE,
>  		REFS_UPDATE_USAGE,
>  		NULL,
> @@ -299,6 +350,7 @@ int cmd_refs(int argc,
>  		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
>  		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
>  		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
> +		OPT_SUBCOMMAND("create", &fn, cmd_refs_create),
>  		OPT_SUBCOMMAND("delete", &fn, cmd_refs_delete),
>  		OPT_SUBCOMMAND("update", &fn, cmd_refs_update),
>  		OPT_END(),
> diff --git a/t/meson.build b/t/meson.build
> index 2063962dab..541e6f919c 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -225,6 +225,7 @@ integration_tests = [
>    't1463-refs-optimize.sh',
>    't1464-refs-delete.sh',
>    't1465-refs-update.sh',
> +  't1466-refs-create.sh',
>    't1500-rev-parse.sh',
>    't1501-work-tree.sh',
>    't1502-rev-parse-parseopt.sh',
> diff --git a/t/t1466-refs-create.sh b/t/t1466-refs-create.sh
> new file mode 100755
> index 0000000000..cfb21bf863
> --- /dev/null
> +++ b/t/t1466-refs-create.sh
> @@ -0,0 +1,151 @@
> +#!/bin/sh
> +
> +test_description='git refs create'
> +
> +. ./test-lib.sh
> +
> +setup_repo () {
> +	git init "$1" &&
> +	test_commit -C "$1" A &&
> +	test_commit -C "$1" B
> +}
> +
> +test_ref_matches () {
> +	git rev-parse "$1" >expect &&
> +	echo "$2" >actual &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'create a new reference' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git refs create refs/heads/foo $A &&
> +		test_ref_matches refs/heads/foo "$A"
> +	)
> +'
> +
> +test_expect_success 'create fails when the reference already exists' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		B=$(git rev-parse B) &&
> +		git refs create refs/heads/foo $A &&
> +		test_must_fail git refs create refs/heads/foo $B 2>err &&
> +		test_grep "reference already exists" err &&
> +		test_ref_matches refs/heads/foo "$A"
> +	)
> +'

I was curious about this test:

	test_expect_success 'create succeed when the reference exists with the same value' '
		test_when_finished "rm -rf repo" &&
		setup_repo repo &&
		(
			cd repo &&
			A=$(git rev-parse A) &&
			git refs create refs/heads/foo $A &&
			git refs create refs/heads/foo $A &&
			test_ref_matches refs/heads/foo "$A"
		)
	'

That fails. It that intentional?

> +
> +test_expect_success 'create with null new value fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git refs create refs/heads/foo $ZERO_OID 2>err &&
> +		test_grep "null new object ID" err &&
> +		test_must_fail git refs exists refs/heads/foo
> +	)
> +'
> +
> +test_expect_success 'create with invalid new value fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git refs create refs/heads/foo invalid-oid 2>err &&
> +		test_grep "invalid object ID" err &&
> +		test_must_fail git refs exists refs/heads/foo
> +	)
> +'
> +
> +test_expect_success 'create does not create a reflog by default' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git refs create refs/foo $A &&
> +		test_must_fail git reflog exists refs/foo
> +	)
> +'
> +
> +test_expect_success 'create creates a reflog with --create-reflog' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git refs create --create-reflog refs/foo $A &&
> +		git reflog exists refs/foo
> +	)
> +'
> +
> +test_expect_success 'create with message records reason in reflog' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git refs create --message="create reason" refs/heads/foo $A &&
> +		git reflog show refs/heads/foo >actual &&
> +		test_grep "create reason$" actual
> +	)
> +'
> +
> +test_expect_success 'create with symref target creates target reference' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git symbolic-ref refs/heads/symref refs/heads/target &&
> +		git refs create refs/heads/symref $A &&
> +		git reflog exists refs/heads/target
> +	)
> +'
> +
> +test_expect_success 'create with symref target and --no-deref refuses to create reference' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git symbolic-ref refs/heads/symref refs/heads/target &&
> +		test_must_fail git refs create --no-deref refs/heads/symref $A 2>err &&
> +		test_grep "dangling symref already exists" err &&
> +		test_must_fail git reflog exists refs/heads/target
> +	)
> +'

Would it make sense to add this test:

	test_expect_success 'create with symref target with --no-deref' '
		test_when_finished "rm -rf repo" &&
		setup_repo repo &&
		(
			cd repo &&
			A=$(git rev-parse A) &&
			git refs create refs/heads/target $A &&
			git refs create --no-deref refs/heads/symref refs/heads/target &&
			git reflog exists refs/heads/symref && false
		)
	'

But that makes me think, this option `--no-deref` is pretty obscure for
use with `git refs create`. There are two situations:

* The symref doesn't exists: so --no-deref basically is forcing the
  command to create a symref. That's confusing
* The symref exists already: then the question is, does the user know it
  exists:
   - The user knows: so they pass --no-deref because they know it exists
     and they want to create a symref. But why run `create` then anyway?
   - The user doesn't know: brings us back to the first asterisk,
     passing in `--no-deref` to create a symref, making it a weird
     option name.


> +
> +test_expect_success 'create with empty message fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		test_must_fail git refs create --message= refs/heads/foo $A 2>err &&
> +		test_grep "empty message" err &&
> +		test_must_fail git refs exists refs/heads/foo
> +	)
> +'
> +
> +test_expect_success 'create without arguments fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	test_must_fail git -C repo refs create 2>err &&
> +	test_grep "requires reference name" err
> +'
> +
> +test_expect_success 'create with too many arguments fails' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	test_must_fail git -C repo refs create refs/heads/foo a b 2>err &&
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
