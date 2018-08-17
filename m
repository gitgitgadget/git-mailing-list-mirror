Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650E31F404
	for <e@80x24.org>; Fri, 17 Aug 2018 01:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbeHQEtW (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 00:49:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:58278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725756AbeHQEtW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 00:49:22 -0400
Received: (qmail 29352 invoked by uid 109); 17 Aug 2018 01:48:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 01:48:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20887 invoked by uid 111); 17 Aug 2018 01:48:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 21:48:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 21:47:58 -0400
Date:   Thu, 16 Aug 2018 21:47:58 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Syncing HEAD
Message-ID: <20180817014757.GA17048@sigill.intra.peff.net>
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
 <20180814210616.GA32367@sigill.intra.peff.net>
 <20180814214723.GA667@sigill.intra.peff.net>
 <CAP8UFD3S5vgMSuXfj1z0F7f-9SLVEm6boCHwdNwn7ysvXSRMrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3S5vgMSuXfj1z0F7f-9SLVEm6boCHwdNwn7ysvXSRMrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 07:49:25AM +0200, Christian Couder wrote:

> > And so here the convention is simpler, because we're talking about the
> > main HEAD. But we still have know if you want to do that, and not update
> > some refs/remotes/ symref in a bare repo.
> 
> We could maybe look at the "remote.XXX.mirror" config option. If it is
> set to "true", we could interpret that as meaning we are interested in
> updating the main HEAD and not some refs/remotes/ symref.

Yeah, for the mirror case I think that would be sufficient, and that's a
subset of the larger problem. I'm not _totally_ opposed to solving just
this narrow case, but I think it would be great if we could solve the
larger problem.

> >   # or the same thing but using the usual refspec "dst defaults to src"
> >   # rule and dwim lookup magic
> >   git fetch origin ~LATEST
> 
> And `git fetch origin ~HEAD` would sync the main HEAD?

Yes, exactly.

> I wonder though if we should restrict the way `git fetch origin ~XXX`
> searches the .git/ directory itself.

The matching is done against the list of refs that the remote
advertises. So everything is under refs/ except for HEAD. If you tried
to do something funky with top-level refs like:

  git fetch origin ~MERGE_HEAD

it would always come up with "couldn't find remote ref MERGE_HEAD".

> I wonder what `git fetch origin ~refs/heads/*:refs/heads/*` should do.
> Could it know which refs are symrefs using protocol v0? Should it
> guess that refs with uppercase names are symrefs? Should we allow '*'
> at all in those kinds of refspecs?

That's an interesting question. I'd be tempted to say that it is an
error to use "~" with a wildcard ref, at least for the first version of
the patch. That way we don't back ourselves into a corner, and can make
it do something useful later.

I think one sane set of rules is:

 - for protocol v2+, where we know which remote refs are symrefs,
   transfer them as symrefs

 - for protocol v0, either transfer them as normal refs (except HEAD,
   which we always suspect of being a symref), or simply declare it
   an error

For the most part, though, I think people would be fine without
combining wildcards with the symref feature, and would just do:

  +refs/*:refs/*
  ~HEAD:HEAD

for a bare mirror, and:

  +refs/heads/*:refs/remotes/origin/*
  ~HEAD:refs/remotes/origin/HEAD

for an auto-updating non-bare remote.

> It looks like making "~" the magic character for "just the symrefs"
> might be a good solution in the end, though we might want to restrict
> it to protocol v2.
> So perhaps something like `git fetch --update-head` that you suggest
> in another email would be a good solution for now and for protocol v0.

You still have the problem with --update-head of where to store the
result. I think the semantics for a non-wildcard "~" are clear enough,
even with protocol v0, that it would be OK to start down that road.

A few final thoughts:

 - I like the look of "~", but there are not very many characters
   disallowed in refs, and we're using one of them. Another notable one
   is "^", from which we've built the "^{foo}" syntax elsewhere. So this
   could be something like "^{symref}HEAD:HEAD", which leaves room for
   new "^{}" types in the future. But man, that looks really ugly
   compared to "~HEAD:HEAD".

 - Is there a case for a symref update where we'd want to require a
   force-push? Maybe if the local side exists and is not already a
   symref?

 - What do we do if the other side isn't a symref (e.g., a detached
   HEAD)? Is that an error? Do we detach ourselves? Does it require a
   force?

-Peff
