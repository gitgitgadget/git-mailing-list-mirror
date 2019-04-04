Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA66B20248
	for <e@80x24.org>; Thu,  4 Apr 2019 01:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDDBdq (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 21:33:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:46222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726167AbfDDBdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 21:33:46 -0400
Received: (qmail 18330 invoked by uid 109); 4 Apr 2019 01:33:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 01:33:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13143 invoked by uid 111); 4 Apr 2019 01:34:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 21:34:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 21:33:44 -0400
Date:   Wed, 3 Apr 2019 21:33:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     steadmon@google.com, git@vger.kernel.org
Subject: Re: [PATCH] clone: do faster object check for partial clones
Message-ID: <20190404013343.GA4409@sigill.intra.peff.net>
References: <20190403194150.GA27199@sigill.intra.peff.net>
 <20190403205748.107979-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403205748.107979-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 01:57:48PM -0700, Jonathan Tan wrote:

> > This isn't strictly true, since we could get objects from elsewhere via
> > --shared or --reference. Those might not be promisor objects.
> 
> I don't think local clones (which --shared or --reference implies) can
> be partial, but the bigger point is below.

Yeah, you're right about --shared. But I don't see any reason a
--reference clone could not be partial.

> > So it seems like this should be a feature of the child rev-list, to stop
> > walking the graph at any object that is in a promisor pack.
> 
> We currently already do a less optimal version of this - we pass
> --exclude-promisor-objects to rev-list, which indeed stops traversal at
> any promisor objects (whether in a promisor pack or referenced by one).
> As far as I know, the problem is that to do so, we currently enumerate
> all the objects in all promisor packs, and all objects that those
> objects reference (which means we inflate them too) - so that we have an
> oidset that we can check objects against.
> 
> A partial solution is for is_promisor_object() to first check if the
> given object is in a promisor pack, avoiding generating the set of
> promisor objects until necessary. This would work in a blob:none clone
> with the refs pointing all to commits or all to blobs, but would not
> work in a tree:none clone (or maybe, in this case, the clone would be
> small enough that performance is not a concern, hmm).
> 
> Maybe the ideal solution is for rev-list to check if an object is in a
> promisor pack and if --exclude-promisor-objects is active, we do not
> follow any outgoing links.

I was thinking you could actually check it before even loading the
object. I.e., something like:

  struct object_info oi = OBJECT_INFO_INIT;

  if (!oid_object_info_extended(oid, &oi, 0) &&
      oi->whence = OI_PACKED &&
      oi->u.packed.pack->pack_promisor)) {
          /*
	   * no point in even looking at its links,
	   * since the promisor pack claims that we
	   * can get anything we need later from the
	   * remote
	   */
     return 0; /* or whatever, depending where this goes ;) */
  } else {
    /* not a promisor object, load it and traverse as normal */
  }

That doesn't quite work as an implementation of is_promisor_object(),
because it wouldn't know about items that we _don't_ have that are
promised. But I think it could work as part of the traversal in
list-objects.c, since we'd just be walking down a traversal from which
we presumably have all the objects.

I guess maybe it would be complicated if you had non-promisor objects
that refer indirectly to promisor ones. E.g., imagine ref A points to
object X, which is in a promisor pack pointing to Y (which we don't
have). But we also have ref B pointing to object Z which also refers to
Y, but _isn't_ in a promisor pack. I'm not sure that can actually happen
with the promisor mechanism, though (how did we get a Z without all of
its objects into a non-promisor pack?).

It's also a shame that it would incur an extra object lookup, since if
it _isn't_ in the promisor pack we'd then have to actually look it up
again via parse_object() or whatever. It may not be measurable though.
In an ideal world, we'd have an object access API that lets us open a
handle, ask things about it (like "which pack is this coming from") and
then load it if we want. But I don't think that needs to hold up this
particular topic.

-Peff
