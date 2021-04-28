Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A674EC43461
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BDD61449
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhD1Pov (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:44:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:38226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240639AbhD1Pm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 11:42:28 -0400
Received: (qmail 8927 invoked by uid 109); 28 Apr 2021 15:41:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Apr 2021 15:41:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 687 invoked by uid 111); 28 Apr 2021 15:41:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Apr 2021 11:41:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Apr 2021 11:41:41 -0400
From:   Jeff King <peff@peff.net>
To:     David Emett <dave@sp4m.net>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 0/2] prune: save reachable-from-recent objects with bitmaps
Message-ID: <YImCNXC5DUvy5gT8@coredump.intra.peff.net>
References: <CAJ-dYSOVx0egnyxJb6ZjgWvEDR=19QPgc70JQ7cXUjUPZ1XDiQ@mail.gmail.com>
 <YIgxPtDmr9sYj0ft@coredump.intra.peff.net>
 <CAJ-dYSOHEfRq3p_MQMJoHf5PjwQtbJOzJ9Dzxrfe+BDkov7Q8w@mail.gmail.com>
 <YIl7tUJA6sQe2K73@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIl7tUJA6sQe2K73@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 11:13:57AM -0400, Jeff King wrote:

> On Wed, Apr 28, 2021 at 01:20:03PM +0100, David Emett wrote:
> 
> > > Here's a fix. Thanks very much for reporting.
> > 
> > Thanks for the quick response! I tried the fix out on the repo I was having
> > trouble with. It's hitting a segfault in traverse_commit_list in the
> > mark_recent block. It looks like the issue is that the bitmap code leaves
> > revs->include_check set, with revs->include_check_data pointing at the stack.
> > Setting revs->include_check to NULL after the traverse_commit_list call in
> > find_objects in pack-bitmap.c fixes the segfault for me. And the original issue
> > appears to be resolved as well, so thanks!
> 
> Oof, good catch. I wondered why my test didn't see this. The answer is
> that the include_check only applies to commits, not trees. And my test
> only has a recent-but-unreachable tree. Beefing it up to include an
> actual commit shows the problem (and ASan nicely pinpoints the issue).
> 
> The solution, as you noted, is to have the bitmap code clean up after
> itself.
> 
> I'll prepare a re-roll of the series.

Here it is.

I did notice one other oddity. The bitmap code doesn't do any sort of
progress reporting. So progress is enabled, we'll _just_ count the
recent-but-unreachable entries in the progress meter.

That's not entirely wrong (it represents the actual traversal work we're
doing), but is a little funny. However, I think the best thing to do for
now is to leave it there. The right path forward is for the bitmap code
to learn about progress reporting, too (for this case, but also for
others). But that's a more involved topic, and I don't want to hold up
this fix for it.

  [1/2]: pack-bitmap: clean up include_check after use
  [2/2]: prune: save reachable-from-recent objects with bitmaps

 pack-bitmap.c              |  3 +++
 reachable.c                | 13 ++++---------
 t/t5304-prune.sh           | 16 ++++++++++++++++
 t/t6501-freshen-objects.sh | 21 +++++++++++++++------
 4 files changed, 38 insertions(+), 15 deletions(-)

-:  ---------- > 1:  43f25e88c5 pack-bitmap: clean up include_check after use
1:  a7fb2a7f5b ! 2:  0a60ea597d prune: save reachable-from-recent objects with bitmaps
    @@ t/t5304-prune.sh: test_expect_success 'trivial prune with bitmaps enabled' '
     +	to_save=$(echo bitmap-from-recent-2 | git hash-object -w --stdin) &&
     +	test-tool chmtime -86400 .git/objects/$(test_oid_to_path $to_save) &&
     +	tree=$(printf "100644 blob $to_save\tfile\n" | git mktree) &&
    ++	test-tool chmtime -86400 .git/objects/$(test_oid_to_path $tree) &&
    ++	commit=$(echo foo | git commit-tree $tree) &&
     +	git prune --expire=12.hours.ago &&
    ++	git cat-file -e $commit &&
     +	git cat-file -e $tree &&
     +	git cat-file -e $to_save &&
     +	test_must_fail git cat-file -e $to_drop

-Peff
