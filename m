Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9561FAFB
	for <e@80x24.org>; Fri,  7 Apr 2017 04:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbdDGEqd (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 00:46:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:57876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbdDGEqb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 00:46:31 -0400
Received: (qmail 21981 invoked by uid 109); 7 Apr 2017 04:46:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 04:46:30 +0000
Received: (qmail 31897 invoked by uid 111); 7 Apr 2017 04:46:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 00:46:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 00:46:27 -0400
Date:   Fri, 7 Apr 2017 00:46:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 0/3] read-cache: speed up add_index_entry
Message-ID: <20170407044626.ypsqnyxguw43gprm@sigill.intra.peff.net>
References: <20170406163442.36463-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170406163442.36463-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 04:34:39PM +0000, git@jeffhostetler.com wrote:

> Teach add_index_entry_with_check() and has_dir_name()
> to avoid index lookups if the given path sorts after
> the last entry in the index.
> 
> This saves at least 2 binary searches per entry.
> 
> This improves performance during checkout and read-tree because
> merge_working_tree() and unpack_trees() processes a list of already
> sorted entries.

Just thinking about this algorithmically for a moment. You're saving the
binary search when the input is given in sorted order. But in other
cases you're adding an extra strcmp() before the binary search begins.
So it's a tradeoff.

How often is the input sorted?  You save O(log n) strcmps for a "hit"
with your patch, and one for a "miss". So it's a net win if we expect at
least 1/log(n) of additions to be sorted (I'm talking about individual
calls, but it should scale linearly either way over a set of n calls).

I have no clue if that's a reasonable assumption or not.

-Peff
