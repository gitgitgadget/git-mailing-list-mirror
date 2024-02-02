Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBF15E5B5
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901925; cv=none; b=FVDJltLA2xqmjzz+o8RfIKAFyfNc8UXZTrAAKYgoxB+lY65afQE60UjRRvAefBKFpoouwrzmCbKA0fKVFZ7TUbTfEplCj9wwkFURNJMvLz84QNHmx7xkDpQn96V3x7u811ZXvKFr4gSlUDmCTnhSdiXz9G8kWk8NeXp8ADb8F70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901925; c=relaxed/simple;
	bh=1a8qsfscIvo9ZEdmq7ArdIBHQNuqq24bMbgOrpVg88k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLcbZYV3wTr2FZxCI7W01wkUTuax69gT+r5b2ZSRDSJRBEL2imDnDrySauf/0e0IK8jOpN8Fu6cIheA4An1kyZk0/2m8hd/zgBHjZM6ZKyz/Cy0AA0sU0ksbbCTJHDPwu7S/VKCYyu9X0CN7N3ldHNk9N3osjNJWkhm2IHfno/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 658CECA126F;
	Fri,  2 Feb 2024 14:19:18 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:5ab:5ff0:49e9:ac9] (unknown [IPv6:2600:1700:840:e768:5ab:5ff0:49e9:ac9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 3428DCC83C0;
	Fri,  2 Feb 2024 14:19:18 -0500 (EST)
Message-ID: <2bae709a-18da-6ab8-2b76-032ddc045641@jeffhostetler.com>
Date: Fri, 2 Feb 2024 14:19:17 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] sparse-index: pass string length to index_file_exists()
To: Junio C Hamano <gitster@pobox.com>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1649.git.1706897095273.gitgitgadget@gmail.com>
 <xmqqo7cysp01.fsf@gitster.g>
Content-Language: en-US
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqo7cysp01.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/2/24 1:24 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> The call to index_file_exists() in the loop in expand_to_path() passes
>> the wrong string length.  Let's fix that.
>>
>> The loop in expand_to_path() searches the name-hash for each
>> sub-directory prefix in the provided pathname. That is, by searching
>> for "dir1/" then "dir1/dir2/" then "dir1/dir2/dir3/" and so on until
>> it finds a cache-entry representing a sparse directory.
>>
>> The code creates "strbuf path_mutable" to contain the working pathname
>> and modifies the buffer in-place by temporarily replacing the character
>> following each successive "/" with NUL for the duration of the call to
>> index_file_exists().
>>
>> It does not update the strbuf.len during this substitution.
> 
> Meaning we memihash() the full pathname munged with '/' -> NUL through
> to the end of the original, when we should memihash() the truncated
> leading pathname.  This is bad, and the ...
> 
>>
>> Pass the patched length of the prefix path instead.
> 
> ... fix looks quite straight-forward.
> 
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
> 
> The problem description and the fix makes sense, but did you
> actually see an end-user visible breakage due to this bug?  I am
> wondering how you found it, and if it is reasonable to have a test
> demonstrate the breakage.

I'm working on a bug where the fsmonitor client doesn't
invalidate the CE flags when there is a case discrepancy between
the expected and observed case on a case-insensitive file system.
(Fix due shortly.)

And I was single-stepping in the debugger inside of
`index_file_exists()` while tracking that down and noticed that the
length argument was bogus.  Something like { name="dir1/", len=10 }

I don't remember if this bug caused visible problems or not. It felt
like it caused a few extra rounds of mutually-recursive calls between
`index_file_exists()` and `expand_to_path()`, but I can't say that
for certain (and I was focused on a different problem at the time).

I do have some test code in `t/helper/lazy-init-name-hash.c` that
I suppose we could extend to beat on it, but I'm not sure it is
worth it in this case.

Jeff


> 
>>   sparse-index.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sparse-index.c b/sparse-index.c
>> index 1fdb07a9e69..093708f6220 100644
>> --- a/sparse-index.c
>> +++ b/sparse-index.c
>> @@ -579,8 +579,9 @@ void expand_to_path(struct index_state *istate,
>>   		replace++;
>>   		temp = *replace;
>>   		*replace = '\0';
>> +		substr_len = replace - path_mutable.buf;
>>   		if (index_file_exists(istate, path_mutable.buf,
>> -				      path_mutable.len, icase)) {
>> +				      substr_len, icase)) {
> 
> There is a break out of this loop when the condition for this "if"
> statement holds, but the value of substr_len does not affect what
> happens after this index_file_exists() call (correctly) computes its
> result.  The fix looks good.
> 
> Thanks.
> 
>>   			/*
>>   			 * We found a parent directory in the name-hash
>>   			 * hashtable, because only sparse directory entries
>> @@ -593,7 +594,6 @@ void expand_to_path(struct index_state *istate,
>>   		}
>>   
>>   		*replace = temp;
>> -		substr_len = replace - path_mutable.buf;
>>   	}
>>   
>>   cleanup:
>>
>> base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
> 
