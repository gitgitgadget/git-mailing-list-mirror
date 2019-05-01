Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6BB01F453
	for <e@80x24.org>; Wed,  1 May 2019 18:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEASbL (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:31:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:46084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726069AbfEASbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:31:10 -0400
Received: (qmail 23495 invoked by uid 109); 1 May 2019 18:31:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:31:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20959 invoked by uid 111); 1 May 2019 18:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:31:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:31:08 -0400
Date:   Wed, 1 May 2019 14:31:08 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 4/8] commit-graph: don't early exit(1) on e.g. "git
 status"
Message-ID: <20190501183108.GE4109@sigill.intra.peff.net>
References: <20190314214740.23360-1-avarab@gmail.com>
 <20190325120834.15529-5-avarab@gmail.com>
 <87y33vr41k.fsf@evledraar.gmail.com>
 <3518ad3e-bc4a-c2c3-d4bd-c87f9e828b1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3518ad3e-bc4a-c2c3-d4bd-c87f9e828b1c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 29, 2019 at 08:48:51AM -0400, Derrick Stolee wrote:

> Q: How should we handle a detectably-invalid commit-graph?
> 
> I think most of your patches have done a good job so far of detecting
> an invalid header, and responding by ignoring the commit-graph. This case
> of a detectable error in the chunk data itself is not something we can
> check on the first load without serious performance issues.
> 
> I hope we can decide on a good solution.

I think it's OK to die() unceremoniously in these cases. We already have
similar behavior when dealing with packfiles. While we try to just
return an error for bit-flips in data (so we can try finding the object
elsewhere), if there are things like nonsensical file offsets, we
generally just give up.

So I think it makes sense to start with the _safe_ thing, which is just
giving up on the operation and informing the user. If somebody wants to
then loosen things up on a case by case basis (after seeing that it
wouldn't produce incorrect results to do so), that can be future work.

For the commit-graph, though, and given that we're talking about file
corruption, I don't know that it's even worth the effort. The solution
is basically always going to be "delete the commit-graph file and
regenerate it". It's perhaps slightly inconvenient compared to falling
back, but this just isn't something we'd expect to happen often.

-Peff
