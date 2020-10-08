Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B2C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEF2221FC
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgJHQnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:43:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:53970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbgJHQne (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 12:43:34 -0400
Received: (qmail 29896 invoked by uid 109); 8 Oct 2020 16:43:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Oct 2020 16:43:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25498 invoked by uid 111); 8 Oct 2020 16:43:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Oct 2020 12:43:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Oct 2020 12:43:33 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3] commit-graph: ignore duplicates when merging layers
Message-ID: <20201008164333.GA2838359@coredump.intra.peff.net>
References: <pull.747.v2.git.1602169145625.gitgitgadget@gmail.com>
 <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
 <20201008155304.GA2823778@coredump.intra.peff.net>
 <e1d4c427-b9a7-261a-6297-4a4768e8dbc0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1d4c427-b9a7-261a-6297-4a4768e8dbc0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 12:26:29PM -0400, Derrick Stolee wrote:

> >> +			/*
> >> +			 * Silently ignore duplicates. These were likely
> >> +			 * created due to a commit appearing in multiple
> >> +			 * layers of the chain, which is unexpected but
> >> +			 * not invalid. We should make sure there is a
> >> +			 * unique copy in the new layer.
> >> +			 */
> > 
> > You mentioned earlier checking tha the metadata for the duplicates was
> > identical. How hard would that be to do here?
> 
> I do think it is a bit tricky, since we would need to identify
> from these duplicates which commit-graph layers they live in,
> then compare the binary data in each row (for tree, date, generation)
> and also logical data (convert parent int-ids into oids). One way
> to do this would be to create distinct 'struct commit' objects (do
> not use lookup_commit()) but finding the two positions within the
> layers is the hard part.

OK, that sounds sufficiently hard that it isn't worth doing. I wondered
if there was easy access since we had the commit_graph handles here. But
I guess it really depends on which chunks are even available.

> At this point, any disagreement between rows would be corrupt data
> in one or the other, and it should be caught by the 'verify'
> subcommand. It definitely would be caught by 'verify' in the merged
> layer after the 'write' completes.
> 
> At this point, we don't have any evidence that whatever causes the
> duplicate rows could possibly write the wrong data to the duplicate
> rows. I'll keep it in mind as we look for that root cause.

That makes sense. I wonder if it is worth tipping the user off that
something funny is going on, and they may want to run "verify". I.e.,
should we be downgrading the die() to a warning(), rather than silently
skipping the duplicate.

I guess it depends on how often we expect this to happen. If the root
cause turns out to be some race that's unusual but may come up from time
to time, then the warning would unnecessarily alarm people, and/or be
annoying. But we don't know yet if that's the case.

-Peff
