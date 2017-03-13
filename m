Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DED21FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 16:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbdCMQkQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 12:40:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbdCMQj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 12:39:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5ED9360877; Mon, 13 Mar 2017 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489423179;
        bh=Y0L2AUSHCH76bsxWQO/pWuSc23KHYTn/iUQ5fyFw0+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSQtSZcaGvoVGG+pd8IF8Jt2ameJerMCCfOdVdGiVe02fJ7JqOEreO1Ex0d6Zu5O3
         qgYiK7rLxvHoNVEXMdTwxBJU2NZEL9j3C1M/M6TOfW52ZibiUDH2oEm+z95JxXGzjm
         EOWEmaOZrUpC/FrOiimG4ECCaiqbljelj8yYe8lQ=
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4A4B60805;
        Mon, 13 Mar 2017 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489423178;
        bh=Y0L2AUSHCH76bsxWQO/pWuSc23KHYTn/iUQ5fyFw0+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ag5y7AwnMTQnOf2MNLFxzLNr8Mcyd77GVcpu4hzEgClqj35RLcSfgVg7ykU/gH6ix
         4XuzhWrHoWrpdq4WZzHW8nL4n5SvCtROBoSU4xKKIASSy9cWybJQLrBoFQOCz5QQNg
         LkkNAj+Jbvob8J8lLxiuMKjvhIGlA6QwflXaBkWw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4A4B60805
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, James Melvin <jmelvin@codeaurora.org>,
        git@vger.kernel.org, nasserg@codeaurora.org, sbeller@google.com
Subject: Re: [PATCH v2] repack: Add option to preserve and prune old pack files
Date:   Mon, 13 Mar 2017 10:39:37 -0600
Message-ID: <2062422.zvngdQjy4d@mfick1-lnx>
User-Agent: KMail/4.8.5 (Linux/3.2.0-106-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <xmqqbmt6v0cf.fsf@gitster.mtv.corp.google.com>
References: <20170310220020.2666-1-jmelvin@codeaurora.org> <20170312122418.e544nrmqniycqouc@sigill.intra.peff.net> <xmqqbmt6v0cf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, March 12, 2017 11:03:44 AM Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> > I can think of one downside of a time-based solution,
> > though: if you run multiple gc's during the time
> > period, you may end up using a lot of disk space (one
> > repo's worth per gc). But that's a fundamental tension
> > in the problem space; the whole point is to waste disk
> > to keep helping old processes.
> 
> Yes.  If you want to help a process that mmap's a packfile
> and wants to keep using it for N seconds, no matter how
> many times somebody else ran "git repack" while you are
> doing your work within that timeframe, you somehow need
> to make sure the NFS server knows the file is still in
> use for that N seconds.
> 
> > But you may want a knob that lets you slide between
> > those two things. For instance, if you kept a sliding
> > window of N sets of preserved packs, and ejected from
> > one end of the window (regardless of time), while
> > inserting into the other end. James' existing patch is
> > that same strategy with a hardcoded window of "1".
> 
> Again, yes.  But then the user does not get any guarantee
> of how long-living a process the user can have without
> getting broken by the NFS server losing track of a
> packfile that is still in use.  My suggestion for the
> "expiry" based approach is essentially that I do not see
> a useful tradeoff afforded by having such a knob.
> > The other variable you can manipulate is whether to gc
> > in the first place. E.g., don't gc if there are N
> > preserved sets (or sets consuming more than N bytes, or
> > whatever). You could do that check outside of git
> > entirely (or in an auto-gc hook, if you're using it).
> Yes, "don't gc/repack more than once within N seconds" may
> also be an alternative and may generally be more useful
> by covering general source of wastage coming from doing
> gc too frequently, not necessarily limited to preserved
> pack accumulation.

As someone who helps manage a Gerrit server for several 
thousand repos, all on the same NFS disks, a time based 
expiry seems unpractical, and not something that I am very 
interested in having.  I favor the simpler (single for now) 
repacking cycle approach, and it is what we have been using 
for almost 6 months now successfully, without suffering any 
more stale file handle exceptions.

While time is indeed the factor that is going to determine 
whether someone is going to see the stale file handles or 
not, on a server (which is what this feature is aimed at), 
this is secondary in my mind to predictability about space 
utilization.  I have no specific minimum time that I can 
reason about, i.e. I cannot reasonably say "I want all 
operations that last less than 1 hour, 1 min, or 1 second... 
to succeed".  I don't really want ANY failures, and I am 
willing to sacrifice some disk space to prevent as many as 
possible.  So the question to me is "How much disk space am 
I willing to sacrifice?", not "How long do I want operations 
to be able to last?".  The only way that time enters my 
equation is to compare it to how long repacking takes, i.e. 
I want the preserved files cleaned up on the next repack.   
So effectively I am choosing a repacking cycle based 
approach, so that I can reasonably predict the extra disk 
space that I need to reserve for my collection of repos.  
With a single cycle, I am effectively doubling the "static" 
size of repos.  

To achieve this predictability with a time based approach 
requires coordination between the expiry setting and the 
repacking time cycle.  This coordination is extra effort for 
me, with no apparent gain.  It is also an additional risk 
that I don't want to have.  If I decide to bump up how often 
I run repacking, and I forget to reduce the expiry time, my 
disk utilization will grow and potentially cause serious 
issues for all my repositories (since they share the same 
volume).  This problem is even more difficult if I decide to 
use a usage (instead of time) based algorithm to determine 
when I repack.

Admittedly, a repacking cycle based approach happens to be 
very easy and practical when it is a "single" cycle.  If I 
determine eventually empirically that a single cycle is not 
long enough for my server, I don't know what I will do?  
Perhaps I would then want a switch that preserves the repos 
for another cycle?  Maybe it could work the way that log 
rotation works, add a number to the end of each file name for 
each preserved cycle?  This option seems preferable to me 
than a time based approach because it makes it more obvious 
what the impact on disk utilization will be.  However, so 
far in practice, this does not seem necessary.

I don't really see a good use case for a time based expiry 
(other than "this is how it was done for other things in 
git").  Of course, that doesn't mean such a use case doesn't 
exist, but I don't support adding a feature unless I really 
understand why and how someone would want to use it.  I 
think that a time based expiry should only be added if 
someone has a specific use case they expect to achieve with 
it, and they actually plan to use it that way, not just for 
uniformity. 

One might even eventually decide that some of the other 
current use cases for time based expiries should be 
converted to cycle based expiries; I suspect server admins 
will have fewer surprises that way,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

