Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447411F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 19:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbdAZTM5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 14:12:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:45510 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752339AbdAZTMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 14:12:52 -0500
Received: (qmail 22507 invoked by uid 109); 26 Jan 2017 19:12:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 19:12:07 +0000
Received: (qmail 26910 invoked by uid 111); 26 Jan 2017 19:12:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 14:12:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 14:12:05 -0500
Date:   Thu, 26 Jan 2017 14:12:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] fsck: lazily load types under --connectivity-only
Message-ID: <20170126191205.iu54sxbjisucsv6t@sigill.intra.peff.net>
References: <20170126041025.hqg3znwew7jxgxxg@sigill.intra.peff.net>
 <20170126041206.5qfv7r7czbwfqvaa@sigill.intra.peff.net>
 <xmqqziid4puz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqziid4puz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 10:51:00AM -0800, Junio C Hamano wrote:

> >   2. It serves as a cross-check that the coercion in (1a) is
> >      correct (i.e., we'll complain about a parent link that
> >      points to a blob). But we get most of this for free
> >      already, because right after coercing, we'll parse any
> >      non-blob objects. So we'd notice then if we expected a
> >      commit and got a blob.
> >
> >      The one exception is when we expect a blob, in which
> >      case we never actually read the object contents.
> >
> >      So this is a slight weakening, but given that the whole
> >      point of --connectivity-only is to sacrifice some data
> >      integrity checks for speed, this seems like an
> >      acceptable tradeoff.
> 
> The only weakening is that a non-blob (or a corrupt blob) object
> that sits where we expect a blob (because the containing tree or the
> tag says so) would not be diagnosed as an error, then?  I think that
> is in line with the spirit of --connectivity-only and is a good
> trade-off.

Correct. The corrupt-blob case we always knew was a tradeoff (that's the
whole point of --connectivity-only). We could add back in the "we expect
a blob, is it really one?" at the moment we traverse to it, but IMHO
it's not interesting enough to even be worth the sha1_object_info()
lookup time.

-Peff
