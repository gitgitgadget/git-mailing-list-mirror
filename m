Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2754EC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008FA20643
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgEOVm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 17:42:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44126 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgEOVm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 17:42:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D18731F55B;
        Fri, 15 May 2020 21:42:57 +0000 (UTC)
Date:   Fri, 15 May 2020 21:42:57 +0000
From:   Eric Wong <e@yhbt.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Caleb Gray <hey@calebgray.com>,
        git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
Message-ID: <20200515214257.GA21855@dcvr>
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
 <20200514210501.GY1596452@mit.edu>
 <20200514211040.a7hrirdzgkphx3la@chatter.i7.local>
 <xmqqr1vmp5wf.fsf@gitster.c.googlers.com>
 <20200514214404.bcbjskgi52bwedlh@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514214404.bcbjskgi52bwedlh@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> On Thu, May 14, 2020 at 02:23:44PM -0700, Junio C Hamano wrote:
> > > I think something like git-caching-proxy would be a neat project, 
> > > because it would significantly improve mirroring for CI deployments 
> > > without requiring that each individual job implements clone.bundle 
> > > prefetching.
> > 
> > What are we improving with such a proxy, though?
> > 
> > Not bandwidth to the client, apparently. 
> 
> Well, if it sits in front of the CI subnet, then it *does* save 
> bandwidth.

Agreed.

> Here's an example with the exact situation we have:
> 
> - the Gerrit server is on the US West Coast
> - the CI builder is on the East Coast
> - each CI job does a full transfer of the multi-MB repo across the 
>   continent, even when cloning shallow
> 
> We solve this by having a local mirror of the repository, but this 
> requires active mirroring to be pre-setup. A caching proxy that could:
> 
> - receive a request for a repository
> - stream the response back to the client
> - cache objects locally
> - use local cache to construct future requests, so only missing objects 
>   are fetched from the remote repo regardless of the haves on the actual 
>   client...

An off-the-shelf HTTP caching proxy (e.g. polipo, Squid) could
do a good enough job with dumb HTTP clones (via GIT_SMART_HTTP=0
env).

With well-packed repos, the dumb HTTP transfer cost shouldn't be
too high (and git 2.10+ got way faster on the client side with
poorly-packed repos, thanks to the Linux kernel-derived list.h).

The occasional full repack on the source git server will
invalidate caches and result in a giant download; but it's
better than no caching at all and doing giant cross-country
transfers all day long.

That said, I'm not sure if any client-side caching proxies can
MITM HTTPS and save bandwidth with HTTPS everywhere, nowadays.
I seem to recall polipo being abandoned because of HTTPS.
Maybe there's a caching HTTPS MITM proxy out there...
