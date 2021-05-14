Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056BC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 07:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123DE61446
	for <git@archiver.kernel.org>; Fri, 14 May 2021 07:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhENH2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 03:28:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:54438 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhENH2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 03:28:25 -0400
Received: (qmail 17192 invoked by uid 109); 14 May 2021 07:27:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 May 2021 07:27:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30890 invoked by uid 111); 14 May 2021 07:27:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 May 2021 03:27:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 May 2021 03:27:12 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
Message-ID: <YJ4mUJ+EEAnudI3G@coredump.intra.peff.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
 <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
 <YJ0FL3zr/SnWN7t6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJ0FL3zr/SnWN7t6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Jonathan Tan for partial clone wisdom]

On Thu, May 13, 2021 at 06:53:36AM -0400, Jeff King wrote:

> > So I think it will require some digging. My _guess_ is that it has to do
> > with the "never filter out an object that was explicitly requested" rule
> > not being consistently followed. But we'll see.
> 
> OK, I think I've unraveled the mysteries.

Nope. This part is wrong:

> It is indeed a problem with the "never filter out an object that was
> explicitly requested" rule. But really, that rule is stronger: it is
> "always include an explicitly requested object". I.e., it must override
> even the usual "you said commit X was uninteresting, so we did not
> include objects reachable from X" logic.

The rule really is the softer "don't filter out explicitly-requested
objects". It's just that the non-bitmap traversal code is way less
careful about finding uninteresting objects.

Here's the same scenario failing without using bitmaps at all:

  # same as before; repo with one commit
  git init repo
  cd repo
  
  echo content >file
  git add file
  git commit -m base

  # and now we make a partial clone omitting the blob
  git config uploadpack.allowfilter true
  git clone --no-local --bare --filter=blob:none . clone

  # but here's the twist. Now we make a second commit...
  echo more >file
  git commit -am more

  # ...and then we fetch both the object we need _and_ that second
  # commit. That causes pack-objects to traverse from base..more.
  # The boundary is at "base", so we mark its tree and blob as
  # UNINTERESTING, and thus we _don't_ send them.
  cd clone
  git fetch origin $(git rev-parse HEAD:file) HEAD

So I guess the first question is: is this supposed to work? Without
bitmaps, it often will. Because we walk commits first, and then only
mark trees uninteresting at the boundary; so if there were more commits
here, and we were asking to get a blob from one of the middle ones, it
would probably work. But fundamentally the client is lying to the server
here (as all partial clones must); it is saying "I have that first
commit", but of course we don't have all of the reachable objects.

If this is supposed to work, I think we need to teach the traversal code
to "add back" all of the objects that were explicitly given when a
filter is in use (either explicitly, or perhaps just clearing or
avoiding the UNINTERESTING flag on user-given objects in the first
place). And my earlier patch does that for the bitmap side, but not the
regular traversal.

Alternatively, part of that fundamental "partial clones are lying about
their reachability" property is that we assume they can fetch the
objects they need on-demand. And indeed, the on-demand fetch we'd do
will use the noop negotiation algorithm, and will succeed. So should we,
after receiving an empty pack from the other side (because we claimed to
have objects reachable from the commit), then do a follow-up on-demand
fetch? If so, then why isn't that kicking in (I can guess there might be
some limits to on-demand fetching during a fetch itself, in order to
avoid infinite recursion)?

-Peff
