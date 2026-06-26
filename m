Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102933C5546
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452206; cv=none; b=NLxjmdWz9lP9EIB8pZHtCIllotuaEPcjQWkOssztNkapok7UHaPo4Oor2KSwIX+2ksKLF8DjfpExaQiSn92QJtofh3q7JfsKELZ/Z/Rx5zQ4UI7VXNQOCLB93IyB47RjYj5JeTNVMKRSHr2ekGcTCUTFHd8CWPYE90fsKNLdZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452206; c=relaxed/simple;
	bh=PLGbLjcrKorTPb1dgMDsVMMV08m6fHR+l4wMikRLqk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAvI5oWGYQNKCnk7CXX7WcWGmZVifKoVvOOj3v8elLj5u5tenLP0dUllPtg2WViIr7Ftd3/8WIhROYZJtDF5cnCC0MkjVXacxdjPMwJ9RYvejt8teIzIVm4QfxXfqMX+sYDau2djHuv9QKZ1HdTy9myZQ3GR+8MKXbSEB/wdoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=A5xmtesw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="A5xmtesw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782452200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Is39KAlWoE692AqBU6/okkldyNjwvN6iuyHxXxpMGbU=;
	b=A5xmtesw6wVawIjVV0rYMeHB39o/m1ytB9x1rBBK3BulsYpWTG+QQzSW0ia5MyRLY/+KIF
	ZpUJ1j6TcPtg3P+3Ow4Ouid9YQmB2WoOO8rYNkgYXQxSuSH5P2H3Nh2k/cTlyxJEEJHU4e
	vwJOtVEkUlzVGHgT3RYwxDDHacfpgmQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <ajk-a4a3KSJ2u7Ju@pks.im>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
 <20260622-toon-git-replay-drop-merges-v4-3-ff257f534319@iotcl.com>
 <ajk-a4a3KSJ2u7Ju@pks.im>
Date: Fri, 26 Jun 2026 07:36:31 +0200
Message-ID: <87qzltyiao.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> git-rebase(1) essentially knows about three different modes:
>
>   - "--no-rebase-merges", which is the default and maps to your
>     "--linearize".
>
>   - "--rebase-merges", which by default doesn't rebase cousins by using
>     "--ancestry-path" internally.
>
>   - "--rebase-merges=rebase-cousins", which doesn't pass the above
>     option.
>
> So it's not a simple boolean there, which makes me wonder whether we
> should mirror the same interface so that all of git-rebase(1)'s modes
> can be represented, as well.

That's a valid question, although I don't know a good answer to that.

Basically you're asking for what the command line options will look
like? Allow me to think out loud.

In this series I'm adding --linearize to git-replay(1). As mentioned, I
don't think it makes sense to add it to git-history(1) as well. Without
this option, the process aborts when it encounters a merge.

Dscho sent a patch series to properly replay (2-way) merges. I think
this should become the default for both git-replay(1) and
git-history(1).

But then, do we want to have an option that brings back the current
behavior of aborting at merges? Maybe with --no-merges?

Then there's the option of rebasing cousins left. That's something that
isn't covered by Dscho's series yet. Maybe --replay-cousins?

To reiterate what the final design could look like:

 * <nothing>: replay merges preserving topology.
 * "--linearize": flattens merges (only git-replay(1)).
 * "--no-merges": dies when the process tries to replay a merge.
 * "--replay-cousins": does what --rebase-merges=rebase-cousins does.

Now, all these options are (I think) mutually exclusive, so we could
consider an option "--replay-merges=<mode>", but personally I find
"--<option>=<value>" arguments harder to use than specifying separate
options.

I think I'm avoiding your question, because the design of the command
line parameters doesn't need tot 1-on-1 correlate to the internal
datastructure. And I agree the mode isn't a boolean, but does that mean
we want to use an enum internally? Well, I don't know. And I also don't
think that matters right now. Code is easy to change, I think the
command line options should be designed with the future in mind, which I
believe we do with "--linearize".

Sorry for this long-winded rambling, but bottom line I think it's fine
to add --linearize and in the future add more options and see how the
code should evolve to support those.

>> diff --git a/replay.c b/replay.c
>> index 7921d7dba3..5539daff00 100644
>> --- a/replay.c
>> +++ b/replay.c
>> @@ -277,12 +277,16 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>  					  struct commit *onto,
>>  					  struct merge_options *merge_opt,
>>  					  struct merge_result *result,
>> +					  struct commit *replayed_base,
>>  					  bool reverse,
>>  					  enum replay_empty_commit_action empty)
>>  {
>> -	struct commit *base, *replayed_base;
>> +	struct commit *base;
>>  	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>>  
>> +	if (replayed_base && reverse)
>> +		BUG("Linearizing commits is not supported when replaying in reverse");
>
> Nit: Error messages should typically start with a lower-case letter.

Thanks.

>> @@ -430,12 +435,25 @@ int replay_revisions(struct rev_info *revs,
>>  	while ((commit = get_revision(revs))) {
>>  		const struct name_decoration *decoration;
>>  
>> -		if (commit->parents && commit->parents->next)
>> -			die(_("replaying merge commits is not supported yet!"));
>> +		if (commit->parents && commit->parents->next) {
>> +			if (!opts->linearize)
>> +				die(_("replaying merge commits is not supported yet!"));
>> +			/*
>> +			 * Drop the merge commit: do not pick it and leave
>> +			 * last_commit unchanged, so its children (and any ref
>> +			 * pointing at it) are reparented onto the previous
>> +			 * non-merge commit, which the ref-update loop below uses.
>> +			 */
>
> One could add a hint here that tells the user to pass the option. But I
> guess that might be somewhat weird, as we cannot assume that we're
> called by git-replay(1) here.

Yeah, true...

-- 
Cheers,
Toon
