Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54FB1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 21:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936494AbeFRV0R (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 17:26:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:47866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935854AbeFRV0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 17:26:17 -0400
Received: (qmail 12299 invoked by uid 109); 18 Jun 2018 21:26:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Jun 2018 21:26:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8391 invoked by uid 111); 18 Jun 2018 21:26:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Jun 2018 17:26:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jun 2018 17:26:14 -0400
Date:   Mon, 18 Jun 2018 17:26:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Halstrick <christian.halstrick@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
Message-ID: <20180618212614.GA2504@sigill.intra.peff.net>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
 <20180614101342.GO38834@genre.crustytoothpaste.net>
 <20180614151507.GA6933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806171335480.77@tvgsbejvaqbjf.bet>
 <20180618041713.GA31125@sigill.intra.peff.net>
 <xmqqo9g8xf9k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9g8xf9k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 08:53:27AM -0700, Junio C Hamano wrote:

> > Yeah, that will work for some cases. A few places it might not:
> >
> >  - some people may want to provide this only in response to a 401
> >
> >  - some tokens may need to be refreshed, which would require interacting
> >    with a credential helper to do the rest of the oauth conversation
> >
> >  - there's no good way to hide your token in secure storage (versus
> >    sticking it on the command-line or in a config file).
> 
> And all of these three are what you get for free by building on the
> credential helper framework, after extending it a bit so that the
> filled credential structure can tell the http code to show it to the
> other side as a bearer token, not a password or password hash.  The
> helper is asked to supply the auth material only after 401, which
> covers both the first and the second points, and then keeping the
> auth material in-core (e.g. cache--daemon) would be more secure
> which covers the third point.  Am I following you correctly?

Yes, exactly.

Even if the credential protocol itself doesn't learn about this feature,
even a config option for "treat password as token to send via bearer"
would help. The "how" of sending the token isn't secret, just the token
itself. So everything else can just pretend it's a password (it's a
little funny because I think there isn't a matching username, but you
could probably get by with an empty one).

That's all just off the top of my head without digging back into the
code, nor running any experiments, of course. There may be some gotchas. :)

-Peff
