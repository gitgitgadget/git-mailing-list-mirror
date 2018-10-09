Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 832311F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 23:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJGcJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 02:32:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:34844 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725827AbeJJGcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 02:32:08 -0400
Received: (qmail 14376 invoked by uid 109); 9 Oct 2018 23:12:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 23:12:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11267 invoked by uid 111); 9 Oct 2018 23:12:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Oct 2018 19:12:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2018 19:12:50 -0400
Date:   Tue, 9 Oct 2018 19:12:50 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bloom Filters
Message-ID: <20181009231250.GA19342@sigill.intra.peff.net>
References: <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
 <20181009030803.GA6250@sigill.intra.peff.net>
 <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
 <20181009184647.GA7014@sigill.intra.peff.net>
 <ec3ca377-0434-322e-4ab9-49e27f96f4af@gmail.com>
 <20181009211449.GB9563@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009211449.GB9563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 09, 2018 at 05:14:50PM -0400, Jeff King wrote:

> Hmph. It really sounds like we could do better with a custom RLE
> solution. But that makes me feel like I'm missing something, because
> surely I can't invent something better than the state of the art in a
> simple thought experiment, right?
> 
> I know what I'm proposing would be quite bad for random access, but my
> impression is that EWAH is the same. For the scale of bitmaps we're
> talking about, I think linear/streaming access through the bitmap would
> be OK.

Thinking on it more, what I was missing is that for truly dense random
bitmaps, this will perform much worse. Because it will use a byte to say
"there's one 1", rather than a bit.

But I think it does OK in practice for the very sparse bitmaps we tend
to see in this application.  I was able to generate a complete output
that can reproduce "log --name-status -t" for linux.git in 32MB. But:

  - 15MB of that is commit sha1s, which will be stored elsewhere in a
    "real" system

  - 5MB of that is path list (which should shrink by a factor of 10 with
    prefix compression, and is really a function of a tree size less
    than history depth)

So the per-commit cost is not too bad. That's still not counting merges,
though, which would add another 10-15% (or maybe more; their bitmaps are
less sparse).

I don't know if this is a fruitful path at all or not. I was mostly just
satisfying my own curiosity on the bitmap encoding question. But I'll
post the patches, just to show my work. The first one is the same
initial proof of concept I showed earlier.

  [1/3]: initial tree-bitmap proof of concept
  [2/3]: test-tree-bitmap: add "dump" mode
  [3/3]: test-tree-bitmap: replace ewah with custom rle encoding

 Makefile                    |   1 +
 t/helper/test-tree-bitmap.c | 344 ++++++++++++++++++++++++++++++++++++
 2 files changed, 345 insertions(+)
 create mode 100644 t/helper/test-tree-bitmap.c

-Peff
