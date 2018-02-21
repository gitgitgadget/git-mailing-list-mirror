Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F90E1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbeBUSwJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:52:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:59548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932316AbeBUSwH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:52:07 -0500
Received: (qmail 7501 invoked by uid 109); 21 Feb 2018 18:52:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 18:52:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23627 invoked by uid 111); 21 Feb 2018 18:52:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 13:52:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 13:52:04 -0500
Date:   Wed, 21 Feb 2018 13:52:04 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about get_cached_commit_buffer()
Message-ID: <20180221185204.GA8476@sigill.intra.peff.net>
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
 <20180220225726.GA17496@sigill.intra.peff.net>
 <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
 <20180221184811.GD4333@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221184811.GD4333@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 01:48:11PM -0500, Jeff King wrote:

> > What confuses me about this behavior is that the OID is still shown on the
> > repeat (and in the case of `git log --oneline` will not actually have a line
> > break between two short-OIDs). I don't believe this behavior is something to
> > preserve.
> 
> I think that repeating the oid is intentional; the point is to dump how
> the traversal code is hitting the endpoints, even if we do so multiple
> times.
> 
> The --oneline behavior just looks like a bug. I think --format is broken
> with --show-all, too (it does not show anything!).

I poked at one of the examples a little more closely. I actually think
these are not repeats, but simply UNINTERESTING parents that we never
needed to look at in our traversal (because we hit a point where
everything was UNINTERESTING).

So we are relying not on finish_commit() to have freed the buffer, but
on the traversal code to have never parsed those commits in the first
place. Which is doubly subtle.

I think the rest of my email stands, though: we should just show the
full headers for those commits.

-Peff
