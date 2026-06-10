Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D73264EF
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101592; cv=none; b=XdSnXmPEexeeWuGziPhrPnqn/9OqksHSdM+kdCTUsttmbpBIZxZdycaY2YL78jgIU/uVuRl8nXcsDNdHYwoig7QUS23f0vM2Rbzox3nHavO6ajDl4y5aDXbhkyGWi3LuiZU5ysI0oP8X2TxINMReCWkuZy4s2NGh/lt4ao4UklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101592; c=relaxed/simple;
	bh=huN6o1+kUU+rVfuri8SIUORdbBBhP2RkKLvFaRNhulU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ukMI0dIVb4r2N5GYusE/tBkq22NnqIfc7dCqxEVcx/7w6VRIoqWUck2PIm8XVzsvgs6CaJqdzVg52UrbX0zPRgFoYS4XMPRUtFlXmWTNy0meT5roiMS3MvVTpoH21teywTpf2vqDDw3fCjM5VndP9mg8kM+iD0bOmuIzrP6eVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gbVwDNSc; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gbVwDNSc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781101586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkcJTSnJpIdhC9/15lTJZ4a1N6xVPsC4tkGTqV9zVJQ=;
	b=gbVwDNScoKSxwTKcZ8OcltwAR+eI6L4fxP2Ob/CiVWlGncTnKCzK5wYAuxsDCvsoHwlZVm
	5o04dmYQNtURFlD1lO/1BHcAi1TJWzYKa39HG2cJSuU1dMdUWOv0tAF60cCMdREMEEfRnb
	9ZUeLoqoInu/HZ1pIRZH7nsbHVDUzqU=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <xmqqtsrcvnjw.fsf@gitster.g>
References: <20260608-toon-git-replay-drop-merges-v1-0-e3ee71fce7b4@iotcl.com>
 <20260608-toon-git-replay-drop-merges-v1-3-e3ee71fce7b4@iotcl.com>
 <xmqqtsrcvnjw.fsf@gitster.g>
Date: Wed, 10 Jun 2026 16:26:08 +0200
Message-ID: <87zf12zd33.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>
>> One of the stated goals of git-replay(1) is to allow implementing the
>> git-rebase(1) functionality on the server side.
>>
>> The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
>> was given. This mode drops merge commits instead of replaying them, and
>> linearized the commit history into a sequence of the
>> regular (single-parent) commits.
>
> "linearized" -> "linearizes"?

Thanks.

>>
>> Add option `--linearize` to git-replay(1) do the same.
>
> "do the same" -> "to do the same"?

Ack.

>> Co-authored-by: Toon Claes <toon@iotcl.com>
>
> There is no sign-off by any of the authors?

My bad. I'll add mine.

@Johannes, can I re-add yours? I've removed it because I've made some
changes on top of the patch you wrote, but if you agree, I'll add your
Sign-off back.

>> @@ -430,12 +435,20 @@ int replay_revisions(struct rev_info *revs,
>>  	while ((commit = get_revision(revs))) {
>>  		const struct name_decoration *decoration;
>>  
>> -		if (commit->parents && commit->parents->next)
>> +		if (opts->linearize && (!commit->parents || commit->parents->next))
>> +			; /* map current commit to the same as the previous commit */
>
> This uses the same treatment on either root commits or merge
> commits?  If this were a mistake and this wants to handle merges but
> not roots, shouldn't it be more like
>
> 		if (opts->linearize && (commit->parents && commit->parents->next))
> 			; /* map the merge to the previous */
>
>> +		else if (commit->parents && commit->parents->next)
>>  			die(_("replaying merge commits is not supported yet!"));
>
> And because the next one is also about merges, perhaps the early
> part of this if/else if cascade can be written
>
> 		if (commit->parents && commit->parents->next) {
> 			/* We have a merge */
> 			if (!opts->linearize)
> 				die(_("can't replay a merge (yet)"));
> 			; /* map current to the previous */
> 		} else {
> 			...
>
> wouldn't it?

The way it was written in v1 was maybe a bit too smart and hard to
follow. I agree with your suggestion and will adopt this (with some
tweaks) in the next version.

> If the "map current to prev" is applicable to root, any root are
> mapped to the last_commit in the above, and if we saw a root as the
> first thing in the loop, last_commit is NULL, we do not do anything
> here, and after the if/else if/else cascade, we see last_commit is
> NULL and break out of the loop.

Yes, good observation. I did not test this.

> Perhaps we would want to have a test that replays all the way down
> to the root commit?

I'll add it.

-- 
Cheers,
Toon
