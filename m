Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A977631
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450711; cv=none; b=Brk5eLIY9yxiRRvFrsSvPFIyKCmAUqEnBr0JI01r2tpz8TVLmtx+0tfR8kMrTirqHq1Krnqjqk80cJBxXI42JGniIaeYVkp/maDegDtJu8kGkx0/sy6T9ZGNJhcsDw7DfTYcPM3icyjkNL+3Lav5pcuYYdcVZrt2z4ljuj5+9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450711; c=relaxed/simple;
	bh=XMhsa4/T8HXE0a1ZNHKf4ZLW/BYCDlQjxO2pF7/0OkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCzkzNb1b5xPudlwW9ASo0cpVc/dIkFXBXXeYPLbS41q6h3e3QguUnq5xQfbR3UwC5m1lcfrMn12QpvG7OcifxapqlMZ/meZ+CqBVvuFcUK9b9EE6lIpSDFSGtrnlT4BMwiQu1A2UGAng1HezOzzF/PPwlmfpg/oqSvui5BQwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 38474CA125B;
	Tue, 20 Feb 2024 12:38:27 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:61e9:e43c:2400:ab1c] (unknown [IPv6:2600:1700:840:e768:61e9:e43c:2400:ab1c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id E70E3CC83B3;
	Tue, 20 Feb 2024 12:38:26 -0500 (EST)
Message-ID: <1913ed1b-a145-e641-6601-d8a55a2a8fec@jeffhostetler.com>
Date: Tue, 20 Feb 2024 12:38:26 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 02/12] name-hash: add index_dir_exists2()
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <3464545fe3feceb08408618c77a70cc95745bfe9.1707857541.git.gitgitgadget@gmail.com>
 <xmqqeddg2g7j.fsf@gitster.g>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqeddg2g7j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/13/24 4:43 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> Create a new version of index_dir_exists() to return the canonical
>> spelling of the matched directory prefix.
>>
>> The existing index_dir_exists() returns a boolean to indicate if
>> there is a case-insensitive match in the directory name-hash, but
>> it doesn't tell the caller the exact spelling of that match.
>>
>> The new version also copies the matched spelling to a provided strbuf.
>> This lets the caller, for example, then call index_name_pos() with the
>> correct case to search the cache-entry array for the real insertion
>> position.
>>
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
>>   name-hash.c | 16 ++++++++++++++++
>>   name-hash.h |  2 ++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/name-hash.c b/name-hash.c
>> index 251f036eef6..d735c81acb3 100644
>> --- a/name-hash.c
>> +++ b/name-hash.c
>> @@ -694,6 +694,22 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
>>   	dir = find_dir_entry(istate, name, namelen);
>>   	return dir && dir->nr;
>>   }
>> +int index_dir_exists2(struct index_state *istate, const char *name, int namelen,
>> +		      struct strbuf *canonical_path)
>> +{
>> +	struct dir_entry *dir;
>> +
>> +	strbuf_init(canonical_path, namelen+1);
>> +
>> +	lazy_init_name_hash(istate);
>> +	expand_to_path(istate, name, namelen, 0);
>> +	dir = find_dir_entry(istate, name, namelen);
>> +
>> +	if (dir && dir->nr)
>> +		strbuf_add(canonical_path, dir->name, dir->namelen);
>> +
>> +	return dir && dir->nr;
>> +}
>>   
>>   void adjust_dirname_case(struct index_state *istate, char *name)
> 
> Missing inter-function blank line, before the new function.
> 
> I wonder if we can avoid such repetition---the body of
> index_dir_exists() is 100% shared with this new function.
> 
> Isn't it extremely unusual to receive "struct strbuf *" and call
> strbuf_init() on it?  It means that the caller is expected to have a
> strbuf and pass a pointer to it, but also it is expected to leave
> the strbuf uninitialized.
> 
> I'd understand if it calls strbuf_reset(), but it may not even be
> necessary, if we make it responsibility of the caller to pass a
> valid strbuf to be appended into.
> 
> 	int index_dir_find(struct index_state *istate,
> 			   const char *name, int namelen,
> 			   struct strbuf *canonical_path)
> 	{
>                  struct dir_entry *dir;
> 
>                  lazy_init_name_hash(istate);
>                  expand_to_path(istate, name, namelen, 0);
>                  dir = find_dir_entry(istate, name, namelen);
> 
>                  if (canonical_path && dir && dir->nr) {
> 			// strbuf_reset(canonical_path); ???
>                  	strbuf_add(canonical_path, dir->name, dir->namelen);
> 		}
>                  return dir && dir->nr;
> 	}
> 
> Then we can do
> 
> 	#define index_dir_exists(i, n, l) index_dir_find((i), (n), (l), NULL)
> 
> in the header for existing callers.
> 

I'm always a little hesitant to change the signature of an existing
function and chasing all of the callers in the middle of another
task.  It can sometimes be distracting to reviewers.

I like your macro approach here. I'll do that in the next version.

Thanks
Jeff
