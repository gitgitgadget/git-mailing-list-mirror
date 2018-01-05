Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533351F42B
	for <e@80x24.org>; Fri,  5 Jan 2018 16:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeAEQq0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 11:46:26 -0500
Received: from siwi.pair.com ([209.68.5.199]:60164 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbeAEQqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 11:46:25 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C8867844D7;
        Fri,  5 Jan 2018 11:46:24 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8D489844D9;
        Fri,  5 Jan 2018 11:46:24 -0500 (EST)
Subject: Re: [PATCH v3 0/5] Add --no-ahead-behind to status
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180103214733.797-1-git@jeffhostetler.com>
 <20180104230630.GA2599@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2887ad5a-5de9-3c5b-92c3-40b19120e604@jeffhostetler.com>
Date:   Fri, 5 Jan 2018 11:46:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180104230630.GA2599@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/4/2018 6:06 PM, Jeff King wrote:
> On Wed, Jan 03, 2018 at 09:47:28PM +0000, Jeff Hostetler wrote:
> 
>> Config values of true and false control non-porcelain formats
>> for compatibility reasons as previously discussed.  In the
>> last commit I added a new value of 2 for the config setting
>> to allow porcelain formats to inherit the new setting.  I've
>> marked this experimental for now or so that we can discuss
>> it.
> 
> I'm mildly negative on this "level 2" config. If influencing the
> porcelain via config creates compatibility headaches, then why would we
> allow it here? And if it doesn't, then why do we need to protect against
> it? This seems to exist in a funny middle ground that cannot decide
> whether it is bad or not.
> 
> It's like we're inserting a foot-gun, but putting it just far enough out
> of reach that we can blame the user when they shoot themselves with it.
> 
> Is there a compelling use case for this? From the previous discussion,
> this is the strawman I came up with:
> 
>    Scripted callers like Visual Studio don't want to unconditionally pass
>    --no-ahead-behind, because it makes sense only for large repositories
>    (and small ones would prefer the more exact answer, if we can get it
>    cheaply). So we'd like the user to trigger "this is large" on a
>    per-repo basis, and accept the consequences of possibly broken
>    porcelain callers.
> 
> I think we could have the best of both worlds, though, if the existing
> config option were coupled with a command-line option to say "yes, I
> understand no-ahead-behind, so use it for the porcelain if applicable".
> IOW, the user does:
> 
>    git config status.aheadbehind false
> 
> and VS does:
> 
>    git status --ahead-behind=maybe
> 
> and together both sides have assented to the "quick" thing.
> 
> -Peff

I kinda trying to serve 2 masters here.  As we discussed earlier, we
don't want config options to change porcelain formats, hence the
true/false thing only affecting non-porcelain formats.  On the other
hand, VS and git.exe are on different release schedules.  Normally,
I'd just have VS emit a "git status --no-ahead-behind --porcelain=v2"
and be done, but that requires that git.exe gets updated before VS.
We do control some of that, but if VS gets updated first, that causes
an error, whereas "git -c status.aheadbehind=<x> status --porcelain=v2"
does not.  It is respected if/when git is updated and ignored until
then.  Likewise, if they update git first, we can tell them to set a
config setting on the repo and inherit it for porcelain v2 output
without VS knowing about it.  Sorry, if that's too much detail.

It is OK with me if we omit the last commit in the patch series (that
does the experimental =2 extension) and I'll deal with this separately
(maybe differently) in the gvfs fork.

Thanks,
Jeff

  
