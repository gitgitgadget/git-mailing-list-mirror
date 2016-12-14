Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508211FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 20:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbcLNUrr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 15:47:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:56669 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752910AbcLNUrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 15:47:46 -0500
Received: (qmail 21533 invoked by uid 109); 14 Dec 2016 20:41:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 20:41:05 +0000
Received: (qmail 28855 invoked by uid 111); 14 Dec 2016 20:41:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 15:41:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 15:41:02 -0500
Date:   Wed, 14 Dec 2016 15:41:02 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 5/5] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161214204102.hwjb3i4aaxf3oigq@sigill.intra.peff.net>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-6-git-send-email-bmwill@google.com>
 <20161214164050.uxk434kzhw6au4c2@sigill.intra.peff.net>
 <20161214201323.GC20063@google.com>
 <20161214203752.GD20063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214203752.GD20063@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 12:37:52PM -0800, Brandon Williams wrote:

> Naively looking at the code (and your longer suggestion), is there a
> reason why we couldn't simply have http-walker set CURLOPT_PROTOCOLS
> with get_curl_allowed_protocols(0) in the fetch_alternates() function?
> That way we just override the CURLOPT_PROTOCOLS value when alternates
> are involved.

No, because we may have many curl handles (especially for the
http-walker, which wants to fetch several objects simultaneously), and
they get recycled as needed for many requests.

So setting a restriction there on slot->curl will only cover the one
handle, and miss other ones which may be used later (and likewise, that
one handle with the restriction may get recycled and used for a
non-alternate fetch, and would be unnecessarily restrictive).

That's why any curl-level settings have to happen when we call
get_active_slot(), since that's when we know what we're actually using
the handle for.

-Peff
