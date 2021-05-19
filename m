Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4648C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927FD610A1
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbhESJ61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 05:58:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:58782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232819AbhESJ60 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 05:58:26 -0400
Received: (qmail 22546 invoked by uid 109); 19 May 2021 09:57:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 09:57:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17962 invoked by uid 111); 19 May 2021 09:57:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 05:57:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 05:57:06 -0400
From:   Jeff King <peff@peff.net>
To:     Greg Pflaum <greg.pflaum@pnp-hcl.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [BUG] clone of large repo fails when server closes idle SSH
 session during "Resolving deltas"
Message-ID: <YKTg8nYjSGpKbq8W@coredump.intra.peff.net>
References: <OF9ECB0D17.7C6A7258-ON852586DA.0014125E-852586DA.0014B7AB@pnp-hcl.com>
 <YKTbsByUaPEuDNtR@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKTbsByUaPEuDNtR@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 05:34:40AM -0400, Jeff King wrote:

> Another side issue is that once the protocol conversation has finished,
> I'm not sure if it's really useful for us to detect and complain about
> ssh's exit code. We know the other side completed the conversation
> successfully, and we have nothing left to ask it. So a fix for your
> immediate pain would be to stop noticing that. I think the root issue is
> still worth addressing, though; we are tying up network and local
> resources with a useless to-be-closed ssh connection.

By the way, there's an interesting subtlety / bug related to this. While
"git clone" does return a failed exit code in this case, it leaves the
repository directory in place! And because no real error occurred with
the clone, you can use it as usual (though I think if it's a non-bare
clone, you'd need to run "git checkout" fill in the working tree).

Propagating the error code comes from aab179d937 (builtin/clone.c: don't
ignore transport_fetch_refs() errors, 2020-12-03). So prior to Git
v2.30.0, your case would kind-of work.

But:

  - I think that is just "clone"; a "git fetch" would always have
    propagated the error from transport_fetch_refs()

  - that commit was right to start propagating the error code from
    transport_fetch_refs(). While in this specific case, we happened to
    produce a useful repository directory, most other errors would not.

  - there _is_ a bug in aab179d937, though. When it sees the error it
    should clean up the repo directory. And that even happens
    automatically via an atexit() handler. But because rather than
    calling die() it jumps to cleanup code, it mistakenly sets the flag
    for "leave the directory in place".

  - any logic to ignore errors would have to be inside the transport
    code (i.e., it realizes that ssh exiting non-zero isn't a big deal
    anymore, and then transport_fetch_refs() still returns success).

-Peff
