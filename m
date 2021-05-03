Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E7EC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB663611CB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhECO4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:56:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:43162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhECO4F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:56:05 -0400
Received: (qmail 6065 invoked by uid 109); 3 May 2021 14:55:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 14:55:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4347 invoked by uid 111); 3 May 2021 14:55:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 10:55:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 10:55:09 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Yiyuan guo <yguoaz@gmail.com>
Subject: Re: [PATCH 3/5] pack-objects: clamp negative window size to 0
Message-ID: <YJAOzTIXkO2lhxSs@coredump.intra.peff.net>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
 <YI1fubjvQQlrPz9D@coredump.intra.peff.net>
 <3d77d70b-2cc5-4ca9-8753-fa9af5111842@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d77d70b-2cc5-4ca9-8753-fa9af5111842@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 08:10:24AM -0400, Derrick Stolee wrote:

> On 5/1/2021 10:03 AM, Jeff King wrote:
> > A negative window size makes no sense, and the code in find_deltas() is
> > not prepared to handle it. If you pass "-1", for example, we end up
> > generate a 0-length array of "struct unpacked", but our loop assumes it
> > has at least one entry in it (and we end up reading garbage memory).
> > 
> > We could complain to the user about this, but it's more forgiving to
> > just clamp it to 0, which means "do not find any deltas at all". The
> > 0-case is already tested earlier in the script, so we'll make sure this
> > does the same thing.
> 
> This seems like a reasonable approach. It takes existing "undefined"
> behavior and turns it into well-understood, "defined" behavior.

I was on the fence on doing that, or just:

  if (window < 0)
	die("sorry dude, negative windows are nonsense");

So if anybody has a strong preference, I could be easily persuaded. Part
of what led me to being forgiving was that we similarly clamp too-large
depth values (with a warning; I didn't think it was really necessary
here, though).

-Peff
