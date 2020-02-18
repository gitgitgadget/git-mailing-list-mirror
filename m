Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA5C34047
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845402173E
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRUYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:24:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:47166 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726352AbgBRUYS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:24:18 -0500
Received: (qmail 20118 invoked by uid 109); 18 Feb 2020 20:24:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 20:24:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22227 invoked by uid 111); 18 Feb 2020 20:33:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 15:33:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 15:24:17 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/15] pack-bitmap: implement BLOB_NONE filtering
Message-ID: <20200218202417.GE21774@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182236.GM150965@coredump.intra.peff.net>
 <800e4714-200e-6256-5538-ef39f6d9246c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <800e4714-200e-6256-5538-ef39f6d9246c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 02:26:53PM -0500, Derrick Stolee wrote:

> On 2/14/2020 1:22 PM, Jeff King wrote:
> > We can easily support BLOB_NONE filters with bitmaps. Since we know the
> > types of all of the objects, we just need to clear the result bits of
> > any blobs.
> > 
> > Note two subtleties in the implementation (which I also called out in
> > comments):
> > 
> >   - we have to include any blobs that were specifically asked for (and
> >     not reached through graph traversal) to match the non-bitmap version
> 
> I have a concern here, but maybe I'm worrying about nothing. When a
> partial clone asks for a pack of missing blobs, will your code create
> an empty bitmap and then add bits to that bitmap one-by-one instead
> of appending to a simple object list?

Yes. They'd all be listed in revs->pending, so we'd add them to our
array of "wants", and then create a bitmap. There's no traversal cost,
but we'd pay the cost to open the bitmap file. But...

> In the typical case where we ask for specific commits and trees, we
> expect a very small number of blobs to add to the resulting bitmap.
> When no commits or trees are included in the wants, then we don't
> need the bitmap at all. IIRC an EWAH bitmap is relatively expensive
> to update bits one at a time, so this is not incredibly efficient.

There's no ewah bitmap at play here at all. The internal bitmap we
create in memory for the walk is a real uncompressed bitmap, so settings
and retrieving bits is pretty cheap.

I'd worry much more about the fact that we had to parse the whole bitmap
file (which for historical format reasons involves actually running over
all of the bytes in the file).

I think that's somewhat orthogonal to this patch, though. The same
pessimality would be true of anybody fetching a couple blobs, whether
they use filters or not (and really, there's no reason that the
follow-up fetch for blobs in a filtered repository would need to use
filters, but for some reason it does).

It would be an easy optimization to say "we have only blobs, don't
bother opening the bitmap file", but I think that should come on top.
However, I have a suspicion that we actually call parse_object() on each
blob before we even get to the bitmap code (via get_reference()). If so,
that's a much larger low-hanging fruit.

> > --- a/t/perf/p5310-pack-bitmaps.sh
> [...]
> 
> I wondered why you chose to extend these tests instead of using
> p5600-partial-clone.sh, but I guess this script definitely creates
> the bitmap for the test. When I tested p5600-partial-clone.sh below,
> I manually repacked the Linux repo to have a bitmap:

Right, when the two features combine, we have to either pick a test
script that hits one or the other, or create a new one. Especially since
this one covers the full and partial bitmap states, I think it's nice to
reuse that work.

> Test                          v2.25.0               HEAD                    
> ----------------------------------------------------------------------------
> 5600.2: clone without blobs   79.81(111.34+11.35)   36.00(69.37+7.30) -54.9%
> 5600.3: checkout of result    45.56(114.59+4.81)    46.43(80.50+5.41) +1.9% 
> 
> Perhaps results for these tests would also be appropriate for your
> commit messages?

I think your p5600.2 is basically the same as what I ended up with
in p5310 for the final commit (when pack-objects finally learns to use
these filters, too). But we want to make sure we are testing with
bitmaps, so I don't think we'd want to count on the sample repo having
bitmaps already.

I think this speaks to the general problems with the perf suite, in that
we probably ought to be testing combinations of repos and tests, rather
than manually creating situations in each script).

> Note the +1.9% for the checkout. It's unlikely that this is actually
> something meaningful, but it _could_ be related to my concerns above
> about building a blob list from an empty bitmap.

In my experience with the perf suite, 2% is most likely noise
(especially for a filesystem-heavy operation like checkout). Note that
the difference in system time covers almost all of the wall-clock time.

It is curious that the user time in your second test dropped so
drastically, but didn't create a wall-clock improvement. I've often seen
weirdness there with the CPU clock changing due to external factors.

-Peff
