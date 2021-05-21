Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2694FC433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01154613CA
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbhEUJo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:44:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233368AbhEUJop (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 05:44:45 -0400
Received: (qmail 2980 invoked by uid 109); 21 May 2021 09:43:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 09:43:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7928 invoked by uid 111); 21 May 2021 09:43:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 05:43:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 05:43:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
Message-ID: <YKeAtj7wwW0Qskm+@coredump.intra.peff.net>
References: <YKWggLGDhTOY+lcy@google.com>
 <YKZj/s/9dp4Oo7aB@coredump.intra.peff.net>
 <YKaguiSjewjpvOj5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKaguiSjewjpvOj5@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 10:47:38AM -0700, Jonathan Nieder wrote:

> >                 And that gets very daunting to think about annotating
> > and communicating about each such case (we don't even pass that level of
> > detailed information inside the program in a machine-readable way;
> > scraping stderr is the best way to figure this stuff out now).
> 
> This feels like good news to me: it sounds like if we add
> application-specific codes like MISSING_OBJECT to Git, then it would
> be useful to both of us.

Perhaps. I think the context matters between "missing an object from the
command line" and "missing an object I expected to find while
traversing". And I'm not sure all spots which look up an object will
know that context.

In some sense that's "just" a programming problem; surfacing the errors
to the right spot that can decide how to exit. But I worry a bit that
it's fighting uphill against the current code structure. There's
probably going to be a period where MISSING_OBJECT versus UNKNOWN is
wildly inaccurate, and a long tail of cases to fix.

Erring to say "UNKNOWN" is probably OK for most callers (they are happy
to learn of a specific error and act on it appropriately, but if Git
can't tell it to them, they have a generic path). But erring in the
other direction might be bad (you fail to realize a repo is corrupt, and
instead attribute it to caller error).

So again, I return "I dunno". Something of this magnitude probably has
to be done incrementally and over time. But I'd be loathe to trust it
and convert existing callers use it for a while. And that creates a
chicken-and-egg problem for finding the places which need improvement.

-Peff
