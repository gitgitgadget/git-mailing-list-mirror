Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 614E420954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdLGV26 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:28:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:51494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750929AbdLGV25 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:28:57 -0500
Received: (qmail 31834 invoked by uid 109); 7 Dec 2017 21:28:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 21:28:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26648 invoked by uid 111); 7 Dec 2017 21:29:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 07 Dec 2017 16:29:18 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Dec 2017 16:28:55 -0500
Date:   Thu, 7 Dec 2017 16:28:55 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: release memory on read error in
 strbuf_read_once()
Message-ID: <20171207212855.GE12850@sigill.intra.peff.net>
References: <6a39662f-8ff2-c314-5348-4189737a6853@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a39662f-8ff2-c314-5348-4189737a6853@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 09:51:26PM +0100, René Scharfe wrote:

> If other strbuf add functions cause the first allocation and
> subsequently encounter an error then they release the memory, restoring
> the pristine state of the strbuf.  That simplifies error handling for
> callers.
> 
> Do the same in strbuf_read_once(), and do it also in case no bytes were
> read -- which may or may not be an error as well, depending on the
> caller.

Makes sense, and the patch is delightfully simple.

For the "0" case nobody should be negatively impacted by dropping the
allocation, as they get a sane 0-length string from the slopbuf (and
anybody who relies on sb->buf being allocated without calling detach or
similar is already doing it wrong).

-Peff
