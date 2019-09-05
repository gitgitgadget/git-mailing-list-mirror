Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD931F461
	for <e@80x24.org>; Thu,  5 Sep 2019 07:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfIEHBz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 03:01:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:40132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731510AbfIEHBy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 03:01:54 -0400
Received: (qmail 25414 invoked by uid 109); 5 Sep 2019 07:01:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 07:01:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24384 invoked by uid 111); 5 Sep 2019 07:03:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 03:03:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 03:01:53 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
Message-ID: <20190905070153.GE21450@sigill.intra.peff.net>
References: <20190826214737.164132-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826214737.164132-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 02:47:37PM -0700, Jonathan Tan wrote:

> The specification of promisor packfiles (in partial-clone.txt) states
> that the .promisor files that accompany packfiles do not matter (just
> like .keep files), so whenever a packfile is fetched from the promisor
> remote, Git has been writing empty .promisor files. But these files
> could contain more useful information.
> 
> So instead of writing empty files, write the refs fetched to these
> files. This makes it easier to debug issues with partial clones, as we
> can identify what refs (and their associated hashes) were fetched at the
> time the packfile was downloaded, and if necessary, compare those hashes
> against what the promisor remote reports now.

I'm not really opposed to what you're doing here, but I did recently
think of another possible use for .promisor files. So it seems like a
good time to bring it up, since presumably we'd have to choose one or
the other.

I noticed when playing with partial clones that the client may sometimes
pause for a while, chewing CPU. The culprit is is_promisor_object(),
which generates the list of known promisor objects by opening every
object we _do_ have to find out which ones they mention.

I know one of the original design features of the promisor pack was that
the client would _not_ keep a list of all of the objects it didn't have.
But I wonder if it would make sense to keep a cache of these "cut
points" in the partial clone. That's potentially smaller than the
complete set of objects (especially for tree-based partial cloning), and
it seems clear we're willing to store it in memory anyway.

And if we do that, would the .promisor file for a pack be a good place
to store it?

-Peff
