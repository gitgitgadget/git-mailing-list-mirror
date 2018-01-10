Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C8B1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 08:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbeAJISm (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 03:18:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:39794 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933639AbeAJISh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 03:18:37 -0500
Received: (qmail 18333 invoked by uid 109); 10 Jan 2018 08:18:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Jan 2018 08:18:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13518 invoked by uid 111); 10 Jan 2018 08:19:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Jan 2018 03:19:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jan 2018 03:18:35 -0500
Date:   Wed, 10 Jan 2018 03:18:35 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/9] bundle: avoid using the rev_info flag leak_pending
Message-ID: <20180110081835.GF16315@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
 <5fe3b4c8-e48c-1922-f564-e75c5a354cef@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fe3b4c8-e48c-1922-f564-e75c5a354cef@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 06:46:14PM +0100, René Scharfe wrote:

> The leak_pending flag is so awkward to use that multiple comments had to
> be added around each occurrence.  We use it for remembering the
> prerequisites for the bundle.  That is easy, though: We have the
> ref_list named "prerequisites" in the header for just that purpose.
> 
> Use this original list of prerequisites to check if all of them are
> present and to clear their commit marks afterward.  The two new loops
> are intentionally kept similar to the first one in the function.
> Calling parse_object() a second time is expected be quick and successful
> in each case -- any errors should have been handled in the first round.

There are a few code paths which unset the "parsed" flag, and could
cause us to actually re-load an object. I doubt we could trigger any
here. And AFAICT this is what the original code was doing inside the
helper function anyway.

I do wonder what this is supposed to do for refs that point to
non-commits (both before and after your patch). Are we failing to clear
the flags on them?

I guess not, because we do not pass "--objects" to the traversal in the
first place, so we would never visit them (though that also makes me
wonder if we do the wrong thing in the verification step for such a
ref).

-Peff
