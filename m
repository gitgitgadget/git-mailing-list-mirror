Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5AF1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 19:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762024AbcINTiY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 15:38:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:43328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755286AbcINTiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 15:38:23 -0400
Received: (qmail 8020 invoked by uid 109); 14 Sep 2016 19:38:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 19:38:23 +0000
Received: (qmail 2744 invoked by uid 111); 14 Sep 2016 19:38:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 15:38:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 12:38:20 -0700
Date:   Wed, 14 Sep 2016 12:38:20 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Message-ID: <20160914193819.ua5ubvbf5wz7tvuj@sigill.intra.peff.net>
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
 <20160913234612.22806-1-me@ikke.info>
 <20160913234612.22806-2-me@ikke.info>
 <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
 <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
 <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
 <20160914160308.GB26893@ikke.info>
 <xmqqoa3qqsw9.fsf@gitster.mtv.corp.google.com>
 <20160914191759.5unwaq2eequ4pifr@sigill.intra.peff.net>
 <xmqqfup2qny9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfup2qny9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 12:30:06PM -0700, Junio C Hamano wrote:

> Another small thing I am not sure about is if the \ quoting can hide
> an embedded newline in the author name.  Would we end up turning
> 
> 	From: "Jeff \
>             King" <peff@peff.net>
> 
> or somesuch into
> 
> 	Author: Jeff
>         King
>         Email: peff@peff.net
> 
> ;-)

Heh, yeah. That is another reason to clean up and sanitize as much as
possible before stuffing it into another text format that will be
parsed.

> So let's roll the \" -> " into mailinfo.
> 
> I am not sure if we also should remove the surrounding "", i.e. we
> currently do not turn this
> 
> 	From: "Jeff King" <peff@peff.net>
> 
> into this:
> 
> 	Author: Jeff King
>         Email: peff@peff.net
> 
> I think we probably should, and remove the one that does so from the
> reader.

I think you have to, or else you cannot tell the difference between
surrounding quotes that need to be stripped, and ones that were
backslash-escaped. Like:

  From: "Jeff King" <peff@peff.net>
  From: \"Jeff King\" <peff@peff.net>

which would both become:

  Author: "Jeff King"
  Email: peff@peff.net

though I am not sure the latter one is actually valid; you might need to
be inside syntactic quotes in order to include backslashed quotes. I
haven't read rfc2822 carefully recently enough to know.

Anyway, I think that:

  From: One "Two \"Three\" Four" Five

may also be valid. So the quote-stripping in the reader is not just "at
the outside", but may need to handle interior syntactic quotes, too. So
it really makes sense for me to clean and sanitize as much as possible
in one step, and then make the parser of mailinfo as dumb as possible.

-Peff
