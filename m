Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997B12018E
	for <e@80x24.org>; Mon,  8 Aug 2016 15:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbcHHPC6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 11:02:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:51174 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752116AbcHHPC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 11:02:58 -0400
Received: (qmail 9975 invoked by uid 109); 8 Aug 2016 15:02:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 15:02:57 +0000
Received: (qmail 5443 invoked by uid 111); 8 Aug 2016 15:02:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 11:02:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 11:02:55 -0400
Date:	Mon, 8 Aug 2016 11:02:55 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
Message-ID: <20160808150255.2otm3z5fluimpiqw@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-12-larsxschneider@gmail.com>
 <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
 <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com>
 <20160805222710.chefh5kiktyzketh@sigill.intra.peff.net>
 <87D4BF17-67BB-4AFA-9B27-40DBB44C0456@gmail.com>
 <20160806121421.bs7n4lhed7phdshb@sigill.intra.peff.net>
 <A07BE78B-5A5D-41F1-A51B-5C71F3E86CCF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A07BE78B-5A5D-41F1-A51B-5C71F3E86CCF@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 06, 2016 at 08:19:28PM +0200, Lars Schneider wrote:

> > I dunno. It's not _that_ big a deal to code around. I was just surprised
> > not to see an up-front status when responding to a request. It seems
> > like the normal thing in just about every protocol I've ever used.
> 
> Alright. The fact that it "surprised" you is a bad sign. 
> How about this:
> 
> Happy answer:
> ------------------------
> packet:          git< status=accept\n
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> packet:          git< status=success\n
> ------------------------

I notice that the status pkt-lines are by themselves. I had assumed we'd
be sending other data, too (presumably before, but I guess possibly
after, too). Something like:

  git< status=accept
  git< 0000
  git< SMUDGED_CONTENT
  git< 0000
  git< status=success
  git< 0000

I don't have any particular meta-information in mind, but I thought
stuff like the tentative "size" field would be here.

I had imagined it at the front, but I guess it could go in either place.
I wonder if keys at the end could simply replace ones from the beginning
(so if you say "foo=bar" at the front, that is tentative, but if you
then say "foo=revised" at the end, that takes precedence).

And so the happy answer is really:

  git< status=success
  git< 0000
  git< SMUDGED_CONTENT
  git< 0000
  git< 0000  # empty list!

i.e., no second status. The original "success" still holds.

And then:

> Happy answer with no content:
> ------------------------
> packet:          git< status=success\n
> ------------------------

This can just be spelled:

  git< status=success
  git< 0000
  git< 0000   # empty content!
  git< 0000   # empty list!

> Rejected content:
> ------------------------
> packet:          git< status=reject\n
> ------------------------

I'd assume that an error status would end the output for that file
immediately, no empty lists necessary (so what you have here). I'd
probably just call this "error" (see below).

> Error during content response:
> ------------------------
> packet:          git< status=accept\n
> packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
> packet:          git< 0000
> packet:          git< status=error\n
> ------------------------

And then this would be:

  git< status=success
  git< 0000
  git< HALF_OF_CONTENT
  git< 0000
  git< status=error
  git< 0000

And then you have only two status codes: success and error. Which keeps
things simple.

There's one other case, which is when the filter dies halfway through
the conversation, like:

  git< status=success
  git< 0000
  git< CONTENT
  git< 0000
  ... EOF on pipe ...

Any time git does not get the conversation all the way to the final
flush after the trailers, it should be considered an error (because we
can never know if the filter was about to say "whoops, status=error").

-Peff
