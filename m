Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B8DC433E1
	for <git@archiver.kernel.org>; Fri, 22 May 2020 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC4B20727
	for <git@archiver.kernel.org>; Fri, 22 May 2020 16:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgEVQbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 12:31:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:54532 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgEVQbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 12:31:24 -0400
Received: (qmail 21578 invoked by uid 109); 22 May 2020 16:31:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 May 2020 16:31:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7533 invoked by uid 111); 22 May 2020 16:31:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 May 2020 12:31:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 May 2020 12:31:23 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 9/9] fixup! remote-curl: error on incomplete packet
Message-ID: <20200522163123.GA2147475@coredump.intra.peff.net>
References: <cover.1589885479.git.liu.denton@gmail.com>
 <4364b38bd027c219d41282bad3f8476daec936f9.1590154401.git.liu.denton@gmail.com>
 <20200522155410.GA2146293@coredump.intra.peff.net>
 <20200522160552.GA677085@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522160552.GA677085@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 22, 2020 at 12:05:52PM -0400, Denton Liu wrote:

> Hi Peff,
> 
> On Fri, May 22, 2020 at 11:54:10AM -0400, Jeff King wrote:
> > > -printf "%s\n" "00"
> > > +printf "%s" "00"
> > 
> > This one is a behavior improvement: we were probably hitting "oops,
> > newline isn't a valid line-length character" before, and now we're
> > really hitting the truncated packet.
> 
> The test currently actually greps for the "incomplete length" error
> message and it passes so the behaviour remains the same. We just got
> lucky that we send "00" instead of "000" beacuse "000\n" would've
> otherwise given us a full length header.

Ah, OK. I was surprised it didn't hit your new code in check_pktline()
that complains about non-hex chars. But the reason is that we don't
check digit-by-digit as we read them. We wait until we have 4 chars, and
then we feed the whole thing to packet_length(). But since we only
receive 3, the state machine doesn't move to that step. So that makes
sense.

> > I don't know if it's worth adding an extra test with a bogus
> > line-length. I'm OK with with it either way.
> 
> I think I'll leave this unless anyone really wants this to be tested.

Sounds good.

-Peff
