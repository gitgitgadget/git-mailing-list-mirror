Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5086C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 01:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKXBEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 20:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKXBE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 20:04:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140EDD5A32
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 17:04:24 -0800 (PST)
Received: (qmail 24299 invoked by uid 109); 24 Nov 2022 01:04:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 01:04:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21448 invoked by uid 111); 24 Nov 2022 01:04:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Nov 2022 20:04:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Nov 2022 20:04:23 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [Design RFC] Being more defensive about fetching commits in
 partial clone
Message-ID: <Y37DF7THHv3wEbUc@coredump.intra.peff.net>
References: <20221124004205.1777255-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221124004205.1777255-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 04:42:05PM -0800, Jonathan Tan wrote:

> A question remains of whether we would need to undo all this work if we decide
> to support commit filters in partial clones. Firstly, there are good arguments
> against (and, of course, for) commit filters in partial clones, so commit
> filters may not work out in the end anyway. Secondly, even if we do have commit
> filters, we at $DAYJOB think that we still need to differentiate, in some way,
> a fetch that we have accounted for in our design and a fetch that we haven't;
> commit chains have much greater lengths than tree chains and users wouldn't
> want to wait for Git to fetch commit by commit (or segment by segment, if we
> end up batch fetching commits as we probably will). So we would be building on
> the defensiveness of fetching commits in this case, not tearing it down.
> 
> My next step will be to send a patch modifying repo_parse_commit() to not
> lazy-fetch, and I think that future work will lie in identifying when we know
> that we are reading a commit and inhibiting lazy-fetches in those cases. If
> anyone has an opinion on this, feel free to let us know (hence the "RFC" in
> the subject).

In general, I think partial clones tend to know which filters were used
to create them, because we save that filter in the config. Would it be
reasonable before lazy-fetching to say "I am looking for an object of
type X; would my configured filters have skipped such an object?".

Then not only would you get the behavior you want for commits (which are
never skipped), but a blob:none clone would not try to lazy-fetch trees
(but a tree:depth one would lazy-fetch both trees and blobs).

The gotcha I'd worry about is that the config doesn't necessarily match
how the repository was originally created. There is nothing right now
saying you cannot partial-clone with one filter, then change the config
going forward.

-Peff
