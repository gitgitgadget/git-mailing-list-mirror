Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406E9C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 02:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLVClP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 21:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiLVClN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 21:41:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC429FCC3
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 18:41:12 -0800 (PST)
Received: (qmail 6143 invoked by uid 109); 22 Dec 2022 02:41:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Dec 2022 02:41:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6850 invoked by uid 111); 22 Dec 2022 02:41:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Dec 2022 21:41:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Dec 2022 21:41:11 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] Documentation: clarify that cache forgets credentials if
 the system restarts
Message-ID: <Y6PDx7Ij4NA/kBB7@coredump.intra.peff.net>
References: <pull.1447.git.1671610994375.gitgitgadget@gmail.com>
 <xmqqo7rxror4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7rxror4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2022 at 08:15:59PM +0900, Junio C Hamano wrote:

> This is not a new issue, but I am not sure if "never touch the disk"
> is a honest thing to say (I know there is no "write this in a file"
> done by the cache daemon, but the running daemon can be swapped out
> and I do not think we do anything to prevent the in-core structure
> credential_cache_entry from getting written to the swap.

Right, we don't do anything like mlock(), mostly because of the
portability problems (though obviously we could make an optional
wrapper, which is strictly better than the status quo). On the other
hand, neither does git itself, so we're only holding credential-cache to
the same standard. Arguably the cache holds credentials longer, but a
fetch or push may run for quite a while bottle-necked on network or pack
generation/indexing (and both of those operations create memory pressure
which may trigger swap).

But I agree that it is more accurate to say "does not touch the
filesystem" or your "instead of written to a file".

> Taking all of the above together, perhaps something like this?
> 
>     ... caches credentials for use by future Git programs.  The
>     stored credentials are kept in memory of the cache-daemon
>     process (instead of written to a file) and are forgotten after a
>     configuarble timeout.  The cache-daemon dies with the cached
>     credentials upon a system shutdown/restart, or when it receives
>     SIGHUP (i.e. by logging out, you disconnect from the terminal
>     the daemon was started from); the latter can be disabled with
>     credentialCache.ignoreSIGHUP configuration.  The cache is
>     accessible over a Unix domain socket, ...

That seems reasonable. I was going to suggest also mentioning that we
can ask the daemon to exit manually, but that is pretty well covered
later in the document. On the other hand, it may make sense to put all
of this together in the description.

As brian mentioned, not every system behaves the same with respect to
SIGHUP here. So we may need to be a little more vague here.

So maybe more like:

  ...are forgotten after a configurable timeout, or if the daemon exits.

  You can ask the daemon to exit manually, forgetting all cached
  credentials before their timeout, by running:

    git credential-cache exit

  The daemon will also exit when it receives a signal. Depending on the
  configuration of your system, this may happen automatically when you
  log out. If you want to inhibit this behavior (and let items time out
  as normal even when you're logged out), you can set the
  credentialCache.ignoreSIGHUP configuration variable to `true`.

There are many possible variations, of course. I was mostly just trying
to get across the point that:

  - there are several ways for the daemon to exit

  - sighup / logout handling may depend on your system

And I am happy with any text that says so.

-Peff
