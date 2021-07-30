Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7B7C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A3F60E76
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhG3QMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:12:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhG3QMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:12:35 -0400
Received: (qmail 15554 invoked by uid 109); 30 Jul 2021 16:12:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Jul 2021 16:12:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3145 invoked by uid 111); 30 Jul 2021 16:12:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Jul 2021 12:12:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Jul 2021 12:12:29 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
Message-ID: <YQQk7Vgf8hBQ9Ko+@coredump.intra.peff.net>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
 <bc24ea9c-178c-bcc9-2097-2271df93ae76@gmail.com>
 <CABPp-BGjrKWXn2ZzeJ-nsZTwsDE=gbaX=1YKfiNtC70VeN9VVA@mail.gmail.com>
 <YQLInKdjor6Vs1yE@coredump.intra.peff.net>
 <CABPp-BF+1=yajJ_Z9MHHbeL6XkctfStj63xVXTkguNicx_PcPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF+1=yajJ_Z9MHHbeL6XkctfStj63xVXTkguNicx_PcPw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 08:27:51PM -0600, Elijah Newren wrote:

> > FWIW, I had the same thought. You can also provide a helper to make the
> > freeing side nicer:
> >
> >   static void mem_pool_free(struct mem_pool *m, void *ptr)
> >   {
> >         if (m)
> >                 return; /* will be freed when pool frees */
> >         free(ptr);
> >   }
> >
> > We do something similar with unuse_commit_buffer(), where the caller
> > isn't aware of we pulled the buffer from cache or allocated it
> > especially for them.
> 
> Having a paired function may help one side, but I worry that the name
> (mem_pool_free) might introduce some confusion of its own -- "Why is
> there a mem_pool_free() function, isn't the point of memory pools to
> not need to individually free things?"  Or, "Why are they freeing the
> pool here and what's the extra parameter?"

Yeah, "mem_pool_maybe_free" or something might explain it. But...

> I'm not sure I see the right way to address that, so I think I'm going
> to leave this part out of my series and let someone else add such
> changes on top if they feel motivated to do so.

That's fine, especially as dropping the conditiona USE_MEMORY_POOL flag
means these functions will go away entirely.

-Peff
