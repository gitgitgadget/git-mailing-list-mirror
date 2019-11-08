Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714871F454
	for <e@80x24.org>; Fri,  8 Nov 2019 21:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfKHVV5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 16:21:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:43284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732246AbfKHVV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 16:21:57 -0500
Received: (qmail 22885 invoked by uid 109); 8 Nov 2019 21:21:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Nov 2019 21:21:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15329 invoked by uid 111); 8 Nov 2019 21:25:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2019 16:25:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Nov 2019 16:21:56 -0500
From:   Jeff King <peff@peff.net>
To:     Paul van Loon <nospam@cheerful.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [BUG/FEATURE] Git pushing and fetching many more objects than
 strictly required
Message-ID: <20191108212156.GA15365@sigill.intra.peff.net>
References: <bc43c70e-861d-425d-d7c4-73a3e25b7383@cheerful.com>
 <20191108184723.246596-1-jonathantanmy@google.com>
 <e537d298-6431-c36a-2fc3-e41baa10d0a3@cheerful.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e537d298-6431-c36a-2fc3-e41baa10d0a3@cheerful.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 08, 2019 at 09:54:02PM +0100, Paul van Loon wrote:

> >> $ git push -v origin 'refs/replace/*:refs/replace/*'
> >> Pushing to XXXX
> >> Enumerating objects: 2681, done.
> >> Counting objects: 100% (2681/2681), done.
> >> Delta compression using up to 8 threads
> >> Compressing objects: 100% (1965/1965), done.
> >> Writing objects: 100% (2582/2582), 1.96 MiB | 1024 bytes/s, done.
> >> Total 2582 (delta 95), reused 1446 (delta 58)
> >> remote: Resolving deltas: 100% (95/95), completed with 33 local objects.
> >> To XXXX
> >>  * [new branch]            refs/replace/XXXX -> refs/replace/XXXX
> >
> > Could you verify that refs/replace/XXXX (or one of its close ancestors)
> > was fetched by the "git fetch --all" command? "--all" fetches all
> > remotes, not all refs.
> 
> No, it was not fetched. HOWEVER, the ONLY thing the replace commit (1 single object) does is point to an existing parent object. No other new objects are referenced.
> Those 'ancestor' objects were all fetched.

Was it a parent object at the tip of a ref?

The push protocol, unlike the fetch protocol, doesn't expend any effort
to negotiate to find a common base. It just feeds the ref tips of the
receiver to pack-objects (which then does traverse down to a merge base,
but it can't always do so if the sender doesn't have all of the
objects).

It's hard to say more without having a reproducible case to look at.

Some possible things to poke at:

  - record the stdin from the local push to the local pack-objects,
    which shows which objects we're planning to send and which we're
    claiming the other side has. That would help determine if the push
    isn't feeding enough information to pack-objects, or if pack-objects
    isn't trying hard enough to find the minimal set of objects

    There's not really an easy way to do this, but something like strace
    might help.

  - try building reachability bitmaps (e.g., "git repack -adb") in the
    local clone. When those are present, pack-objects will compute the
    object set more thoroughly (because it can do so efficiently).

I don't _think_ the fact that it's in refs/replace should matter to push
(in terms of what it feeds to pack-objects). But obviously another thing
to try is whether pushing to or from a different ref has any impact.

-Peff
