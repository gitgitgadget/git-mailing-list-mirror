Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DDDC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6C4613F1
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 15:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhD1POx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:14:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:38202 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239696AbhD1POo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 11:14:44 -0400
Received: (qmail 8858 invoked by uid 109); 28 Apr 2021 15:13:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Apr 2021 15:13:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 479 invoked by uid 111); 28 Apr 2021 15:13:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Apr 2021 11:13:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Apr 2021 11:13:57 -0400
From:   Jeff King <peff@peff.net>
To:     David Emett <dave@sp4m.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: save reachable-from-recent objects with bitmaps
Message-ID: <YIl7tUJA6sQe2K73@coredump.intra.peff.net>
References: <CAJ-dYSOVx0egnyxJb6ZjgWvEDR=19QPgc70JQ7cXUjUPZ1XDiQ@mail.gmail.com>
 <YIgxPtDmr9sYj0ft@coredump.intra.peff.net>
 <CAJ-dYSOHEfRq3p_MQMJoHf5PjwQtbJOzJ9Dzxrfe+BDkov7Q8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-dYSOHEfRq3p_MQMJoHf5PjwQtbJOzJ9Dzxrfe+BDkov7Q8w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 01:20:03PM +0100, David Emett wrote:

> > Here's a fix. Thanks very much for reporting.
> 
> Thanks for the quick response! I tried the fix out on the repo I was having
> trouble with. It's hitting a segfault in traverse_commit_list in the
> mark_recent block. It looks like the issue is that the bitmap code leaves
> revs->include_check set, with revs->include_check_data pointing at the stack.
> Setting revs->include_check to NULL after the traverse_commit_list call in
> find_objects in pack-bitmap.c fixes the segfault for me. And the original issue
> appears to be resolved as well, so thanks!

Oof, good catch. I wondered why my test didn't see this. The answer is
that the include_check only applies to commits, not trees. And my test
only has a recent-but-unreachable tree. Beefing it up to include an
actual commit shows the problem (and ASan nicely pinpoints the issue).

The solution, as you noted, is to have the bitmap code clean up after
itself.

I'll prepare a re-roll of the series.

-Peff
