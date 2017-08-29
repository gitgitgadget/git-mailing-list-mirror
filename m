Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DABA208DB
	for <e@80x24.org>; Tue, 29 Aug 2017 08:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdH2IMI (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:12:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:51598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750779AbdH2IMF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 04:12:05 -0400
Received: (qmail 4642 invoked by uid 109); 29 Aug 2017 08:12:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 08:12:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7623 invoked by uid 111); 29 Aug 2017 08:12:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 04:12:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 04:12:03 -0400
Date:   Tue, 29 Aug 2017 04:12:03 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/3] merge-recursive: fix memory leak
Message-ID: <20170829081203.uwt6yfve5uatbhch@sigill.intra.peff.net>
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-2-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170828202829.3056-2-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2017 at 02:28:27PM -0600, Kevin Willford wrote:

> In merge_trees if process_renames or process_entry returns less
> than zero, the method will just return and not free re_merge,
> re_head, or entries.
> 
> This change cleans up the allocated variables before returning
> to the caller.

Good catch. I suspect this function could stand to be refactored a bit.
For instance, pulling those inner bits of the conditional into a helper
would let us do:

  re_merge = get_renames(...);
  ... other setup ...

  clean = our_new_helper(re_merge, ...);

  string_clear(re_merge);
  ... other cleanup ...

  if (clean < 0)
	return clean;

without having to resort to a goto. But certainly I don't mind this much
more minimal change, which fixes the actual functionality problem.

-Peff
