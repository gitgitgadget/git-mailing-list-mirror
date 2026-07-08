Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E363B42EC
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535508; cv=none; b=PwTQgJkRhfTA7FjBStS4znhv7dkTab7UcYus4B8TleydpS38Z0x68QK2kJEFDacnZiwo2mh4coNI9oKENZsaweBfB8L0rOgt21dN/WJKTGp9o38InaMprLBX77z8kZTen+5qlyjOSz0WEFPcDoraljlG7MdHb+g0anhCuTW1HpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535508; c=relaxed/simple;
	bh=KRvhtSulyzt8LntcNwMn5AlYZQA9L4Mu1fFWN/utFbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEvgulCA+TvobpghI8pC24scykUJyjuJJD8HB0emIiMGNqSDkFQy/o1VbH2A8IdDzHiyI42Rzu+hM9sWoDB2isHAEekp6eZl+oBCr5eil7ArbbdtgdqfSS4b/AXDASH9+jpUoXg2hlpe6lweSCfwN+mLikskW4sg+LeUbWbXANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pXLJ64vW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pXLJ64vW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DSFnNLhILF/8YmEPKPl1RAswS6+JkeicDtkYwVGc8xo=; b=pXLJ64vWo3H/4pQv2wqzntXhh6
	x+1F737SmhNxGeTsMBXpJnojZpmZ6bPpy108ToNcXeZTit7xkiFDDH/HNQsSGuoOV2lc+Zies2GNy
	7Kr+IZMgF9TAphFWcZVnIsBW2tkwHc+ttJhADKJqlfyWlN6QqQHVhp2UKzZgv5qJcjqfMYhtZJnBu
	WNQ60L0EHouSOLNIQpVmu/u40jgiLqfqD/9vrAsCkC4smmlM+Li/ukdVJBguyHR43TNOt6AFAG/Xi
	aKM1pJF/QuuGBD25CCDGl15V+zqgymlNVHshRrbdeUHkevwZWq2RKhU7T6rST6MkSRhSuVaTtleom
	yPuxEggQ==;
Received: from [91.117.33.88] (helo=[192.168.1.137])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1whX3c-00BrlV-Rp; Wed, 08 Jul 2026 20:31:40 +0200
Message-ID: <4c0a31e9-9b20-46c8-8f1f-0fda34515270@igalia.com>
Date: Wed, 8 Jul 2026 20:31:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] unpack-trees: avoid quadratic index scan in
 next_cache_entry()
To: Junio C Hamano <gitster@pobox.com>,
 Henrique Ferreiro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
 <xmqqv7aqzdvq.fsf@gitster.g>
Content-Language: en-US
From: Henrique Ferreiro <hferreiro@igalia.com>
In-Reply-To: <xmqqv7aqzdvq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/07/2026 23:30, Junio C Hamano wrote:
> "Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index b42020f16b..ed9fef453a 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -671,8 +671,10 @@ static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
>>   
>>   	while (pos < index->cache_nr) {
>>   		struct cache_entry *ce = index->cache[pos];
>> -		if (!(ce->ce_flags & CE_UNPACKED))
>> +		if (!(ce->ce_flags & CE_UNPACKED)) {
>> +			o->internal.cache_bottom = pos;
>>   			return ce;
>> +		}
>>   		pos++;
> Nice spotting.
>
> Does this trick work correctly even when a path's sorting order
> differs between the index and tree objects, which is precisely why
> .cache_bottom was introduced, to allow backward scanning while
> bounding the lookback distance?
IIUC, .cache_bottom points at the first entry that needs to be 
processed. With this change, that still holds true even when entries are 
processed out of index order. find_cache_pos() also advances 
cache_bottom past unpacked entries since e53e6b4433 (unpack-trees: Make 
index lookahead less pessimal, 2010-06-10).
>
>>   	}
>>   	return NULL;
>
>> diff --git a/t/perf/p0009-diff-pathspec.sh b/t/perf/p0009-diff-pathspec.sh
>> new file mode 100755
>> index 0000000000..0f1dccfbb4
>> --- /dev/null
>> +++ b/t/perf/p0009-diff-pathspec.sh
>> @@ -0,0 +1,27 @@
>> +#!/bin/sh
>> +
>> +test_description='Tests performance of diffing the working tree with a pathspec'
>> +
>> +. ./perf-lib.sh
>> +
>> +test_perf_fresh_repo
>> +
>> +# The entries exist only in the index, which is enough to
>> +# exercise the index scan.
>> +test_expect_success 'setup' '
>> +	count=100000 &&
> You will probably want to mimic how t/perf/p4209-pickaxe.sh helps
> testers by adjusting the count based on how the EXPENSIVE
> prerequisite is configured.
>
>> +	blob=$(echo content | git hash-object -w --stdin) &&
>> +	{
>> +		printf "100644 $blob\taaa/file\n" &&
>> +		printf "100644 $blob\tf%s\n" $(test_seq $count)
>> +	} | git update-index --index-info &&
>> +	git commit -q -m initial &&
>> +	mkdir -p aaa &&
>> +	echo content >aaa/file
>> +'
>> +
>> +test_perf 'diff pathspec subtree' '
>> +	git diff HEAD -- aaa/file
>> +'
>> +
>> +test_done
> Thanks.
