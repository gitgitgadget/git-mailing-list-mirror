Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA95266A7
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036166; cv=none; b=dqZOEw8ca6qNdhOR2uQp4+NfF7IXDvUz5SLkaCE4P5BPoteh35k15wkLpWALcIM1k8PMzUFbPRlZAngut1TxrLMBIChBSe6gcGapn0bUJfVXWd7dkpd0ZvWGpS7BRTPksn5fiJNUysgB1UO6xqFwRYoNauCEAu1hkW5g4eucLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036166; c=relaxed/simple;
	bh=wuQ2qKNBdvVfav++oxIGe+ir3HCiK0V0zYDsfXaVtK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eyHy0cy5JC2C2MXOMZwTqk2o2+dLAZ9iZpeyraqZuLZQ4DasUv4XdgbP9WJ9SqHxu30ZIBh3YG0Nfjor9rKRN3ipaRj1ealEtiEK8a4En98C4Rz2gvK2HIqDmOY6BLQTh/xRH7k0x/vJzyMnSmUcD7cDSxzA00OLxsNuSdSPCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5PurncqS; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5PurncqS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1758036159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMQTO98fxX4ulPX5m8AvXjuTbii6VD8h8/OdZB0ULwI=;
	b=5PurncqSoO/s+amscgf1z+0Sb8H03vYXXv7BwD9cSzWy+hfDG11VBt1tHCs4pLkT1yM01p
	LURV6Gnzoqujf5idYn1Rr91doiy5P4xNW3VwOtTnb5JHxXmfR6Uf8k2rZwGisAxl0h2MYQ
	y8FMWayQjTLLnLzomVY7f27zjuh+aNs=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] combine-diff: don't override recursive flag in
 diff_tree_combined()
In-Reply-To: <aMkNiC_s-Dt4iRPp@pks.im>
References: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
 <aMkNiC_s-Dt4iRPp@pks.im>
