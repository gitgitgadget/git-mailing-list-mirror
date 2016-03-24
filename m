From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin/tag.c: move PGP verification inside builtin.
Date: Thu, 24 Mar 2016 18:14:57 -0400
Message-ID: <20160324221457.GB17805@sigill.intra.peff.net>
References: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
 <20160324215104.GC8830@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:15:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDX0-0002r4-UG
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbcCXWPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:15:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:37826 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750772AbcCXWPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:15:00 -0400
Received: (qmail 29277 invoked by uid 102); 24 Mar 2016 22:15:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 18:15:00 -0400
Received: (qmail 18094 invoked by uid 107); 24 Mar 2016 22:15:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 18:15:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2016 18:14:57 -0400
Content-Disposition: inline
In-Reply-To: <20160324215104.GC8830@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289812>

On Thu, Mar 24, 2016 at 05:51:05PM -0400, Santiago Torres wrote:

> Sorry for the delay with this, I got caught up with coursework.

No problem. The project moves forward as contributor time permits.

> This is my first stab at this, in the dumbest/simplest way imaginable. I
> don't like that there is no code reuse (the run_gpg_verify function is
> repeated here and in the plumbing command). I would appreciate pointers
> on what would be the best way to avoid this.

It looks to me like you could factor the repeated code into a common
verify_tag(), but maybe I am missing something.

> I also spent quite some time figuring out what you meant with
> 
> > Do note the trickery with SIGPIPE in verify-tag, though. We probably
> > need to do the same here (in fact, I wonder if that should be pushed
> > down into the code that calls gpg).
> I don't see any explicit SIGPIPE trickery here. Any pointers?

There is a call to ignore SIGPIPE in builtin/verify-tag.c, line 100.
Do we need to do be doing the same thing here?

There's some discussion in the thread starting at:

  http://thread.gmane.org/gmane.comp.version-control.git/53878/focus=53904

The claim there is that we get SIGPIPE and die early if we feed gpg a
tag which isn't signed. We _should_ be catching that case already via
parse_signature(), though I wonder if it can be fooled (e.g., something
that looks like a signature, but when gpg parses it, it turns out to be
bogus). So we should probably continue ignoring SIGPIPE to be on the
safe side.

But I notice that we already handle SIGPIPE explicitly in sign_buffer()
for similar reasons.  What I was wondering earlier was whether we should
teach other functions that call gpg (like verify_signed_buffer()) to
ignore SIGPIPE, too, so that we can return a reasonable error value
rather than just killing the whole program.

-Peff
