Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7E91F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbcHFUQF (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:16:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:36336 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750912AbcHFUQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:16:05 -0400
Received: (qmail 22313 invoked by uid 102); 6 Aug 2016 12:14:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Aug 2016 08:14:24 -0400
Received: (qmail 19496 invoked by uid 111); 6 Aug 2016 12:14:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Aug 2016 08:14:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Aug 2016 08:14:21 -0400
Date:	Sat, 6 Aug 2016 08:14:21 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
Message-ID: <20160806121421.bs7n4lhed7phdshb@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-12-larsxschneider@gmail.com>
 <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
 <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com>
 <20160805222710.chefh5kiktyzketh@sigill.intra.peff.net>
 <87D4BF17-67BB-4AFA-9B27-40DBB44C0456@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87D4BF17-67BB-4AFA-9B27-40DBB44C0456@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 06, 2016 at 01:55:23PM +0200, Lars Schneider wrote:

> > And I expect it makes the lives of the client
> > easier to get a code up front, before it starts taking steps to handle
> > what it _thinks_ is probably a valid response.
> 
> I am not sure I can follow you here. Which actor are you referring to when
> you write "client" -- Git, right? If the response is rejected right away
> then Git just needs to read a single flush. If the response experiences
> an error only later, then the filter wouldn't know about the error when
> it starts sending. Therefore I don't see how an error code up front could
> make it easier for Git.

Yes, I mean git (I see it as the "client" side of the connection in that
it is making requests of the filter, which will then provide responses).

What I mean is that the git code could look something like:

  status == send_filter_request();
  if (status == OK) {
	prepare_storage();
	read_response_into_storage();
  } else {
	complain();
  }

But if there's no status up front, then you probably have:

  send_filter_request();
  prepare_storage();
  status = read_response_into_storage();
  if (status != OK) {
	rollback_storage();
	complain();
  }

In the first case, we could easily avoid preparing the storage if our
request wasn't going to be filled, whereas in the second we have to do
it unconditionally. That's not a big deal if preparing the storage is
initializing a strbuf. It's more so if you're opening a temporary object
file to stream into.

You _do_ still have to deal with rollback in the first one (for the case
that the stream ends prematurely for whatever reason). So it's really a
question of where and how often we expect the failures to come, and
whether it is worth git knowing up front that the request is not going
to be fulfilled.

I dunno. It's not _that_ big a deal to code around. I was just surprised
not to see an up-front status when responding to a request. It seems
like the normal thing in just about every protocol I've ever used.

-Peff
