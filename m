Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6283D1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 21:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeDDVHW (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 17:07:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:53714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751749AbeDDVHV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 17:07:21 -0400
Received: (qmail 25552 invoked by uid 109); 4 Apr 2018 21:07:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 21:07:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8230 invoked by uid 111); 4 Apr 2018 21:08:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 17:08:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 17:07:20 -0400
Date:   Wed, 4 Apr 2018 17:07:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michal Nazarewicz <mina86@mina86.com>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: report host and port separately when calling
 git credential
Message-ID: <20180404210719.GB15402@sigill.intra.peff.net>
References: <20180331180514.14628-1-mina86@mina86.com>
 <xmqqk1tpxo0g.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1tpxo0g.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 02, 2018 at 03:05:35PM -0700, Junio C Hamano wrote:

> "git help credential" mentions protocol, host, path, username and
> password (and also url which is a short-hand for setting protocol
> and host), but not "port".  And common sense tells me, when a system
> allows setting host but not port, that it would expect host:port to
> be given when the service is running a non-standard port, so from
> that point of view, I suspect that the current code is working as
> expected.  In fact, credential.h, which defines the API, does not
> have any "port" field, either, so I am not sure how this is expected
> to change anything without touching the back-end that talks over the
> pipe via _credential_run-->credential_write callchain.
> 
> Now, it is a separate matter if it were a better design if the
> credential API had 'host' and 'port' defined as separate keys to the
> authentication information.  Such an alternative design would have
> made certain things harder while some other things easier (e.g. "use
> this credential to the host no matter what port the service runs"
> may be easier to implement if 'host' and 'port' are separate).

I don't recall giving a huge amount of thought to alternate ports when
writing the credential code. But at least the osxkeychain helper does
parse "host:port" from the host field and feed it to the appropriate
keychain arguments. And I think more oblivious helpers like
credential-cache would just treat the "host" field as an opaque blob,
making the port part of the matching.

I suspect there are some corner cases, though. Reading the osxkeychain
code, I think that asking for "http://example.com:80" and
"http://example.com" would probably not get you to the same key, as we
feed port==0 in the second case. In practice, it's probably not a _huge_
deal to be overly picky, as the worst case is that you get prompted and
store the credential in a second slot (which then works going forward).

So in general I think it's OK for the whole system to err on the side of
being picky about whether two things are "the same" (which in this case
is including the port). It usually works itself out in the long run, and
we would not surprise the user with "example.com:8080 is the same as
example.com:80".

-Peff