Date: Tue, 16 Sep 2025 17:22:21 +0200
Message-ID: <87ecs6o21e.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Sep 05, 2025 at 03:06:31PM +0200, Toon Claes wrote:
>> Function diff_tree_combined() copies the 'struct diff_options' from the
>> input 'struct rev_info' to override some flags. One flag was
>> 'recursive', which is set to 1. This has been the case since the
>> inception of this function in af3feefa1d (diff-tree -c: show a merge
>> commit a bit more sensibly., 2006-01-24). From that commit there's no
>> clear indication why recursive is overridden. But this breaks the
>> recently introduced subcommand git-last-modified(1) in some cases
>> (i.e. when criss-cross merges are involved). It then would exit with the
>> error:
>> 
>>     BUG: paths remaining beyond boundary in last-modified
>> 
>> The last-modified machinery uses a hashmap for all the files it wants to
>> get the last-modified commit for. Through log_tree_commit() the callback
>> mark_path() is called. Here the incoming path is looked up in the
>> hashmap, but because the diff-tree machinery internally switched to
>> recursive (even if the last-modified machinery wasn't) the entry for
>> 'dir' was never expelled from the hashmap, and the BUG() statement was
>> hit.
>
> Okay. So if I understand correctly, the issue here is that once we do a
> recursive diff we skip directory entries and only print blobs. And
> because of that we never manage to blame the directory to any specific
> commit.
>
> What this doesn't explain though is how this is related to criss-cross
> merges. Why does the error not happen with "normal" merges?

To be honest, I don't exactly understand what's happening. Depending on
conditions(??) it determines a change is attributed to a merge commit.
When this is the cases, we run into a different code path in
log_tree_diff() in log-tree.c (see `is_merge`). One scenario I managed
to reproduce is condition is when using criss-cross merges. It seems to
me the diff machinery tries to find the commit that actually introduced
the change, ignoring the commit that merged that commit. In case of
criss-cross merges, it's hard to find the commit that made the change,
so it attributes the change to a merge commit. And then we run into the
code path that was causing this error.

>> Remove overriding 'diffopt.flags.recursive' in diff_tree_combined() and
>> move setting this flag to the callers which relied on the recursive
>> behavior.
>> 
>> Because internally diff-tree no longer runs recursive, this results in a
>> nice speedup when running `git last-modified` on git.git:
>
> I assume this is only the case for `git last-modified --no-recursive`,
> right?

Yes, that's the default.

> Do we know to set `diffopt.flags.recursive` in that case already,
> or do we handle recursion manually in that case?

git-last-modified sets that flag when `-r` or `--recursive` is given.
That flag is passed down to diff_tree_combined(), which reuses that
value (and no longer overrided it). Does that answer your question?

>> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
>> index 49dd4d00ebf1bcc644383ee99df3a9e05502b89b..6ef0438d36dd1091d2806b46306f2b5ee7274bc0 100644
>> --- a/builtin/diff-tree.c
>> +++ b/builtin/diff-tree.c
>> @@ -16,10 +16,21 @@ static struct rev_info log_tree_opt;
>>  
>>  static int diff_tree_commit_oid(const struct object_id *oid)
>>  {
>> +	struct rev_info rev_info = log_tree_opt;
>>  	struct commit *commit = lookup_commit_reference(the_repository, oid);
>> +
>>  	if (!commit)
>>  		return -1;
>> -	return log_tree_commit(&log_tree_opt, commit);
>> +
>> +	/*
>> +	 * log_tree_commit() calls into diff_tree_combined() which historically
>> +	 * used to enable diffopt.flags.recursive when option '-c' is given.
>> +	 * To not break backward compatibility, set 'resursive' here.
>> +	 */
>> +	if (rev_info.combine_merges)
>> +		rev_info.diffopt.flags.recursive = 1;
>> +
>> +	return log_tree_commit(&rev_info, commit);
>>  }
>>  
>>  /* Diff one or more commits. */
>
> Don't we have to do the same dance for `stdin_diff_commit()`? There's
> also callsites in git-am(1), git-log(1) and others. Why don't we have to
> adjust any of those?

Good question. I can address these in the next version.

>> diff --git a/combine-diff.c b/combine-diff.c
>> index 3878faabe7bb2f7c80cffbf3add6123f17960627..305414efdf436d53fee8d79aa4219f6a4dd3445e 100644
>> --- a/combine-diff.c
>> +++ b/combine-diff.c
>> @@ -1515,7 +1515,6 @@ void diff_tree_combined(const struct object_id *oid,
>>  
>>  	diffopts = *opt;
>>  	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
>> -	diffopts.flags.recursive = 1;
>>  	diffopts.flags.allow_external = 0;
>>  
>>  	/* find set of paths that everybody touches
>
> With the above I'm a bit worried that we're changing behaviour for
> direct or indirect callers without noticing. Our tests may not detect
> any regressions, but that doesn't really prove that there is none.

As I've been trying to explain in the first version[1] of my patch, I
would say my change fixes a bug. Agreed, it's an ancient old bug, I
still consider it a bug. I think in practice no one will notice this
change in behaviour, because otherwise they would have complained about
the buggy behaviour.

For the callsites we didn't address, I'm doubtful anyone will notice a
change. Also, as I'm laying out above, we only see a bug in rare edge
cases. That's also why we don't see any test failures.

So yes, there might be a change in behaviour, but it will be correct and
barely anyone will notice.

Unfortunately I don't have any data to prove this.

> An alternative approach could be to introduce a new flag that causes us
> to not override the `recursive` flag. It's quite an ugly workaround and
> makes the infra even weirder. But at least we could be sure that we
> don't alter behaviour inadvertently.

Personally, I would rather not do this. It will create more tech debt,
on top of the tech debt that is the odd-ish behaviour.

> Other than that I don't really have much of a better idea.

Yeah, I've been trying some things, but I also have no other idea.

[1]: https://lore.kernel.org/git/20250904-toon-fix-last-modified-v1-1-91bf87ddf62b@iotcl.com/

-- 
Cheers,
Toon
