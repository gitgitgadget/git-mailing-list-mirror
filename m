Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6939D200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933321AbeEHSSn (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:18:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:60722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933071AbeEHSSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:18:42 -0400
Received: (qmail 16202 invoked by uid 109); 8 May 2018 18:18:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 18:18:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7366 invoked by uid 111); 8 May 2018 18:18:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 14:18:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 14:18:40 -0400
Date:   Tue, 8 May 2018 14:18:40 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
Message-ID: <20180508181839.GC7210@sigill.intra.peff.net>
References: <20180506141031.30204-5-martin.agren@gmail.com>
 <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
 <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com>
 <CAN0heSpA5H7Gwwx0TEY9=iFJrgKb0SPXqKOwHK=4NxPYoGjZ7A@mail.gmail.com>
 <CACsJy8DDyrUinwXx1b66DCHB+2DLt1KBmFt_83R1+HWjbzGH2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DDyrUinwXx1b66DCHB+2DLt1KBmFt_83R1+HWjbzGH2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 07, 2018 at 05:24:05PM +0200, Duy Nguyen wrote:

> >>>> -       static struct lock_file lock;
> >>>> +       struct lock_file lock = LOCK_INIT;
> >>>
> >>> Is it really safe to do this? I vaguely remember something about
> >>> (global) linked list and signal handling which could trigger any time
> >>> and probably at atexit() time too (i.e. die()). You don't want to
> >>> depend on stack-based variables in that case.
> >>
> >> So I dug in a bit more about this. The original implementation does
> >> not allow stack-based lock files at all in 415e96c8b7 ([PATCH]
> >> Implement git-checkout-cache -u to update stat information in the
> >> cache. - 2005-05-15). The situation has changed since 422a21c6a0
> >> (tempfile: remove deactivated list entries - 2017-09-05). At the end
> >> of that second commit, Jeff mentioned "We can clean them up
> >> individually" which I guess is what these patches do. Though I do not
> >> know if we need to make sure to call "release" function or something/
> >> Either way you need more explanation and assurance than just "we can
> >> drop their staticness" in the commit mesage.
> >
> > Thank you Duy for your comments. How about I write the commit message
> > like so:
> 
> +Jeff. Since he made it possible to remove lock file from the global
> linked list, he probably knows well what to check when switching from
> a static lock file to a stack-local one.

It should be totally safe. If you look at "struct lock_file", it is now
simply a pointer to a tempfile allocated on the heap (in fact, I thought
about getting rid of lock_file entirely, but the diff is noisy and it
actually has some value as an abstraction over a pure tempfile).

If you fail to call a release function, it will just hang around until
program exit, which is more or less what the static version would do.
The big difference is that if we re-enter the function while still
holding the lock, then the static version would BUG() on trying to use
the already-active lockfile. Whereas after this series, we'd try to
create a new lockfile and say "woah, somebody else is holding the lock".

> >   After 076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05),
> >   we can have lockfiles on the stack. These `struct lock_file`s are local
> >   to their respective functions and we can drop their staticness.
> >
> >   Each of these users either commits or rolls back the lock in every
> >   codepath, with these possible exceptions:
> >
> >     * We bail using a call to `die()` or `exit()`. The lock will be
> >       cleaned up automatically.
> >
> >     * We return early from a function `cmd_foo()` in builtin/, i.e., we
> >       are just about to exit. The lock will be cleaned up automatically.
> 
> There are also signals which can be caught and run on its own stack (I
> think) so whatever variable on the current stack should be safe, I
> guess.

Yes, the stack variables should all be intact during an exit or a
signal.

> >   If I have missed some codepath where we do not exit, yet leave a locked
> >   lock around, that was so also before this patch. If we would later
> >   re-enter the same function, then before this patch, we would be retaking
> >   a lock for the very same `struct lock_file`, which feels awkward, but to
> >   the best of my reading has well-defined behavior. Whereas after this
> >   patch, we would attempt to take the lock with a completely fresh `struct
> >   lock_file`. In both cases, the result would simply be that the lock can
> >   not be taken, which is a situation we already handle.
> 
> There is a difference here, if the lock is not released properly,
> previously the lockfile is still untouched. If it's on stack, it may
> be overwritten which can corrupt the linked list to get to the next
> lock file.  (and this is about calling the function in question just
> _once_ not the second time).

The only bits on the stack are just a pointer to the list item. So the
linked list is fine if it goes out of scope while the tempfile is still
active. That was the point of 076aa2cbd.

-Peff
