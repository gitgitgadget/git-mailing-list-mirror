Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3485B676
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065405; cv=none; b=azF3gmesIo6owVGrqki+kmdJ21zsus6fY2wXPs7bUvKTW3wm0r/ne1RKuJAuqVOHl0aWIYdnUnp7Vfj2TJSvLHa1ID5Us7JjjeWWq4u3jIFB3NNaPJsu6O5zZhs24wX7ZHVr0RzK6SvBlOn747Qel/qxrs8M47Heq9a5uGg4fN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065405; c=relaxed/simple;
	bh=apfV1e9gGM3s9oro/fcm60fhn9XyQjyMqob5aVMqk10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OlVvCFr4naIPZRgIS+UWgdImKUofgw0qBSF0BeuA/BKAb5suL3xRK36X+SXYjfpaj3H3Fk5bofhYhezFn29T+/tACok9+yOEhCyxBhFc6HAJzFnO3w45QTylbX7vrvb1uO+L1NoUl4xUiD+TGNB7JvH5WN0+Impl8GS+0ZQD1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=FKN3KU9Y; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="FKN3KU9Y"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754065400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nlzYUl2XGRK2xWB8rOXD5+iihISiZK31G5Y3AXBlAAo=;
	b=FKN3KU9Y1z/ArYgRmijw1JwBis0p/uDk7RjtcCYuYYxdmKQbS7WZu2CKQ6/RcBs7pT2P8b
	Wr9wQQb5Ej34IaAprHxhuiX/EaZHQ9gR03pXQyaByPkwFIktjT6kWmPGPprgiW12OHiqS4
	RCdC/bZEWKdtA+U4ktASFAuxj+zWOCA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, Christian Couder
 <christian.couder@gmail.com>
Subject: Re: [PATCH v6 4/4] last-modified: use Bloom filters when available
In-Reply-To: <aIsQfZyMq0ltbMtz@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-5-toon@iotcl.com> <aIsQfZyMq0ltbMtz@pks.im>
Date: Fri, 01 Aug 2025 18:23:08 +0200
Message-ID: <87ldo3ui37.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jul 30, 2025 at 07:55:10PM +0200, Toon Claes wrote:
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
>> Comparing the perf test results on git.git:
>> 
>>     Test                                        HEAD~             HEAD
>>     ------------------------------------------------------------------------------------
>>     8020.1: top-level last-modified             4.49(4.34+0.11)   2.22(2.05+0.09) -50.6%
>>     8020.2: top-level recursive last-modified   5.64(5.45+0.11)   5.62(5.30+0.11) -0.4%
>>     8020.3: subdir last-modified                0.11(0.06+0.04)   0.07(0.03+0.04) -36.4%
>
> Nice results.
>
>> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
>> index e4c73464c7..19bf25f8a5 100644
>> --- a/builtin/last-modified.c
>> +++ b/builtin/last-modified.c
>> @@ -179,6 +192,27 @@ static void last_modified_diff(struct diff_queue_struct *q,
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
>
> This function is basically the same as `maybe_changed_paths()` in
> "blame.c", but that isn't a huge issue from my point of view. What makes
> me wonder though is why we have an additional check over there for
> whether or not the commit has a valid generation number.

I've been asking me the same question. And I couldn't find a good reason
(neither from the commit history, or from my reasoning). This check was
in the version shared by Taylor, but because we were ignoring the return
value from generation_numbers_enabled() in that version, it didn't make
sense to me to do this check. That's why I removed it.

>> @@ -227,6 +264,9 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>>  		return argc;
>>  	}
>>  
>> +	prepare_commit_graph(lm->rev.repo);
>> +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
>> +
>
> So this here is why we export `prepare_commit_graph()`. How about we
> instead expose `bloom_filters_enabled()` that mirrors what we do in
> `generation_numbers_enabled()` and `corrected_commit_dates_enabled()`?
> That would both be on a higher level and do exactly what we want to
> achieve.

I've got another proposal, what if we let get_bloom_filter_settings()
call prepare_commit_graph()? Functions like
repo_find_commit_pos_in_graph() and lookup_commit_in_graph() do this
too. 

-- 
Cheers,
Toon
