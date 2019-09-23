Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FBB11F463
	for <e@80x24.org>; Mon, 23 Sep 2019 21:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503099AbfIWV2g (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 17:28:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:57588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732345AbfIWV2g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 17:28:36 -0400
Received: (qmail 30412 invoked by uid 109); 23 Sep 2019 21:28:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 21:28:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4484 invoked by uid 111); 23 Sep 2019 21:30:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 17:30:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 17:28:34 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923212834.GA19504@sigill.intra.peff.net>
References: <20190923191509.GC21344@sigill.intra.peff.net>
 <20190923203854.171170-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923203854.171170-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 01:38:54PM -0700, Jonathan Tan wrote:

> I didn't have any concrete ideas so I didn't include those, but some
> unrefined ideas:

One risk to a mentoring project like this is that the intern does a good
job of steps 1-5, and then in step 6 we realize that the whole thing is
not useful, and upstream doesn't want it. Which isn't to say the intern
didn't learn something, and the project didn't benefit. Negative results
can be useful; but it can also be demoralizing.

I'm not arguing that's going to be the case here. But I do think it's
worth talking through these things a bit as part of thinking about
proposals.

>  - index-pack has the CLI option to specify a message to be written into
>    the .promisor file, but in my patch to write fetched refs to
>    .promisor [1], I ended up making fetch-pack.c write the information
>    because I didn't know how many refs were going to be written (and I
>    didn't want to bump into CLI argument length limits). If we had this
>    feature, I might have been able to pass a callback to index-pack that
>    writes the list of refs once we have the fd into .promisor,
>    eliminating some code duplication (but I haven't verified this).

That makes some sense. We could pass the data over a pipe, but obviously
stdin is already in use to receive the pack here. Ideally we'd be able
to pass multiple streams between the programs, but I think due to
Windows support, we can't assume that arbitrary pipe descriptors will
make it across the run-command boundary. So I think we'd be left with
communicating via temporary files (which really isn't the worst thing in
the world, but has its own complications).

>  - In your reply [2] to the above [1], you mentioned the possibility of
>    keeping a list of cutoff points. One way of doing this, as I state in
>    [3], is my original suggestion back in 2017 of one such
>    repository-wide list. If we do this, it would be better for
>    fetch-pack to handle this instead of index-pack, and it seems more
>    efficient to me to have index-pack be able to pass objects to
>    fetch-pack as they are inflated instead of fetch-pack rereading the
>    compressed forms on disk (but again, I haven't verified this).

And this is the flip-side problem: we need to get data back, but we have
only stdout, which is already in use (so we need some kind of protocol).
That leads to things like the horrible NUL-byte added by 83558686ce
(receive-pack: send keepalives during quiet periods, 2016-07-15).

> There are also the debuggability improvements of not having to deal with
> 2 processes.

I think it can sometimes be easier to debug with two separate processes,
because the input to index-pack is well-defined and can be repeated
without hitting the network (though you do have to figure out how to
record the network response, which can be non-trivial). I've also done
similar things for running performance simulations.

We'll still have the stand-alone index-pack command, so it can be used
for those cases. But as we add more features that utilize the in-process
interface, that may eventually stop being feasible.

> > [dropping unpack-objects]
> >     Maybe that would be worth making part of the project?
> 
> I'm reluctant to do so because I don't want to increase the scope too
> much - although if my project has relatively narrow scope for an
> Outreachy project, we can do so. As for eliminating the utility of
> having richer communication, I don't think so, because in the situations
> where we require richer communication (right now, situations to do with
> partial clone), we specifically run index-pack anyway.

Yeah, we're in kind of a weird situation there, where unpack-objects is
used less and less. I wonder how many surprises are lurking where
somebody reasoned about index-pack behavior, but unpack-objects may do
something slightly differently (I know this came up when we looked at
fsck-ing incoming objects for submodule vulnerabilities).

I kind of wonder if it would be reasonable to just always use index-pack
for the sake of simplicity, even if it never learns to actually unpack
objects. We've been doing that for years on the server side at GitHub
without ill effects (I think the unpack route is slightly more efficient
for a thin pack, but since it only kicks in when there are few objects
anyway, I wonder how big an advantage it is in general).

-Peff
