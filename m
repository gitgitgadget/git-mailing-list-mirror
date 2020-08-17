Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF8C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87460204EC
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391658AbgHQSs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:48:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:33232 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391655AbgHQSsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:48:23 -0400
Received: (qmail 5889 invoked by uid 109); 17 Aug 2020 18:48:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 18:48:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19769 invoked by uid 111); 17 Aug 2020 18:48:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 14:48:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 14:48:21 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] clear_pattern_list(): clear embedded hashmaps
Message-ID: <20200817184821.GA1278968@coredump.intra.peff.net>
References: <20200814111049.GA4101811@coredump.intra.peff.net>
 <CABPp-BGrxaY-ObzuJ60TDMfQD+crq+TTnYE03T=KVmG5mEf-5A@mail.gmail.com>
 <CABPp-BGUBPJCW3-GrVvom5CwfauY-m5ZCLJmKP=P=fXWm=Kepg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGUBPJCW3-GrVvom5CwfauY-m5ZCLJmKP=P=fXWm=Kepg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 10:22:27AM -0700, Elijah Newren wrote:

> > > +       hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
> > > +       hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);
> >
> > This clears up the hash entries, but continues to leak the hash table.
> > Since you submitted first, can you fix this to use hashmap_free_()
> > instead, as per
> > https://lore.kernel.org/git/932741d7598ca2934dbca40f715ba2d3819fcc51.1597561152.git.gitgitgadget@gmail.com/?
> >  Then I'll rebase my series on yours and drop my first patch (since
> > it'll then be identical).
> 
> Nevermind, I got confused once again by the name.
> hashmap_free_entries() doesn't mean just free the entries, it means
> free what hashmap_free() would plus all the entries, i.e. do what
> hashmap_free() *should* *have* *been* defined to do.  Such a confusing
> API.  And hashmap_free() really perplexes me -- it seems like a
> function that can't possibly be useful; it's sole purpose seems to be
> a trap for the unwary.

There used to be an "also free entries" flag, but that got complicated
by the loosening of the "hashmap_entry must be at the front of the
struct to be freed" rule.

With this kind of embedded-entry data structure (and list.h is in the
same boat) it _is_ sometimes useful to be part of a data structure
without giving up ownership of the memory. But I agree that the more
normal case is to free items when the hashmap is destroyed.

Likewise, the whole "you have to define a struct that contains the map
entry" thing is flexible and efficient, but a pain to use.

I generally find khash's "map this type to that type, the hash owns the
memory" much more natural. And it doesn't lose efficiency (and indeed
sometimes even gains it) because it uses macros to store concrete types.
But of course macros create their own headaches. :)

Anyway, I'm definitely open to renaming to something more sensible. I
already mentioned the free/clear thing earlier, but
hashmap_clear_entries() ends up _very_ confusing. Because it's clearing
the hashmap but freeing the entries. hashmap_clear_and_free_entries() is
kind of long, but a lot more descriptive.

-Peff
