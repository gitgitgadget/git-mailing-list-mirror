Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhLHVR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:17:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:47052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232921AbhLHVR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:17:27 -0500
Received: (qmail 11310 invoked by uid 109); 8 Dec 2021 21:13:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Dec 2021 21:13:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7675 invoked by uid 111); 8 Dec 2021 21:13:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Dec 2021 16:13:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Dec 2021 16:13:48 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [RFC] fetch: update refs in a single transaction
Message-ID: <YbEgDBJPuGXQ+2t6@coredump.intra.peff.net>
References: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
 <CAP8UFD0Y-2aD6ywRFi49_emxzcLqrfyNpZ29fgsJ0FKc0njYqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0Y-2aD6ywRFi49_emxzcLqrfyNpZ29fgsJ0FKc0njYqg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 08, 2021 at 09:15:01AM +0100, Christian Couder wrote:

> > Note that this slightly changes semantics of git-fetch(1): if we hit any
> > unexpected errors like the reference update racing with another process,
> > then we'll now fail to update any references, too.
> 
> So that's one difference between the "partial-update" and the
> "non-atomic" modes, but what you say doesn't really make me confident
> that it's the only one.
> 
> Also are there people who are in cases where a lot of reference
> updates are racing, and where it's important that in such cases at
> least some ref updates succeed?
> 
> If yes, then maybe the 3 modes could be kept and options for
> "partial-update" and "non-atomic" could be added. "partial-update"
> could be the default in case the reftable backend is used, while
> "non-atomic" would still be the default when the files backend is
> used.

I think these three modes are hard to explain to users, because the
failures which trigger for partial-update versus atomic depend on how
things happen to be implemented. Just coming from a user's perspective,
we might expect a breakdown like:

  - problems like non-fast-forward are logical policy issues, and we'd
    reject those without failing the whole transaction (in
    partial-update mode)

  - a system error like write() failing should be rare, and abandons the
    whole transaction (in either mode)

But there are some confusing cases:

  - if somebody else takes the lock and updates the ref at the same
    time, then that is handled in the ref transaction code. And so even
    though it's closer to a logical policy issue, the patch here would
    fail the whole transaction

  - likewise name conflicts (writing "refs/foo" when "refs/foo/bar"
    exists or vice versa) are more of a logical issue, but are also
    handled by the transaction code.

So I think we really have to teach the ref transaction code the notion
of non-atomic transactions, or we'll end up leaking out all of those
implementation details in user-facing behavior. I.e., the ref code needs
to learn not to immediately abort if it fails one lockfile, but to
optionally keep going (if the caller specified a non-atomic flag, of
course).

For the files-backend code, I think system errors would naturally fall
out in the same code. Failing to write() or rename() is not much
different than failing to get the lock in the first place. So
"partial-update" and "non-atomic" behavior would end up the same anyway,
and we do not need to expose the third mode to the user.

For the reftable backend, syscalls are inherently covering all the refs
anyway (we either commit the whole reftable update or not). So likewise
there would be no different between partial-update and non-atomic modes
(but they would both be different from the files backend).

I suspect the surgery needed for the ref-transaction code to allow
non-atomic updates would be pretty big, though. It involves checking
every error case to make sure it is safe to continue rather than
aborting (and munging data structures to mark particular refs as
"failed, don't do anything further for this one").

So I dunno. All of my analysis assumes the breakdown of user
expectations I gave above is a reasonable one. There may be others. But
it seems like the behavior created by just this patch would be very hard
to explain, and subject to change based on implementation details.

-Peff
