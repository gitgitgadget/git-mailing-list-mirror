From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote: make prune work for mixed mirror/non-mirror repos
Date: Thu, 20 Jun 2013 19:08:44 -0400
Message-ID: <20130620230843.GA5780@sigill.intra.peff.net>
References: <1371763424.17896.32.camel@localhost>
 <1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
 <7vppvgpfib.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 01:08:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpnyJ-0001dq-4C
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 01:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539Ab3FTXIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 19:08:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:60780 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757878Ab3FTXIr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 19:08:47 -0400
Received: (qmail 19745 invoked by uid 102); 20 Jun 2013 23:09:47 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 18:09:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 19:08:44 -0400
Content-Disposition: inline
In-Reply-To: <7vppvgpfib.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228557>

On Thu, Jun 20, 2013 at 03:46:20PM -0700, Junio C Hamano wrote:

> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > When cloning a repo with --mirror, and adding more remotes later,
> > get_stale_heads for origin would mark all refs from other repos as stale. In
> > this situation, with refs-src and refs->dst both equal to refs/*, we should
> > ignore refs/remotes/* when looking for stale refs to prevent this from
> > happening.
> 
> I do not think it is a right solution to single out refs/remotes/*.

Yeah, I agree.

> Going back to your original example:
> 
>     [remote "origin"]
>             url = git://github.com/git/git.git
>             fetch = +refs/*:refs/*
>             mirror = true
>     [remote "peff"]
>             url = git://github.com/peff/git.git
>             fetch = +refs/heads/*:refs/remotes/peff/*

There is a fundamental namespace conflict here: one remote is claiming
the whole refs/* namespace, and another remote is claiming some subset.
"fetch --prune" is only one type of problem you can have; you might also
overwrite stuff from the "peff" remote with stuff from the "origin"
remote (if it happens to have "refs/remotes/peff/foo" itself).

> I think this is an unsolvable problem, and I _think_ the root cause
> of the issue is the configuration above that allows the RHS of
> different fetch refspecs to overlap.  refs/* is more generic and
> covers refs/remotes/peff/* and refs/remotes/github/*.  You cannot
> even know, just by looking at "origin" and your local repository,
> if refs/remotes/github/html you have should go away or it might have
> come from somewhere else.

Exactly.

> The best we _could_ do, without contacting all the defined remotes,
> is probably to check each ref that we did not see from "origin" (for
> example, you find "refs/remotes/peff/frotz" that your origin does
> not have) and see if it could match RHS of fetch refspec of somebody
> else (e.g. RHS of "refs/heads/*:refs/remotes/peff/*" matches that
> ref).  Then we can conclude that refs/remotes/peff/frotz _might_
> have come from Peff's repository and not from "origin", and then we
> can optionally issue a warning and refrain from removing it.

I think this is just papering over the problem in one instance. What
happens when you _do_ have overlapping refs in the "origin" remote, and
you have a true conflict.

I wonder why Dennis wants to "refs/*:refs/*" in the first place. It
is not usually a useful thing to have in a non-bare repository, because
fetches will overwrite local work on branches. If he just wanted the
automatic "git push --mirror" setting, that does not depend on the fetch
refspec.

We made this distinction in "git remote --mirror={fetch,remote}", but I
don't think "git clone --mirror" ever learned about it.

-Peff
