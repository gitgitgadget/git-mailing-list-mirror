Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715B21F461
	for <e@80x24.org>; Thu, 29 Aug 2019 14:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfH2OiI (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 10:38:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:33000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727773AbfH2OiH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 10:38:07 -0400
Received: (qmail 24185 invoked by uid 109); 29 Aug 2019 14:38:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Aug 2019 14:38:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23450 invoked by uid 111); 29 Aug 2019 14:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2019 10:39:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Aug 2019 10:38:05 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190829143805.GB1746@sigill.intra.peff.net>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
 <20190828161552.GE8571@szeder.dev>
 <4d5773f9-4637-d8a3-d683-82624950f319@gmail.com>
 <20190829141307.GE1797@sigill.intra.peff.net>
 <131dfa37-0f65-f0c3-6f30-5b6eca12d9c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <131dfa37-0f65-f0c3-6f30-5b6eca12d9c0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 10:27:16AM -0400, Derrick Stolee wrote:

> > I don't think we should need such a call. For one thing, if it were
> > necessary, that would mean we're not writing out the packet at all. But
> > your whole problem is that we're writing the message twice, one of which
> > comes from the packet.
> 
> The problem the flush() was trying to solve was the new "Broken pipe" error,
> which I had assumed was due to a communication race. (Looking at the message
> more closely now, I see that Szeder was able to repro this broken pipe both
> with and without my change. I am still unable to repro the broken pipe.)

I think the broken pipe is coming the _other_ way. We do send the packet
from the server to the client, but since the client is still writing
when the server has hung up, we get a write error instead of seeing the
error packet.

So any fixes there have to happen on the client side. I am still
confused about why the client is writing in this case, per the argument
in 014ade7484 (upload-pack: send ERR packet for non-tip objects,
2019-04-13). It would be nice to use GIT_TRACE_PACKET to see what it's
trying to write, but I still haven't been able to reproduce the issue.

-Peff
