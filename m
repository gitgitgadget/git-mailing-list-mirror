Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916491F453
	for <e@80x24.org>; Tue, 30 Apr 2019 20:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfD3Udz (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 16:33:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:44962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726028AbfD3Udz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 16:33:55 -0400
Received: (qmail 26837 invoked by uid 109); 30 Apr 2019 20:33:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Apr 2019 20:33:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12138 invoked by uid 111); 30 Apr 2019 20:34:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Apr 2019 16:34:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2019 16:33:53 -0400
Date:   Tue, 30 Apr 2019 16:33:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190430203353.GA16290@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net>
 <19221376.OlD5LWjr85@mfick-lnx>
 <20190423015538.GA16369@sigill.intra.peff.net>
 <20190423042109.GA19183@sigill.intra.peff.net>
 <CACsJy8B7tjjpUZK+zH4rvOSk=uTLOHCOy6hk4FkkHXqCzNZU9g@mail.gmail.com>
 <20190430175048.GB16729@sigill.intra.peff.net>
 <87sgtzqqhj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgtzqqhj.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 08:48:08PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > So I'd say the right answer is probably either online_cpus() or half
> > that. The latter would be more appropriate for the machines I have, but
> > I'd worry that it would leave performance on the table for non-intel
> > machines.
> 
> It would be a nice #leftoverbits project to do this dynamically at
> runtime, i.e. hook up the throughput code in progress.c to some new
> utility functions where the current code using pthreads would
> occasionally stop and try to find some (local) maximum throughput given
> N threads.
> 
> You could then dynamically save that optimum for next time, or adjust
> threading at runtime every X seconds, e.g. on a server with N=24 cores
> you might want 24 threads if you have one index-pack, but if you have 24
> index-packs you probably don't want each with 24 threads, for a total of
> 576.

Yeah, I touched on that in my response to Martin. I think that would be
nice, but it's complicated enough that I don't think it's a left-over
bit. I'm also not sure how hard it is to change the number of threads
after the initialization.

IIRC, it's a worker pool that just asks for more work. So that's
probably the right moment to say not just "is there more work to do" but
also "does it seem like there's an idle slot on the system for our
thread to take".

-Peff
