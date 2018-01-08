Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFBD1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 14:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757228AbeAHOWd (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 09:22:33 -0500
Received: from siwi.pair.com ([209.68.5.199]:10421 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757153AbeAHOWc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 09:22:32 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E6A87844C1;
        Mon,  8 Jan 2018 09:22:31 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A933C844BE;
        Mon,  8 Jan 2018 09:22:31 -0500 (EST)
Subject: Re: [PATCH v3 0/5] Add --no-ahead-behind to status
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180103214733.797-1-git@jeffhostetler.com>
 <20180104230630.GA2599@sigill.intra.peff.net>
 <2887ad5a-5de9-3c5b-92c3-40b19120e604@jeffhostetler.com>
 <20180108063712.GB10933@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3ed06c39-2eac-e9d7-2976-6a7b55536cb0@jeffhostetler.com>
Date:   Mon, 8 Jan 2018 09:22:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180108063712.GB10933@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/8/2018 1:37 AM, Jeff King wrote:
> On Fri, Jan 05, 2018 at 11:46:24AM -0500, Jeff Hostetler wrote:
> 
>>> I'm mildly negative on this "level 2" config. If influencing the
>>> porcelain via config creates compatibility headaches, then why would we
>>> allow it here? And if it doesn't, then why do we need to protect against
>>> it? This seems to exist in a funny middle ground that cannot decide
>>> whether it is bad or not.
>>>
>>> It's like we're inserting a foot-gun, but putting it just far enough out
>>> of reach that we can blame the user when they shoot themselves with it.
>>>
>>> Is there a compelling use case for this? From the previous discussion,
>>> this is the strawman I came up with:
>> [...]
>>
>> I kinda trying to serve 2 masters here.  As we discussed earlier, we
>> don't want config options to change porcelain formats, hence the
>> true/false thing only affecting non-porcelain formats.  On the other
>> hand, VS and git.exe are on different release schedules.  Normally,
>> I'd just have VS emit a "git status --no-ahead-behind --porcelain=v2"
>> and be done, but that requires that git.exe gets updated before VS.
>> We do control some of that, but if VS gets updated first, that causes
>> an error, whereas "git -c status.aheadbehind=<x> status --porcelain=v2"
>> does not.  It is respected if/when git is updated and ignored until
>> then.  Likewise, if they update git first, we can tell them to set a
>> config setting on the repo and inherit it for porcelain v2 output
>> without VS knowing about it.  Sorry, if that's too much detail.
> 
> OK, so my strawman was totally off-base. :)
> 
> That explanation is interesting. I do think you're facing a real problem
> with moving the versions in lockstep. But shoe-horning the feature into
> config like this seems like a pretty ugly solution:
> 
>    1. Then we're stuck with this weird foot-gun config option forever.
> 
>    2. It only solves the problem for this one option. Is there a more
>       general solution?
> 
> The more general solutions I can come up with are:
> 
>    1. Is there a way for a caller to query Git to say "do you understand
>       --no-ahead-behind?".
> 
>       You can ask "git version", but parsing version numbers is
>       problematic. We don't have any kind of "feature flags" output, and
>       I'm not sure we'd want to get down to the level of specific
>       command-line options there.
> 
>       One thing you can do is speculatively run "status --no-ahead-behind",
>       and if it returns 129, try again without as a fallback. That incurs
>       a failed invocation for the fallback case, but it's quick (we fail
>       before looking at any data) and you can cache it for the duration
>       of a VS session.
> 
>    2. There could be some way to tell the option parser that the next
>       flag is optional. E.g.:
> 
>         git status --optional=--no-ahead-behind
> 
>       That would be pretty easy to implement globally in parse-options.c.
>       It knows when an option is unrecognized, so it could just treat
>       that as a silent noop rather than barfing.
> 
>       Of course, that doesn't solve your problem today. It wouldn't be
>       safe to start using "--optional" until it had been in several
>       released versions.
> 
>       And I have a feeling it may not be sufficient without further
>       feedback to the caller. For this flag, the caller is happy to say
>       "do this if you know how, but otherwise I will cope". But there are
>       probably flag where it would need to know whether it had any effect
>       or not. So this whole direction is probably crazy.
> 
> Of the two, I think (1) is not so bad.
> 
>> It is OK with me if we omit the last commit in the patch series (that
>> does the experimental =2 extension) and I'll deal with this separately
>> (maybe differently) in the gvfs fork.
> 
> That would be my preference. Thanks.
> 
> -Peff
> 

Interesting ideas, but probably overkill for now.  I'll pull it out
of my next version and deal with it differently our gvfs fork.

Thanks,
Jeff
