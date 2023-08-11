Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54E8C001DE
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 18:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHKSKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbjHKSJr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 14:09:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE3D35A2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:09:33 -0700 (PDT)
Received: (qmail 29150 invoked by uid 109); 11 Aug 2023 18:09:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 18:09:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28670 invoked by uid 111); 11 Aug 2023 18:09:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 14:09:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 14:09:32 -0400
From:   Jeff King <peff@peff.net>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org
Subject: Re: Fetching too many tags?
Message-ID: <20230811180932.GB2816191@coredump.intra.peff.net>
References: <274ec1a2152b0fd53b35c1591f5177e0b0713430@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <274ec1a2152b0fd53b35c1591f5177e0b0713430@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 06:08:34AM +0000, Ronan Pigott wrote:

> I am interested in git performance today and can't figure out what's going on
> here. I was wondering why my git-fetch might be slow in an up-to-date repo:
> 
>   $ git pull
>   Already up to date.
>   $ time git fetch origin master
>   From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
>    * branch                      master     -> FETCH_HEAD
>   git fetch origin master  0.13s user 0.06s system 10% cpu 1.705 total
> 
> GIT_TRACE_CURL shows it spends most of the time transfering (all) tags from the
> remote. It's much faster with --no-tags:
> 
>   $ time git fetch -n origin master
>   From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
>    * branch                      master     -> FETCH_HEAD
>   git fetch -n origin master  0.11s user 0.03s system 36% cpu 0.383 total
> 
> But I don't have tagOpt set:
> 
>   $ git config remote.origin.tagOpt || echo $?
>   1
> 
> And the remote doesn't have to send me any commits, so I don't see why I should
> receive any tags at all. Why might I be receiving so many tags?

You didn't define "receiving tags", but I assume you just mean that you
saw the tag names and object ids in the trace output. From the output
above, it looks like no actual tag objects were transferred.

And the answer, then, is that this is how the Git protocol works. The
server says "here are all the refs I know about", then the client
decides what it wants from that list and asks the server to send the
necessary objects, after which it updates its local refs.

So the server will necessarily send all of the tags. Only the client
knows what it already has and whether any of them are new. And in the
default mode, which will fetch tags that point to commits we have, it is
checking each such new tag to see if it is worth fetching. Even if we
did not fetch new commits, we might see new tags that point to existing
commits.

When you use "--no-tags", that explicitly says "do not bother with tags
at all". Recent versions of Git have a protocol extension where the
client can say "I am only interested in refs/heads/master; don't bother
telling me about other stuff". Since the client knows we do not care
about tags, it can use that extension to get a much smaller ref
advertisement from the server.

-Peff
