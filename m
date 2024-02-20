Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD5762E4
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455288; cv=none; b=J0bfZONGVnm56Mma+a4HScc/RGtlP7jQxniI8LcqRVdSu9fOy4AJ+jFNJ3kPZqy+TGmByB3NUm+4GEBbuNYS3MOEq58wUTx/wqgy3m0L8v9F9u9yC4auFwp6U00Q0YEs7tY0uKWXKOawNu9iHpSH4LVCrNa7PBjtlIdzX7JgdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455288; c=relaxed/simple;
	bh=Gah8EcMi2iAwH/Beq52Xt3CEKFyfdIa5UF7xiZyymb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M79HBuuwOpFhPMHUJ6KR4J1aH8rwFbM7AdVgD6m0TNoncDfGE778Dgp0sBlqlaa/YCLswQXOVKCbnLpbdDaPzkOIqFA8wbwlIJXgktZAgLU8MHapvOzYBt/rCMJ8ik5fM8zxjgVRiPJhHiYSoHonD2mabo1c/OEyNc+4G9Je8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id F387CCA1256;
	Tue, 20 Feb 2024 13:54:44 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:61e9:e43c:2400:ab1c] (unknown [IPv6:2600:1700:840:e768:61e9:e43c:2400:ab1c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id B7828CC83B4;
	Tue, 20 Feb 2024 13:54:44 -0500 (EST)
Message-ID: <3fcb41e4-b17e-48ec-b54c-50452654b28c@jeffhostetler.com>
Date: Tue, 20 Feb 2024 13:54:44 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 04/12] fsmonitor: refactor refresh callback on directory
 events
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <3fb8e0d0a7c0455cc7a5ba28c12736fd4bbbd44e.1707857541.git.gitgitgadget@gmail.com>
 <Zc3aGSbEIFVClRd_@tanuki>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <Zc3aGSbEIFVClRd_@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/15/24 4:32 AM, Patrick Steinhardt wrote:
> On Tue, Feb 13, 2024 at 08:52:13PM +0000, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
>>   fsmonitor.c | 52 ++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 30 insertions(+), 22 deletions(-)
>>
>> diff --git a/fsmonitor.c b/fsmonitor.c
>> index f670c509378..b1ef01bf3cd 100644
>> --- a/fsmonitor.c
>> +++ b/fsmonitor.c
>> @@ -183,6 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
>>   	return result;
>>   }
>>   
>> +static void fsmonitor_refresh_callback_slash(
>> +	struct index_state *istate, const char *name, int len, int pos)
> 
> `len` should be `size_t` as it tracks the length of the name. This is
> a preexisting issue already because `fsmonitor_refresh_callback()`
> assigns `int len = strlen(name)`, which is wrong.
> 
>> +{
>> +	int i;
> 
> `i` is used to iterate through `istate->cache_nr`, which is an `unsigned
> int` and not an `int`. I really wish we would compile the Git code base
> with `-Wconversion`, but that's a rather big undertaking.
> 
> Anyway, none of these issues are new as you merely move the code into a
> new function.
> 
> Patrick
> 

Yeah, the int types are bit of a mess, but I'd like to defer that to
another series.

There are several things going on here as you point out.

(1) 'int len' for the length of a pathname buffer.  This could be fixed,
but the odds of Git correctly working with a >2Gb pathname doesn't make
this urgent.

(2) 'int i' is signed, but should be unsigned -- but elsewhere in this
function we use 'int pos' which an index on the same array and has
double duty as the suggested insertion point when negative.  So we can
fix the type of 'i', but that just sets us up to hide errors with 'pos',
since they'd have different types.  Also, since it is really unlikely
for Git to work with >2G cache-entries, I think this one can wait too.

I don't mean to be confrontational, but I think these changes should
wait until another series that is focused on just those types of issues.

Jeff

