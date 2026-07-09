Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593D38E8AB
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590800; cv=none; b=GJtRSCNiD2qMxuWbSYtkrr1DeLd4UB9BgFFkgcdgUtyyhg5iR5JNQ5wyfkT29+cG1c2w96DBj55tgpp4aawoU3gJlyzRUuDLnly6PvDAIVk2E2IQsgr8kxc5ECi8iu/KRr9Ad6ojmDVPltY+Mtb3I5zj6o/yN4o9rSVL8Iuf7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590800; c=relaxed/simple;
	bh=nhhjesFmM/c0nXw7zDM6oRkK247jGL7kELURhV2znZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OAhhhvCG00EtetjweDTXkyymqPy66HmGQ10V+3SKNP4mc7jYCeBC+tMo2EJ3aM+FdGvxqCRfgzx/jpac1Cz+csczjILYJgs4I102U2xMF+h4DGpr636xPK0yuFZKECM17KVNd0QKzZWthCp9FbZv+F8pL5HnX5O1VriwEvoKptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=bMmTIvHw; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="bMmTIvHw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783590797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAwU7SfbaX/zY0nYlTeGX8109qUNADu0iukBmLlSHrc=;
	b=bMmTIvHw5sfDCfMzbRhVblyFAYBFqL+61txaGT5FW1TWsp7alemaevKhJuaofOsppbewVl
	VuHGb60u2enD5sVjxowEwiX4zFoWfHOyydPT4/vgUzWNYVN15oo3buKE2fRV9M1NaPKD3m
	eC/KWJx194PQ2rDQxJgClElFCeQVy08=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] builtin/refs: add "create" subcommand
In-Reply-To: <aktVdaB2xRk-iI_8@pks.im>
References: <20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im>
 <20260630-pks-refs-writing-subcommands-v3-4-deb04de1ecef@pks.im>
 <87qzlk2m0h.fsf@emacs.iotcl.com> <aktVdaB2xRk-iI_8@pks.im>
Date: Thu, 09 Jul 2026 11:53:06 +0200
Message-ID: <87zf00mqv1.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jul 03, 2026 at 04:19:58PM +0200, Toon Claes wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
>> > index 6475bdcc62..e6a3528349 100644
>> > --- a/Documentation/git-refs.adoc
>> > +++ b/Documentation/git-refs.adoc
>> > @@ -181,6 +184,53 @@ static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
>> >  	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
>> >  }
>> >  
>> > +static int cmd_refs_create(int argc, const char **argv, const char *prefix,
>> > +			   struct repository *repo)
>> > +{
>> > +	static char const * const refs_create_usage[] = {
>> > +		REFS_CREATE_USAGE,
>> > +		NULL
>> > +	};
>> > +	const char *message = NULL;
>> > +	unsigned flags = 0;
>> > +	struct option opts[] = {
>> > +		OPT_STRING(0, "message", &message, N_("reason"),
>> > +			   N_("reason of the update")),
>> > +		OPT_BIT(0 ,"no-deref", &flags,
>> > +			N_("update <refname> not the one it points to"),
>> > +			REF_NO_DEREF),
>> 
>> Can `git refs create --no-deref` be used to create symrefs? Should we
>> add a test for that? Or can it not
>> 
>> I understand the symmetry, but does it make sense to ask the user to
>> create symrefs with `--no-deref`? Feels a bit obscure. The docs say:
>> 
>> `--no-deref`::
>> 	Operate on <ref> itself rather than the reference it points to via a
>> 	symbolic ref.
>> 
>> That's far from obvious for a user to realize they need to pass that
>> option if they want to create a symref.
>
> It doesn't cause them to create a symref. What this flag controls is
> whether the command would fail when the refname exists already as a
> symbolic ref. That is:
>
>     $ git symbolic-ref refs/heads/symref refs/heads/target
>     $ git refs create refs/heads/symref $OID
>     $ git refs exists refs/heads/target

That makes sense. Sort of.

So passing `--no-deref` to `git refs create` in the example above would
make sense if you want creation of refs/heads/target to fail. Okay,
doesn't seem very obvious, but feels correct.

> The git-refs(1) command would have created "refs/heads/target" in this
> case, and by passing "--no-deref" you'd instead make it fail.
>
> This flag is somewhat weird. Having it is probably a sensible think to
> do, but now that I think about it I wonder whether the default makes all
> that much sense in the first place. That being said, _if_ we want to
> change it then we should change it for all subcommands.

Not sure how to make it better, so let's leave it like this.

>> > diff --git a/t/t1466-refs-create.sh b/t/t1466-refs-create.sh
>> > new file mode 100755
>> > index 0000000000..cfb21bf863
>> > --- /dev/null
>> > +++ b/t/t1466-refs-create.sh
>> > @@ -0,0 +1,151 @@
> [snip]
>> > +test_expect_success 'create fails when the reference already exists' '
>> > +	test_when_finished "rm -rf repo" &&
>> > +	setup_repo repo &&
>> > +	(
>> > +		cd repo &&
>> > +		A=$(git rev-parse A) &&
>> > +		B=$(git rev-parse B) &&
>> > +		git refs create refs/heads/foo $A &&
>> > +		test_must_fail git refs create refs/heads/foo $B 2>err &&
>> > +		test_grep "reference already exists" err &&
>> > +		test_ref_matches refs/heads/foo "$A"
>> > +	)
>> > +'
>> 
>> I was curious about this test:
>> 
>> 	test_expect_success 'create succeed when the reference exists with the same value' '
>> 		test_when_finished "rm -rf repo" &&
>> 		setup_repo repo &&
>> 		(
>> 			cd repo &&
>> 			A=$(git rev-parse A) &&
>> 			git refs create refs/heads/foo $A &&
>> 			git refs create refs/heads/foo $A &&
>> 			test_ref_matches refs/heads/foo "$A"
>> 		)
>> 	'
>> 
>> That fails. It that intentional?
>
> Yes, this is intentional. We didn't end up creating the reference, which
> is what the user has asked us to do, and hence we fail.

Understood.

>> > +test_expect_success 'create with symref target and --no-deref refuses to create reference' '
>> > +	test_when_finished "rm -rf repo" &&
>> > +	setup_repo repo &&
>> > +	(
>> > +		cd repo &&
>> > +		A=$(git rev-parse A) &&
>> > +		git symbolic-ref refs/heads/symref refs/heads/target &&
>> > +		test_must_fail git refs create --no-deref refs/heads/symref $A 2>err &&
>> > +		test_grep "dangling symref already exists" err &&
>> > +		test_must_fail git reflog exists refs/heads/target
>> > +	)
>> > +'
>> 
>> Would it make sense to add this test:
>> 
>> 	test_expect_success 'create with symref target with --no-deref' '
>> 		test_when_finished "rm -rf repo" &&
>> 		setup_repo repo &&
>> 		(
>> 			cd repo &&
>> 			A=$(git rev-parse A) &&
>> 			git refs create refs/heads/target $A &&
>> 			git refs create --no-deref refs/heads/symref refs/heads/target &&
>> 			git reflog exists refs/heads/symref && false
>> 		)
>> 	'
>> 
>> But that makes me think, this option `--no-deref` is pretty obscure for
>> use with `git refs create`. There are two situations:
>> 
>> * The symref doesn't exists: so --no-deref basically is forcing the
>>   command to create a symref. That's confusing
>
> No, it's not. It tells us that we only want to create the reference if
> it doesn't exist and is not a symref. Otherwise, we'd potentially create
> the reference that the symref is pointing to.

Okay, I better understand now with the example above. Thanks!

-- 
Cheers,
Toon
