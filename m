Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77947208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 12:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdHRMPM (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 08:15:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:42608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750949AbdHRMPL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 08:15:11 -0400
Received: (qmail 5593 invoked by uid 109); 18 Aug 2017 12:15:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 12:15:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1636 invoked by uid 111); 18 Aug 2017 12:15:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 08:15:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2017 08:15:09 -0400
Date:   Fri, 18 Aug 2017 08:15:09 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Revision resolution for remote-helpers?
Message-ID: <20170818121509.fjsmzkdaokyjuaya@sigill.intra.peff.net>
References: <20170818064208.plkppke7efpucuwm@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170818064208.plkppke7efpucuwm@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 03:42:08PM +0900, Mike Hommey wrote:

> I was thinking it could be useful to have a special syntax for revisions
> that would query a helper program. The helper program could use a
> similar protocol to that of the remote helpers.

That sounds like a reasonable thing to want.

> My thought is that a string like <helper>::<revision> could be used
> wherever a committish is expected. That would call some helper
> and request to resolve revision, and the helper would provide a git
> commit as a response.

So I'm guessing this would look something like:

  git log svn::12345

I think even without Git support, you could do something like:

  git log $(git svn map 12345)

which is similarly complex in terms of concepts, and not too many more
characters. That would be a little more awkward outside of a shell,
though.

But it did get me wondering if we could do _better_ with something built
into Git. For example, could we have an external resolution helper that
resolves names to object ids as a fallback after internal resolution has
failed. And then you could do:

 git log 12345

and it would just work. Efficiency shouldn't be a big problem, because
we'd hit the helper only in the error case.

I'd be more concerned about awkward ambiguities, though. If mercurial is
also using sha1s, then there's nothing syntactic to differentiate the
two. For that matter, 12345 has the same problem, since it could be a
partial sha1.

It might work to actually check if we have the object and then bail
to the remote resolver only if we don't. But that's actually conflating
name resolution with object lookup, which our internals typically keep
separate.

So maybe this is a bad direction to go in. I'm mostly just thinking out
loud here.

> Which leads me to think some "virtual" ref namespace could be a solution
> to the problem. So instead of <helper>::, the prefix would be <helper>/.
> For e.g. svn, svn/$remote/$rev would be a natural way to specify the
> revision for a given remote. For mercurial, hg/$sha1.

Interesting. I do like the general idea of having external helpers to
fill in bits of the virtual namespace. But it may also open many cans of
worms. :)

> Potentially, this could be a sort of pluggable ref stores, which could
> be used for extensions such as the currently discussed reftable.

The current pluggable code is definitely geared for build-time
pluggability, not runtime. But I think you could have a builtin
pluggable store that does the overlay, and then chains to another
backend. I.e., configure something like:

  [extensions]
  refBackend = externalOverlay

  [externalOverlay "svn"]
  namespace = refs/svn
  command = my-svn-mapper

  [externalOverlay]
  chain = reftable

That would allow the externalOverlay thing to develop independent of the
core of Git's refs code.

> On the opposite end of the problem, I'm also thinking about git log
> --decorate=<helper> displaying the mercurial revisions where branch
> decorations would normally go.

Interesting thought. I'm not sure if that would be a good thing or a bad
thing. But one of the virtual methods for pluggable backends is
"enumerate all refs". If you're mapping every mercurial revision, that's
going to be a lot of refs (and potentially a lot of overhead for certain
operations).

I think the decorate code just looks at a few parts of the refs
namespace right now (so a "refs/svn" would probably get ignored by
default).

-Peff
