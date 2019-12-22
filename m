Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B320BC3F68F
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F8E20733
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLVJai (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 04:30:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:52200 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725899AbfLVJai (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 04:30:38 -0500
Received: (qmail 12612 invoked by uid 109); 22 Dec 2019 09:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Dec 2019 09:30:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26849 invoked by uid 111); 22 Dec 2019 09:35:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Dec 2019 04:35:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Dec 2019 04:30:36 -0500
From:   Jeff King <peff@peff.net>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
Message-ID: <20191222093036.GA3449072@coredump.intra.peff.net>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 10:05:11PM +0000, Garima Singh via GitGitGadget wrote:

> Adopting changed path bloom filters has been discussed on the list before,
> and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
> Derrick Stolee [1]. This series is based on Dr. Stolee's approach [2] and
> presents an updated and more polished RFC version of the feature.

Great to see progress here. I probably won't have time to review this
carefully before the new year, but I did notice some low-hanging fruit
on the generation side.

So here are a few patches to reduce the CPU and memory usage. They could
be squashed in at the appropriate spots, or perhaps taken as inspiration
if there are better solutions (especially for the first one).

I think we could go further still, by actually doing a non-recursive
diff_tree_oid(), and then recursing into sub-trees ourselves. That would
save us having to split apart each path to add the leading paths to the
hashmap (most of which will be duplicates if the commit touched "a/b/c"
and "a/b/d", etc). I doubt it would be that huge a speedup though. We
have to keep a list of the touched paths anyway (since the bloom key
parameters depend on the number of entries), and most of the time is
almost certainly spent inflating the trees in the first place. However
it might be easier to follow the code, and it would make it simpler to
stop traversing at the 512-entry limit, rather than generating a huge
diff only to throw it away.

  [1/3]: commit-graph: examine changed-path objects in pack order
  [2/3]: commit-graph: free large diffs, too
  [3/3]: commit-graph: stop using full rev_info for diffs

 bloom.c        | 18 +++++++++---------
 commit-graph.c | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 10 deletions(-)

-Peff
