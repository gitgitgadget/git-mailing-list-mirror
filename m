Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701511FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 16:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935606AbcLUQjG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 11:39:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:59358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934822AbcLUQjF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 11:39:05 -0500
Received: (qmail 7626 invoked by uid 109); 21 Dec 2016 16:12:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 16:12:23 +0000
Received: (qmail 12689 invoked by uid 111); 21 Dec 2016 16:13:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 11:13:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Dec 2016 11:12:20 -0500
Date:   Wed, 21 Dec 2016 11:12:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] string-list: make compare function compatible with
 qsort(3)
Message-ID: <20161221161220.x3qkcwmuangcdc2l@sigill.intra.peff.net>
References: <c7bac0b7-c555-162f-7880-0355831cee48@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7bac0b7-c555-162f-7880-0355831cee48@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2016 at 10:36:41AM +0100, René Scharfe wrote:

> One shortcoming is that the comparison function is restricted to working
> with the string members of items; util is inaccessible to it.  Another
> one is that the value of cmp is passed in a global variable to
> cmp_items(), making string_list_sort() non-reentrant.

I think this approach is OK for string_list, but it doesn't help the
general case that wants qsort_s() to actually access global data. I
don't know how common that is in our codebase, though.

So I'm fine with it, but I think we might eventually need to revisit the
qsort_s() thing anyway.

> Remove the intermediate layer, i.e. cmp_items(), make the comparison
> functions compatible with qsort(3) and pass them pointers to full items.
> This allows comparisons to also take the util member into account, and
> avoids the need to pass the real comparison function to an intermediate
> function, removing the need for a global function.

I'm not sure if access to the util field is really of any value, after
looking at it in:

  http://public-inbox.org/git/20161125171546.fa3zpapbjngjcl26@sigill.intra.peff.net/

Though note that if we do take this patch, there are probably one or two
spots that could switch from QSORT() to string_list_sort().

-Peff
