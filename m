Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9716720248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDKNri (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:47:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:54890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726145AbfDKNri (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:47:38 -0400
Received: (qmail 7112 invoked by uid 109); 11 Apr 2019 13:47:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 13:47:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27804 invoked by uid 111); 11 Apr 2019 13:48:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 09:48:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 09:47:36 -0400
Date:   Thu, 11 Apr 2019 09:47:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: [PATCH 0/4] use xmalloc in more places
Message-ID: <20190411134736.GA28543@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported on the Git security list that there are a few spots
which use a bare malloc() but don't check the return value, which could
dereference NULL. I don't think any of these are exploitable in an
interesting way, beyond Git just segfaulting more or less immediately.

But we should still be handling failures, and I think it makes sense to
be consistent about how we do it (and the other rules which come with
using xmalloc, like GIT_ALLOC_LIMIT).

This series cleans up most of the bare calls found by:

  git grep -E '[^a-z_](m|c|re)alloc\(' '*.c' :^compat :^contrib :^wrapper.c

The calls I've left are:

  - wrapper.c obviously needs to call the real functions :)

  - compat/ has functions emulating libc and system calls, and which are
    expected to return ENOMEM as appropriate

  - diff-delta will gracefully return NULL when trying to delta
    something too large, and pack-objects will skip past trying to find
    a delta. I've never seen this happen in practice, but then I
    primarily use Linux which is more than happy to overcommit on
    malloc(). I've left it unchanged, though possibly we could have an
    xmalloc_gently() if we want to enforce things like GIT_ALLOC_LIMIT
    but still do the graceful fallback thing.

  - test-hash tries to probe malloc() to see how big a buffer it can
    allocate. I doubt this even does anything useful on systems like
    Linux that overcommit. We also don't seem to ever invoke this with a
    buffer larger than 8k in the first place. So it could maybe go away
    entirely, but I left it here.

  [1/4]: test-prio-queue: use xmalloc
  [2/4]: xdiff: use git-compat-util
  [3/4]: xdiff: use xmalloc/xrealloc
  [4/4]: progress: use xmalloc/xcalloc

 progress.c                 | 18 +++++-------------
 t/helper/test-prio-queue.c |  2 +-
 xdiff/xdiff.h              |  4 ++--
 xdiff/xinclude.h           |  8 +-------
 4 files changed, 9 insertions(+), 23 deletions(-)

