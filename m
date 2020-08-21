Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88037C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FEA20748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgHUUKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:10:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:37570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgHUUKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 16:10:35 -0400
Received: (qmail 20787 invoked by uid 109); 21 Aug 2020 20:10:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 20:10:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31838 invoked by uid 111); 21 Aug 2020 20:10:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 16:10:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 16:10:34 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] strmap: add functions facilitating use as a
 string->int map
Message-ID: <20200821201034.GG1165@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <418975b46039f63476852a868ca6221244b5d88e.1598035949.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <418975b46039f63476852a868ca6221244b5d88e.1598035949.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 06:52:29PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Although strmap could be used as a string->int map, one either had to
> allocate an int for every entry and then deallocate later, or one had to
> do a bunch of casting between (void*) and (intptr_t).
> 
> Add some special functions that do the casting.  Also, rename put->set
> for such wrapper functions since 'put' implied there may be some
> deallocation needed if the string was already found in the map, which
> isn't the case when we're storing an int value directly in the void*
> slot instead of using the void* slot as a pointer to data.

I think wrapping this kind of hackery is worth doing.

You'd be able to use put() as usual, wouldn't you? It never deallocates
the util field, but just returns the old one. And the caller knows that
it's really an int, and shouldn't be deallocated.

> A note on the name: strintmap looks and sounds pretty lame to me, but
> after trying to come up with something better and having no luck, I
> figured I'd just go with it for a while and then at some point some
> better and obvious name would strike me and I could replace it.  Several
> months later, I still don't have a better name.  Hopefully someone else
> has one.

strnummap? That's pretty bad, too.

Since the functions all take a raw strmap, you _could_ just do
"strmap_getint()", etc. But I think you could actually get some
additional safety by defining a wrapper type:

  struct strintmap {
          struct strmap strmap;
  };

It's a bit annoying because you a bunch of pass-through boilerplate for
stuff like:

  static inline int strintmap_empty(struct strintmap *map)
  {
          return strmap_empty(&map->map);
  }

but it would prevent mistakes like:

  strintmap_incr(&map, "foo", 10);
  strmap_clear(&map, 1);

which would try to free (void *)10.  I'm not sure if that's worth it or
not. You'd almost have to be trying to fail to pass "1" for free_util
there. But I've seen stranger things. :)

-Peff
