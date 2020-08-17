Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E8AC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580812072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404000AbgHQTAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:00:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403952AbgHQTAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:00:32 -0400
Received: (qmail 5954 invoked by uid 109); 17 Aug 2020 19:00:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 19:00:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19864 invoked by uid 111); 17 Aug 2020 19:00:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 15:00:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 15:00:31 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] dir: fix problematic API to avoid memory leaks
Message-ID: <20200817190031.GB1278968@coredump.intra.peff.net>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
 <b9310e9941e91336258edd97a913e5908180720e.1597561152.git.gitgitgadget@gmail.com>
 <20200816091154.GC1221900@coredump.intra.peff.net>
 <CABPp-BHyCVdb5AueF+tTwTsgAA5LkPEj-mPLoX_F+WYgPqFcNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHyCVdb5AueF+tTwTsgAA5LkPEj-mPLoX_F+WYgPqFcNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 10:19:03AM -0700, Elijah Newren wrote:

> > (I also wouldn't be opposed to changing hashmap and oidmap to use the
> > name "clear", but that's obviously a separate patch).
> 
> hashmap is one of the cases that needs to have a free construct,
> because the table in which to stuff the entries has to be allocated
> and thus a hashmap_clear() would have to leave the table allocated if
> it wants to be ready for re-use.  If someone really is done with a
> hashmap, then to avoid leaking, both the entries and the table need to
> be deallocated.

Hmm, you're right. oidmap() will lazy-initialize the table, but hashmap
will not. You _do_ have to initialize a hashmap because somebody has to
set the comparison function. But that could be fixed, and would make it
more like the rest of our code. I.e., you should be able to do:

  struct hashmap foo = HASHMAP_INIT(my_cmpfn);

  if (bar)
	return; /* no leak, because we never put anything in the map! */

  ... add some stuff to the map ...

  hashmap_clear(&foo);

  ... now it's empty and nothing allocated; we could return
      here without a leak or we could add more stuff to it ...

I don't even think it would be that big a change. Just translate a NULL
table to "not found" on the read side, and lazily call alloc_table() on
the write side. And have hashmap_free() not very the _whole_ struct, but
leave the cmpfn in place.

> I keep getting confused by the hashmap API, and what pieces it frees
> -- it looks like my earlier comments today were wrong and
> hashmap_free_entries() does free the table.  So...perhaps I should
> create a patch to make that clearer, and also submit the patch I've
> had for a while to introduce a hashmap_clear() function (which is
> similar to hashmap_free_entries, in that it frees the entries and
> zeros out most of the map, but it leaves the table allocated and ready
> for use).
> 
> I really wish hashmap_free() did what hashmap_free_entries() did.  So
> annoying and counter-intuitive...

I left some comments in my other reply, but in case you do pursue this:
the obvious thing to have is a free_entries boolean parameter to the
function, so that each caller is clear about what they want. And we used
to have that. But it's awkward because "free the entries" isn't a
boolean anymore; it's "free the entries you can find by moving backwards
to this offset from the hashmap_entry pointer". So callers who don't
want to free them have to pass some sentinel value there. And that's how
we ended up with two separate wrapper functions.

I think your main complaint is just about the naming though. If we had:

  /* drop all entries, freeing any hashmap-specific memory */
  hashmap_clear();

  /* ditto, but also free the entries themselves */
  hashmap_clear_and_free_entires();

that would be a bit more obvious (though I imagine it would still be
easy to forget that "clear" doesn't drop the entries). Another approach
would be to have a flag in the map for "do I own the entry memory". Most
callers are happy to hand off ownership of the entries when they're
added. And it may even be that this would open up the possibility of
more convenience functions on the adding/allocation side. I didn't think
it through carefully, though.

-Peff
