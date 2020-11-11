Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C10C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8479520678
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKKTBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:01:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:54826 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgKKTBW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:01:22 -0500
Received: (qmail 13827 invoked by uid 109); 11 Nov 2020 19:01:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 19:01:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18179 invoked by uid 111); 11 Nov 2020 19:01:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Nov 2020 14:01:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Nov 2020 14:01:21 -0500
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 12/15] strmap: enable allocations to come from a
 mem_pool
Message-ID: <20201111190121.GE9902@coredump.intra.peff.net>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
 <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
 <34f542d9dd846da5fd81274966ee2ebe0660dcef.1604622299.git.gitgitgadget@gmail.com>
 <fbaa60c4-ee6b-02b7-68b5-e5873f8ec713@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbaa60c4-ee6b-02b7-68b5-e5873f8ec713@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 05:33:47PM +0000, Phillip Wood wrote:

> On 06/11/2020 00:24, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> > 
> > For heavy users of strmaps, allowing the keys and entries to be
> > allocated from a memory pool can provide significant overhead savings.
> > Add an option to strmap_init_with_options() to specify a memory pool.
> > [...]
> > diff --git a/strmap.h b/strmap.h
> > index c8c4d7c932..dda928703d 100644
> > --- a/strmap.h
> > +++ b/strmap.h
> > @@ -3,8 +3,10 @@
> >   #include "hashmap.h"
> > +struct mempool;
> 
> I think this is a typo - I assume you wanted to declare `struct mem_pool`
> but it's not strictly necessary as you're only adding a pointer to the
> struct below.

Good catch.

Even if we're only using a pointer to it, we still need a valid forward
declaration (using the pointer only saves us from needing the full
definition). Or so I thought.

It looks like the compiler will treat the use inside the struct:

> >   struct strmap {
> >   	struct hashmap map;
> > +	struct mem_pool *pool;
> >   	unsigned int strdup_strings:1;
> >   };

as an implicit forward declaration, but not the ones inside the function
declarations:

> >   void strmap_init_with_options(struct strmap *map,
> > +			      struct mem_pool *pool,
> >   			      int strdup_strings);

If you replace the pointer in the struct definition with "struct foo",
then "make hdr-check" will complain about mem_pool in the function. And
likewise if you replace the ones in the function with "struct foo", then
we'll complain about those.

I'm not sure whether this is a seldom-seen corner of the C standard, or
a compiler-specific thing (though both clang and gcc seem to allow it).
At any rate, I think it is worth fixing the typo'd forward declaration
(rather than deleting it) to make the intention clear.

-Peff
