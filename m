Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67258222D68
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607435; cv=none; b=EssxfOjZ8XaoX8bfSlqLBZ+8CiTcPCgbbbNar8qPOpdtNClIJgkY5h3wKWU9wqBEPBIZAkYpJkjFtkHzkSkmIALPapSy1v3MUcDEd/WE5ywXXnti8lRpMzPbtqel7ZguIdswS7CaYl6vSfLydb4JHD8CwTaxFZ0YZs9W7fve3a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607435; c=relaxed/simple;
	bh=bwlZAm4jQt+oeBJPegFyxvXri0dRcy7ifjaxpCXtWio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmUqzodJc8aAsXYSNuQa29/9utOM0kzsPvxunhy/aUNr/q9FCh+QiclNKLMm5HXbPjR5nPaNJ50jHF6pv1otffBcJpvjk5j3LcItFZha1I5P8sVPUnr0dgYRExYF1EC7paVPKRdTcD7gEHWECTC734bWATWM55a6KENACjcxHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=EmuvMMDy; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="EmuvMMDy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734607425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i06nl8oEEYoL5ZLOJZeGBdScP5wZ5JdRZiXrHZ7UA/I=;
	b=EmuvMMDyDrKC86batUsTE+GE2gyq133Vpopg188bjZomtnrdeugWuFCKppefbd3NpmB6Kw
	dbHuE2VsFH0932b8WnZ4Iu11hxBQSsqc+ulP1vBKvg+f6muDdsD06XseWkSIyHi1g/+qut
	uUSfuwK6o3uo1pjLQea+KzKq3iDuLDE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>
Subject: Re: [PATCH v2] builtin/clone: teach git-clone(1) the --revision=
 option
In-Reply-To: <Z02_YwCgHp_MVj3M@pks.im>
References: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>
 <Z02_YwCgHp_MVj3M@pks.im>
Date: Thu, 19 Dec 2024 12:23:30 +0100
Message-ID: <87ttazhq6l.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

>> conjunction with `--depth` to do a minimal clone that only contains the
>> sources for a single revision. This can be useful for automated tests.
>
> It's implicity, but automated tests in this context probably means CI
> systems.

I wasn't sure which term is more commonly used in commit messages here.
I know some people consider CI to be a completely different thing from
"automated testing", that's why I didn't use "CI". I'll modify the
message to be more explicit and say something like:

    This can be useful for automated tests running in CI systems.

>> This type of shallow clone could also be achieved with the following set
>> of commands:
>> 
>>     git init the-repo
>>     cd ./the-repo
>>     git remote add origin <url>
>>     git fetch --depth=1 origin <commit-id>
>>     git checkout <commit-id>
>> 
>> Unfortunately, this approach uses git-fetch(1) instead of git-clone(1),
>> and only on git-clone(1) the bundle URIs advertised by the server are
>> used. By adding this option `--revision` to git-clone(1) allows us to
>> get the same end result, while benefiting from bundle URIs if advertised
>> by the server.
>
> I'd claim that this is not only about enabling bundle URIs, but also
> about making this easier to work with in the first place. The above is
> rather on the complex side even though the use case at hand is not all
> that esoteric.

Okay, that's fair. I'll add that to the commit message as well.

>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> index 7acb4cb17618c6cbee5d6ebe41a53be03ebfaa6c..2a3f6d9deae4b817db50d8c4e555a6f33b8296f1 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -218,6 +218,13 @@ objects from the source repository into a pack in the cloned repository.
>>  	`--branch` can also take tags and detaches the `HEAD` at that commit
>>  	in the resulting repository.
>>  
>> +`--revision` _<rev>_::
>> +	This clones the given revision, and that revision only. The argument can
>> +	be a symbolic ref name (e.g. `refs/heads/main`), or a raw commit hash.
>
> Nit: while I know what you want to say with "symbolic ref name", I think
> it's a bit awkwardly worded because a reader may confuse it with an
> actual symbolic ref. I would just drop the "symbolic".
>
> We should also clarify whether this accepts tags that peel down to a
> commit.

Makes sense, I'll modify this piece of documentation a bit.

