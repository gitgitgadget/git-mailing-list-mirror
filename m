Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871A12838D
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455365; cv=none; b=sy1WPtHL1S3EMAoIpw6dYgkKbKMEiTx8TiRnbjXf/fpV9r9rsWY/m96vBGD6Oo7IxbT2vCOFgcLOPOhI/2dtyt4qnR2J90hmEAkVtna/ncLaX5rLLnXE3wlWYFVgMzXCcjxtPtmP4Ul3p8xO2WxFpxmjFqQmf/+2hRV4mtG/CyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455365; c=relaxed/simple;
	bh=9hlHKMrmn4tEB6szxKFycOzA3j/LK7CjMAMs0sTOmnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNsl9E9g1kev+HVvRr8sgcu4szjBclQnxjPbtAKVzbXtd5Bhwzn6vBvXKQ14aWC38SqUkEkvf0tbqR9NnMFrHGOpEtAux9rsqmmzsv8nQODryAqe9PTZYMxmFwfUzy7Gl+k1EWgeTIH0n9Gi4yzND8xpkvN/j+Dq9cCeYdWTSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 42432CA1256;
	Tue, 20 Feb 2024 13:56:02 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:61e9:e43c:2400:ab1c] (unknown [IPv6:2600:1700:840:e768:61e9:e43c:2400:ab1c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id EB931CC83B4;
	Tue, 20 Feb 2024 13:56:01 -0500 (EST)
Message-ID: <b379b92f-407a-c4b3-ee65-a7fa6e7dff74@jeffhostetler.com>
Date: Tue, 20 Feb 2024 13:56:01 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 06/12] fsmonitor: clarify handling of directory events in
 callback
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <5b6f8bd1fe7b6c742b25a5a1ed95b528f352215e.1707857541.git.gitgitgadget@gmail.com>
 <xmqqil2rzdvo.fsf@gitster.g>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqil2rzdvo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/14/24 2:47 AM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
>>   fsmonitor.c | 47 +++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 33 insertions(+), 14 deletions(-)
>>
>> diff --git a/fsmonitor.c b/fsmonitor.c
>> index 614270fa5e8..754fe20cfd0 100644
>> --- a/fsmonitor.c
>> +++ b/fsmonitor.c
>> @@ -219,24 +219,40 @@ static void fsmonitor_refresh_callback_unqualified(
>>   	}
>>   }
>>   
>> -static void fsmonitor_refresh_callback_slash(
...
>> +static int fsmonitor_refresh_callback_slash(
>>   	struct index_state *istate, const char *name, int len, int pos)
>>   {
> 
> This was split out a few patches ago, and the caller of course
> ignored the return value (void), but now it turns an integer, and
> this change is without a corresponding update to the caller, which
> leaves readers puzzled.
> 
> Perhaps a future patch either updates the existing caller or adds a
> new caller that utilize the returned value, but then at least the
> proposed commit message for this step should hint how it helps the
> caller(s) we will see in the future steps if this function returns
> the number of entries invalidated, iow, how the caller is expected
> to use the returned value from here, no?
> 
> Alternatively, this step can limit itself to what the commit title
> claims to do---to clarify what the helper does with enhanced in-code
> comments.  Then a future step that updates the caller to care about
> the return value can have both the changes to this callee as well as
> the caller---which may make it easier to see how the returned info
> helps the caller.  I dunno which is more reasonable.
> 

I'll split this into 2 commits.  One for the refactor and one for
the new return value.

Jeff

