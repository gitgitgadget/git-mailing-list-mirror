Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E21C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6751206C3
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgDFSfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:35:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:34762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725787AbgDFSfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 14:35:43 -0400
Received: (qmail 26209 invoked by uid 109); 6 Apr 2020 18:35:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Apr 2020 18:35:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15763 invoked by uid 111); 6 Apr 2020 18:46:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2020 14:46:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Apr 2020 14:35:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fast-import: replace custom hash with hashmap.c
Message-ID: <20200406183542.GA23753@coredump.intra.peff.net>
References: <20200403121508.GA638328@coredump.intra.peff.net>
 <6926f6fe-2e5c-bcbc-fd0a-5b9a70eed06c@web.de>
 <20200405185951.GA1309762@coredump.intra.peff.net>
 <020726d4-5a5c-e751-2824-d05004823326@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <020726d4-5a5c-e751-2824-d05004823326@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 08:07:45PM +0200, René Scharfe wrote:

> > Interesting. I re-ran mine just to double check, and got:
> [...]
> A second run today reported:
> 
> Test                        origin/master         HEAD
> ---------------------------------------------------------------------------
> 9300.1: export (no-blobs)   61.58(59.93+1.40)     60.63(59.35+1.22) -1.5%
> 9300.2: import (no-blobs)   239.64(239.00+0.63)   246.02(245.18+0.82) +2.7%
> 
> git describe says v5.4-3890-g86fd3e9df543 in that repo.

I'm on v5.6-rc7-188-g1b649e0bcae7, but I can't imagine it makes a big
difference.

> Dunno.  My PC has thermal issues and stressing it for half an hour straight
> may cause it to throttle?

Yeah. I wonder what the variance is between the 3 runs (assuming you're
using ./run and doing 3). I.e., is one run in the first set much faster
than the others, and we pick it as best-of-3.

> With Git's own repo I just got this:
> 
> Test                        origin/master       HEAD
> -----------------------------------------------------------------------
> 9300.1: export (no-blobs)   2.58(2.45+0.05)     2.81(2.75+0.05) +8.9%
> 9300.2: import (no-blobs)   10.41(10.37+0.03)   10.75(10.72+0.02) +3.3%

I get similar numbers here. But I wouldn't expect much. We only have
~160k commits+trees in git.git, so the average chain length is ~2.5.

> > I think in practice we won't ever pass NULL, though. Even a
> > hashmap_get() needs to pass in a hashmap_entry with the hash value in
> > it. Though I think that's technically _also_ undefined behavior. If I
> > have a struct where the entry is not at the beginning, like:
> >
> >   struct foo {
> >     const char *bar;
> >     struct hashmap_entry ent;
> >   };
> >
> > then:
> >
> >   e2 = container_of(ptr_to_entry, struct foo, ent);
> >
> > is going to form a pointer at 8 bytes before ptr_to_entry. If it really
> > is a "struct hashmap_entry" on the stack, then it's pointing at garbage.
> >
> > We don't dereference it, so it's likely fine in practice, but even
> > computing such a pointer does violate the standard.
> 
> Really?  If ptr_to_entry was NULL then any pointer arithmetic on it would
> be bad.  If it points to a bare hashmap_entry and we lied to container_of
> by telling it that it's embedded in some other struct then that would be
> bad as well.  But if there actually is a surrounding struct of the
> specified type then the resulting pointer must surely be valid, no matter
> if the object it points to was initialized?  Do you have the relevant
> chapter and verse handy?

Pointing to uninitialized bits is fine according to the standard (and I
think that's what you're asking about for chapter and verse). But we
really do lie to container_of(). See remote.c, for example. In
make_remote(), we call hashmap_get() with a pointer to lookup_entry,
which is a bare "struct hashmap_entry". That should end up in
remotes_hash_cmp(), which unconditionally computes a pointer to a
"struct remote".

Now the hashmap_entry there is at the beginning of the struct, so the
offset is 0 and the two pointers are the same. So while the pointer's
type is incorrect, we didn't compute an invalid pointer value. And
traditionally the hashmap code required that it be at the front of the
containing struct, but that was loosened recently (and container_of
introduced) in 5efabc7ed9 (Merge branch 'ew/hashmap', 2019-10-15).

And grepping around, I don't see any cases where it's _not_ at the
beginning. So perhaps this is a problem waiting to bite us.

> Stuffing the oidhash() result into a variable and using it twice with
> hashmap_entry_init() would work as well.  This would make the reason for
> the duplicate find_object() code obvious, while keeping struct
> hashmap_entry opaque.

I'd prefer not to use a separate variable, as that requires giving it a
type. Perhaps:

  hashmap_entry_init(&e->ent, lookup_entry.hash);

which is used elsewhere is OK? That still assumes there's a hash field,
but I think hashmap has always been pretty up front about that (the real
sin in the original is assuming that nothing else needs to be
initialized).

-Peff
