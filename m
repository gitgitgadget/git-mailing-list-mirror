Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1556C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 05:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04F02253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 05:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfLMFm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:42:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:45628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725799AbfLMFm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 00:42:28 -0500
Received: (qmail 27754 invoked by uid 109); 13 Dec 2019 05:42:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Dec 2019 05:42:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21402 invoked by uid 111); 13 Dec 2019 05:46:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 00:46:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 00:42:27 -0500
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Gmail munges dates?
Message-ID: <20191213054227.GA76445@coredump.intra.peff.net>
References: <20191213015753.GA14249@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213015753.GA14249@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 12, 2019 at 05:57:53PM -0800, Denton Liu wrote:

> It seems like Gmail is munging the dates on patches sent. Before today,
> I've been sending patches out with mutt but I decided to switch to
> git-send-email today since I was forwarding a patch that wasn't mine and
> I wanted to preserve the date as part of the authorship information.
> 
> Unfortunately, it seems like mutt wasn't the culprit, it was Gmail
> that's been munging the dates. For example, in this patch[1], the date
> shows as
> 
> 	Date: Thu, 12 Dec 2019 16:44:50 -0800
> 
> even though locally, the output of the format-patch shows as
> 
> 	Date: Mon, 9 Dec 2019 19:25:34 +0100

Both mutt and git-send-email will munge the headers. And they really
need to, since sending a message whose Date header is several days old
(or much more, in some cases) is likely to trigger spam filters.

> So two questions related to this:
> 
> 1. Is this something that we care about or is it okay to have fudged
> dates? (I know all of my patches in each patchset only differ by a few
> seconds and it seems like no one has noticed or cared so far)

It's OK to have fudged dates. In fact, I think you could make an
argument that it's preferable for our development flow. It treats the
patch hitting the list as the moment of authorship. When reading "git
log" later, that would put its author date near its peers. Of course in
a non-linear history you probably care more about "when did this hit
master", but the author timestamps are a rough approximation for "era".
And of course the committer information could tell you more there, but
we don't tend to show it by default.

So I think there are philosophical arguments to be made, but for
practical purposes, I think everybody is reasonably happy with the
current mechanisms.

There are cases when you might want to preserve old date information
(say, re-sending a patch that was several years old). Usually in that
case I'd leave the author date as current but make a note about the
patch's history if it's relevant.


> 2. Do we want to introduce a --in-body-date option or something to
> format-patch which would include an in-body Date:, similar to the
> in-body From:? (Also, while we're at it, maybe we could include an
> --in-body-from to force that to happen since that's been a feature that
> was requested in the past[2])

I doubt I'd use it myself, but I wouldn't be opposed to an in-body-date
option. You'd perhaps want to define some heuristics to avoid
uninteresting noise. If your patch is from 10 minutes ago, and you are
just now sending it in, adding the extra date header is mostly just
clutter. So perhaps you'd want it to kick in when the date is more than
N time units or something.

-Peff
