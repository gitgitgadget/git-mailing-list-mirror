From: Jeff King <peff@peff.net>
Subject: Re: Benchmarks regarding git's gc
Date: Tue, 8 Nov 2011 16:58:12 -0500
Message-ID: <20111108215812.GB18529@sigill.intra.peff.net>
References: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
 <CA+sFfMdax6UYsi2ojGWQT_TdPSMPGMGRZA3jz+VaENmbs4buzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 22:58:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNtgR-00025h-Vv
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 22:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab1KHV6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 16:58:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37174
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab1KHV6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 16:58:14 -0500
Received: (qmail 8506 invoked by uid 107); 8 Nov 2011 21:58:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 16:58:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 16:58:12 -0500
Content-Disposition: inline
In-Reply-To: <CA+sFfMdax6UYsi2ojGWQT_TdPSMPGMGRZA3jz+VaENmbs4buzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185116>

On Tue, Nov 08, 2011 at 10:40:15AM -0600, Brandon Casey wrote:

> On Tue, Nov 8, 2011 at 5:34 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Has anybody seen these?
> > http://draketo.de/proj/hg-vs-git-server/test-results.html#results
> >
> > Seems like a potential area of improvement.
> 
> I think this is a case of designing the problem space so that your
> intended winner wins and your intended loser loses.

Sort of. It is a real problem space, and mercurial does have some
advantage in that area.

His problem definition is that of a git-backed server database that is
under constant load creating new commits. So imagine wikipedia backed by
git.

Mercurial's strategy (as I understand it) is to always calculate and
store deltas as new commits are created. Git's strategy is to store full
objects, and then worry about deltification later. So of course git is
going to do more work, and especially more I/O.

Git's strategy is fine for the workload for which it was designed:
people making commits in burst, and occasionally doing book-keeping to
make things smaller.

But for a constant-commit workflow, the burstiness is annoying, and the
amount of I/O can be cumbersome.  We realized this long ago when
importing old histories into git. And that's why fast-import was born:
it does at least a minimal level of delta and puts everything into a
single packfile, instead of writing out loose objects.

If you were writing commits at some fast constant rate into your
repository, then you'd probably want to do the same thing. And it would
be fairly easy to do on top of git's object model. At best, it's just a
specialized commit command (like fast-import), and at worst it's
probably a more incremental object store.

So he may have a point that mercurial might perform better for some
metrics than git in the current state. But I think a lot of that is
because nobody has bothered putting git into this situation and done the
tweaks needed to make it fast. You can argue that git sucks because it
needs tweaking, of course, but if I were picking between the two systems
to implement something like this, I'd consider picking git and doing the
tweaks (of course, I'm far from unbiased).

-Peff
