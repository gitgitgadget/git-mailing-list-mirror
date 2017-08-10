Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789DD208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbdHJUgP (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:36:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:35196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752889AbdHJUgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:36:14 -0400
Received: (qmail 27113 invoked by uid 109); 10 Aug 2017 20:36:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 20:36:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9435 invoked by uid 111); 10 Aug 2017 20:36:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 16:36:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 16:36:12 -0400
Date:   Thu, 10 Aug 2017 16:36:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH V2 1/2] Fix delta integer overflows
Message-ID: <20170810203612.lt342yq3gnfadjlp@sigill.intra.peff.net>
References: <1502348462-4992-1-git-send-email-martin@mail.zuhause>
 <xmqqmv772nmc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmv772nmc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 01:07:07PM -0700, Junio C Hamano wrote:

> Perhaps we should teach the receiving end to notice that the varint
> data it reads encodes a size that is too large for it to grok and
> die.  With that, we can safely move forward with whatever size_t
> each platform uses.

Yes, this is very important even for "unsigned long". I'd worry that
malicious input could cause us to wrap to 0, and we'd potentially write
into a too-small buffer[1].

There's some prior art with checking this against bitsizeof() in
unpack_object_header_buffer() but get_delta_hdr_size() does not seem to
have a check.

-Peff

[1] In most cases it's _probably_ not a vulnerability to wrap here,
    because we'd just read less data than we ought to. But it makes me
    nervous nonetheless.
