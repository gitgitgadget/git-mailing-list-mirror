Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C9120248
	for <e@80x24.org>; Sat, 20 Apr 2019 03:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfDTDYh (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 23:24:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:35714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725911AbfDTDYh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 23:24:37 -0400
Received: (qmail 10113 invoked by uid 109); 20 Apr 2019 03:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 20 Apr 2019 03:24:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15012 invoked by uid 111); 20 Apr 2019 03:25:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Apr 2019 23:25:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2019 23:24:35 -0400
Date:   Fri, 19 Apr 2019 23:24:35 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5304: add a test for pruning with bitmaps
Message-ID: <20190420032435.GA3559@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
 <49e2aa9b-ff22-a8d1-ba72-1c881ff5fab4@gmail.com>
 <20190418194953.GA15249@sigill.intra.peff.net>
 <20190418200827.GB15249@sigill.intra.peff.net>
 <ba16afb4-25c1-8148-602e-130b0e17fc89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba16afb4-25c1-8148-602e-130b0e17fc89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 19, 2019 at 09:01:50PM -0400, Derrick Stolee wrote:

> > +test_expect_success 'trivial prune with bitmaps enabled' '
> > +	git repack -adb &&
> > +	blob=$(echo bitmap-unreachable-blob | git hash-object -w --stdin) &&
> > +	git prune --expire=now &&
> > +	git cat-file -e HEAD &&
> > +	test_must_fail git cat-file -e $blob
> > +'
> > +
> >  test_done
> 
> This test does cover the 'mark_object_seen()' method, which I tested by
> removing the "!" in the "if (!obj) die();" condition.
> 
> However, my first inclination was to remove the line
> 
> 	obj->flags |= SEEN;
> 
> from the method, and I found that it still worked! This was confusing,
> so I looked for places where the SEEN flag was added during bitmap walks,
> and it turns out that the objects are marked as SEEN by prepare_bitmap_walk().

I think this is only _some_ objects. The full bitmap is created by
reading the on-disk bitmaps, and then filling in any necessary gaps by
doing a traditional traversal. We also set it on tip objects to de-dup
the initial revs->pending list.

Try running t5304 with this:

diff --git a/reachable.c b/reachable.c
index eba6f64e01..7ec73ef43f 100644
--- a/reachable.c
+++ b/reachable.c
@@ -191,6 +191,8 @@ static int mark_object_seen(const struct object_id *oid,
 	if (!obj)
 		die("unable to create object '%s'", oid_to_hex(oid));
 
+	if (!(obj->flags & SEEN))
+		die("seen flag not already there");
 	obj->flags |= SEEN;
 	return 0;
 }

which shows that we are indeed freshly setting SEEN on some objects.

Interestingly, I don't _think_ you can cause an object to get pruned
accidentally here, because:

  1. Any object that will miss its SEEN has to be in the bitmapped pack,
     and not found through normal traversal.

  2. git-prune only removes loose objects, not packed ones.

  3. Loose objects cannot be in the bitmapped pack. Therefore, no object
     can hit both cases (1) and (2).

Even if that were the end of the story, I don't think I'd want to rely
on it here. The post-condition of the function should be that SEEN is
set on all reachable objects, whether bitmaps are used or not. And we do
indeed use this elsewhere:

We'll later call prune_shallow(), which uses SEEN to discard unreachable
entries. I'm not sure it even makes sense to have a shallow repo with
bitmaps, though.  Obviously we're lacking the full graph, but I wouldn't
be surprised if the shallow code quietly pretends that all is well and
we generate bogus bitmaps or something. Or maybe it even mostly works as
long as you don't walk over the shallow cut-points.

mark_reachable_objects() is also used for reflog expiration with
--stale-fix. I tried generating a test that would fail with your patch,
but I think it's not quite possible, because --stale-fix will do a
follow-up walk of the graph to see which objects mentioned in the reflog
we have and do not have. So it doesn't actually break things, it just
makes them slower (because we erroneously fail to mark SEEN things that
it's then forced to walk).

So I don't _think_ your patch actually breaks anything user-visible, but
it's a bit like leaving a live grenade in your living room for somebody
to find.

And I think we are indeed covering lookup_object_by_type(), etc in the
t5304 test I added. So AFAICT all of the new code is covered after that?

-Peff
