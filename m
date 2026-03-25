Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924B2D94BA
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443014; cv=none; b=ksrrOBYcGHBkHPtMBWBaCkyYhBPWDhAwuYXyoUuMDqeyJ+FNTf+5Ds0qEf6riAVvKVxA96By5aW/wvmLoXykuvkHVCLHcLjiSaUAjKBKbiA/WT3mYkTayo12oCNe7eS1kVLNqSia3lErua1FjVOA3L2tPXdwsmR4ERpI9T+e/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443014; c=relaxed/simple;
	bh=nVQEIDllBraDOxU3/RNCNtK9nuBrCaJEsUqwZh+ykWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BMBOYfEUVjho8yFNjJI9p2l2UMr7p4Re6FGGB/Moh7o4Uzs/6DB4/+o3z9jkdZkfsCeQku3bAT/QZIdZc3zDqImMtAxowacTT/fckdwv86wwT+OHQo5SVVnlerTr2auJ5Lugw07wya1TaLH7Lyyw/BI5tkErgr+nFw9d76HigCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VQya8jsr; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VQya8jsr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774443011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqnZ7I29/ncAoP+RXJTS1IkmTRUnaAuvX6Gy66N+REQ=;
	b=VQya8jsrTgCeQccIg/aW4H2uj3cchQ7L3Mf5Euax67F/4Ak0Ok7F/jyIUP9cv7LsAUvWWj
	YPcd2bqc4MAXUuGNYiwJQactmdz8fj8BOZg0tSZ4J8Ixa2CvaVh6FE29Ejz5UNY9AUEYtm
	MYxT/Rg9AgjgLJ7+n7uq5vwRZRNdejs=
From: Toon Claes <toon@iotcl.com>
To: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Siddharth Asthana
 <siddharthasthana31@gmail.com>, Yee Cheng Chin <yeecheng.chin@gmail.com>
Subject: Re: [PATCH 3/3] replay: allow to specify a ref with option --ref
In-Reply-To: <b0d49276-a9d3-435d-bb39-8cf7a08fbd11@malon.dev>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
 <20260323-toon-replay-arbitrary-ref-v1-3-5c7172f675ec@iotcl.com>
 <b0d49276-a9d3-435d-bb39-8cf7a08fbd11@malon.dev>
Date: Wed, 25 Mar 2026 13:50:06 +0100
Message-ID: <87h5q413b5.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tian Yuchen <cat@malon.dev> writes:

> Hi Toon,
>
> On 3/24/26 00:09, Toon Claes wrote:
>
>
>> +	die_for_incompatible_opt2(!!opts.ref, "--ref",
>> +				  !!opts.contained, "--contained");
>
>> +	/*
>> +	 * Reference to update with the result of the replay. This stops replay
>> +	 * from taking refs from `onto`, `advance`, and `revert`. Ignores
>> +	 * `contained`.
>> +	 */
>> +	const char *ref;
>> +
>
> Do the comment and the code implementation match up here?

The comment is a bit misleading. A user cannot set the field `contained`
in the struct when it passed `--ref`. But if a bug is made somewhere,
but both fields can be set, that's what the comment is saying.

I can add a check to verify in replay.c that not both are set, and
update the comment they are incompatible?

>> @@ -427,13 +446,9 @@ int replay_revisions(struct rev_info *revs,
>>  		goto out;
>>  	}
>>  
>> -	/* In --advance or --revert mode, update the target ref */
>> -	if (advance || revert) {
>> -		const char *ref = advance ? advance : revert;
>> -		replay_result_queue_update(out, ref,
>> -					   &onto->object.oid,
>> +	if (ref)
>> +		replay_result_queue_update(out, ref, &old_oid,
>>  					   &last_commit->object.oid);
>> -	}
>>  
>>  	ret = 0;
>
> It doesn't seem like there's anything here to prevent users from 
> inputting multiple branches? I think this will result in at least one 
> branch becoming orphaned, without any error being reported.
>
> Consider this command:
>
> 	git replay --onto main --ref refs/heads/target topic1 topic2

That's interesting, I didn't think of that.

>
> In replay.c we have:
>
>> if (onto_name) {
>> 		*onto = peel_committish(repo, onto_name, "--onto");
>> 		if (rinfo.positive_refexprs <
>> 		    strset_get_size(&rinfo.positive_refs))
>> 			die(_("all positive revisions given must be references"));
>> 		*update_refs = xcalloc(1, sizeof(**update_refs));
>> 		**update_refs = rinfo.positive_refs;
>> 		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
>
>
> After topic1 and topic2 are put into update_refs, only one ref 
> (refs/heads/target) is updated, since what is written in the patch is:
>
>  > +	if (ref)
>  > +		replay_result_queue_update(out, ref, &old_oid,
>  >  					   &last_commit->object.oid);
>
> I believe this is not what we expect :P

Let me look into that how we can deal with that.

-- 
Cheers,
Toon
