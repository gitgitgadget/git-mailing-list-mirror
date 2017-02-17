Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7364C201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935040AbdBQWRF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:17:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:57497 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935044AbdBQWRE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:17:04 -0500
Received: (qmail 25841 invoked by uid 109); 17 Feb 2017 22:10:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 22:10:22 +0000
Received: (qmail 6580 invoked by uid 111); 17 Feb 2017 22:10:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 17:10:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 17:10:19 -0500
Date:   Fri, 17 Feb 2017 17:10:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
Message-ID: <20170217221019.wjuaxmaatqtx2olt@sigill.intra.peff.net>
References: <87tw7uv439.fsf@linux-m68k.org>
 <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
 <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
 <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
 <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
 <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
 <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
 <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
 <20170217212106.bew6krtb7pqpi3rr@sigill.intra.peff.net>
 <xmqqy3x4qyte.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3x4qyte.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 01:42:21PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Feb 17, 2017 at 01:17:06PM -0800, Junio C Hamano wrote:
> >
> >> Stepping back a bit, would this be really needed?  Even if the ferror()
> >> does not update errno, the original stdio operation that failed
> >> would have, no?
> >
> > Sure, but we have no clue what happened in between.
> 
> Hmm, so we are protecting against somebody who does "errno = 0"
> explicitly, because she knows that she's dealt with the error from
> stdio earlier?  Such a careful person would have called clearerr()
> as well, I would guess.

I'm not sure I understand what you are saying here. If somebody calls
clearerr(), our ferror() handling does not trigger at all, and do not
care what is in errno either way. They can reset errno or not when they
clearerr(), but it is not relevant.

If you are asking about somebody who sets errno to "0" and _doesn't_
call clearerr(), then I don't know what that person is trying to
accomplish. Setting errno to "0" is not the right way to clear an error.
And they certainly should not be relying on it not to get overwritten
before we make it to the final ferror()/fclose().

> So let's assume we only care about the case where some other error
> was detected and errno was updated by a system library call.

Right.

> > I think our emails crossed, but our patches are obviously quite similar.
> > My commit message maybe explains a bit more of my thinking.
> 
> Yes, but ;-)
> 
> If we are trying to make sure that the caller would not say "failed
> to close tempfile: ERRNO" with an ERRNO that is unrelated to any
> stdio opration, I am not sure if the patch improves things.  The
> caller did not fail to close (most likely we successfully closed
> it), and no matter what futzing we do to errno, the message supplied
> by such a caller will not be improved.

Right. EIO is almost certainly _not_ the error we saw. But I would
rather consistently say "I/O error" and have the user scratch their
head, look up this thread, and say "ah, it was probably a deferred
error", as opposed to the alternative: the user sees something
nonsensical like ENOMEM or EBADF. Those are more misleading, and worse,
may change from run to run based on what other code runs or fails in
between.

> If the caller used "noticed an earlier error while closing tempfile:
> ERRNO", such a message would describe the situation more correctly,
> but then ERRNO that is not about stdio is probably acceptable in the
> context of that message (the original ERRNO might be ENOSPC that is
> even more specific than EIO, FWIW).  So I am not sure if the things
> will improve from the status quo.

Yes, that's I suggested that xfclose() is probably not a good direction.
The _best_ thing we can do is have the caller not report errno at all
(or even say "there was an earlier error, I have no idea what errno
was"). And xfclose() works in the opposite direction.

The only reason I do not think we should do so for close_tempfile() is
that the fclose is typically far away from the code that actually calls
error(). We'd have to pass the tristate (success, fail, fail-with-errno)
state up through the stack (most of the calls indirectly come from
commit_lock_file(), I would think).

-Peff
