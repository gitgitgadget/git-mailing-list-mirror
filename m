Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EAAC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB242075D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 19:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG2T3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:29:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:41428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgG2T3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 15:29:16 -0400
Received: (qmail 8510 invoked by uid 109); 29 Jul 2020 19:29:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 19:29:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7530 invoked by uid 111); 29 Jul 2020 19:29:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 15:29:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 15:29:15 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [RFC PATCH] Modify fetch-pack to no longer die on error?
Message-ID: <20200729192915.GA2351724@coredump.intra.peff.net>
References: <20200728200847.GA1019822@coredump.intra.peff.net>
 <20200729185347.653706-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729185347.653706-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 11:53:47AM -0700, Jonathan Tan wrote:

> > This is definitely true sometimes, but I think is sometimes the
> > opposite. When we push things out to a sub-process, then the interface
> > between the two processes has to be well-defined (e.g., writing results
> > to a file with a particular format). And that can make debugging easier,
> > because you can pick up from that intermediate state (munging it in the
> > middle, or even generating it from scratch for testing).
> 
> Well, unless there is some sort of interactivity like in remote helpers
> :-)

Yes, debugging remote helpers is its own special hell. :)

> > That said, I think I could buy the argument that "fetch" works pretty
> > well as a basic building block for users. It's pretty rare to actually
> > use fetch-pack as a distinct operation. This is all a monolith vs module
> > tradeoff question, and the tradeoff around modularity for fetch isn't
> > that compelling.
> 
> If we are going the sub-process route, I was planning to use "fetch" as
> the sub-process, actually, not "fetch-pack" - among other things,
> "fetch" allows us to specify a fetch negotiator. So it seems like you
> are saying that if we had to use "fetch-pack", you have no problem with
> libifying it and calling it in the same process, but if we can use
> "fetch", we should use it as a sub-process?

No, I just meant that in general fetching is a monolithic operation from
the users perspective, and we don't often need to break it down further.
So if you have to build more options into "fetch" (that _could_ have
been broken out into separate sub-commands) I don't think anybody will
be sad.

I guess that is kind of orthogonal to your original problem, though,
which is "should fetch be triggered in-process by other processes". So
one could still make the argument that whatever features are needed by
that calling code (e.g., "use a different negotiation scheme") might
also be needed by other (script) callers of git-fetch, so there may be
some benefit to users in making the cross-process interface more rich
(of course in the case of negotiation schemes, it is not "make it more
rich now" but "earlier efforts to make it rich are now paying off").

-Peff
