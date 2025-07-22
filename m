Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C360433A8
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200171; cv=none; b=gqhsDGH/l+eLoqigQq16xCDX948jTQ1u1V2B6UwTNiirH2j6I5T9JkfMGOnm6itvm+C74zLAfJlSxhBJdVm19iW8oX0YFF7C9yz7h/JzPCbYWnXmHQkpdpXo6mnnJbAtOYrbSS70eDA+sU313zox3X/6inmHEDhqZrIZB6zCuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200171; c=relaxed/simple;
	bh=T2W0OEXtC/5kMuCcq/Yxl6Gs4ysAMBueFDLsvBBi4Uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HO4ZvyIzViiOXhbN3FEr95GEd4pBhqutUVEL/vVEEr2K+anhHLdGk38ataLy/+tP1rYrCSFpV44sJ4mWv6dO4ubHkjN3DkYTgLFGpMO3bx7P07xyYkTdDTxikUe0MjKBi+InX6XktONm+y1ltSSz4OTIXJ0t2qZyPaYbQ+mES4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=O8JkED0R; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="O8JkED0R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753200166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4SZPZa6Esy9tLwB8mYHoqDM35UbjTJPuAt3oBZ74jM=;
	b=O8JkED0Rccdf55pGrQKsg80nf+PlwY9IJ0gkk9VCeUAgtS7pF1iPrwhQlukDwmrwT8AYk3
	JPMShSsOjhbx+RoAL6RvW3nc5zeyKMS8/3J7AgS6rDjEKKING3tujEIAF4GtiO6Dy8TpDV
	1OMc49xgAXKlBvawBDBFsBTzWyLWraA=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/6] last-modified: use Bloom filters when available
In-Reply-To: <aHmSW1pOUF0U3KFk@nand.local>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-3-toon@iotcl.com> <aHmSW1pOUF0U3KFk@nand.local>
Date: Tue, 22 Jul 2025 18:02:37 +0200
Message-ID: <871pq8kyci.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jul 16, 2025 at 03:35:15PM +0200, Toon Claes wrote:
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
> As an aside on 8020.3 (that I probably should have mentioned in the last
> commit), I think that our "| head -n1" heuristic for picking a sub-tree
> is skewing these results down. In git.git, the lexicographically
> earliest sub-tree is ".github", which is awfully tiny. I wonder if we
> should be grabbing the *last* sub-tree, or maybe the largest one by
> count of entries?

Ah yes, that's automatable. Good suggestion.

>
>> @@ -40,6 +43,12 @@ struct last_modified {
>>
>>  static void last_modified_release(struct last_modified *lm)
>>  {
>> +	struct hashmap_iter iter;
>> +	struct last_modified_entry *ent;
>> +
>> +	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
>> +		clear_bloom_key(&ent->key);
>> +
>
> I did a double-take to make sure that ent->key would always be
> initialized here, but it is thanks to the FLEX_ALLOC_STR() call below.
>
>>  	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
>>  	release_revisions(&lm->rev);
>>  }
>> @@ -67,6 +76,9 @@ static void add_path_from_diff(struct diff_queue_struct *q,
>>
>>  		FLEX_ALLOC_STR(ent, path, path);
>>  		oidcpy(&ent->oid, &p->two->oid);
>> +		if (lm->rev.bloom_filter_settings)
>> +			fill_bloom_key(path, strlen(path), &ent->key,
>> +				       lm->rev.bloom_filter_settings);
>>  		hashmap_entry_init(&ent->hashent, strhash(ent->path));
>>  		hashmap_add(&lm->paths, &ent->hashent);
>>  	}
>> @@ -126,6 +138,7 @@ static void mark_path(const char *path, const struct object_id *oid,
>>  		data->callback(path, data->commit, data->callback_data);
>>
>>  	hashmap_remove(data->paths, &ent->hashent, path);
>> +	clear_bloom_key(&ent->key);
>
> OK, we're calling clear_bloom_key() here, too, but it uses
> FREE_AND_NULL(), so calling it again in last_modified_release() may be a
> noop, but won't ever be a double-free.
>
>> @@ -238,6 +276,13 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
>>  		return argc;
>>  	}
>>
>> +	/*
>> +	 * We're not interested in generation numbers here,
>> +	 * but calling this function to prepare the commit-graph.
>> +	 */
>> +	(void)generation_numbers_enabled(lm->rev.repo);
>> +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
>
> Hmmph. I think when I originally wrote this I was using the side-effect
> of calling generation_numbers_enabled() as a hack. But I think that it
> may be worth making "prepare_commit_graph()" a non-static function and
> calling that instead.

Well thanks for confirming this assumption. I wasn't 100%, and I agree
having a non-static "prepare_commit_graph()" would be better.

Somewhat related to that. In your branch you have this line in
"maybe_changed_path()": 

	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
		return 1;

I excluded this line because if we ignore the result of
"generation_numbers_enabled()", why would it matter to have a generation
number?

The thing is "maybe_changed_path()" in blame.c also has this line too,
but unfortunately git-blaming that line didn't learn me anything why
it's there. Do you have any idea?

-- 
Cheers,
Toon
