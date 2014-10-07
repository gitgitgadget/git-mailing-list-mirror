From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo =
 bar"
Date: Tue, 7 Oct 2014 17:29:41 -0400
Message-ID: <20141007212941.GA24508@peff.net>
References: <xmqq61fveg1j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:29:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbcKK-00035S-Mk
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371AbaJGV3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:29:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:55968 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753837AbaJGV3o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:29:44 -0400
Received: (qmail 9150 invoked by uid 102); 7 Oct 2014 21:29:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 16:29:44 -0500
Received: (qmail 9704 invoked by uid 107); 7 Oct 2014 21:29:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 17:29:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2014 17:29:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61fveg1j.fsf@gitster.dls.corp.google.com>
 <xmqqa957ehz0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 07, 2014 at 01:35:15PM -0700, Junio C Hamano wrote:

> Yeah, if we are going to reduce it down to the above implementation,
> intereseting things like "test -f $frotz" will become possible and
> "cmp-str" stops making sense.  It really is about "We run test and
> expect it to yield true.  Report the failure a bit more prominently
> under the '-v' option to help us debug".

We already have test_path_is_file to do the same thing just for "-f". We
could in theory switch all of those to this new, more generic wrapper. I
don't know if it is worth doing a mass-conversion, but we could
discourage test_path_is_file in new tests. We could also implement
test_path_is_{dir,file} on top of this.

There is also test_path_is_missing, which would need the negated form.
We'd either need a "test_not_cond", or to allow:

  test_cond ! -e path

That is specified by POSIX. I seem to recall that we ran into
problems using it with some shells, but I note there is currently some
use of it in t5304. So perhaps it is fine.

> So among the ones you listed, test_verbose may be the least silly, I
> would think.

Somehow test_verbose seems to me like checking the "verbose" option of
the test suite. I prefer "test_cond", but I do not feel too strongly, if
you want to override me.

> > (any quoting or whitespace may be wrong, of course, but that's OK; it's
> > for human consumption, and is just a hint).
> 
> If we really cared, we could do
> 
> 	echo >&2 "command failed: test $(git rev-parse --sq-quote "$@")"
> 
> perhaps?

Yeah, that would work. I am always a little hesitant sticking git
commands into our test infrastructure, since we may end up masking
errors due to our own bug. But we can probably rely on --sq-quote
working sanely (and anyway, we're not even affecting the test outcome
here).

-Peff
