Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CE0C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1358420BED
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgIANv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:51:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:46312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgIANvI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 09:51:08 -0400
Received: (qmail 27301 invoked by uid 109); 1 Sep 2020 13:51:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2020 13:51:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27551 invoked by uid 111); 1 Sep 2020 13:51:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2020 09:51:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Sep 2020 09:51:05 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length
 realloc()
Message-ID: <20200901135105.GA3284077@coredump.intra.peff.net>
References: <20200901111800.GA3115584@coredump.intra.peff.net>
 <c81b7225-a663-1598-62b3-bd80457d5648@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c81b7225-a663-1598-62b3-bd80457d5648@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 01, 2020 at 09:04:36AM -0400, Derrick Stolee wrote:

> > The simplest fix here is to just pass "ret" (which we know to be NULL)
> > to the follow-up realloc(). That does mean that a system which _doesn't_
> > free the original pointer would leak it. But that interpretation of the
> > standard seems unlikely (if a system didn't deallocate in this case, I'd
> > expect it to simply return the original pointer). If it turns out to be
> > an issue, we can handle the "!size" case up front instead, before we
> > call realloc() at all.
> 
> Adding an `if (!size) {free(ptr); return NULL;}` block was what I
> expected. Was that chosen just so we can rely more on the system
> realloc(), or is there a performance implication that I'm not
> seeing?

I went back and forth on whether to do that or not. This case should
basically never happen, so I like both the performance and readability
of only triggering it when realloc() returns NULL. But it would get rid
of the hand-waving above, and I doubt the performance is measurable.

If we do handle it up-front, then I think we'd actually want:

  if (!size) {
          free(ptr);
	  return xmalloc(0);
  }

(i.e., to never return NULL for consistency with xmalloc() and
xcalloc()).

> > @@ -120,7 +120,7 @@ void *xrealloc(void *ptr, size_t size)
> >  	memory_limit_check(size, 0);
> >  	ret = realloc(ptr, size);
> >  	if (!ret && !size)
> > -		ret = realloc(ptr, 1);
> > +		ret = realloc(ret, 1);
> 
> I appreciate all the additional context for such a small change.

Somebody's got to complete with you for ratio of commit message to diff
lines. :)

-Peff
