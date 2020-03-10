Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F579C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B82C21D56
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCJRyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:54:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:35526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726467AbgCJRyr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 13:54:47 -0400
Received: (qmail 25039 invoked by uid 109); 10 Mar 2020 17:54:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Mar 2020 17:54:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13435 invoked by uid 111); 10 Mar 2020 18:04:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Mar 2020 14:04:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Mar 2020 13:54:46 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-slab: clarify slabname##_peek()'s return value
Message-ID: <20200310175446.GB549010@coredump.intra.peff.net>
References: <20200310153049.3482-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310153049.3482-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 04:30:49PM +0100, SZEDER Gábor wrote:

> Ever since 862e730ec1 (commit-slab: introduce slabname##_peek()
> function, 2015-05-14) the slabname##_peek() function is documented as:
> 
>   This function is similar to indegree_at(), but it will return NULL
>   until a call to indegree_at() was made for the commit.
> 
> This, however, is usually not the case.  If indegree_at() allocates
> memory, then it will do so not only for the single commit it got as
> parameter, but it will allocate a whole new, ~512kB slab.  Later on,
> if any other commit's 'index' field happens to point into an already
> allocated slab, then indegree_peek() for such a commit will return a
> valid non-NULL pointer, pointing to a zero-initialized location in the
> slab, even if no indegree_at() call has been made for that commit yet.
> 
> Update slabname##_peek()'s documentation to clarify this.

Yeah, I agree the existing documentation is misleading. Your update
looks good to me.

I thought at first we might simply be able to say:

  This function is similar to indegree_at(), but it will avoid
  allocating new slab memory (so its result is suitable only for
  reading, not writing).

But I think it's worth mentioning that the caller needs to handle both
NULL or a possible zero-initialized value, as your patch does.

I also wondered if we could make life easier for the caller by
collapsing these cases. I.e., always returning a zero-initialized value,
and never NULL. All of the callers do something like:

  struct blame_origin *get_blame_suspects(struct commit *commit)
  {                               
          struct blame_origin **result;
                  
          result = blame_suspects_peek(&blame_suspects, commit);
  
          return result ? *result : NULL;
  }

all of which could be turned into a single blame_suspects_peek() call if
it just consistently returned a zero-initialized value (it's a little
confusing in this example because we're storing pointers, so the
zero-initialized value is _also_ NULL, but it's a different type).

But that would get a bit awkward, because peek() returns a pointer, not
a value (as it should, because the type we're storing may be a compound
type, which we generally avoid passing or returning by value).  So we'd
actually need to return a pointer to a zero-initialized dummy value. Not
impossible, but getting a bit odd.

-Peff
