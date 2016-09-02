Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48E41FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 23:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbcIBXfw (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 19:35:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37305 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753207AbcIBXfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 19:35:51 -0400
Received: (qmail 1628 invoked by uid 109); 2 Sep 2016 23:35:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 23:35:50 +0000
Received: (qmail 30096 invoked by uid 111); 2 Sep 2016 23:35:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 19:35:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 19:35:47 -0400
Date:   Fri, 2 Sep 2016 19:35:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org,
        sbeller@google.com
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
Message-ID: <20160902233547.mzgluioc7hhabalw@sigill.intra.peff.net>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1472853827.git.jonathantanmy@google.com>
 <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 03:06:12PM -0700, Jonathan Tan wrote:

> The cause is that, since v3.1.0.201309270735-rc1~22 (Advertise capabilities
> with no refs in upload service., 2013-08-08), JGit's ref advertisement includes
> a ref named capabilities^{} to advertise its capabilities on, while git's ref
> advertisement is empty in this case. This allows the client to learn about the
> server's capabilities and is needed, for example, for fetch-by-sha1 to work
> when no refs are advertised.

So does JGit actually have a fetch-by-sha1 that works in such a case
(obviously the repository has to have _some_ objects, so is this a
feature where the server hides some of the refs?).

I was thinking we did not have one in git (i.e., we have nothing to
allow fetching arbitrary sha1s). But combining hideRefs with
allowTipSHA1InWant could trigger this case.

> This also affects "ls-remote". For example, against an empty repository served
> by JGit:
> 
> 	$ git ls-remote git://localhost/tmp/empty
> 	0000000000000000000000000000000000000000        capabilities^{}
> 
> Git advertises the same capabilities^{} ref in its ref advertisement for push
> but since it never remembered to do so for fetch, the client forgot to handle
> this case. Handle it.

As you can probably guess from my previous emails in this thread, I
don't think it is "never remembered to do so". It is more like "never
intended to do so and was documented incorrectly".

That doesn't make things clear cut, of course. But I think the real
story is more like (I dug a little in the history, as you'll see, but
didn't look for conversations in the list archive, so take this with the
appropriate grain of salt):

  0. Upload-pack existed without this capabilities^{} trick for some time.

  1. Receive-pack learned the capabilities^{} trick, and send-pack on
     the client side learned to accept it (this looks like it came along
     with the first capability in cfee10a (send-pack/receive-pack: allow
     errors to be reported back to pusher., 2005-12-25).

  2. Later, b31222c (Update packfile transfer protocol documentation,
     2009-11-03) tried to document the upload-pack and receive-pack
     protocols, but mistakenly documented both as having
     capabilities^{}.

  3. In ae1f469 (Advertise capabilities with no refs in upload service.,
     2013-08-08), JGit started sending these in its upload-pack
     equivalent, according to the documentation from (3).

So now we are in a state where JGit behavior does not match Git
behavior. Since JGit versions have existed in the wild for a few years,
it's a good idea for all clients to be liberal and accept both cases.

> In this aspect, JGit is compliant with the specification in pack-protocol.txt.
> Because git client versions without this fix are expected to exist in the wild
> for a while, we should not change the server to always send the capabilities^{}
> line when there are no refs to advertise yet.  A transition will take multiple
> steps:
> 
>  1. This patch, which updates the client
> 
>  2. Update pack-protocol to clarify that both server behaviors must be
>     tolerated.

These two seem like obvious improvements.

>  3. Add a configuration variable to allow git upload-pack to advertise
>     capabilities when there are no refs to advertise.  Leave it disabled
>     by default since git clients can't be counted on to have this patch (1)
>     yet.
> 
>  4. After a year or so, flip the default for that server configuration
>     variable to true.

I think "a year or so" is not nearly long enough, as this is not a
backwards-compatible change. The only thing that mitigates it is that an
older client doesn't barf totally, but just generates funny output.

I'd be more interested in the pain of this transition if there was a
concrete use case for "hide literally all refs, but still allow
fetches". Is that a thing that people do?

-Peff
