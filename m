Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C71E895
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973122; cv=none; b=H126CDTbeW19txsNvVmOm3g5CViHC9VgB9qLjFl7aWDy00ovvMwwww48gFprofWeUOEBDZszW5sFX81PlOK9bdk+3BkWG/UYypoRzKtMhln8KZh4457IXL0QGisxYnNTulmOX8fNxNmqkxHzrflbxx4XezYkrbS4aFLha/TaWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973122; c=relaxed/simple;
	bh=MSM9YLw1nvUYwN3odP9+wg5nZng4jlAyruOsMvHRphg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsWTFtNVm56pV99db46UU+tMn5EwnwcP5H8LlhlSmTHmqIzlNz6quRitwKlQyTTeoXNBNa9hkOSi2bYZIVRK3MUAxvPcTWfkhoWQmxVc79Tzt+R+z33ZC24WJ8PLpX8lqhmAIcKHjAPhrkzrnxLWJQAZrmzad7fPyiSOR8b0IO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 9AA3CCA1271;
	Mon, 26 Feb 2024 13:45:16 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:b846:2f3e:cac1:b0eb] (unknown [IPv6:2600:1700:840:e768:b846:2f3e:cac1:b0eb])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 2E13ACC83B9;
	Mon, 26 Feb 2024 13:45:15 -0500 (EST)
Message-ID: <57e3632f-36db-a9d8-b14c-1a68fea1b68d@jeffhostetler.com>
Date: Mon, 26 Feb 2024 13:45:13 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 09/16] fsmonitor: move untracked invalidation into
 helper functions
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <af6f57ab3e6d61036cd969f5fd9256200313aaa9.1708658300.git.gitgitgadget@gmail.com>
 <xmqqy1bbuloo.fsf@gitster.g>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqy1bbuloo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/23/24 12:36 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhostetler@github.com>
>>
>> Move the call to invalidate the untracked cache for the FSEvent
>> pathname into the two helper functions.
>>
>> In a later commit in this series, we will call these helpers
>> from other contexts and it safer to include the UC invalidation
>> in the helper than to remember to also add it to each helper
>> call-site.
>>
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
>>   fsmonitor.c | 26 +++++++++++++++++++-------
>>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> Thanks.  The steps in this iteration makes this move much less
> confusing to me than in the previous one.  We used to call one of
> "handle path with/without trailing slash" functions and then called
> the invalidation.  Now the invalidation happens in these "handle path"
> functions.
> 
> The unexplained change in behaviour is that we used to do the rest
> of "handle path" and invalidation was done at the end.  Now we do it
> upfront.  I think the "rest" works solely based on what is in the
> main in-core index array (i.e. the_index.cache[] aka active_cache[])
> and affects only what is in the in-core index array, while
> untracked_cache_invalidate*() works solely based on what is in the
> untracked cache extension (i.e. the_index.untracked) and affects
> only what is in there, so the order of these two does not matter.
> 
> Am I correct?
> 
> Or does it affect correctness or performance or whatever in any way?
> IOW, is there a reason why it is better to do the invalidation first
> and then doing the "rest" after (hence this patch flips the order of
> two to _improve_ something)?
> 
> Thanks.

The ce_flags invalidation and the untracked-cache invalidation are
independent (as far as I could tell) and it doesn't matter which
order we do them.  Moving the UC to the start of the function was
an attempt to avoid the usual "goto the bottom" or the need to guard
against early "return" statements that were present in some of the
original code (or my various refactorings).  Moving it to the top
just let me get it out of the way and not have to contrive things.

I'll update the commit message.

Thanks
Jeff

