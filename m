Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15719201A4
	for <e@80x24.org>; Sat, 13 May 2017 08:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbdEMIgS (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 04:36:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50744 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752353AbdEMIgS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 04:36:18 -0400
Received: (qmail 26236 invoked by uid 109); 13 May 2017 08:36:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 08:36:17 +0000
Received: (qmail 30492 invoked by uid 111); 13 May 2017 08:36:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 04:36:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 04:36:15 -0400
Date:   Sat, 13 May 2017 04:36:15 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v6] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170513083615.dyfnmug35ghhy7ba@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170512204648.10611-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512204648.10611-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 01:46:48PM -0700, Jonathan Tan wrote:

> Change from v5: used "ensure_tip_oids_initialized" function instead.
> This removes some of the muddiness (e.g. with newlist being modified
> after the function).

I don't think it really improves the muddiness. You are still calling
the ensure function each time through the loop with a potentially
modified list, but it doesn't actually look at the list after the first
time. So the muddy part is still there.

I think rather than changing the code, you'd do better with a comment
like:

  /*
   * Note that this only looks at the ref lists the first time
   * it's called. This works out in filter_refs() because even
   * though it may add to "newlist" between calls, the additions
   * will always be for oids that are already in the set.
   */

At which point the original all-in-one function is probably fine (as it
avoids the "return 1 just to join the &&-chain" bit).

-Peff
