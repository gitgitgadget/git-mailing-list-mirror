Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4F420248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfDEAAD (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:00:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:47488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727398AbfDEAAD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:00:03 -0400
Received: (qmail 1926 invoked by uid 109); 5 Apr 2019 00:00:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 00:00:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20770 invoked by uid 111); 5 Apr 2019 00:00:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 20:00:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 20:00:01 -0400
Date:   Thu, 4 Apr 2019 20:00:01 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2] rev-list: exclude promisor objects at walk time
Message-ID: <20190405000001.GA20793@sigill.intra.peff.net>
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9f327d6d8dc5e71eb0039aef3ac76ea16c2adab3.1554417917.git.steadmon@google.com>
 <20190404230759.GA26623@sigill.intra.peff.net>
 <20190404234726.GG60888@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404234726.GG60888@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 04:47:26PM -0700, Josh Steadmon wrote:

> > Did you (or anybody else) have any thoughts on the case where a given
> > object is referred to both by a promisor and a non-promisor (and we
> > don't have it)? That's the "shortcut" I think we're taking here: we
> > would no longer realize that it's available via the promisor when we
> > traverse to it from the non-promisor. I'm just not clear on whether that
> > can ever happen.
> 
> I am not sure either. In process_blob() and process_tree() there are
> additional checks for whether missing blobs/trees are promisor objects
> using is_promisor_object()...  but if we call that we undo the
> performance gains from this change.

Hmm. That might be a good outcome, though. If it never happens, we're
fast. If it does happen, then our worst case is that we fall back to the
current slower-but-more-thorough check. (And I think that happens with
your patch, without us having to do anything further).

> > One other possible small optimization: we don't look up the object
> > unless the caller asked to exclude promisors, which is good. But we
> > could also keep a single flag for "is there a promisor pack at all?".
> > When there isn't, we know there's no point in looking for the object.
> [...]
> I'm not necessarily opposed, but I'm leaning towards the "won't matter
> much" side.
> 
> Where would such a flag live, in this case, and who would be responsible
> for initializing it? I guess it would only matter for rev-list, so we
> could initialize it in cmd_rev_list() if --exclude-promisor-objects is
> passed?

The check is really something like:

  int have_promisor_pack() {
	for (p = packed_git; p; p = p->next) {
		if (p->pack_promisor)
			return 1;
	}
	return 0;
  }

That could be lazily cached as a single bit, but it would need to be
reset whenever we call reprepare_packed_git().

Let's just punt on it for now. I'm not convinced it would actually yield
any benefit, unless we have a partial-clone repo that doesn't have any
promisor packs (but then, I suspect whatever un-partial'd it should
probably be resetting the partial flag in the config).

> > I didn't see any tweaks to the callers, which makes sense; we're already
> > passing --exclude-promisor-objects as necessary. Which means by itself,
> > this patch should be making things faster, right? Do you have timings to
> > show that off?
> 
> Yeah, for a partial clone of a large-ish Android repo [1], we see the
> connectivity check go from >180s to ~7s.

Those are nice numbers. :) Worth mentioning in the commit message, I
think. How does it compare to your earlier patch? I'd hope they're about
the same.

-Peff
