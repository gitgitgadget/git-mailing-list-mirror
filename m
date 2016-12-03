Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07321FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 05:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbcLCFRX (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 00:17:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:51070 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752110AbcLCFRX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 00:17:23 -0500
Received: (qmail 5202 invoked by uid 109); 3 Dec 2016 05:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 05:17:23 +0000
Received: (qmail 19667 invoked by uid 111); 3 Dec 2016 05:17:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 00:17:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Dec 2016 00:17:21 -0500
Date:   Sat, 3 Dec 2016 00:17:21 -0500
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] shallow.c: avoid theoretical pointer wrap-around
Message-ID: <20161203051720.z5elgoaapulqxlw5@sigill.intra.peff.net>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <1480710664-26290-2-git-send-email-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480710664-26290-2-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 09:31:02PM +0100, Rasmus Villemoes wrote:

> The expression info->free+size is technically undefined behaviour in
> exactly the case we want to test for. Moreover, the compiler is likely
> to translate the expression to
> 
>   (unsigned long)info->free + size > (unsigned long)info->end
> 
> where there's at least a theoretical chance that the LHS could wrap
> around 0, giving a false negative.
> 
> This might as well be written using pointer subtraction avoiding these
> issues.
> [...]
>
> -	if (!info->slab_count || info->free + size > info->end) {
> +	if (!info->slab_count || size > info->end - info->free) {

Yeah, I agree the correct way to write this is to compare the sizes
directly. That is how overflow checks _must_ be written. This one is
less likely to overflow, but even computing the value more than one past
the end of the array is technically undefined.

-Peff
