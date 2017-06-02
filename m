Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8C12027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdFBWQt (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:16:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:34139 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBWQs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:16:48 -0400
Received: (qmail 6683 invoked by uid 109); 2 Jun 2017 22:16:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 22:16:48 +0000
Received: (qmail 32110 invoked by uid 111); 2 Jun 2017 22:17:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 18:17:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 18:16:45 -0400
Date:   Fri, 2 Jun 2017 18:16:45 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [WIP v2 0/2] Modifying pack objects to support --blob-max-bytes
Message-ID: <20170602221645.nsz6r6tgfndulc6c@sigill.intra.peff.net>
References: <cover.1496361873.git.jonathantanmy@google.com>
 <cover.1496432147.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1496432147.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 12:38:43PM -0700, Jonathan Tan wrote:

> > Do we need to future-proof the output format so that we can later
> > use 32-byte hash?  The input to pack-objects (i.e. rev-list --objects)
> > is hexadecimal text, and it may not be so bad to make this also
> > text, e.g. "<hash> SP <length> LF".  That way, you do not have to
> > worry about byte order, hash size, or length limited to uint64.
> 
> The reason for using binary is for the convenience of the client to
> avoid another conversion before storing it to disk (and also network
> savings). In a large repo, I think this list will be quite large. I
> realized that I didn't mention anything about this in the commit
> message, so I have added an explanation.
> 
> I think this is sufficiently future-proof in that the format of this
> hash matches the format of the hashes used in the objects in the
> packfile. As for object size being limited to uint64, I think the
> benefits of the space savings (in using binary) outweigh the small risk
> that our files will get larger than that before we upgrade our protocol
> :-P

The rest of the pack code uses a varint encoding which is generally
much smaller than a uint64 for most files, but can handle arbitrary
sizes.

The one thing it loses is that you wouldn't have a fixed-size record, so
if you were planning to dump this directly to disk and binary-search it,
that won't work. OTOH, you could make pseudo-pack-entries and just
index them along with the rest of the objects in the pack .idx.

The one subtle thing there is that the pseudo-entry would have to say
"this is my sha1". And then we'd end up repeating that sha1 in the .idx
file. So it's optimal on the network but wastes 20 bytes on disk (unless
index-pack throws away the in-pack sha1s as it indexes, which is
certainly an option).

> > Can this multiplication overflow (hint: st_mult)?
> 
> Thanks - used st_mult.

Actually, I think this is a good candidate for ALLOC_ARRAY().

> > This sorting is a part of external contract (i.e. "output in hash
> > order" is documented), but is it necessary?  Just wondering.
> 
> It is convenient for the client because the client can then store it
> directly and binary search when accessing it. (Added a note about
> convenience to the commit message.)

In general the Git client doesn't trust the pack data coming from a
remote, and you can't corrupt a client by sending it bogus data. Either
the client computes it from scratch (e.g., the sha1s of each object) or
the client will reject nonsense (missing bases, refs pointing to objects
that aren't sent, etc).

I know this feature implies a certain amount of trust (after all, the
server could claim that it omitted any sha1 it likes), but we should
probably still be as strict as possible that what the other side is
sending makes sense. In this case, we should probably hashcmp() each
entry with the last and make sure they're strictly increasing (no
out-of-order and no duplicates).

-Peff
