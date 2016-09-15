Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0981FCA9
	for <e@80x24.org>; Thu, 15 Sep 2016 05:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756147AbcIOFPg (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 01:15:36 -0400
Received: from ikke.info ([178.21.113.177]:35852 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbcIOFPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 01:15:35 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 87E004400B9; Thu, 15 Sep 2016 07:15:33 +0200 (CEST)
Date:   Thu, 15 Sep 2016 07:15:33 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Message-ID: <20160915051533.GC26893@ikke.info>
References: <20160913234612.22806-1-me@ikke.info>
 <20160913234612.22806-2-me@ikke.info>
 <xmqqr38ns5wi.fsf@gitster.mtv.corp.google.com>
 <20160914050919.qhv2gxzjyj5ydpub@sigill.intra.peff.net>
 <xmqqmvjbrpp4.fsf@gitster.mtv.corp.google.com>
 <20160914160308.GB26893@ikke.info>
 <xmqqoa3qqsw9.fsf@gitster.mtv.corp.google.com>
 <20160914191759.5unwaq2eequ4pifr@sigill.intra.peff.net>
 <xmqqfup2qny9.fsf@gitster.mtv.corp.google.com>
 <20160914193819.ua5ubvbf5wz7tvuj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160914193819.ua5ubvbf5wz7tvuj@sigill.intra.peff.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 12:38:20PM -0700, Jeff King wrote:
> On Wed, Sep 14, 2016 at 12:30:06PM -0700, Junio C Hamano wrote:
> 
> > Another small thing I am not sure about is if the \ quoting can hide
> > an embedded newline in the author name.  Would we end up turning
> > 
> > 	From: "Jeff \
> >             King" <peff@peff.net>
> > 
> > or somesuch into
> > 
> > 	Author: Jeff
> >         King
> >         Email: peff@peff.net
> > 
> > ;-)
> 
> Heh, yeah. That is another reason to clean up and sanitize as much as
> possible before stuffing it into another text format that will be
> parsed.

A quoted string cannot contain newlines according to the RFC, so I think
we don't need to care about that.

> 
> > So let's roll the \" -> " into mailinfo.
> > 
> > I am not sure if we also should remove the surrounding "", i.e. we
> > currently do not turn this
> > 
> > 	From: "Jeff King" <peff@peff.net>
> > 
> > into this:
> > 
> > 	Author: Jeff King
> >         Email: peff@peff.net
> > 
> > I think we probably should, and remove the one that does so from the
> > reader.
> 
> I think you have to, or else you cannot tell the difference between
> surrounding quotes that need to be stripped, and ones that were
> backslash-escaped. Like:
> 
>   From: "Jeff King" <peff@peff.net>
>   From: \"Jeff King\" <peff@peff.net>
> 
> which would both become:
> 
>   Author: "Jeff King"
>   Email: peff@peff.net
> 
> though I am not sure the latter one is actually valid; you might need to
> be inside syntactic quotes in order to include backslashed quotes. I
> haven't read rfc2822 carefully recently enough to know.
> 
> Anyway, I think that:
> 
>   From: One "Two \"Three\" Four" Five
> 
> may also be valid. So the quote-stripping in the reader is not just "at
> the outside", but may need to handle interior syntactic quotes, too. So
> it really makes sense for me to clean and sanitize as much as possible
> in one step, and then make the parser of mailinfo as dumb as possible.
> 

Makes sense, the current itteration of my patch already strips exterior
quotes, no matter where they happen.

I will send a patch soon.
