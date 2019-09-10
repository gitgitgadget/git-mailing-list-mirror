Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F83E1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 16:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436790AbfIJQbT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 12:31:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:45516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2436787AbfIJQbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 12:31:19 -0400
Received: (qmail 447 invoked by uid 109); 10 Sep 2019 16:31:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Sep 2019 16:31:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16857 invoked by uid 111); 10 Sep 2019 16:33:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2019 12:33:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Sep 2019 12:31:18 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Diomidis Spinellis' <dds@aueb.gr>, git@vger.kernel.org
Subject: Re: Patching Git to handle dates before the Unix epoch
Message-ID: <20190910163117.GB12758@sigill.intra.peff.net>
References: <c12e3505-7a02-3eaf-7d71-57a3b4df28d1@aueb.gr>
 <003301d567f2$03550df0$09ff29d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <003301d567f2$03550df0$09ff29d0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 12:08:34PM -0400, Randall S. Becker wrote:

> My suggestion is a new feature as a patch. See other contributions.
> While you're at this, especially given how extensive this may be given
> the time_t references, it might be useful to examine the end of epoch
> concerns as well. 2036 is not that far off and some of the
> repositories I am managing will likely last beyond the Unix date
> rollover. There are no time64_t to get us to 2106, but even that is
> probably not sufficient (thinking beyond my own expiry date). The
> concept of unlimited date ranges is intriguing if we are going to
> store broader range artifacts in git, like signatures of physical core
> samples and use the carbon dating in git, or some Sci-Fi conceptual
> commit on old 1701D. So if I had a preference, it would be to store an
> extensible date range going from the Big Bang to the Big Crunch (or
> beyond), but that is excessive.

Internally we now use a uintmax_t (with a resolution of 1-second) for
parsing and storing most timestamps, which should presumably be at least
64-bit on most systems. We do convert to time_t at various points,
recognizing truncation and switching that to a sentinel value (so at
least you get "Jan 1 1970" instead of some random wrapped time).

So I think we should behave sanely in all cases (at least going forward
from 1970 for now), and it's a quality-of-implementation issue whether
any given system can pretty-print specific dates.

Switching that to intmax_t should get us pretty good coverage in the
opposite direction, and anybody with a 64-bit signed time_t on their
system will generally be happy.

-Peff
