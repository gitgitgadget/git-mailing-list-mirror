Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A37120899
	for <e@80x24.org>; Wed, 16 Aug 2017 08:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdHPIeg (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 04:34:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:40524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751617AbdHPIee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 04:34:34 -0400
Received: (qmail 20250 invoked by uid 109); 16 Aug 2017 08:34:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 Aug 2017 08:34:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17725 invoked by uid 111); 16 Aug 2017 08:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 Aug 2017 04:34:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Aug 2017 04:34:32 -0400
Date:   Wed, 16 Aug 2017 04:34:32 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
Message-ID: <20170816083432.rgurgckch6phcul3@sigill.intra.peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 04:43:26PM +0200, Nicolas Morey-Chaisemartin wrote:

> I have a few doubt on patch #2:
> - is socketpair working on all git supported system (windows ?)

I'm pretty sure the answer is no, after searching a bit for mingw and
socketpair. The big question is whether we could come up with a suitable
replacement. And that would depend on how libcurl works on Windows, I
think (because it's going to feed whatever we give it to other syscall
wrappers).

> - should socketpair always be used or limited to the curl over tunnel case ?
>   I don't think there is too much different between an unname pipe and a socketpair but I'm not sure either :)

There's not much difference in practice. The obvious one is that
half-duplex shutdowns require shutdown() on a socket and just close() on
the write half of a pipe. I don't know if we do that or not.

I'd be inclined to leave the existing code alone, though, just because
of the risk of regression (and because I don't think the curl and
non-curl versions actually share that much code). But I haven't looked
deeply, so I may be wrong.

> It appears curl do not support the PREAUTH tag.

Too bad. IMHO preauth is the main reason to use a tunnel in the first
place.

-Peff
