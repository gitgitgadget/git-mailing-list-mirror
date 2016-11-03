Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27EE2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 14:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbcKCOiK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 10:38:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:38013 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbcKCOiK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 10:38:10 -0400
Received: (qmail 25363 invoked by uid 109); 3 Nov 2016 14:38:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 14:38:09 +0000
Received: (qmail 12689 invoked by uid 111); 3 Nov 2016 14:38:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 10:38:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 10:38:07 -0400
Date:   Thu, 3 Nov 2016 10:38:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161103002225.GA13369@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 05:22:25PM -0700, Jonathan Nieder wrote:

> Another difficulty with setting GIT_ALLOW_PROTOCOL globally is that it
> requires copy/pasting the default value from upstream and then adding
> the values I want.  There's no straightforward way to get the current
> value and add to it, in case I want to benefit from future upstream
> fixes to the default list.

I agree that this is a big drawback of the current scheme, and it would
be nice to be able to say "also allow".

> That is, would it be possible to use something like
> 
> 	[protocol "sso"]
> 		allow = always
> 
> instead of
> 
> 	[core]
> 		allowProtocol = file:git:http:https:....:sso
> 
> ?

One complication is that the whitelist has multiple states:

  1. if it's not used at all, anything goes

  2. if it exists and has zero or more entries, only those entries are
     allowed

And then submodules are an exception to (1), because it's not anything
goes. It's "this default safe whitelist".

So when does protocol.sso.allow kick in? We wouldn't want it to trigger
case (2) for things like fetch (disabling other non-allowed protocols).
Nor do I think we'd only want it for the submodule case, as I would
assume that "protocol.sso.allow = false" should disable it.

So I think this probably needs to be a separate parallel system where
each protocol can be white- or black-listed in a context-specific way.
Like:

  protocol.X.allow = always | user | never

Where "user" specifies that the protocol is OK coming directly from the
user, but not from other sources.  And we default known-common-and-good
ones like protocol.http.allow to "always", unknown ones (like "foo"
which runs "remote-foo") to "user"), and possibly known-scary ones like
"ext") to "never".

Then we need some way of telling git "you are in a context where the URL
parameter is not coming from the user". Probably via the environment in
GIT_PROTOCOL_FROM_USER or similar. Which git-submodule would sent when
recursing clones, along with things like "go get".

In other words, stop asking git-submodule or "go get" to specify policy,
and let them specify context that can be used to implement policy that
the user specifies (and have git provide a sane default policy).

I think this would all take a backseat to GIT_ALLOW_PROTOCOL, for
backwards compatibility, and then GIT_ALLOW_PROTOCOL could slowly die
off over time.

> That reminds me: external tools also set GIT_ALLOW_PROTOCOL when the
> user hasn't set it explicitly, like git-submodule.sh does.  E.g.
> repo <https://gerrit.googlesource.com/git-repo/+/466b8c4e/git_command.py#171>,
> mercurial <https://www.mercurial-scm.org/repo/hg/file/b032a7b676c6/mercurial/subrepo.py#l1404>.
> Other external tools consume GIT_ALLOW_PROTOCOL, like 'go get'
> <https://go.googlesource.com/go/+/55620a0e/src/cmd/go/vcs.go#64>.
> Can we make it more convenient for them to support this configuration
> too?

I think under my proposal above this ugliness just goes away, as all
they have to do is say "trust my URLs less; they come from an automated
source" without specifying policy themselves.

But we may still want...

> An example approach would be a GIT_ALLOW_PROTOCOL var returned by
> "git var".
> 
> That way git-submodule.sh could do
> 
> 	: ${GIT_ALLOW_PROTOCOL=$(git var GIT_ALLOW_PROTOCOL)}
> 
> and it would just work.  Other tools could do the same, with a
> fallback to the current default until new enough git is in widespread
> use.

...some automated way to say "is this protocol supported"? I think it is
not just "give me ALLOW_PROTOCOL" anymore, though, but "apply your rules
to this protocol, and tell me if it is supported".

I don't think things like "go get" would need it, but you would if you
had a porcelain built around git that was accessing a URL _not_ via
git-fetch, but wanted to apply git's rules. That could come as a step 2
later, though.

-Peff
