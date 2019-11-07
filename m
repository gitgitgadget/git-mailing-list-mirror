Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811961F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfKGGn5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:43:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:41746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726094AbfKGGn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:43:57 -0500
Received: (qmail 29205 invoked by uid 109); 7 Nov 2019 06:43:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 06:43:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32453 invoked by uid 111); 7 Nov 2019 06:47:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 01:47:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 01:43:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, rynus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] commit-graph: use start_delayed_progress()
Message-ID: <20191107064356.GH6431@sigill.intra.peff.net>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
 <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
 <20191106040955.GD4307@sigill.intra.peff.net>
 <xmqqpni4s3mn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpni4s3mn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 01:37:52PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think this is OK for now, though it does make me wonder if
> > "--progress" ought to perhaps override "delayed" in some instances,
> > since it's a positive signal from the caller that they're interested in
> > seeing progress.
> 
> I did have the same reaction after seeing the change to 5318 where
> the expected output from "git commit-graph write --progress" has
> become unreliable.
> 
> I think there are possibly three kinds of folks:
> 
>  - I do not want the output smudged with any progress (e.g. I am a
>    script);
> 
>  - I want to see progress if it takes very long, but do not waste
>    vertical screen real estate if it does not make me wait (e.g. I
>    am an interactive user who occasionally wants a cue to leave the
>    keyboard to grab coffee); and
> 
>  - I want to see all progress (... now who am I?  Taking a
>    screenshot to write a tutorial or something???).

I think type 3 may be people who want to understand more about the
program flow, and where it's at when it sees an error.

> In the ideal world, the three choices above should probably be
> "--progress=(no|auto|always)" where not having any defaults to one
> of them (probably "auto", as the code can use isatty() to further
> turn it to "no").

I think any no/auto/always here is tricky, because it already has a
meaning: to use or disregard isatty(2). And overriding that might be
independent of the "type" (think pack-objects on a server generating
output that's going over the wire; we have to tell it "yes, definitely
show progress even though there is no terminal", but that has nothing to
do with any "delay" decisions).

-Peff
