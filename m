Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA301F454
	for <e@80x24.org>; Mon, 11 Nov 2019 03:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKKD3r (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 22:29:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:44078 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726742AbfKKD3r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 22:29:47 -0500
Received: (qmail 14645 invoked by uid 109); 11 Nov 2019 03:29:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 03:29:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1182 invoked by uid 111); 11 Nov 2019 03:33:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 10 Nov 2019 22:33:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 10 Nov 2019 22:29:46 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: Split commit graphs and commit-graph read
Message-ID: <20191111032946.GA5912@sigill.intra.peff.net>
References: <CAGyf7-G3NDp--2nUbri_0EqvSLF21M0gsFCOKDCWMY+e68Htog@mail.gmail.com>
 <87f16645-6af4-9703-1d0d-eb64728d2849@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87f16645-6af4-9703-1d0d-eb64728d2849@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 10, 2019 at 08:19:20PM -0500, Derrick Stolee wrote:

> > Running some tests with commands like git for-each-ref and git
> > rev-list shows that the "split" commit graph is being used (setting
> > core.commitGraph=false makes commands noticeably slower), so
> > functionally all seems well. But should git commit-graph read be
> > handling this better?
> 
> Unfortunately, you're running into an issue because I designed the
> "read" subcommand poorly (and also forgot to update it for
> incremental commit-graph files). The biggest issue is that "read"
> is not really meant for end-users. It really should have been built
> as a test-tool. This point was corrected when I got around to writing
> the multi-pack-index since it uses "test-tool read-midx" instead of
> add.
> 
> To fix this issue, I would probably go about it by removing the "read"
> subcommand and creating a "test-tool read-commit-graph" for the tests
> that need that output.
> 
> If others on-list think that the better thing to do is to update the
> "read" subcommand to provide the same output, but iterate over each
> layer of an incremental commit-graph, then I can do that work instead.

In theory I suppose one could use it to debug a commit-graph file "in
the field" as it were, where somebody does not necessarily have the
test-tool programs. But in practice, I have not ever done that (I didn't
even know "commit-graph read" was there), and it's not that big a deal
to just have a build of git.git handy.

I'd be much more likely to use "commit-graph verify". And perhaps it
could grow a "--verbose" flag if somebody really wants that (but I think
it would be fine to punt until somebody cares enough to do so).

I guess dropping the sub-command is technically a backwards incompatible
change, but since it didn't do anything that normal users would find
useful in the first place, I wouldn't be sorry to see it go.

-Peff
