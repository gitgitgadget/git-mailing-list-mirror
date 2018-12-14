Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E2920A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 08:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeLNIfK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 03:35:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:41710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726494AbeLNIfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 03:35:10 -0500
Received: (qmail 21785 invoked by uid 109); 14 Dec 2018 08:35:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Dec 2018 08:35:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1355 invoked by uid 111); 14 Dec 2018 08:34:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Dec 2018 03:34:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2018 03:35:08 -0500
Date:   Fri, 14 Dec 2018 03:35:08 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bwilliamseng@gmail.com
Subject: Re: [PATCH 0/3] protocol v2 and hidden refs
Message-ID: <20181214083507.GB11777@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181213195305.249059-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213195305.249059-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 11:53:05AM -0800, Jonathan Tan wrote:

> >     I don't know if there's a good solution. I tried running the whole
> >     test suite with v2 as the default. It does find this bug, but it has
> >     a bunch of other problems (notably fetch-pack won't run as v2, but
> >     some other tests I think also depend on v0's reachability rules,
> >     which v2 is documented not to enforce).
> 
> I think Aevar's patches (sent after you wrote this) is a good start, and
> I have started looking at it too.

Yeah, I'm excited to see it working with fetch-pack, as the current
behavior is to complain if you've tried to enable v2 config:

  $ git config protocol.version 2
  $ git fetch-pack git://github.com/git/git
  fatal: support for protocol v2 not implemented yet

I haven't actually run into it in the real world, but somebody might if
they have scripted around fetch-pack and are experimenting with v2. A
much friendlier behavior would be falling back to v1, but actually
supporting v2 is better still. :)

> >   - The "serve" command is funky, because it has no concept of whether
> >     the "ls-refs" is for fetching or pushing. Is git-serve even a thing
> >     that we want to support going forward?  I know part of the original
> >     v2 conception was that one would be able to just connect to
> >     "git-serve" and do a number of operations. But in practice the v2
> >     probing requires saying "I'd like to git-upload-pack, and v2 if you
> >     please". So no client ever calls git-serve.
> > 
> >     Is this something we plan to eventually move to? Or can it be
> >     considered a funny vestige of the development? In the latter case, I
> >     think we should consider removing it.
> 
> Personally, I lean towards removing it, but there are arguments on both
> sides. In particular, removing "serve" means that both developers and
> users of Git need not be concerned with a 3rd endpoint, but preserving
> "serve" (and planning to migrate away from "upload-pack" and
> "receive-pack") means that we will only have one endpoint, eliminating
> confusion about which endpoint to use when making certain requests (when
> we add requests other than "fetch" and "push").

Yeah, at first glance I like the simplicity of a unified model. But the
separate fetch/push endpoints have been useful in the past. Separate
uploadpack/receive.hiderefs that I dealt with here are one form. Another
is that many people do HTTP access control using the endpoints. For
example, if I have a repo which is public-read and private-write, the
config we recommend in git-http-backend(1) is to lock down the
receive-pack access using webserver config.

If all the webserver sees is "somebody wants to connect to git-serve",
it doesn't know if it should be challenging them for authentication or
not. It would have to start peeking into the git-serve conversation to
see what the client actually wants to do. That's _possible_ to do, but
it gets pretty awkward with existing webserver tools (whereas matching
the URI endpoint is pretty easy).

Ditto for locked down ssh sessions like git-shell (or custom solutions
like gitolite). Right now we can "git-upload-pack is OK on this repo,
git-receive-pack is not". But blindly running "git serve" would be
dangerous. In this case I think we have a few more options, because the
user has always already authenticated. So we can just tell "git serve"
via the environment whether the user is authorized for push. It's harder
with HTTP because most setups avoid even challenging for auth unless
it's necessary.

So I'm a bit worried that the unified endpoint model is going to be a
dead end, at which point carrying around git-serve just makes things
more complicated.

-Peff
