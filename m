Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C508A1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 06:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfBPGpz (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 01:45:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:46700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727363AbfBPGpz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 01:45:55 -0500
Received: (qmail 32280 invoked by uid 109); 16 Feb 2019 06:45:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 16 Feb 2019 06:45:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4551 invoked by uid 111); 16 Feb 2019 06:46:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 16 Feb 2019 01:46:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2019 01:45:53 -0500
Date:   Sat, 16 Feb 2019 01:45:53 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: 2.21: Change in ref advertisement handling?
Message-ID: <20190216064553.GA27641@sigill.intra.peff.net>
References: <CAGyf7-FC1q1f4F36_hS53sdP3wCxd7fTgbegSj+tPS4idvF+Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-FC1q1f4F36_hS53sdP3wCxd7fTgbegSj+tPS4idvF+Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 06:45:42PM -0800, Bryan Turner wrote:

> In Bitbucket Server's Git test suite, we have some lazy tests that use
> a stub HTTP server with mocked payloads to feed a Git client, to test
> its behavior.
> 
> For some of those tests, we have the server configured to send a
> response body like this for a ref advertisement:
> 76d28b849be7fb3301e4bd14fb28328947b4f5a1<tab>HEAD<newline>
> 76d28b849be7fb3301e4bd14fb28328947b4f5a1<tab>refs/heads/master<newline>
> 
> There are headers we set, like "Content-Type:
> application/x-git-upload-pack-advertisement", but that's the response.
> It's not packeted or anything.
>
> [...]
>
> First let me say, I had no idea these tests of ours existed, and I'm
> surprised that they worked on Git 2.20 and older, given that the
> response isn't in proper pkt-line format.

I believe older versions of Git would have fallen back to dumb-http
here. Do your tests actually follow-up with a real object fetch, or are
they just listing the refs? If the latter, I think it would "work" even
if your server does not otherwise implement dumb-http.

> I'm not looking for anything to change here, let me hasten to add; I'm
> just interested in some clarification. Why did our invalid ref
> advertisement response work in older Git versions? Why has it stopped
> working in 2.21?

This is almost certainly due to my 8ee3e120cd (remote-curl: refactor
smart-http discovery, 2019-02-06), which intentionally tightened a few
corner cases to match the spec. In particular, once you respond with
"application/x-git-upload-pack-advertisement", we fully commit to
smart-http and complain if you further violate the spec, rather than
falling back to dumb-http.

-Peff
