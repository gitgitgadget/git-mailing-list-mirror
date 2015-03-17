From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] not making corruption worse
Date: Tue, 17 Mar 2015 03:37:31 -0400
Message-ID: <20150317073730.GA25267@peff.net>
References: <20150317072750.GA22155@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 08:37:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXm4I-0001Bf-38
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 08:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbbCQHhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 03:37:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:33931 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751268AbbCQHhd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 03:37:33 -0400
Received: (qmail 25947 invoked by uid 102); 17 Mar 2015 07:37:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 02:37:33 -0500
Received: (qmail 22885 invoked by uid 107); 17 Mar 2015 07:37:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 03:37:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2015 03:37:31 -0400
Content-Disposition: inline
In-Reply-To: <20150317072750.GA22155@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265619>

On Tue, Mar 17, 2015 at 03:27:50AM -0400, Jeff King wrote:

> The general strategy for these is to use for_each_rawref traversals in
> these situations. That doesn't cover _every_ possible scenario. For
> example, you could do:
> 
>   git clone --no-local repo.git backup.git &&
>   rm -rf repo.git
> 
> and you might be disappointed if "backup.git" omitted some broken refs
> (upload-pack will simply skip the broken refs in its advertisement).  We
> could tighten this, but then it becomes hard to access slightly broken
> repositories (e.g., you might prefer to clone what you can, and not have
> git die() when it tries to serve the breakage). Patch 2 provides a
> tweakable safety valve for this.

One thing I thought about while working on this was whether we should
just make _all_ ref iterations for_each_rawref. The benefit to not doing
so in the hypothetical above is that you might be able to clone "foo"
even if "bar" is broken.

But it strikes me as weird that we consider the _tips_ of history to be
special for ignoring breakage. If the tip of "bar" is broken, we omit
it. But if the tip is fine, and there's breakage three commits down in
the history, then doing a clone is going to fail horribly, as
pack-objects realizes it can't generate the pack. So in practice, I'm
not sure how much you're buying with the "don't mention broken refs"
code.

OTOH, there are probably _some_ situations that can be recovered with
the current code that could not otherwise. For example, in the current
code, I can still fetch "foo" even if "bar" is broken 3 commits down.
Whereas if the tip is broken, there's a reasonable chance that
"upload-pack" would just barf and I could fetch nothing.

So I stuck to the status quo in most cases, and only turned on the more
aggressive behavior for destructive operations (and people who want to
go wild can set GIT_REF_PARANOIA=1 for their every day operations if
they want to).

-Peff
