Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94442021E
	for <e@80x24.org>; Thu,  3 Nov 2016 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757470AbcKCOSw (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 10:18:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37996 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755028AbcKCOSv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 10:18:51 -0400
Received: (qmail 24326 invoked by uid 109); 3 Nov 2016 14:18:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 14:18:50 +0000
Received: (qmail 12565 invoked by uid 111); 3 Nov 2016 14:19:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 10:19:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 10:18:48 -0400
Date:   Thu, 3 Nov 2016 10:18:48 -0400
From:   Jeff King <peff@peff.net>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: send-email garbled header with trailing doublequote in email
Message-ID: <20161103141848.42pg6iow24prign5@sigill.intra.peff.net>
References: <20161102202709.GI4611@redhat.com>
 <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
 <20161102213805.GJ4611@redhat.com>
 <20161102220437.5ewzezxs2nasyouv@sigill.intra.peff.net>
 <20161102222901.GK4611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102222901.GK4611@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 11:29:01PM +0100, Andrea Arcangeli wrote:

> So this must be postfix then that out of the blue decided to garble it
> in a strange way while parsing the input... The removal of all
> whitespaces s/what ever/whatever/ especially I've no idea how it
> decided to do so.
> 
> Can you reproduce with postfix as sendmail at least? If you can
> reproduce also see what happens if you add another --to.

Yes, I can easily reproduce without using git at all by installing
postfix in local-delivery mode and running:

sendmail peff@sigill.intra.peff.net <<\EOF
From: Jeff King <peff@peff.net>
To: "what ever" " <peff@sigill.intra.peff.net>
Subject: patch

This is the body
EOF

Many MTAs do this kind of header-rewriting. I don't necessarily agree
with it as a general concept, but the real problem is the syntactically
bogus header. The munging that postfix does makes things worse, but I
can see why it is confused and does what it does (the whole email is
inside a double-quoted portion that is never closed, so it probably
thinks there is no hostname portion at all).

So git is possibly at fault for passing along a bogus address. OTOH, the
user is perhaps at fault for providing the bogus address to git in the
first place. GIGO. :)

I think if any change were to be made, it would be to recognize this
bogosity and either clean it up or abort. That ideally would happen via
Mail::Address so git does not have to add a bunch of ad-hoc "is this
valid rfc822" checks. Reading the manpage for that module, though, it
says:

  [we do not handle all of rfc2822]
  Often requests are made to the maintainers of this code improve this
  situation, but this is not a good idea, where it will break zillions
  of existing applications.  If you wish for a fully RFC2822 compliant
  implementation you may take a look at Mail::Message::Field::Full, part
  of MailBox.

So it's possible that switching to a more robust module would improve
things.

-Peff
