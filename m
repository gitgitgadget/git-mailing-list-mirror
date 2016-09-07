Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10431F859
	for <e@80x24.org>; Wed,  7 Sep 2016 22:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757450AbcIGWBG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:01:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:39672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750727AbcIGWBF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 18:01:05 -0400
Received: (qmail 29380 invoked by uid 109); 7 Sep 2016 22:01:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 22:01:04 +0000
Received: (qmail 8376 invoked by uid 111); 7 Sep 2016 22:01:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 18:01:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:01:01 -0400
Date:   Wed, 7 Sep 2016 18:01:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC/PATCH v2 0/3] patch-id for merges
Message-ID: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a re-roll of the series I posted at:

  http://public-inbox.org/git/20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net/

Basically, it drops the time for "format-patch --cherry-pick" on a
particular case from 3 minutes down to 3 seconds, by avoiding diffs
on merge commits. Compared to v1, it fixes the totally-broken handling
of commit_patch_id() pointed out by Johannes.

We can drop the diffs on the merge commits because they're quite broken,
as discussed in the commit message of patch 3 (they don't take into
account any parent except the first). So what do we do when somebody
asks for the patch-id of a merge commit?

This is still marked RFC, because there are really two approaches here,
and I'm not sure which one is better for "format-patch --base". I'd like
to get input from Xiaolong Ye (who worked on --base), and Josh Triplett
(who has proposed some patches in that area, and is presumably using
them).

Option one is that merges are defined as having no patch-id at all. They
are skipped for "--cherry-pick" comparison, and "format-patch --base"
will not mention them at all as prerequisites. That's what I've
implemented here.

Option two is to use the commit sha1 as the patch-id for a merge, making
it (essentially) unique. That gives us a defined value, but it's one
that "--cherry-pick" will not match between two segments of history. I
don't know if having _some_ defined value is useful for "format-patch
--base" or not.

And obviously there's an option 3: define some more complicated patch-id
for merges that takes into account all of the parents. I didn't think
too much on that because I don't really see value in it over using the
commit sha1, and it would be computationally expensive.

  [1/3]: patch-ids: turn off rename detection
  [2/3]: diff_flush_patch_id: stop returning error result
  [3/3]: patch-ids: use commit sha1 as patch-id for merge commits

-Peff
