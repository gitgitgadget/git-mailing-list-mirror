Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A62A1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 14:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbdBAOxG (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 09:53:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:47817 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdBAOxE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 09:53:04 -0500
Received: (qmail 27506 invoked by uid 109); 1 Feb 2017 14:53:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 14:53:03 +0000
Received: (qmail 11224 invoked by uid 111); 1 Feb 2017 14:53:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 09:53:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2017 15:53:00 +0100
Date:   Wed, 1 Feb 2017 15:53:00 +0100
From:   Jeff King <peff@peff.net>
To:     Erik van Zijst <erik.van.zijst@gmail.com>
Cc:     git@vger.kernel.org, ssaasen@atlassian.com,
        mheemskerk@atlassian.com
Subject: Re: [ANNOUNCE] Git Merge Contributor Summit topic planning
Message-ID: <20170201145300.4pn3faodhdb72jly@sigill.intra.peff.net>
References: <20170131004804.p5sule4rh2xrgtwe@sigill.intra.peff.net>
 <1485941532-47993-1-git-send-email-erik.van.zijst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485941532-47993-1-git-send-email-erik.van.zijst@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2017 at 10:32:12AM +0100, Erik van Zijst wrote:

> Clients performing a full clone get redirected to a CDN where they seed
> their new local repo from a pre-built bundle file, and then pull/fetch
> any remaining changes. Mercurial has had native, built-in support for
> this for a while now.
> 
> I imagine other large code hosts could benefit from this as well and
> I'd love to gauge the group's interest for this. Could this make sense
> for Git? Would it have a chance of landing?
> 
> Our spike implements it as an optional capability during ref
> advertisement. What are your thoughts on this?

I think this is definitely an interesting topic to discuss tomorrow.

Here are a few observations from my past thinking on the issue. I
haven't read the proposal from earlier this week yet, so some of them
may be obsolete.

Seeding from a bundle CDN generally solves two problems: getting the
bulk of the data from someplace with higher bandwidth (the CDN), and
getting the bulk of the data over a protocol that can be resumed (the
bundle).

But we don't necessarily have to solve both problems simultaneously.
And you might not want to. Storing a separate bundle on another server
is complicated to configure, and doubles the amount of disk space you
need (just half of it is on the CDN). Using a bundle means you can't
seed from a non-bundle source.

So for any solution, I'd want to consider how you can put together the
pieces. Can you seed from a non-bundle? Can you seed from yourself and
just get resumability? If so, how hard is it to serve a pseudo-bundle
based on the packfiles you have on disk (i.e., getting resumability
at least in the common cases without paying the disk cost). I.e., saving
enough data that you could reconstruct the bundle byte-for-byte when you
need to.

If you _can_ do that latter part, and you take "I only care about
resumability" to the simplest extreme, you'd probably end up with a
protocol more like:

  Client: I need a packfile with this want/have
  Server: OK, here it is; its opaque id is XYZ.
  ... connection interrupted ...
  Client: It's me again. I have up to byte N of pack XYZ
  Server: OK, resuming
          [or: I don't have XYZ anymore; start from scratch]

Then generating XYZ and generating that bundle are basically the same
task.

All just food for thought. I look forward to digging into it more on the
list and in the in-person discussion.

-Peff
