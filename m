Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4515EC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200386127A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 08:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFHIgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 04:36:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:48808 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhFHIgR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 04:36:17 -0400
Received: (qmail 29129 invoked by uid 109); 8 Jun 2021 08:34:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 08:34:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8211 invoked by uid 111); 8 Jun 2021 08:34:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 04:34:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 04:34:21 -0400
From:   Jeff King <peff@peff.net>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: use HEAD as primary sort key in
 git_get_heads_list()
Message-ID: <YL8rjeKQPOtQSyzT@coredump.intra.peff.net>
References: <20210606085116.13739-1-greg@hurrell.net>
 <20210606085732.15001-1-greg@hurrell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210606085732.15001-1-greg@hurrell.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 06, 2021 at 10:57:32AM +0200, Greg Hurrell wrote:

> Prior to this commit, the "heads" section on a gitweb summary page would
> list the heads in `-committerdate` order (ie. the most recently-modified
> ones at the top).
> 
> In my own repos I have started to move from "master" towards "main", but
> I keep "master" around and in sync with "main" so as not to break
> existing clones. As such, they always point at the same commit.
> 
> This means that in the "heads" listing of a gitweb instance, the display
> order ends up being determined by how `git for-each-ref` decides to
> tie-break "master" and "main"

Hmm. I'd have expected it to, because we start the list in lexicographic
order. I suspect the sort we use simply isn't stable (in a simple 3-ref
example I made, "main" did sort before "master" by default). That would
be easy to fix, of course, but there may be value in using the HEAD rule
anyway.

> For example, right now on a sample repo, gitweb shows the heads in this
> order, even though "master" and "main" reference the same commit. The
> tie-breaking evidently isn't happening lexicographically:
> 
> - master
> - main
> - pu
> - next
> 
> So, this commit adds another `--sort` parameter to the `git
> for-each-ref` invocation in `git_get_heads_list()`, ensuring that the
> `HEAD` ref always ends up getting sorted to the top:
> 
> - main
> - master
> - pu
> - next

In your earlier example, it sounded like you were primarily concerned
with breaking ties. But here it sounds like you're proposing putting the
HEAD first _regardless_ of the committer timestamp.

I don't have a strong feeling either way on that. It may surface an
older branch, but in general I'd expect the HEAD to be reasonably
up-to-date (unless somebody has a weird workflow that does not really
use it at all, and expects people to always clone with "-b" or
whatever. We can probably discount that).

It doesn't help the stability of non-HEAD branches that are in ties.
I.e., I wonder if this should be two separate patches:

  1. break ties by name, like:

       git for-each-ref --sort=refname --sort=-committerdate

  2. emphasize the HEAD branch, even if it isn't the newest:

       git for-each-ref --sort=refname --sort=-committerdate --sort=-HEAD

-Peff
