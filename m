Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C733C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B046222210
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbgJOQOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:14:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:32864 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389477AbgJOQOs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:14:48 -0400
Received: (qmail 23080 invoked by uid 109); 15 Oct 2020 16:14:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 16:14:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29835 invoked by uid 111); 15 Oct 2020 16:14:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 12:14:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 12:14:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sean McAllister <smcallis@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
Message-ID: <20201015161447.GB1104947@coredump.intra.peff.net>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-3-smcallis@google.com>
 <20201013211453.GB3678071@coredump.intra.peff.net>
 <CAM4o00eCKP1+f=xBw4LJfNqrstEnutAe9StxknW9qLMtPBdhKQ@mail.gmail.com>
 <CAM4o00fO++JMNdES03JKRyxmZtiLjkrJ2nux0-TZYBdH2+0ijA@mail.gmail.com>
 <20201014193456.GA365553@coredump.intra.peff.net>
 <CAM4o00eZjr2apH6WO-sTvuOfR-cuiSh1yhh3j=14ZFstXDz7bA@mail.gmail.com>
 <20201015000410.GB328643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015000410.GB328643@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 05:04:10PM -0700, Jonathan Nieder wrote:

> > Some large projects (Android, Chrome), use git with a distributed
> > backend to feed changes to automated builders and such.  We can
> > actually get into a case where DDOS mitigation kicks in and 429s start
> > going out.  In that case I think it's pretty important that we honor
> > the Retry-After field so we're good citizens and whoever's running the
> > backend service has some options for traffic shaping to manage load.
> > In general you're right it doesn't matter _that_ much but in at least
> > the specific case I have in my head, it does.
> 
> I see.  With Peff's proposal, the backend service could still set
> Retry-After, and *modern* machines with new enough libcurl would still
> respect it, but older machines[*] would have to use some fallback
> behavior.
> 
> I suppose that fallback behavior could be to not retry at all.  That
> sounds appealing to me since it would be more maintainable (no custom
> header parsing) and the fallback would be decreasingly relevant over
> time as users upgrade to modern versions of libcurl and git.  What do
> you think?

Yeah, the good-citizen behavior would be to err on the side of not
retrying. And actually, I kind of like that better anyway. The
retryable_code() list has things like 502 in it, which aren't
necessarily temporary errors. If the server didn't give us a hint of
when to retry, perhaps it's not a good idea to do so.

That's slightly orthogonal to the CURLINFO_RETRY_AFTER question. It
would mean an older Git would not retry in this case. But if you're
primarily interested in fixing automated builders overloading your
system, it's probably not that big a deal to make sure they're up to
date (after all, they need the new Git, too ;) ).

If you're hoping to help random developers on various platforms, then
making the feature work with older curl is more compelling. Many people
might upgrade their Git version there, but be stuck with an older system
libcurl.

-Peff
