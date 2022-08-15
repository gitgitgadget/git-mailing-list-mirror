Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D035CC00140
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 02:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiHPCfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 22:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiHPCfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 22:35:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21833139E3A
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 15:53:15 -0700 (PDT)
Received: (qmail 28120 invoked by uid 109); 15 Aug 2022 22:53:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Aug 2022 22:53:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16748 invoked by uid 111); 15 Aug 2022 22:53:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Aug 2022 18:53:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Aug 2022 18:53:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrew Olsen <andrew.olsen@koordinates.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] is_promisor_object(): fix use-after-free of tree buffer
Message-ID: <YvrOWY2x19G1jCTK@coredump.intra.peff.net>
References: <CAPJmHpVssKshapGYDF-ifU1fts-jFTC-HqxnjN8meSMP3weB4g@mail.gmail.com>
 <YvS50W6wku5Y/NC7@coredump.intra.peff.net>
 <YviWO9Bhz5PU1HaL@coredump.intra.peff.net>
 <xmqqmtc63wdf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtc63wdf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2022 at 10:32:12PM -0700, Junio C Hamano wrote:

> > We're in the middle of walking through the entries of a tree object via
> > process_tree_contents(). We see a blob (or it could even be another tree
> > entry) that we don't have, so we call is_promisor_object() to check it.
> > That function loops over all of the objects in the promisor packfile,
> > including the tree we're currently walking.
> 
> I forgot that the above "loops over" happens only once to populate
> the oidset hashtable, and briefly wondered if we are being grossly
> inefficient by scanning pack .idx file each time we encounter a
> missing object.  "Upon first call, that function loops over
> ... walking, to prepare a hashtable to answer if any object id is
> referred to by an object in promisor packs" would have helped ;-).

Right. When you have worked in an area, sometimes it is easy to forget
which things are common knowledge and which are not. :) I don't mind at
all if you want to amend the commit message as you apply.

> > It may also be a good direction for this function in general, as there
> > are other possible optimizations that rely on doing some analysis before
> > parsing:
> >
> >   - we could detect blobs and avoid reading their contents; they can't
> >     link to other objects, but parse_object() doesn't know that we don't
> >     care about checking their hashes.
> >
> >   - we could avoid allocating object structs entirely for most objects
> >     (since we really only need them in the oidset), which would save
> >     some memory.
> >
> >   - promisor commits could use the commit-graph rather than loading the
> >     object from disk
> >
> > This commit doesn't do any of those optimizations, but I think it argues
> > that this direction is reasonable, rather than relying on parse_object()
> > and trying to teach it to give us more information about whether it
> > parsed.
> 
> Yeah, all of the future bits sound sensible. 

I very intentionally didn't work on those things yet, because I wanted
to make sure we got a simple fix in as quickly as possible. That said, I
don't have immediate plans for them. They are perhaps not quite small
enough for #leftoverbits, but I think they might also be nice bite-sized
chunks for somebody wanting to get their feet wet in that part of the
code.

-Peff
