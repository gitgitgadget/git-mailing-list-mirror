Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E4C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AEE604E9
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbhJ0Lmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:42:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:47916 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhJ0Lmi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 07:42:38 -0400
Received: (qmail 13144 invoked by uid 109); 27 Oct 2021 11:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 11:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22089 invoked by uid 111); 27 Oct 2021 11:40:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 07:40:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 07:40:12 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] config: include file if remote URL matches a glob
Message-ID: <YXk6nLJTZn1ilsf6@coredump.intra.peff.net>
References: <YWYafdpemaiAjvUV@coredump.intra.peff.net>
 <20211013183341.85761-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013183341.85761-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 13, 2021 at 11:33:41AM -0700, Jonathan Tan wrote:

> > But in general, I'd imagine most people put their repository in ~/work
> > or similar, and just do:
> > 
> >   [includeIf "gitdir:~/work"]
> >   path = foo.conf
> > 
> > (and of course you can imagine more subdivisions as necessary). So I
> > find the use-case only sort-of compelling. In general, I'm in favor of
> > adding new includeIf directions even if they're only moderately
> > convenient. But this one is rather sticky, because it is dependent on
> > other config keys being defined. So it introduces a new and complicated
> > ordering issue. Is it worth it? Maybe I'm not being imaginative enough
> > in seeing the use cases.
> 
> My main use case is for a remote repo administrator to offer a
> recommended config to anyone who clones that repo. For this, I don't
> think we can prescribe a local directory structure (e.g. "~/work")
> without being too restrictive or broad (that is, if the user ends up
> creating a repo that so happens to match our glob but did not intend the
> config to apply to it).

Yeah, I agree that it's not quite as turnkey if you have to assume
something about the user's directory structure. On the other hand, they
have to decide to put the included config file somewhere, too, so it
seems like you need to give the user "do something like this"
instructions rather than purely something they can copy and paste.

I dunno. I guess you can assume they'll put it in ~/.gitconfig-foo or
similar, and come up with copy-and-pastable directions from that.

I agree that the "match the remote" rule makes things _more_ convenient.
Mostly I was just wondering if it changed things enough to merit the
complications it introduces. I'm not sure I have an answer, and clearly
it's pretty subjective.

> > Just brainstorming some alternatives:
> > 
> >   - We could stop the world while we are parsing and do a _new_ parse
> >     that just looks at the remote config (in fact, this is the natural
> >     thing if you were consulting the regular remote.c code for the list
> >     of remotes, because it does its own config parse).
> > 
> >     That does mean that the remote-conditional includes cannot
> >     themselves define new remotes. But I think that is already the case
> >     with your patch (and violating that gets you into weird circular
> >     problems).
> 
> Hmm...yes, having a special-case rule that such an included file cannot
> define new remotes would be complex.

I think that's mostly true of your "defer" system, too, unless you keep
applying it recursively. The rule is slightly different there: it's not
"you can't define new remotes", but rather "you can't do a
remote-conditional include based on a remote included by
remote-conditional".

> >   - We could simply document that if you want to depend on conditional
> >     includes based on a particular remote.*.url existing, then that
> >     remote config must appear earlier in the sequence.
> > 
> >     This is a bit ugly, because I'm sure it will bite somebody
> >     eventually. But at the same time, it resolves all of the weird
> >     timing issues, and does so in a way that will be easy to match if we
> >     have any other config dependencies.
> 
> My main issue with this is that different config files are read at
> different times, and the repo config (that usually contains the remote)
> is read last.

Ah, right. I was thinking of the definitions within a single file, but
you're right that the common case would be having the include in
~/.gitconfig, and the remotes defined in $GIT_DIR/config. So yeah, any
ordering constraint like that is a non-starter, I'd think.

-Peff
