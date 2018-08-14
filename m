Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9771F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeHNXzS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:55:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:55356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727997AbeHNXzS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:55:18 -0400
Received: (qmail 5720 invoked by uid 109); 14 Aug 2018 21:06:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 21:06:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26122 invoked by uid 111); 14 Aug 2018 21:06:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 17:06:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 17:06:16 -0400
Date:   Tue, 14 Aug 2018 17:06:16 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Syncing HEAD
Message-ID: <20180814210616.GA32367@sigill.intra.peff.net>
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 10:09:37PM +0200, Christian Couder wrote:

> When cloning with --mirror, the clone gets its HEAD initialized with
> the value HEAD has in its origin remote. After that if HEAD changes in
> origin there is no simple way to sync HEAD at the same time as the
> refs are synced.
> 
> It looks like the simplest way to sync HEAD is:
> 
> 1) git remote show origin
> 2) parse "HEAD branch: XXX" from the output of the above command
> 3) git symbolic-ref HEAD refs/heads/XXX

How about:

  git remote set-head origin -a

?

> It looks like it would be quite easy to add an option to `fetch` to
> sync HEAD at the same time as regular refs are synced because every
> fetch from an origin that uses a recent Git contains something like:

I think the "remote set-head" option is not very discoverable, since
people are used to working with "fetch", making it the natural place to
look. Just like we ported "remote update" over to "fetch --all", I think
it would be sensible to have "fetch --update-head" or similar.

One tricky thing is that the name "refs/remotes/<remote>/HEAD" is only
special by convention, and that convention is known on the writing side
only by git-clone and git-remote. So obviously:

  git fetch --update-head https://example.com/

is nonsense. We don't even have a ref. What should:

  git config remote.origin.fetch refs/heads/*:refs/remotes/foo/*
  git fetch --update-head origin

do? Should it update based no the remote name, or based on the refspec?
What happens if there are several refspecs? Etc.

99% of the time those questions won't come up. But we should design so
that we do the obvious thing in those 99%, and something sane in the
other 1%.

-Peff
