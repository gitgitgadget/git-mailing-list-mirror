Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC4CC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E14361139
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhDOJPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:15:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:53146 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231491AbhDOJP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:15:28 -0400
Received: (qmail 9771 invoked by uid 109); 15 Apr 2021 09:15:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 09:15:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14376 invoked by uid 111); 15 Apr 2021 09:15:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 05:15:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 05:15:04 -0400
From:   Jeff King <peff@peff.net>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/2] prevent `repack` to unpack and delete promisor
 objects
Message-ID: <YHgEGHIgwfobcwDr@coredump.intra.peff.net>
References: <20210403090412.GH2271@szeder.dev>
 <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 09:14:01PM +0200, Rafael Silva wrote:

> It took me a bit to come up with the test because it seems `repack`
> doesn't offer an option to skip the "deletion of unpacked objects",
> so this series adds a new option to `repack` for skip the
> `git prune-packed` execution thus allowing us to easily inspect the
> unpacked objects before they are removed and simplification of our
> test suite. Furthermore, The test will now test the `repack` code
> path instead of performing the operations by calling
> `pack-objects`.

Thanks for working on this. Overall the patches seem sane, though I
think Jonathan's comments (especially about the confusion in the commit
message of 2/2) are worth addressing.

I have mixed feelings on the "--no-prune-packed" option, just because
it's user-visible and I don't think it's something a normal user would
ever really want.

In the new test (and I think in the old ones you modified, though I
didn't look carefully) the main thing we care about is whether we write
out loose objects. So another solution would be to improve the debug
logging inside pack-objects to tell us more about what it's doing.

The fork of Git we use at GitHub has something similar; when we discard
objects or force them loose, we write their sha1 values to a log file.
This has come in handy for a lot of after-the-fact debugging ("oops,
this repo is corrupted; did we intentionally delete object X?").

I wonder if we could do something similar with the trace2 facility. I
know it can be turned on via config, but I don't know how good the
support is for enabling just one segment of data (and this may generate
a lot of entries, so people using trace2 for telemetry probably wouldn't
want it on).

For the purposes of the tests, though just a normal GIT_TRACE_PACK_DEBUG
would be plenty. I dunno. I don't want to open up a can of worms on
logging that would hold up getting this quite-substantial fix in place.
But once we add --no-prune-packed, it will be hard to take away.

-Peff
