Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D57C4320A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 15:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5467460F43
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 15:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhG2P00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:26:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:60874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237854AbhG2P0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 11:26:25 -0400
Received: (qmail 8749 invoked by uid 109); 29 Jul 2021 15:26:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jul 2021 15:26:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20561 invoked by uid 111); 29 Jul 2021 15:26:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jul 2021 11:26:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jul 2021 11:26:20 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
Message-ID: <YQLInKdjor6Vs1yE@coredump.intra.peff.net>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
 <bc24ea9c-178c-bcc9-2097-2271df93ae76@gmail.com>
 <CABPp-BGjrKWXn2ZzeJ-nsZTwsDE=gbaX=1YKfiNtC70VeN9VVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGjrKWXn2ZzeJ-nsZTwsDE=gbaX=1YKfiNtC70VeN9VVA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 04:49:18PM -0600, Elijah Newren wrote:

> On Mon, Jul 26, 2021 at 8:36 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 7/23/2021 8:54 AM, Elijah Newren via GitGitGadget wrote:
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > We need functions which will either call
> > >     xmalloc, xcalloc, xstrndup
> > > or
> > >     mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
> > > depending on whether we have a non-NULL memory pool.  Add these
> > > functions; the next commit will make use of these.
> >
> > I briefly considered that this should just be the way the
> > mem_pool_* methods work. It does rely on the caller knowing
> > to free() the allocated memory when their pool is NULL, so
> > perhaps such a universal change might be too much. What do
> > you think?
> 
> That's interesting, but I'm worried it might be a bit much.  Do others
> on the list have an opinion here?

FWIW, I had the same thought. You can also provide a helper to make the
freeing side nicer:

  static void mem_pool_free(struct mem_pool *m, void *ptr)
  {
	if (m)
		return; /* will be freed when pool frees */
	free(ptr);
  }

We do something similar with unuse_commit_buffer(), where the caller
isn't aware of we pulled the buffer from cache or allocated it
especially for them.

-Peff
