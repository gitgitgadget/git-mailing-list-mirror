From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 16:31:41 -0400
Message-ID: <20110714203141.GA28548@sigill.intra.peff.net>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net>
 <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net>
 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:32:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhSa1-00008V-Eb
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab1GNUbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:31:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58155
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071Ab1GNUbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:31:43 -0400
Received: (qmail 11692 invoked by uid 107); 14 Jul 2011 20:32:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 16:32:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 16:31:41 -0400
Content-Disposition: inline
In-Reply-To: <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177174>

On Thu, Jul 14, 2011 at 01:19:51PM -0700, Linus Torvalds wrote:

> >Out of curiosity, what don't you like about the generation cache?
> 
> The thing I hate about it is very fundamental: I think it's a hack
> around a basic git design mistake. And it's a mistake we have known
> about for a long time.
> 
> Now, I don't think it's a *fatal* mistake, but I do find it very
> broken to basically say "we made a mistake in the original commit
> design, and instead of fixing it we create a separate workaround for
> it".
> 
> THAT I find distasteful. My reaction is that if we're going to add
> generation numbers, then were should just do it the way we should have
> done them originally, rather than as some separate hack.
> 
> See? That's why I wouldn't have any problem with adding a separate
> cache on top of it, if it's really required, but I would hope that it
> isn't really needed.
> 
> So a cache in itself is not necessarily wrong. But leaving the
> original design mistake in place IS.

Thanks, that makes some sense to me.

However, I'm not 100% convinced leaving generation numbers out was a
mistake. The git philosophy seems always to have been to keep the
minimal required information in the DAG. And I think that has served us
well, because we're not saddled with cruft that seemed like a good idea
early on, but isn't.

Generation numbers are _completely_ redundant with the actual structure
of history represented by the parent pointers. Having them in there is
not about giving git more information that it doesn't have, but about
being a cheap place to stuff a value that is a little expensive to
calculate.

And so that seems a bit hack-ish to me.

I liken it somewhat to the "don't store renames" debate. We don't want
to crystallize forever in the history whatever crappy rename-detection
algorithm is done at the time of commit. We put the minimum amount of
information in the DAG, and it's the runtime's responsibility to get the
answer.

I think the decision is a little more gray with generation numbers,
because it's not about "you got this information with a wrong and crappy
algorithm" like it might be with rename detection, but rather "we're
sticking this redundant number in the commit object, and we assume that
it will always be useful enough to future algorithms to merit being
here".

> And fixing it really ended up being a very tiny patch, no?

Well, yes. But it also doesn't yield a 100-fold speedup in "git tag
--contains" for existing repositories. So it's not quite a full
solution.

-Peff
