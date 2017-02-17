Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E82201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964898AbdBQXj4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:39:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:57645 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964885AbdBQXjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:39:55 -0500
Received: (qmail 31819 invoked by uid 109); 17 Feb 2017 23:39:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 23:39:55 +0000
Received: (qmail 8707 invoked by uid 111); 17 Feb 2017 23:39:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 18:39:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 18:39:53 -0500
Date:   Fri, 17 Feb 2017 18:39:53 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
Message-ID: <20170217233952.56h2z3l76orn4zht@sigill.intra.peff.net>
References: <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
 <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
 <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
 <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
 <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
 <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
 <20170217212106.bew6krtb7pqpi3rr@sigill.intra.peff.net>
 <xmqqy3x4qyte.fsf@gitster.mtv.corp.google.com>
 <20170217221019.wjuaxmaatqtx2olt@sigill.intra.peff.net>
 <xmqqzihkphkc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzihkphkc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 02:40:19PM -0800, Junio C Hamano wrote:

> > Right. EIO is almost certainly _not_ the error we saw. But I would
> > rather consistently say "I/O error" and have the user scratch their
> > head, look up this thread, and say "ah, it was probably a deferred
> > error", as opposed to the alternative: the user sees something
> > nonsensical like ENOMEM or EBADF. Those are more misleading, and worse,
> > may change from run to run based on what other code runs or fails in
> > between.
> 
> My point was actually not what errno we feed to strerror().  In that
> example, what is more misleading is the fixed part of the error
> message the caller of close_tempfile() used after seeing the funcion
> fail, i.e. "failed to close".  strerror() part is used to explain
> why we "failed to close", and of course any nonsensical errno that
> we did not get from the failed stdio call would not explain it, but
> a more misleading part is that we did not even "failed to close" it.
> 
> We just noticed an earlier error while attempting to close it.
> strerror() in the message does not even have to be related to the
> closing of the file handle.

Ah, I see.  I think the errno thing is a strict improvement over what is
there now. Actually having a separate error message is even better, but
it does end up rather verbose in the callers.

I'm also not sure that it's all that useful to distinguish errors from
fwrite() versus fclose(). In practice, errors will come from write() in
either case, and the caller does not have much control over when the
flushing happens. So any error saying "error closing file" is probably
assuming too much anyway. It should be "error writing file".

And I think in practice the messages end up quite generic anyway, as
they are really calling commit_lock_file(), which may also fail due to a
rename. So you get something like "unable to write 'foo': ", with errno
appended. That's _also_ potentially confusing when rename() fails.

Solving that would probably require passing down an "err" strbuf (or
other data structure) for the low-level code to fill in.

> > The only reason I do not think we should do so for close_tempfile() is
> > that the fclose is typically far away from the code that actually calls
> > error(). We'd have to pass the tristate (success, fail, fail-with-errno)
> > state up through the stack (most of the calls indirectly come from
> > commit_lock_file(), I would think).
> 
> We _could_ clear errno to allow caller to tell them apart, though,
> if we wanted to ;-)

Hmm. So basically "errno = 0" instead of EIO? That at least has the
advantage that you can tell it apart from a real EIO, and a caller
_could_ if they chose do:

  if (commit_lock_file(&lock)) {
	if (!errno)
		error("error writing to file");
	else
		error_errno("error closing file");
  }

But I am not sure I would want to annotate all such callers that way. It
would probably be less bad to just pass down a "quiet" flag or a strbuf
and have the low-level code fill it in. And that solves this problem
_and_ the rename() thing above.

But TBH, I am not sure if it is worth it. Nobody is complaining. This is
just a thing we noticed. I think setting errno to EIO or to "0" is a
strict improvement over what is there (where the errno is essentially
random) and the complexity doesn't escape the function.

So I think that "easy" thing falls far short of a solution, but it's at
least easy. I could take it or leave it at this point.

-Peff
