Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095ECC433FB
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8EF2070B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgG1UIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:08:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:40170 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgG1UIs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:08:48 -0400
Received: (qmail 29566 invoked by uid 109); 28 Jul 2020 20:08:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:08:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28378 invoked by uid 111); 28 Jul 2020 20:08:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:08:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:08:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
Message-ID: <20200728200847.GA1019822@coredump.intra.peff.net>
References: <xmqqft9fi4hm.fsf@gitster.c.googlers.com>
 <20200728192350.352978-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728192350.352978-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 12:23:50PM -0700, Jonathan Tan wrote:

> > For this particular case, with the performance and all, I agree that
> > the stupid and robust approach would be the best.
> 
> I'm concerned that we will be painting ourselves into a corner here - I
> have been appreciating the richer interface that a C call provides us,
> compared to sub-processes where we have to communicate through a single
> input stream and a single output stream. For example, "wanted-refs" and
> [...]

Yeah, that's a compelling reason. I'd have thought for this use case you
could just say "hey, make sure these objects exist", which doesn't
require a lot of communication. But often when I think things like that
and start coding, it turns out to be much more complicated. So I am
perfectly willing to believe you that it doesn't apply here. And even
if it did, you're right that we may run into other spots that do need to
pass back more information, but benefit from more lib-ified code that
doesn't die().

Just to play devil's advocate for a moment...

> (Also, I think that debugging within a process is easier than debugging
> across processes, but that might not be a concern that other people
> share.)

This is definitely true sometimes, but I think is sometimes the
opposite. When we push things out to a sub-process, then the interface
between the two processes has to be well-defined (e.g., writing results
to a file with a particular format). And that can make debugging easier,
because you can pick up from that intermediate state (munging it in the
middle, or even generating it from scratch for testing).

Likewise, that can result in a more flexible and robust system from the
perspective of users. If we had invented "git log" first, we probably
wouldn't have "git rev-list | git diff-tree --stdin" at all. But having
that as two separate tools is sometimes useful for people doing things
_besides_ log, since it gives different entry points to the code.

That said, I think I could buy the argument that "fetch" works pretty
well as a basic building block for users. It's pretty rare to actually
use fetch-pack as a distinct operation. This is all a monolith vs module
tradeoff question, and the tradeoff around modularity for fetch isn't
that compelling.

-Peff
