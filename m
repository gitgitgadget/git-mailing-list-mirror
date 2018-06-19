Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6837D1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030237AbeFSQpn (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:45:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:48528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966938AbeFSQpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:45:43 -0400
Received: (qmail 31899 invoked by uid 109); 19 Jun 2018 16:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Jun 2018 16:45:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14432 invoked by uid 111); 19 Jun 2018 16:46:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Jun 2018 12:46:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2018 12:45:41 -0400
Date:   Tue, 19 Jun 2018 12:45:41 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Halstrick <christian.halstrick@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
Message-ID: <20180619164540.GA22697@sigill.intra.peff.net>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
 <20180614101342.GO38834@genre.crustytoothpaste.net>
 <20180614151507.GA6933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806171335480.77@tvgsbejvaqbjf.bet>
 <20180618041713.GA31125@sigill.intra.peff.net>
 <xmqqo9g8xf9k.fsf@gitster-ct.c.googlers.com>
 <20180618212614.GA2504@sigill.intra.peff.net>
 <CAENte7hzJw5VW2JFLV1Pj5v4u52=xL-dvhcfRACYa2eUvQnAVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAENte7hzJw5VW2JFLV1Pj5v4u52=xL-dvhcfRACYa2eUvQnAVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 02:36:50PM +0200, Christian Halstrick wrote:

> What is not clear to me is how we can make use of the servers initial
> response in order control which credential helper to call and how to
> transport the credentials.

I don't think we'd ever decide _which_ credential helper to call; we
always call all of them, in order, and then quit when we have sufficient
credentials to continue.

But potentially we could feed some extra information to each helper and
let it decide what to do.

> Imagine we try to clone over http. The initial request sent to the
> server may not contain a "Authorization: ..." header and the server
> responds with Unauthorized.  But the server response contains hints
> like a "WWW-Authenticate: Basic realm=..." line or a
> "WWW-Authenticate: Bearer realm=..." line which helps choosing the
> authentication scheme used next. Maybe the server even responds with
> both lines telling I would accept BASIC or BEARER.

So for this example, yeah, I think it might make sense to feed the
credential helper extra context like "authtype=basic" or similar. Most
helpers would ignore it, but smart ones could make a decision based on
it.

And then the response could contain a similar "authtype" key in the
response.

> I can imagine that we want libcurl to deal with that decisions. But
> even then. How do we make sure the our credential helpers can act
> return either user/password or bearer tokens based on the server
> response? If credential helper would have access to the servers
> response (or only relevant parts of it?) it could decide whether to
> feel responsible for that server or not and what data to return.
> 
> And if credential helper could optionally give metadata about the kind
> credential they offer (e.g. "I return user/password" or "I return a
> bearer token") then core code could know where to transport this data.
> E.g. in a "Authorization: Basic ..." or a "Authorization: Bearer ..."
> field.

Yep, I think that all matches my general line of thinking. It would help
if we had some concrete cases. In particular, it's unclear to me if:

  1. A config option to say "treat password as a bearer token" would be
     enough.

  2. We'd need the credential helper to say "I'm giving you a token"
     versus "I'm giving you a password".

  3. We might need _both_ (1) and (2), because some servers would be
     fine with (1) and it lets them Just Work with credential helpers
     that are unaware of bearer tokens in the first place.

I suspect the answer is (3), but I'd probably delay working on (2) until
I saw a situation that really needed it. :)

But I think we're on the same page, so if you're looking into or
developing more concrete cases, those answers should become more clear.

-Peff
