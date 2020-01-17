Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD90C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 19:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420472072B
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 19:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgAQT0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:26:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:39090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726897AbgAQT0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 14:26:11 -0500
Received: (qmail 13006 invoked by uid 109); 17 Jan 2020 19:26:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Jan 2020 19:26:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18988 invoked by uid 111); 17 Jan 2020 19:32:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2020 14:32:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jan 2020 14:26:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] fetch: add --no-update-remote-refs
Message-ID: <20200117192610.GC11358@coredump.intra.peff.net>
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
 <xmqqa76lew1l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa76lew1l.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 11:13:10AM -0800, Junio C Hamano wrote:

> > Add a --[no-]update-remote-refs option to 'git fetch' which defaults
> > to the existing behavior of updating the remote refs. This allows
> > a user to run
> >
> >   git fetch <remote> --no-update-remote-refs +refs/heads/*:refs/hidden/*
> >
> > to populate a custom ref space and download a pack of the new
> > reachable objects.
> 
> Hmph.  I have to wonder if this should have been the default.  That
> is, when refs/heads/X on the remote is configured to be copied to
> refs/remotes/origin/X on this side, and an explicit refspec says it
> should go some other place (i.e. refs/hidden/X), shouldn't that
> automatically bypass configured +refs/heads/*:refs/remotes/origin/*
> refspec?  In any case, it is too late to change that now.

It used to be the default. You can blame 2013-me. ;)

Before that, though, we had people complaining the other way ("I just
fetched from the remote, but my tracking ref is stale!").

> > 3. With fetch.writeCommitGraph enabled, the refs/hidden refs are
> >    used to update the commit-graph file.
> 
> I have a moderately strong suspicion that it would be better to make
> this "--ignore-configured-refspecs" and implemented without special
> casign the "refs/remotes/" hierarchy like the code does by
> hardcoding.

Yeah, I just independently wrote something similar. Your "--refmap"
option can accomplish that already.

> I also wonder if auto-following of tags should be disabled at the
> same time.  I have no good argument either way (yet).

I _didn't_ think of tag auto-following in my other response. That's a
good point. I think he'd probably just want to use "--no-tags" for the
background fetch. You'd end up having to fetch the tag objects
themselves during the "real" fetch, but presumably they're very small
compared to the rest of history.

You could also do:

  git fetch --refmap= <remote> +refs/heads/*:refs/hidden/heads/* +refs/tags/*:refs/hidden/tags/*

to get everything in your pre-fetch (though you actually get more than
the real fetch would need, since by default it won't grab tags which
don't point to otherwise-reachable history).

-Peff
