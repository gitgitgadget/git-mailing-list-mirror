Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E8E20193
	for <e@80x24.org>; Wed,  2 Nov 2016 22:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757170AbcKBWEk (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 18:04:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:37704 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756639AbcKBWEk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 18:04:40 -0400
Received: (qmail 22143 invoked by uid 109); 2 Nov 2016 22:04:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 22:04:39 +0000
Received: (qmail 6967 invoked by uid 111); 2 Nov 2016 22:05:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 18:05:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 18:04:37 -0400
Date:   Wed, 2 Nov 2016 18:04:37 -0400
From:   Jeff King <peff@peff.net>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: send-email garbled header with trailing doublequote in email
Message-ID: <20161102220437.5ewzezxs2nasyouv@sigill.intra.peff.net>
References: <20161102202709.GI4611@redhat.com>
 <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
 <20161102213805.GJ4611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102213805.GJ4611@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 10:38:05PM +0100, Andrea Arcangeli wrote:

> > But in either case, in my test, the actual email address is still
> > extracted correctly and fed to the MTA, so the mail is delivered.
> 
> The email is delivered to the right email for me too, but to see the
> problem you need to check the email itself, and look how the To: field
> looks in the actual email in your mail client or web interface.
> 
> Don't you see whatever@yourhostname without spaces and @yourhostname
> instead of the email domain?

Nope, it looks exactly as --dry-run reports it.

To see exactly what is being sent out, try:

-- >8 --

cat >/tmp/foo <<\EOF
#!/bin/sh
echo "args: $*"
sed 's/^/stdin: /'
EOF

chmod +x /tmp/foo

git send-email --smtp-server=/tmp/foo --to=whatever

-- 8< --

Mine shows the same header as --dry-run. Which makes sense, because the
code is literally just dumping the $header variable, which is the same
thing that gets sent to the sendmail binary (or the SMTP server if that
is in use).

So my guess would be that either an MTA in the routing path is garbling
it (or possibly mailing list software). or maybe even the eventual MUA,
though it sounds like you checked the raw bytes.

> If you still can't reproduce, maybe it's a different perl
> Mail::Address, I'm using dev-perl/MailTools-2.140.0

Mine is 2.13, which I would imagine is comparable.

> If --dry-run complained and failed instead of passing and then sending
> an email with garbled To/Cc list, it'd be more than enough. Either
> that or it should generate a mail header that matches the output of
> --dry-run so the review of --dry-run becomes meaningful again.

OK. I think we get that first part right. The problem is that the
garbling is such that somebody in the middle is unhappy with it (which
makes sense; it's syntactically bogus). So the tool is there to see the
problem in --dry-run, but of course it's rather subtle.

In theory we should be able to detect and complain about bogus syntax
like this, but right now we don't re-parse the addresses at all. We rely
on Mail::Address to produce valid output, and it doesn't seem to be
doing so here.

-Peff
