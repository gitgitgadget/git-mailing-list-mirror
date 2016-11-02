Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8168E20193
	for <e@80x24.org>; Wed,  2 Nov 2016 21:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757497AbcKBVLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 17:11:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:37669 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757360AbcKBVLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 17:11:21 -0400
Received: (qmail 18978 invoked by uid 109); 2 Nov 2016 21:11:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 21:11:20 +0000
Received: (qmail 6464 invoked by uid 111); 2 Nov 2016 21:11:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 17:11:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 17:11:18 -0400
Date:   Wed, 2 Nov 2016 17:11:18 -0400
From:   Jeff King <peff@peff.net>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: send-email garbled header with trailing doublequote in email
Message-ID: <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
References: <20161102202709.GI4611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102202709.GI4611@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 09:27:09PM +0100, Andrea Arcangeli wrote:

> send-email gets confused with one trailing " at the end of the
> email. Details and how to reproduce below, it breaks also with
> upstream git version 2.10.2.dirty.

I'm not quite sure what happened, and what you wanted to happen. In your
example:

> FYI: apparently I hit a git bug in this submit... reproducible with
> the below command:
> 
> git send-email -1 --to '"what ever" <--your--@--email--.com>"'

The "to" address is slightly bogus here because of the extra
double-quote. That gets turned into a slightly bogus rfc2822 header:

> *snip*
> Dry-OK. Log says:
> To: "what ever" " <--your--@--email--.com>

Which is funny, but matches what we do with other addresses that are
invalid according to the rfc. E.g., there was a discussion recently on:

  Stable <stable@vger.kernel.org> [4.8+]

which has historically been converted to:

  "Stable [4.8+]" <stable@vger.kernel.org>

In fact, it is not even git that does this, but rather what
Mail::Address happens to output (though git has fallback routines if
that module isn't available that do the same thing).

But in either case, in my test, the actual email address is still
extracted correctly and fed to the MTA, so the mail is delivered.

So I'm not sure what you wanted to happen that didn't. Did you want
--dry-run to complain about the bogus address? Did the message not get
delivered for you? Something else?

-Peff
