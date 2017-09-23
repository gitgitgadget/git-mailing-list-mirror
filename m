Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA583202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 03:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbdIWDrU (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 23:47:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:47750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751832AbdIWDrT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 23:47:19 -0400
Received: (qmail 21886 invoked by uid 109); 23 Sep 2017 03:47:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 03:47:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10587 invoked by uid 111); 23 Sep 2017 03:47:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 23:47:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 23:47:17 -0400
Date:   Fri, 22 Sep 2017 23:47:17 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/6] leak_pending: use `object_array_clear()`, not
 `free()`
Message-ID: <20170923034717.i65irpbmlxtzwo3h@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
 <d4df674923b0dbc5c2e232cdc56a75205653d275.1506120292.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4df674923b0dbc5c2e232cdc56a75205653d275.1506120292.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 01:34:51AM +0200, Martin Ågren wrote:

> Setting `leak_pending = 1` tells `prepare_revision_walk()` not to
> release the `pending` array, and makes that the caller's responsibility.
> See 4a43d374f (revision: add leak_pending flag, 2011-10-01) and
> 353f5657a (bisect: use leak_pending flag, 2011-10-01).
> 
> Commit 1da1e07c8 (clean up name allocation in prepare_revision_walk,
> 2014-10-15) fixed a memory leak in `prepare_revision_walk()` by
> switching from `free()` to `object_array_clear()`. However, where we use
> the `leak_pending`-mechanism, we're still only calling `free()`.

Thanks for digging up the history here. Reviewing those it seems clear
that doing a full object_array_clear() is the right thing.

> Use `object_array_clear()` instead. Copy some helpful comments from
> 353f5657a to the other callers that we update to clarify the memory
> responsibilities, and to highlight that the commits are not affected
> when we clear the array -- it is indeed correct to both tidy up the
> commit flags and clear the object array.
> 
> Document `leak_pending` in revision.h to help future users get this
> right.

This all looks good to me. Since the main use of "leak_pending" seems to
be to clear commit marks, I have a feeling that a better API would have
been something like:

  /* normal setup and use */
  init_revisions(&rev);
  setup_revisions(&rev, ...);
  prepare_revision_walk(&rev);
  while (get_revision(&rev))
	...;

  /* optional, but sensible if there may be other callers */
  clear_commit_marks(&rev);

  /* actually free any held memory */
  clear_revisions(&rev);

which would imply rev_info holding onto the "old" pending list
automatically until we decommission the rev_info in the final step.

But that's obviously a much bigger change. What you have here looks like
a nice clean fix to the leak problems.

-Peff
