From: tytso@mit.edu
Subject: Re: Why is "git tag --contains" so slow?
Date: Tue, 6 Jul 2010 12:53:36 -0400
Message-ID: <20100706165336.GJ25518@thunk.org>
References: <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705141012.GA25518@thunk.org>
 <20100706115826.GA15413@sigill.intra.peff.net>
 <1278430303.32094.15.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 18:53:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWBP2-0004RS-9S
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 18:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab0GFQxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 12:53:43 -0400
Received: from THUNK.ORG ([69.25.196.29]:43449 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab0GFQxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 12:53:42 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OWBOs-0000oN-CJ; Tue, 06 Jul 2010 12:53:38 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OWBOq-0006nX-9J; Tue, 06 Jul 2010 12:53:36 -0400
Content-Disposition: inline
In-Reply-To: <1278430303.32094.15.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150368>

On Tue, Jul 06, 2010 at 04:31:43PM +0100, Will Palmer wrote:
> Is it wrong to expect that git perform poorly in the edge-cases (hugely
> skewed timestamps), but that it perform /correctly/ in all cases?
> 
> Clearly, marking already-traversed histories was the right thing to do,
> and if I read correctly, made a good improvement on its own. But you
> seem to have crossed a line at some point between "optimization" and
> "potentially giving the wrong answer because it's faster"

When "it's faster" is between 100-1000 times faster, I think we have
to look at things a bit more closely.  That's the difference between a
command being usable and not usable.

We would be much better off if our tools enforced the fact that
committer times were always increasing.  If from the beginning, we had
introduced checks so that "git commit" refused to create new commits
where the committer time was before its parent commit(s), and
git-receive-pack refused to accept packs that contained
non-monotonically increasing commits or commits that occurred in the
future according to its system clock, then these optimizations would
be completely valid.

But we didn't, and we do have skew in some repositories.  So the
question is what to do going forward?  One solution might be to
enforce this moving forward, and to have varying levels of strictness
in enforcing this constraint.  So for completely new repositories,
this becomes a non-brainer.  For older repositories, Jeff's idea of
having a tunable parameter so that results are correct given a maximum
clock skew --- which can be determined --- will allow us to have
correctness _and_ performance.

						- Ted
