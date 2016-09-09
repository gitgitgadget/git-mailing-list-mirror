Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91811F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754302AbcIIUhq (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:37:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:41025 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751917AbcIIUhq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:37:46 -0400
Received: (qmail 6280 invoked by uid 109); 9 Sep 2016 20:37:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 20:37:45 +0000
Received: (qmail 28250 invoked by uid 111); 9 Sep 2016 20:37:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 16:37:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2016 16:37:42 -0400
Date:   Fri, 9 Sep 2016 16:37:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 2/2] patch-ids: define patch-id of merge commits as
 "null"
Message-ID: <20160909203742.cyg3y7ju6vhfrx7o@sigill.intra.peff.net>
References: <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
 <20160909203447.nlyx6v76fpyx2vzl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160909203447.nlyx6v76fpyx2vzl@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 04:34:47PM -0400, Jeff King wrote:

> This patch defines the patch-id of a merge commit as
> essentially "null"; it has no patch-id. As a result,
> merges cannot match patch-ids via "--cherry-pick", and
> "format-patch --base" will not list merges in its list of
> prerequisite patch ids.
> 
> To distinguish between real errors and "null", we have to
> expand the semantics of commit_patch_id()'s return value,
> and callers need to distinguish these cases.

One alternative would be to add an out-parameter that is set in the
success case saying "yes, we have a real patch-id". And then the callers
could look like:

  if (commit_patch_id(commit, &diffopt, sha1, 0, &got_one))
	die("error!");
  if (!got_one)
	continue; /* silently skip */

We could even use the null sha1 to signal that rather than an extra
parameter, I suppose.

I dunno. It would make the callers less clunky, I think, but it does
feel a bit magical.

-Peff
