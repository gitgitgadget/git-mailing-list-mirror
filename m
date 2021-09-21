Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B892DC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9814160F6D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhIUBpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:45:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:51338 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbhIUBlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:41:01 -0400
Received: (qmail 2900 invoked by uid 109); 21 Sep 2021 01:39:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 01:39:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26047 invoked by uid 111); 21 Sep 2021 01:39:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 21:39:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 21:39:27 -0400
From:   Jeff King <peff@peff.net>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] pretty: colorize pattern matches in commit
 messages
Message-ID: <YUk3zwuse56v76ze@coredump.intra.peff.net>
References: <20210921003050.641393-1-someguy@effective-light.com>
 <20210921003050.641393-2-someguy@effective-light.com>
 <YUk0OEXg36QXrkDm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUk0OEXg36QXrkDm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 09:24:08PM -0400, Jeff King wrote:

> > +	buf = (char *)line;
> > +	eol = buf + linelen;
> 
> OK, so we got rid of the copy of "line", which is nice. But we are
> casting away const-ness, which is a potential red flag (is somebody
> going to modify this string, even though we promised our caller we would
> not?). We'd probably want a comment to explain why we are doing so, and
> why it is OK (e.g., if somebody in the call stack modifies it
> temporarily).
> 
> More on this in a moment.

The root of the issue is that grep_next_match() takes a non-const
buffer, and so on. And indeed, it _does_ eventually get modified,
although only temporarily. I think we can clean that up, though.

Here are two patches I prepared on top of your series to show what's
possible, though I think we should do one of:

  - put them at the front of your series (with the appropriate
    adjustments) as preparatory cleanup

  - keep them separate. You can put a comment above the cast to mention
    what's going on and why it's OK for now, and then later when they're
    both merged, we can remove that cast.

The second option creates a little extra work for the maintainer (they
both touch match_one_patter(), so there will be some textual conflicts).
But it does mean we avoid a dependencies; the cleanups don't derail your
series, nor does your series hold up the cleanups. So I could go either
way.

  [1/2]: grep: stop modifying buffer in strip_timestamp
  [2/2]: grep: mark "haystack" buffers as const

 grep.c   | 30 ++++++++++++------------------
 grep.h   |  3 ++-
 pretty.c |  6 +++---
 3 files changed, 17 insertions(+), 22 deletions(-)

-Peff
