Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076922068B
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812769; cv=none; b=uvexX/5z+OGJm5HF9CXyE8ps7Zwk321ZKV00t1bN0LFTte1TOyBC8HZulwTxBpbeWySwZOb2PNuOiTVduW0iKV3SPf7YAOgG04LrSV8NSGG4VBPpmt46Cltxtle0dNeBjWG3nrDA4foQs2ragf080+Rd1sW0S9fEpOSg1Ak20bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812769; c=relaxed/simple;
	bh=bweJPzEFh1gYnHR+TYiAZGtbBHasm+RQm5+d7YRACbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KYfGlMhQlu5elyTEFFH2ZNskebkUNktHCd0QSHH7gkK2SwngmJ492Z10/E2CtCEYdn2dW6rx91T7uIWiC7xRUIWaZph7xirHk0GFhkSShSGJM//Rt1bH/HwibeAEAtZ4s5vfM0bk2VJ2ze8A8rwJPOXWMfn/fhOiA9T/+dRTAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=DKE59m1h; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="DKE59m1h"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1749812759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tt8lrA6Jm7XvHNCgImPwr3gIadtA3iZtweLy1jFCTEE=;
	b=DKE59m1hJnABPiGSuxDJW+QurqHgFpffvLvHYSgn6xI/XTtFJ46EMy3oAMZjdI+Wjjwro9
	qIshOcZk1Xa0/c4iqVJlUMGP34FetdNHeQNEKdBNgByZaOi8XqIBJRuwflymx0u/5Agw/4
	BtvRbwvqMBTyk+kZ3d0Jq4tRAI/y/Lk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 3/5] last-modified: use Bloom filters when available
In-Reply-To: <aDWWgj8gTS9EM7v6@pks.im>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-3-101e4ca4c1c9@iotcl.com>
 <aDWWgj8gTS9EM7v6@pks.im>
Date: Fri, 13 Jun 2025 13:05:43 +0200
Message-ID: <87h60j296g.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, May 23, 2025 at 11:33:50AM +0200, Toon Claes wrote:
>> Our 'git last-modified' performs a revision walk, and computes a diff at
>> each point in the walk to figure out whether a given revision changed
>> any of the paths it considers interesting.
>> 
>> When changed-path Bloom filters are available, we can avoid computing
>> many such diffs. Before computing a diff, we first check if any of the
>> remaining paths of interest were possibly changed at a given commit by
>> consulting its Bloom filter. If any of them are, we are resigned to
>> compute the diff.
>> 
>> If none of those queries returned "maybe", we know that the given commit
>> doesn't contain any changed paths which are interesting to us. So, we
>> can avoid computing it in this case.
>> 
>> This results in a substantial performance speed-up in common cases of
>> 'git last-modified'. In the kernel, here is the before and after (all
>> times computed with best-of-five):
>> 
>> With commit-graphs (but no Bloom filters):
>> 
>>     real	0m5.133s
>>     user	0m4.942s
>>     sys	0m0.180s
>> 
>> ...and with Bloom filters:
>> 
>>     real	0m0.936s
>>     user	0m0.842s
>>     sys	0m0.092s
>> 
>> These times are with my development-version of Git, so it's compiled
>> without optimizations. Compiling instead with `-O3`, the results look
>> even better:
>> 
>>     real	0m0.754s
>>     user	0m0.661s
>>     sys	0m0.092s
>
> I'm sure that the old state without bloom filters will also improve a
> bit?

These are the benchmarks from the original commits I took over. They are
no longer really relevant, I'll remove them.

>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>  last-modified.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>> 
>> diff --git a/last-modified.c b/last-modified.c
>> index 9283f8fcae..f628434929 100644
>> --- a/last-modified.c
>> +++ b/last-modified.c
>> @@ -92,12 +99,21 @@ void last_modified_init(struct last_modified *lm,
>>  	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
>>  		die(_("unknown last-modified argument: %s"), argv[1]);
>>  
>> +	(void)generation_numbers_enabled(lm->rev.repo);
>
> Why the `(void)` cast? And why even call this in the first place? This
> definitely needs a comment and smells like funky design in our commit
> graph subsystem where we rely on side effects of one function to leak
> into a different function.

This function calls `prepare_commit_graph()` which I think is the
important side-effect. Let me add a comment. Or would you rather to see
a separate function?

>> +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
>> +
>>  	if (add_from_revs(lm) < 0)
>>  		die(_("unable to setup last-modified"));
>>  }
>>  
>>  void last_modified_release(struct last_modified *lm)
>>  {
>> +	struct hashmap_iter iter;
>> +	struct last_modified_entry *ent;
>> +
>> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
>> +		clear_bloom_key(&ent->key);
>> +	}
>
> The curly braces shouldn't be needed.

Okay.

>> @@ -180,6 +197,30 @@ static void last_modified_diff(struct diff_queue_struct *q,
>>  	}
>>  }
>>  
>> +static int maybe_changed_path(struct last_modified *lm, struct commit *origin)
>> +{
>> +	struct bloom_filter *filter;
>> +	struct last_modified_entry *ent;
>> +	struct hashmap_iter iter;
>> +
>> +	if (!lm->rev.bloom_filter_settings)
>> +		return 1;
>> +
>> +	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
>> +		return 1;
>
> Hm, okay, so here we require generation numbers to exist. Why is that
> though? Shouldn't we only care about bloom filters? I don't quite get
> that part yet.

That's a good question. Because we're above ignoring the return value of
`generation_numbers_enabled()` we shouldn't rely on generation numbers.
I verified things and did some testing and it seems to me we can safely
remove this condition.

>> +	filter = get_bloom_filter(lm->rev.repo, origin);
>> +	if (!filter)
>> +		return 1;
>> +
>> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
>> +		if (bloom_filter_contains(filter, &ent->key,
>> +					  lm->rev.bloom_filter_settings))
>> +			return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>
> Okay, and here we check whether any of our desired paths may be
> contained in the bloom filter.
>
>>  int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
>>  {
>>  	struct last_modified_callback_data data;
>> @@ -199,6 +240,9 @@ int last_modified_run(struct last_modified *lm, last_modified_callback cb, void
>>  		if (!data.commit)
>>  			break;
>>  
>> +		if (!maybe_changed_path(lm, data.commit))
>> +			continue;
>
> If there either are no bloom filters or in case none of them contain our
> commit we can safely skip over the commit indeed. Otherwise we'll have
> to check whether the commit really is interesting.
>
> Makes sense.
>
> Patrick
>

-- 
Cheers,
Toon