>> +	Unless the revision points to a branch (i.e. ref starting with
>> +	`refs/heads/`), the HEAD is detached.
>
> Okay, makes sense. When cloning a tag or committish we wouldn't know how
> to name the branch, so we instead put us into detached HEAD mode.
>
> I could see an argument that we should do this unconditionally even when
> cloning a branch to simplify the UX by always doing the same thing, no
> matter what the user has passed.

I've been thinking about this as well, but I didn't see any benefit to
the user in making branches detach as well. The existing option
`--branch` detaches only when it resolves to a tag, so we would have
similar behavior. Plus, I would have to add extra code to detach a
branch, so I left it out and would wait for feedback from review here
whether detaching a branch would be better.

>> +	This option is incompatible with `--branch`, `--mirror`, and `--bare`.
>
> The restriction on `--branch` and `--mirror` is sensible: we ask for a
> single commit, so neither of those options would make sense when taken
> together.
>
> But why can't we pass `--bare`? That only controls whether we have a
> working tree or not, and a bare repository can have a detached HEAD, as
> well.

Hah, good point. It felt to me it was incompatible, but after some
testing it *is* compatible. I'll remove the limitation.

>>  `-u` _<upload-pack>_::
>>  `--upload-pack` _<upload-pack>_::
>>  	When given, and the repository to clone from is accessed
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index c0013c75cdc7672abced893c36d2aaf4ff246045..0b118388e059068e78ac1eff4c0a9685a1c4e26b 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -69,6 +69,7 @@ static char *option_template, *option_depth, *option_since;
>>  static char *option_origin = NULL;
>>  static char *remote_name = NULL;
>>  static char *option_branch = NULL;
>> +static char *option_rev = NULL;
>>  static struct string_list option_not = STRING_LIST_INIT_NODUP;
>>  static const char *real_git_dir;
>>  static const char *ref_format;
>> @@ -141,6 +142,8 @@ static struct option builtin_clone_options[] = {
>>  		   N_("use <name> instead of 'origin' to track upstream")),
>>  	OPT_STRING('b', "branch", &option_branch, N_("branch"),
>>  		   N_("checkout <branch> instead of the remote's HEAD")),
>> +	OPT_STRING(0, "revision", &option_rev, N_("rev"),
>> +		   N_("clone single revision <rev> and check out")),
>>  	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
>>  		   N_("path to git-upload-pack on the remote")),
>>  	OPT_STRING(0, "depth", &option_depth, N_("depth"),
>> @@ -682,12 +685,14 @@ static void update_head(const struct ref *our, const struct ref *remote,
>>  			install_branch_config(0, head, remote_name, our->name);
>>  		}
>>  	} else if (our) {
>> -		struct commit *c = lookup_commit_reference(the_repository,
>> -							   &our->old_oid);
>> -		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
>> -		refs_update_ref(get_main_ref_store(the_repository), msg,
>> -				"HEAD", &c->object.oid, NULL, REF_NO_DEREF,
>> -				UPDATE_REFS_DIE_ON_ERR);
>> +		struct commit *c =
>> +			lookup_commit_reference(the_repository, &our->old_oid);
>> +
>> +		if (c)
>> +			/* --branch specifies a non-branch (i.e. tags), detach HEAD */
>> +			refs_update_ref(get_main_ref_store(the_repository), msg,
>> +					"HEAD", &c->object.oid, NULL,
>> +					REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
>
> This change is a bit surprising. Why can it happen that we don't have
> the commit now?

For the added test case (8) "clone with --revision being a tree hash" we
would hit a segmentation fault without this fix. So when the user would
pass a object ID that's not a commit, we'd hit this code.

But I've realized we end up with `c` being `NULL` also in case a tree
oid was passed to `--revision`. This is what happens in that case:

    Cloning into 'dst'...
    done.
    error: object be0788944df13c5d170e050f2fe178360c3df5a5 is a tree, not a commit
    warning: remote HEAD refers to nonexistent ref, unable to checkout

This is not correct. We should die hard in that situation. I'm fixing
that. 

>>  	} else if (remote) {
>>  		/*
>>  		 * We know remote HEAD points to a non-branch, or
>> @@ -889,7 +894,7 @@ static void write_refspec_config(const char *src_ref_prefix,
>>  	struct strbuf key = STRBUF_INIT;
>>  	struct strbuf value = STRBUF_INIT;
>>  
>> -	if (option_mirror || !option_bare) {
>> +	if (!option_rev && (option_mirror || !option_bare)) {
>>  		if (option_single_branch && !option_mirror) {
>>  			if (option_branch) {
>>  				if (starts_with(our_head_points_at->name, "refs/tags/"))
>> @@ -968,7 +973,7 @@ int cmd_clone(int argc,
>>  	char *repo_to_free = NULL;
>>  	char *path = NULL, *dir, *display_repo = NULL;
>>  	int dest_exists, real_dest_exists = 0;
>> -	const struct ref *refs, *remote_head;
>> +	const struct ref *refs = NULL, *remote_head;
>>  	struct ref *remote_head_points_at = NULL;
>>  	const struct ref *our_head_points_at;
>>  	char *unborn_head = NULL;
>> @@ -1345,6 +1350,18 @@ int cmd_clone(int argc,
>>  
>>  	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
>>  
>> +	if (option_rev) {
>> +		if (option_branch)
>> +			die(_("options '%s' and '%s' cannot be used together"),
>> +			    "--revision", "--branch");
>> +		if (option_mirror)
>> +			die(_("options '%s' and '%s' cannot be used together"),
>> +			    "--revision", "--mirror");
>> +		if (option_bare)
>> +			die(_("options '%s' and '%s' cannot be used together"),
>> +			    "--revision", "--bare");
>> +	}
>> +
>>  	if (reject_shallow)
>>  		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
>>  	if (option_depth)
>
> We have `die_for_incompatible_opt{3,4}()`, but don't yet have the
> eqiuvalent for two options. I know this has come up repeatedly during
> reviews. Maybe we should finally add that helper in a separate commit?

I didn't know about those. Although because it's only a few lines in
parse-options.h, I'm including it in the same commit. But I can split up
if you prefer? I didn't touch any of the existing code in clone.c that
also could use this function, or should I?

>> @@ -1387,7 +1404,27 @@ int cmd_clone(int argc,
>>  		strvec_push(&transport_ls_refs_options.ref_prefixes,
>>  			    "refs/tags/");
>>  
>> -	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
>> +	if (option_rev) {
>> +		refspec_clear(&remote->fetch);
>
> Why do we have to clear the fetchspec first? I would have expected us to
> skip over any previous steps that may have populated it when given the
> "--revision=" option.

There are various places where we add items to `remote->fetch` and
`transport_ls_refs_options.ref_prefixes`. To me it felt way more
complicated to wrap them in `if (!option_rev)`.

>> +		refspec_init(&remote->fetch, REFSPEC_FETCH);
>> +		refspec_append(&remote->fetch, option_rev);
>> +
>> +		strvec_clear(&transport_ls_refs_options.ref_prefixes);
>> +		refspec_ref_prefixes(&remote->fetch,
>> +				     &transport_ls_refs_options.ref_prefixes);
>> +
>> +		if (transport_ls_refs_options.ref_prefixes.nr == 0)
>> +			/*
>> +			 * We need to talk to the server to determine the hash
>> +			 * algorithm, but when no ref prefixes are set the
>> +			 * server announces all known refs, so ask the server to
>> +			 * only tell us about HEAD.
>> +			 */
>> +			strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
>> +	}
>> +
>> +	refs = transport_get_remote_refs(transport,
>> +					 &transport_ls_refs_options);
>>  
>>  	/*
>>  	 * Now that we know what algorithm the remote side is using, let's set
>> @@ -1461,8 +1498,13 @@ int cmd_clone(int argc,
>>  		}
>>  	}
>>  
>> -	if (refs)
>> +	if (option_rev) {
>> +		struct ref **tail = &mapped_refs;
>> +
>> +		get_fetch_map(refs, &remote->fetch.items[0], &tail, 1);
>> +	} else if (refs) {
>>  		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
>> +	}
>>  
>>  	if (mapped_refs) {
>>  		/*
>> @@ -1495,6 +1537,8 @@ int cmd_clone(int argc,
>>  		if (!our_head_points_at)
>>  			die(_("Remote branch %s not found in upstream %s"),
>>  			    option_branch, remote_name);
>> +	} else if (option_rev) {
>> +		our_head_points_at = mapped_refs;
>>  	} else if (remote_head_points_at) {
>>  		our_head_points_at = remote_head_points_at;
>>  	} else if (remote_head) {
>> diff --git a/t/t5620-clone-revision.sh b/t/t5620-clone-revision.sh
>> new file mode 100755
>> index 0000000000000000000000000000000000000000..833438e46d1c648ca46cf9d0a2948aad261c7f89
>> --- /dev/null
>> +++ b/t/t5620-clone-revision.sh
>> @@ -0,0 +1,97 @@
>> +#!/bin/sh
>> +
>> +test_description='tests for git clone --revision'
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +
>> +TEST_PASSES_SANITIZE_LEAK=true
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +	test_commit --no-tag "initial commit" README "Hello" &&
>> +	test_commit "second commit" README "Hello world" v1.0 &&
>> +	test_commit --no-tag "third commit" README "Hello world!" &&
>> +	git switch -c feature v1.0 &&
>> +	test_commit --no-tag "feature commit" README "Hello world!" &&
>> +	git switch main
>> +'
>> +
>> +test_expect_success 'clone with --revision being a branch' '
>> +	test_when_finished "rm -rf dst" &&
>> +	git clone --revision=refs/heads/feature . dst &&
>> +	git rev-parse refs/heads/feature >expect &&
>> +	git -C dst rev-parse HEAD >actual &&
>> +	test_cmp expect actual &&
>> +	git for-each-ref refs/heads/feature > expect &&
>> +	git -C dst for-each-ref > actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'clone with --depth and --revision being a branch' '
>> +	test_when_finished "rm -rf dst" &&
>> +	git clone --depth=1 --revision=refs/heads/feature . dst &&
>> +	git rev-parse refs/heads/feature >expect &&
>> +	git -C dst rev-parse HEAD >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'clone with --revision being a tag' '
>> +	test_when_finished "rm -rf dst" &&
>> +	git clone --revision=refs/tags/v1.0 . dst &&
>> +	git rev-parse refs/tags/v1.0 >expect &&
>> +	git -C dst rev-parse HEAD >actual &&
>> +	test_cmp expect actual
>> +'
>
> Is this an annotated tag or a normal one?

Good call, it was a lightweight tag. I'll change it into a annotated.

>> +test_expect_success 'clone with --revision being HEAD' '
>> +	test_when_finished "rm -rf dst" &&
>> +	git clone --revision=HEAD . dst &&
>> +	git rev-parse HEAD >expect &&
>> +	git -C dst rev-parse HEAD >actual &&
>> +	test_cmp expect actual
>> +'
>
> Ah, interesting. So we can essentially clone whatever the remote HEAD
> points to. Nice.
>
>> +test_expect_success 'clone with --revision being a raw commit hash' '
>> +	test_when_finished "rm -rf dst" &&
>> +	oid=$(git rev-parse refs/heads/feature) &&
>> +	git clone --revision=$oid . dst &&
>> +	echo $oid >expect &&
>> +	git -C dst rev-parse HEAD >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'clone with --revision being a short raw commit hash' '
>> +	test_when_finished "rm -rf dst" &&
>> +	oid=$(git rev-parse --short refs/heads/feature) &&
>> +	git clone --revision=$oid . dst 2>err &&
>> +	grep "warning: remote HEAD refers to nonexistent ref, unable to checkout" err
>> +'
>
> You probably want to use `test_grep` for these.

Ah, TIL.

> What makes me wonder though is that these clones don't fail, but
> generate a warning because we don't understand the ref. I would have
> expected us to either bail out completely or succeed and end up with a
> well-formed repository that has the commit in question checked out.

Because this code path exists already, I considered it to be valid. But
it's good you're making me aware of this, because if we were not able to
resolve the given revision, we should die right there.

Thanks for all the feedback. The second version will be sent out soon.

-- 
Toon
