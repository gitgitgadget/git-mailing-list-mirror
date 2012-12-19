From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 16:09:19 -0500
Message-ID: <20121219210919.GA11894@sigill.intra.peff.net>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <7vk3sd930z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:09:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlQta-0006eR-2L
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 22:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074Ab2LSVJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 16:09:24 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58786 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab2LSVJW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 16:09:22 -0500
Received: (qmail 749 invoked by uid 107); 19 Dec 2012 21:10:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Dec 2012 16:10:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2012 16:09:19 -0500
Content-Disposition: inline
In-Reply-To: <7vk3sd930z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211848>

On Wed, Dec 19, 2012 at 12:54:04PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... doing ":(noglob)" right would mean converting
> > the whole codebase to use "struct pathspec", as the usual
> > "const char **pathspec" cannot represent extra per-item
> > flags.
> 
> As that is the longer-term direction we would want to go, I'd rather
> not to take the approach in this patch for introducing user-facing
> support of literal pathspecs.
> 
> Having said that, even when we have the ':(noglob)' magic pathspec
> support, it would make sense to introduce a command line option to
> make it easier for scripted Porcelains that call plumbing commands
> to pass literal pathspecs (i.e. they know exactly what paths they
> want to operate, not what patterns the paths they want to operate
> would match).

Right, that is my use case. Even once ":(noglob)" exists, it will still
be much simpler for me to use a single option, since I would never have
mixed patterns and literal paths (and I suspect most use cases that
would care about the distinction would be in the same boat). And that is
what led me to submit this at all, as it is not just "well, it is a hack
until :(noglob) works", but "this is not as fine a granularity as
:(noglob), but it better matches what callers want".

> I do not think configuration variable makes much sense (unless you are
> thinking "git -c core.literalpathspec=true" as that command line
> option).

The configuration variable is much more convenient for me, because
otherwise I have to instrument every call to git with a "--no-glob"
option. Because I have a very restricted environment, and happen to know
that globs will _never_ be useful on my repos (or, say, on commands run
by a particular user who has this in their ~/.gitconfig), it makes sense
to just turn off the feature with one switch.

And my thinking was that for people who are not in such a restricted
environment, "git -c core.pathspecglob=false" could serve as that
command-line option, as you mentioned.

It's perhaps a better match to make it an environment variable. Then it
is tied to a particular flow of execution, rather than having it be a
property of a system, user, or repo (which is what config does). So for
my restricted environment, it would be sufficient for me to set the
environment variable for the user who runs the scripts. And people who
want a command-line option can set it via the shell, or we can provide
"git --no-pathspec-glob" to set it.

-Peff
