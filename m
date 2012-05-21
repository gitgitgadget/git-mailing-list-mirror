From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 15:41:14 -0400
Message-ID: <20120521194114.GA28358@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <201205211215.14455.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon May 21 21:41:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWYTq-0005k3-O0
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 21:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab2EUTlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 15:41:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51017
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756181Ab2EUTlR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 15:41:17 -0400
Received: (qmail 4942 invoked by uid 107); 21 May 2012 19:41:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 15:41:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 15:41:14 -0400
Content-Disposition: inline
In-Reply-To: <201205211215.14455.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198123>

On Mon, May 21, 2012 at 12:15:13PM -0600, Martin Fick wrote:

> Of course, we use Gerrit, so features tend to be called 
> changes and each change may get many revisions (patchsets), 
> so all of these get refs, but I think that it might be wrong 
> to consider that out of the ordinary anymore.  After all, 
> should a version control system such as git not support 100K 
> revisions of features developed independently on separate 
> branches (within Gerrit or not)?  100K is not really that 
> many when you consider a large project.  Even without 
> Gerrit, if someone wanted to track that many features 
> (likely over a few years), they will probably use up tons of 
> refs.  

I think the more compelling line of argument is not "is this
reasonable?", but rather that git has been designed from the ground-up
to be efficient, and these are not fundamental design issues with git at
all. They are just silly little spots where we used a quick-to-write
quadratic algorithm instead of something more complex with better
asymptotic behavior. And if we can fix these silly spots easily, then
there's no reason not to. It helps the small-N case a tiny bit, and it
makes the big-N case feasible.

So far, the only quadratic case I have seen that is not easy to fix is
replacing "struct commit_list" with a priority queue or similar.  But we
managed to hack around that long ago with fce87ae (Fix quadratic
performance in rewrite_one., 2008-07-12), and I don't think it's
generally a problem in practice.

Anyway, my point is that we don't even have to talk about "reasonable"
or "absurd". Git should be fast even on absurd cases, because 99% of the
work has already been done, and the last 1% is easy.

-Peff
