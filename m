Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE03C5517A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 05:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47C022202
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 05:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgJ3Fzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 01:55:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:42102 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3Fzm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 01:55:42 -0400
Received: (qmail 4035 invoked by uid 109); 30 Oct 2020 05:55:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 05:55:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18006 invoked by uid 111); 30 Oct 2020 05:55:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 01:55:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 01:55:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
Cc:     git@vger.kernel.org
Subject: Re: Credential Store: Don't acquire lock when only reading the file
Message-ID: <20201030055541.GA3264588@coredump.intra.peff.net>
References: <20201029192020.mcri76ylbdure2o7@safonso-t430>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029192020.mcri76ylbdure2o7@safonso-t430>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 07:20:20PM +0000, Simão Afonso wrote:

> When git is configured for parallel fetches `fetch.parallel = 0` and
> uses the `store` credential helper, fetching all remotes might lead to a
> spurious lock fail. It's a race condition when several remotes require
> the credentials at the same time.
> 
> This shouldn't happen, using the `get` operation should not lock the
> file.

I agree that "get" should not be taking a lock. And looking at the code,
I don't think that it is.

However, after successfully using a password, Git will then trigger each
helper with a "store" command. So likely what you are seeing is each
fetch telling credential-store to store the successful password.

There are a few options here:

  - we could have Git not do that. And indeed, I wrote a patch for that
    long ago:

      https://lore.kernel.org/git/20120407033417.GA13914@sigill.intra.peff.net/

    but it turns out that some people rely on it. There were some
    options discussed there for moving it forward, but nothing ever
    happened.

    Another option that we didn't discuss there: we could remember which
    helper gave us the credential and not feed it back to itself. That
    would let simple cases work without the extra request, but would let
    more complex ones (feeding the result of one helper to another)
    continue to work the same.

  - the problem with `store` is that it has unfriendly concurrency
    semantics. Only one instance can hold the lock at a time, and
    clients which see that the lock is held just fail immediately, even
    though they could probably succeed by waiting a few milliseconds.
    Whereas other helpers are likely a bit smarter about this. So if we
    just wanted to improve credential-store, some other options are:

      - teach it to try the lock until hitting a timeout. I think just
	swapping out hold_lock_file_for_update() for
	hold_lock_file_for_update_timeout() would do it (I probably
	would have used it back then, but it didn't exist yet).

      - teach it to check whether the requested update is a noop
	(because we already have the identical entry in the file)
	without holding the lock. This implies an extra pass over the
	file when we _do_ write something, but the noop case is clearly
	going to be the more common one (and will also be faster,
	because we won't do any writing at all).

	I think I do prefer handling this inside Git, though (i.e.,
	having it realize it would be a noop and avoid calling the
	helper at all).

Interested in trying a patch for any of those?

-Peff
