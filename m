Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A696C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56739613CF
	for <git@archiver.kernel.org>; Mon, 10 May 2021 21:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhEJV0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 17:26:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:49760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhEJV0e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 17:26:34 -0400
Received: (qmail 19983 invoked by uid 109); 10 May 2021 21:25:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 May 2021 21:25:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15303 invoked by uid 111); 10 May 2021 21:25:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 May 2021 17:25:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 May 2021 17:25:26 -0400
From:   Jeff King <peff@peff.net>
To:     Thijs Cramer <thijs.cramer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-credential-cache inner workings
Message-ID: <YJmkxkqz2k+K3Dso@coredump.intra.peff.net>
References: <CAKWuzOrga4eqXhrw11xMsxJCVAPJRTTa7FncNYW5PE5QXCwAJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKWuzOrga4eqXhrw11xMsxJCVAPJRTTa7FncNYW5PE5QXCwAJw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 08:33:38AM +0200, Thijs Cramer wrote:

> We are seeing GIT code 128's in rare cases when jobs follow each other
> up at a fairly high tempo. The reason is:
> https://github.com/git/git/blob/master/http.c#L1637 . This line
> 'approves' a credential that gives a successful result. This means
> that Tokens that have been cached in the git-credential-cache-daemon
> will have it's timeout refreshed even though they might expire
> shortly.
> The credential cache timeout is a user-input timeout, and not a token
> timeout, and this structure collides with the functional lifetime of a
> token.

Right. This was discussed a few months ago in this thread:

  https://lore.kernel.org/git/CAP8UukiL0niGSm3o7uYNBzL3FP-UEgfOuq-Tu=fksWJkerT5fg@mail.gmail.com/

which also links back to a much older discussion of various solutions.

> There are several solutions to circumvent this issue:
> 1) We could ask the Plugin that manages the tokens to support managing
> the Credential Cache as well. This makes it possible for the plugin to
> actively manage tokens and revoke tokens from the cache that have
> expired. Downside is that making plugins aware of the cache in git,
> might not be a good idea, and there might even be cases where caching
> is disabled completely, which would still require the ASKPASS method.

Yes, I agree it's much nicer if the plugin doesn't have to fiddle with
(possibly) configured helpers itself.

> 2) We could add an option to the GIT client that has the same
> functionality as the ASKPASS variable, but one that takes precedence
> before the cache. This way, one can preseed the GIT client with
> credentials that will *always* be used, even if there is a cache that
> has a credential for the given URL.

You can do that already by setting up a helper that provides the
credentials; Git will stop asking as soon as it has an answer. Inserting
a helper at the front of the list is tricky, but you can provide an
empty helper to reset the list. E.g.:

  git \
    -c credential.helper = \
    -c credential.helper = your-real-helper \
    fetch ...

would work.

> 3) We could alter the cache daemon (or build a new one) that has more
> elaborate options regarding it's timeout. Perhaps a daemon option like
> "--keep-timeout-on-approve".
> This would mean that if a credential is approved for a second time the
> timeout is not refreshed.

Yes, that would mostly work. There is a race condition where the cache
times out _during_ a client request. So the cache daemon sees:

  1. Client asks for credential; we provide it.

  2. Cache times out; credential is dropped.

  3. Client provides credential to store.

Then it appears "new". We could keep a tombstone entry for the timed-out
credential, but part of the point of timing out is that we drop the
secret data. You could perhaps do something clever with one-way hashes,
but my preference is to keep things as simple as possible.

> Currently the daemon just removes any old credentials from it's cache
> and adds the new one without questioning the intention of the user. We
> could add a check that tests if the incoming credential is equal to
> the currently cached credential, and skip updating the expiration date
> if they are the same. (With an exception when receiving a new
> password, then we should forcefully update). This means that the
> --timeout option from the daemon will become a 'hard' timeout, instead
> of a user-action timeout. Of course this should be done with a command
> line option on the daemon to not change the default behaviour.

The variant discussed in the thread I linked is to ask Git not to ask to
store credentials which came from a helper in the first place. I think
that solves the problem more directly, and gives the cache helper more
predictable semantics. But some people expressed a preference for the
current behavior in that thread. We could perhaps make it optional,
though (credential.storeFromHelpers or similar).

-Peff
