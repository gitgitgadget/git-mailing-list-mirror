Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D311F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 06:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406333AbfJQGKl (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:10:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:50470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2406095AbfJQGKk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:10:40 -0400
Received: (qmail 20673 invoked by uid 109); 17 Oct 2019 06:10:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 06:10:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6129 invoked by uid 111); 17 Oct 2019 06:13:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 02:13:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 02:10:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     stolee@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] send-pack: never fetch when checking exclusions
Message-ID: <20191017061038.GA10543@sigill.intra.peff.net>
References: <20191011161504.GB19741@sigill.intra.peff.net>
 <20191011220822.154063-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011220822.154063-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 03:08:22PM -0700, Jonathan Tan wrote:

> > As a general rule (and why I'm raising this issue in reply to Jonathan's
> > patch), I think most or all sites that want OBJECT_INFO_QUICK will want
> > SKIP_FETCH_OBJECT as well, and vice versa. The reasoning is generally
> > the same:
> > 
> >   - it's OK to racily have a false negative (we'll still be correct, but
> >     possibly a little less optimal)
> > 
> >   - it's expected and normal to be missing the object, so spending time
> >     double-checking the pack store wastes measurable time in real-world
> >     cases
> 
> I took a look on "next" and it's true for these reasons in most cases
> but not all.

Thanks for digging into this.

> QUICK implies SKIP_FETCH_OBJECT:
> 
>   fetch-pack.c: Run with fetch_if_missing=0 (from builtin/fetch.c,
>   builtin/fetch-pack.c, or through a lazy fetch) so OK.
>   
>   builtin/index-pack.c: Run with fetch_if_missing=0, so OK.
>   
>   builtin/fetch.c: Run with fetch_if_missing=0, so OK.
>   
>   object-store.h, sha1-file.c: Definition and implementation of this
>   flag.

Right, I think going in this direction is pretty simple. Having been
marked with QUICK, they hit both of my points from above. And if we want
to avoid re-scanning the pack directory because of cost, we _definitely_
want to avoid making an expensive network call.

> Everything is OK here. Now, SKIP_FETCH_OBJECT implies QUICK:
> 
>   cache-tree.c: I added this recently in f981ec18cf ("cache-tree: do not
>   lazy-fetch tentative tree", 2019-09-09). No problem with a false
>   negative, since we know how to reconstruct the tree. OK.
> [...]
>   send-pack.c: This patch (which is already in "next"). If we have a
>   false negative, we might accidentally send more than we need. But that
>   is not too bad.

Yeah, I think both of these could be QUICK.

>   promisor-remote.c: This is the slightly tricky one. We use this
>   information to determine if we got our lazily-fetched object from the
>   most recent lazy fetch, or if we should continue attempting to fetch the
>   given object from other promisor remotes; so this information is
>   important. However, adding QUICK doesn't lose us anything because the
>   lack of QUICK only helps us when there is another process packing
>   loose objects: if we got our object, our object will be in a pack
>   (because of the way the fetch is implemented - in particular, we need
>   a pack because we need the ".promisor" file).
> 
> So everything is OK except for promisor-remote.c, but even that is OK
> for another reason.

Yeah, though I wouldn't be sad to see that use a separate flag, since it
really is about promisor logic.

That implies to me maybe we should be using QUICK more aggressively, and
QUICK should auto-imply SKIP_FETCH_OBJECT.

> Having said that, perhaps we should consider promisor-remote.c as
> low-level code and expect it to know that objects are fetched into a
> packfile (as opposed to loose objects), so it can safely use QUICK
> (which is documented as checking packed after packed and loose). If no
> one disagrees, I can make such a patch after jt/push-avoid-lazy-fetch is
> merged to master (as is the plan, according to What's Cooking [1]).

I think it's OK to continue leaving out QUICK there if it's not causing
problems. It really is a bit different than the other cases.

-Peff
