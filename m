Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF171FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 13:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbdCMNvB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 09:51:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:43132 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752851AbdCMNu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 09:50:57 -0400
Received: (qmail 9118 invoked by uid 109); 13 Mar 2017 13:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 13:50:55 +0000
Received: (qmail 18193 invoked by uid 111); 13 Mar 2017 13:51:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 09:51:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 09:50:53 -0400
Date:   Mon, 13 Mar 2017 09:50:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-walker: fix buffer underflow processing remote
 alternates
Message-ID: <20170313135053.3pi56dfdlcva66ml@sigill.intra.peff.net>
References: <20170312123853.55ehe2jurozb6zad@sigill.intra.peff.net>
 <xmqqfuihu382.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuihu382.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2017 at 10:59:09PM -0700, Junio C Hamano wrote:

> > Let's fix this by using strbuf_strip_suffix() to drop the
> > characters we want. As a bonus this lets us handle names
> > that do not end in "objects" (all git repos do, but there is
> > nothing to say that an alternate object store needs to be a
> > git repo).
> 
> Hmph.
> 
> Isn't the reason why the function wants to strip "objects" at the
> end because it then expects to be able to tack strings like
> "objects/info/packs", etc. after the result of stripping, i.e.
> $URL/../foo.git/, and get usable URLs to download other things?

Good point. I think that behavior is a misfeature in the first place. It
should be leaving the path as-is and tacking "info/packs", etc.

But without fixing that, yeah, there is not much value in the "maybe
strip" behavior (unless you happen to provide the incorrect path that
does not include "objects" in the first place, but then it would not
work as a _local_ alternate).

> I think it is very sensible to use strip_suffix() to notice that the
> alternate does not end with "/objects", but I am not sure if it is a
> good idea to proceed without stripping when it does not end with
> "/objects".  Shouldn't we be ignoring (with warning, possibly) such
> a remote alternate?

Yeah, probably warn and ignore is the best bet. I'll re-work the patch.

-Peff
