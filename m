Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8AD41F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 20:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfDVUVn (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 16:21:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDVUVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 16:21:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 37B6060FEE; Mon, 22 Apr 2019 20:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555964502;
        bh=5+hRRmYJY9Fa5tX/cT+qxqz2MbJyTdRfE+rQmnQYsTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bd+QzXT8iOdtHeoBNuLRvg2lqFjGoWw+eACp8rEM0499UdpEilXNeGz4X2SSBULMZ
         JAGMK94/uqBAloZ0g/s4ZNC6VbW/g54xFwf3UPEz6bxuZHBwjV3CM04x6IlEK3yE1x
         AzlFmJ27jHU5WwzQbgINijxL0YMBHh+dajEfzSd0=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BDA660FE9;
        Mon, 22 Apr 2019 20:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555964501;
        bh=5+hRRmYJY9Fa5tX/cT+qxqz2MbJyTdRfE+rQmnQYsTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpkF9RwOB7oquEX/gB1CmYy4ev7N+ui7TVt+aS/UU3KMiWdpRsSqlAPf4P92+waYe
         yrthiKqFr4Chz46c8xnjQWPIcYvLLt5xFOGrEZT1fKhwJ61HCQ/DnW3XXy84nGUtz1
         1U35eONvKUU7W82t0VghrgtcUxLoSW2dXdeBn5fY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BDA660FE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Date:   Mon, 22 Apr 2019 14:21:40 -0600
Message-ID: <16052712.dFCfNLlQnN@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-137-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20190420035825.GB3559@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx> <20190420035825.GB3559@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, April 19, 2019 11:58:25 PM MDT Jeff King wrote:
> On Fri, Apr 19, 2019 at 03:47:22PM -0600, Martin Fick wrote:
> > I have been thinking about this problem, and I suspect that this compute
> > time is actually spent doing SHA1 calculations, is that possible? Some
> > basic back of the envelope math and scripting seems to show that the repo
> > may actually contain about 2TB of data if you add up the size of all the
> > objects in the repo. Some quick research on the net seems to indicate
> > that we might be able to expect something around 500MB/s throughput on
> > computing SHA1s, does that seem reasonable? If I really have 2TB of data,
> > should it then take around 66mins to get the SHA1s for all that data?
> > Could my repo clone time really be dominated by SHA1 math?
> 
> That sounds about right, actually. 8GB to 2TB is a compression ratio of
> 250:1. That's bigger than I've seen, but I get 51:1 in the kernel.
> 
> Try this (with a recent version of git; your v1.8.2.1 won't have
> --batch-all-objects):
> 
>   # count the on-disk size of all objects
>   git cat-file --batch-all-objects --batch-check='%(objectsize)
> %(objectsize:disk)' | perl -alne '
>     $repo += $F[0];
>     $disk += $F[1];
>     END { print "$repo / $disk = ", $repo/$disk }
>   '

This has been running for a few hours now, I will update you with results when 
its done.

> 250:1 isn't inconceivable if you have large blobs which have small
> changes to them (and at 8GB for 8 million objects, you probably do have
> some larger blobs, since the kernel is about 1/8th the size for the same
> number of objects).

I think it's mostly xml files in the 1-10MB range.

> So yes, if you really do have to hash 2TB of data, that's going to take
> a while.

I was hoping I was wrong. Unfortunately I sense that this is not likely 
something we can improve with a better algorithm. It seems like the best way 
to handle this long term is likely to use BUP's rolling hash splitting, it 
would make this way better (assuming it made objects small enough). I think it 
is interesting that this approach might end up being effective for more than 
just large binary file repos. If I could get this repo into bup somehow, it 
could potentially show us if this would drastically reduce the index-pack 
time.

> I think v2.18 will have the collision-detecting sha1 on by default,
> which is slower.

Makes sense.

> If you don't mind losing the collision-detection, using openssl's sha1
> might help. The delta resolution should be threaded, too. So in _theory_
> you're using 66 minutes of CPU time, but that should only take 1-2
> minutes on your 56-core machine. I don't know at what point you'd run
> into lock contention, though. The locking there is quite coarse.

I suspect at 3 threads, seems like the default?

I am running some index packs to test the theory, I can tell you already that 
the 56 thread versions was much slower, it took 397m25.622s. I am running a 
few other tests also, but it will take a while to get an answer. Since things 
take hours to test, I made a repo with a single branch (and the tags for that 
branch) from this bigger repo using a git init/git fetch. The single branch 
repo takes about 12s to clone, but it takes around 14s with 3 threads to run 
index-pack, any ideas why it is slower than a clone?

Here are some thread times for the single branch case:

 Threads  Time
 56           49s
 12           34s
 5             20s
 4             15s
 3             14s
 2             17
 1             30

So 3 threads appears optimal in this case.

Perhaps the locking can be improved here to make threading more effective?

> We also hash non-deltas while we're receiving them over the network.
> That's accounted for in the "receiving pack" part of the progress meter.
> If the time looks to be going to "resolving deltas", then that should
> all be threaded.

Would it make sense to make the receiving pack time also threaded because I 
believe that time is still longer than the I/O time (2 or 3 times)?

> If you want to replay the slow part, it should just be index-pack. So
> something like (with $old as a fresh clone of the repo):
> 
>   git init --bare new-repo.git
>   cd new-repo.git
>   perf record git index-pack -v --stdin <$old/.git/objects/pack/pack-*.pack
>   perf report
> 
> should show you where the time is going (substitute perf with whatever
> profiling tool you like).

I will work on profiling soon, but I wanted to give an update now.

Thanks for the great feedback,
 
-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

