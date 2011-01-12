From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Tue, 11 Jan 2011 20:25:15 -0500
Message-ID: <20110112012515.GA30856@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <7vsjx449bv.fsf@alter.siamese.dyndns.org>
 <7vipy0483h.fsf@alter.siamese.dyndns.org>
 <20110111065207.GF10094@sigill.intra.peff.net>
 <7vvd1v4bmt.fsf@alter.siamese.dyndns.org>
 <20110111180208.GC1833@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 02:25:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcpSq-0005Rb-Kd
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 02:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab1ALBZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 20:25:23 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44473 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393Ab1ALBZW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 20:25:22 -0500
Received: (qmail 17408 invoked by uid 111); 12 Jan 2011 01:25:19 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 12 Jan 2011 01:25:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 20:25:15 -0500
Content-Disposition: inline
In-Reply-To: <20110111180208.GC1833@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165001>

On Tue, Jan 11, 2011 at 01:02:08PM -0500, Jeff King wrote:

> On Tue, Jan 11, 2011 at 09:02:18AM -0800, Junio C Hamano wrote:
> 
> > > Also, one other question while we are on the subject. I think we all
> > > agree that "git checkout $foo" should prefer $foo as a branch. But what
> > > about "git checkout -b $branch $start_point"?
> > 
> > That has always been defined as a synonym for
> > 
> > 	git branch $branch $start_point && git checkout $branch
> > 
> > so $start_point is just a random extended SHA-1 expression.
> 
> That's what I would have expected, but I wanted to write a test to make
> sure it was the case.

Looking into this more, I'm not sure what the right behavior is. The
offending lines are in branch.c:create_branch:

        switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
        case 0:
                /* Not branching from any existing branch */
                if (explicit_tracking)
                        die("Cannot setup tracking information; starting point is not a branch.");
                break;
        case 1:
                /* Unique completion -- good, only if it is a real ref */
                if (explicit_tracking && !strcmp(real_ref, "HEAD"))
                        die("Cannot setup tracking information; starting point is not a branch.");
                break;
        default:
                die("Ambiguous object name: '%s'.", start_name);
                break;
        }

The die("Ambiguous...") blames all the way back to 0746d19 (git-branch,
git-checkout: autosetup for remote branch tracking, 2007-03-08) and
seems to just be a regression there that we didn't catch.

Obviously we can loosen the die() there and just handle the ambiguous
case like the unique case. But I'm not sure how tracking should interact
with the branch/tag thing.

This code seems to be trying to only track branches, but it fails at
that. It actually will track _any_ ref. So I can happily do:

  git branch --track foo v1.5

and start tracking refs/tags/v1.5. Is that a bug or a feature?

And then that makes me wonder. What should:

  git branch --track foo ambiguity

do? Should it choose the branch, because that is more useful for
tracking? Or choose the tag? And if branch, then what should:

  git branch foo ambiguity

do? It won't track a tag unless --track is given explicitly. Should it
prefer a branch with implicit tracking, or an untracked tag?

I'm not sure. And to be honest I don't really care, because I think
people with ambiguous refs are little bit crazy anyway (after all, in
the current code it simply calls die()). But I think there is some
argument to be made that due to tracking, start_point is not _just_
a regular ref. We do care about its branchiness.

-Peff
