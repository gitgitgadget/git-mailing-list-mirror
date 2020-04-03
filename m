Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A049EC2BA16
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 14:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627E5207FF
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 14:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391057AbgDCOiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:38:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:60534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728066AbgDCOip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 10:38:45 -0400
Received: (qmail 28038 invoked by uid 109); 3 Apr 2020 14:38:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 14:38:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19254 invoked by uid 111); 3 Apr 2020 14:48:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 10:48:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 10:38:44 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix -Wmaybe-uninitialized warnings under -O0
Message-ID: <20200403143844.GB639586@coredump.intra.peff.net>
References: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
 <20200401095255.GA60227@coredump.intra.peff.net>
 <20200401140643.GA880372@generichostname>
 <20200403140447.GA639586@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403140447.GA639586@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 10:04:47AM -0400, Jeff King wrote:

> Ah, OK, I can reproduce easily with -Og (up through gcc-10). Most of
> them don't trigger with -O1; just the one in ref-filter.c.

I guess I should have been more clear since the -O1 and -Og locations
are different. -O1 complains in filter_refs().

By the way, that function's handling of filter->kind seems very sketchy
to me. It does:

  int ret = 0;
  if (!filter->kind)
                die("filter_refs: invalid type");
  else {
          /*
           * For common cases where we need only branches or remotes or tags,
           * we only iterate through those refs. If a mix of refs is needed,
           * we iterate over all refs and filter out required refs with the help
           * of filter_ref_kind().
           */
          if (filter->kind == FILTER_REFS_BRANCHES)
                  ret = for_each_fullref_in("refs/heads/", ...);
          else if (filter->kind == FILTER_REFS_REMOTES)
                  ret = for_each_fullref_in("refs/remotes/", ...);
          else if (filter->kind == FILTER_REFS_TAGS)
                  ret = for_each_fullref_in("refs/tags/", ...);
          else if (filter->kind & FILTER_REFS_ALL)
                  ret = for_each_fullref_in_pattern(filter, ...);
          if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
                  head_ref(...);
  }

So filter->kind is sometimes treated like a bitfield and sometimes not.
I can set it to (ALL & DETACHED_HEAD) to get something useful, but not
(BRANCHES & HEAD). The up-front check tries to complain if you didn't
ask for anything, but there are other flags like INCLUDE_BROKEN that
would cause "!filter->kind" to be false, but still not produce any
output.

And shouldn't we be checking the return value of head_ref() like the
others?

All of this is outside the scope of our current discussion, and
untangling it might be messy (because it could touch the callers). I
just wanted to document my findings for now. :)

-Peff
