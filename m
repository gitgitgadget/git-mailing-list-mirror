Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE68EC8754
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 19:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjIGTGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjIGTGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 15:06:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7999D
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 12:06:13 -0700 (PDT)
Received: (qmail 27000 invoked by uid 109); 7 Sep 2023 07:59:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 07:59:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24378 invoked by uid 111); 7 Sep 2023 07:59:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 03:59:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 03:59:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/8] builtin/repack.c: extract marking packs for deletion
Message-ID: <20230907075931.GB1260718@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
 <313537ef68892b15e772eaad8937a4a8c7ebbe61.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <313537ef68892b15e772eaad8937a4a8c7ebbe61.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 04:36:43PM -0400, Taylor Blau wrote:

> At the end of a repack (when given `-d`), Git attempts to remove any
> packs which have been made "redundant" as a result of the repacking
> operation. For example, an all-into-one (`-A` or `-a`) repack makes
> every pre-existing pack which is not marked as kept redundant. Geometric
> repacks (with `--geometric=<n>`) make any packs which were rolled up
> redundant, and so on.
> 
> But before deleting the set of packs we think are redundant, we first
> check to see whether or not we just wrote a pack which is identical to
> any one of the packs we were going to delete. When this is the case, Git
> must avoid deleting that pack, since it matches a pack we just wrote
> (so deleting it may cause the repository to become corrupt).
> 
> Right now we only process the list of non-kept packs in a single pass.
> But a future change will split the existing non-kept packs further into
> two lists: one for cruft packs, and another for non-cruft packs.
> 
> Factor out this routine to prepare for calling it twice on two separate
> lists in a future patch.

There are really two "factor outs" here: we pull the code from
cmd_repack() into a helper, and then the helper is also just a thin
wrapper around its "_1" variant. That latter part isn't needed yet, but
I can guess from your description that we'll eventually have the main
function dispatch to the "_1" helper for lists.

The main caller in cmd_repack() could do that double-dispatch, but then
this code:

> +	if (delete_redundant && pack_everything & ALL_INTO_ONE)
> +		mark_packs_for_deletion(&existing, &names);

would know more about how "existing_packs" work than it needs to. So
this seems like a good split (and the two-liner above is making
cmd_repack() much more readable than the big loop it had in the
pre-image).

-Peff
