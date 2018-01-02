Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C3C1F428
	for <e@80x24.org>; Tue,  2 Jan 2018 21:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750819AbeABVyi (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 16:54:38 -0500
Received: from siwi.pair.com ([209.68.5.199]:30738 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbeABVyh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 16:54:37 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A1E66844DF;
        Tue,  2 Jan 2018 16:54:36 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 523F6844DC;
        Tue,  2 Jan 2018 16:54:36 -0500 (EST)
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-2-git@jeffhostetler.com>
 <20171221204356.GA58971@aiede.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2a5eb18a-d1b4-da2d-c2c8-5798d8627617@jeffhostetler.com>
Date:   Tue, 2 Jan 2018 16:54:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20171221204356.GA58971@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/21/2017 3:43 PM, Jonathan Nieder wrote:
> Hi,
> 
> Jeff Hostetler wrote:
> 
>> Created core.aheadbehind config setting and core_ahead_behind
>> global variable.  This value defaults to true.
>>
>> This value will be used in the next few commits as the default value
>> for the --ahead-behind parameter.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   Documentation/config.txt | 8 ++++++++
>>   cache.h                  | 1 +
>>   config.c                 | 5 +++++
>>   environment.c            | 1 +
>>   4 files changed, 15 insertions(+)
> 
> Not a reason to reroll on its own, but this seems out of order: the
> series is easier to explain and easier to merge down in stages if the
> patch for --ahead-behind comes first, then the config setting.
> 
> More generally, new commandline flags tend to be less controversial
> than new config settings since they cannot affect a script by mistake,
> and for that reason, they can go earlier in the series.
> 
> As a bonus, that makes it possible to include tests.  It's probably
> worth adding a test or two for this new config setting.

I'll look at restacking the commits and make this later in the
series.  I have tests in a later commit that uses the config setting,
but at this point nothing uses it, so I didn't add any tests for it.
So maybe with a restacking, I can split up the tests to go with this
change.

> 
> [...]
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 9593bfa..c78d6be 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -895,6 +895,14 @@ core.abbrev::
>>   	abbreviated object names to stay unique for some time.
>>   	The minimum length is 4.
>>   
>> +core.aheadbehind::
>> +	If true, tells commands like status and branch to print ahead and
>> +	behind counts for the branch relative to its upstream branch.
>> +	This computation may be very expensive when there is a great
>> +	distance between the two branches.  If false, these commands
>> +	only print that the two branches refer to different commits.
>> +	Defaults to true.
> 
> This doesn't seem like a particularly core feature to me.  Should it be
> e.g. status.aheadbehind (even though it also affects "git branch") or
> even something like diff.aheadbehind?  I'm not sure.

I wasn't sure where to put it after the earlier conversation in V1.

> I also wonder if there's a way to achieve the same benefit without
> having it be configurable.  E.g. if a branch is way behind, couldn't
> we terminate the walk early to get the same bounded cost per branch
> without requiring configuration?

I created a config setting because we don't want to force users to
type "git status --no-ahead-behind" on every interactive command to
get the benefit of it.  I guess we could ask them to alias it, if we
don't want a config setting.

Also, I didn't want to change the time-tested behavior that users see,
so I didn't want to change the algorithm in any way -- just not call it.


Would it make more sense to name this something like "status.aheadBehindLimit"
where 0 would mean no limit and match existing behavior and a positive
number be the number of commits we are allowed to search before giving up.
A value of 1 would match the "different" case in the current patch series.
For most users, a value of say 1000 would be sufficient most of the time
(and report at most a 999 a/b value), but keep us from going off into the
weeds for those ridiculous cases with very old branches.


Thanks,
Jeff

