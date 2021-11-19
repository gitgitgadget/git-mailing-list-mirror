Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47652C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 22:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhKSWfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:35:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:35412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhKSWfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 17:35:10 -0500
Received: (qmail 9375 invoked by uid 109); 19 Nov 2021 22:32:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 22:32:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19956 invoked by uid 111); 19 Nov 2021 22:32:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 17:32:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 17:32:06 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch-pack: ignore SIGPIPE when writing to index-pack
Message-ID: <YZgl5qYbAyAsixmo@coredump.intra.peff.net>
References: <YZgQD3lrw4+i4EMd@coredump.intra.peff.net>
 <xmqqy25jokft.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy25jokft.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 02:21:58PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When fetching, we send the incoming pack to index-pack (or
> > unpack-objects) via the sideband demuxer. If index-pack hits an error
> > (e.g., because an object fails fsck), then it will die immediately. This
> > may cause us to get SIGPIPE on the fetch, as we're still trying to write
> > pack contents from the sideband demuxer (which is typically a thread,
> > and thus takes down the whole fetch process).
> 
> So, ... we'd die anyway and won't update the refs and anything that
> leaves permanent damage to the repository either way, but we choose
> a better way to die by not taking SIGPIPE, but to get an error from
> one of the write()s or the final close(), which will lead us to more
> "controlled" death using the normal error path?

Yes, exactly. We'll be exiting either way; it's just a matter of racily
changing the exit code and possibly the error message from the parent
fetch process.

So I do doubt this really hurts users much in practice, but making the
tests robust seems worth it to me (because I found it after tracking
down a flaky test failure). And because it _is_ a race in the code, I
fixed it there rather than papering over the SIGPIPE exit in the test
script.

-Peff
