From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 8 Jul 2010 07:28:02 -0400
Message-ID: <20100708112802.GA2294@sigill.intra.peff.net>
References: <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705141012.GA25518@thunk.org>
 <20100706115826.GA15413@sigill.intra.peff.net>
 <1278430303.32094.15.camel@wpalmer.simply-domain>
 <20100706165336.GJ25518@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Will Palmer <wmpalmer@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Thu Jul 08 13:28:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWpH1-0007SS-GG
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab0GHL2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:28:06 -0400
Received: from peff.net ([208.65.91.99]:34075 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab0GHL2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 07:28:04 -0400
Received: (qmail 2421 invoked by uid 107); 8 Jul 2010 11:29:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 08 Jul 2010 07:29:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jul 2010 07:28:02 -0400
Content-Disposition: inline
In-Reply-To: <20100706165336.GJ25518@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150562>

On Tue, Jul 06, 2010 at 12:53:36PM -0400, tytso@mit.edu wrote:

> We would be much better off if our tools enforced the fact that
> committer times were always increasing.  If from the beginning, we had
> introduced checks so that "git commit" refused to create new commits
> where the committer time was before its parent commit(s), and
> git-receive-pack refused to accept packs that contained
> non-monotonically increasing commits or commits that occurred in the
> future according to its system clock, then these optimizations would
> be completely valid.
> 
> But we didn't, and we do have skew in some repositories.  So the
> question is what to do going forward?  One solution might be to
> enforce this moving forward, and to have varying levels of strictness
> in enforcing this constraint.  So for completely new repositories,

Whatever we do with the optimization, I do agree with your suggestion at
least for "git commit" to avoid making such commits.  Rejecting them
during fetchs and pushes would be a nice, too, but should probably just
be a warning at first, in case you have to pull from somebody with an
older git. You would also have to consider whether some small skew is
acceptable during a pull. Something like a 5-second skew is not a big
deal. If you had thousands of such skews in a row, yes, it would be bad,
but that is not likely to happen (and I can't think of some way to
maliciously create such a history that would not otherwise be
unusable).

> this becomes a non-brainer.  For older repositories, Jeff's idea of
> having a tunable parameter so that results are correct given a maximum
> clock skew --- which can be determined --- will allow us to have
> correctness _and_ performance.

Yeah. I think the real question is what the default for that parameter
should be: pessimistic but always correct, optimistic but possibly
incorrect in the face of skew, or auto-tuned per-repository.

-Peff
