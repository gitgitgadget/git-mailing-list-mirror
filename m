From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Mon, 5 Jul 2010 08:27:23 -0400
Message-ID: <20100705122723.GB21146@sigill.intra.peff.net>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 05 14:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVklp-0007yq-FG
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 14:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758529Ab0GEM11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 08:27:27 -0400
Received: from peff.net ([208.65.91.99]:49957 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755583Ab0GEM10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 08:27:26 -0400
Received: (qmail 12070 invoked by uid 107); 5 Jul 2010 12:28:21 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 05 Jul 2010 08:28:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jul 2010 08:27:23 -0400
Content-Disposition: inline
In-Reply-To: <20100704005543.GB6384@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150260>

On Sat, Jul 03, 2010 at 08:55:43PM -0400, tytso@mit.edu wrote:

> > I noticed that my improved time for "git tag --contains" was similar to
> > the total time for "git rev-list --all >/dev/null". Can you try timing
> > that? My suspicion is that it is going to be about 2.9 seconds for you.
> 
> I'm at home, so getting access to my work machine is a bit of a pain,
> so I replicated the experiment at home.

Thanks. Those numbers confirm what I had been thinking.

> Yep, it does blow up in the face of the extreme clock skew in some of
> the ext4 commits in the Linux kernel tree.  (Sorry about that; mea
> culpa, I didn't realize at the time this was a problem, and it was my
> workflow using the guilt program which happened to introduce them.)

Yes, I was thinking specifically of those commits when I warned about
clock skew. :)

> In any case, because of the ext4 commits, I can show a test case which
> doesn't work well with your date cutoff patch:

Not surprising. I think you will find that "git name-rev" (or "git
describe --contains", which simply calls name-rev) will have similar
problems.

> (Or maybe we have git config options that can enable or disable
> optimizations that depend on the lack of clock skews; but I could
> understand people not wanting to maintian the extra code paths.)

I think the best thing we can do is provide a "how much clock skew to
tolerate" variable, and give it a sane default. Then people who know
they have skewed repositories can make the correctness-optimization
tradeoff as they see fit.

The extra code is very minor. It's really only a line or two of code
when calculating the cutoff date to convert "be thorough" into a cutoff
date of 0.

The real question is what that default should be. Name-rev already uses
86400 seconds. The worst skew in git.git is 8 seconds. The worst skew in
linux-2.6.git is 8622098 (about 100 days). For reference, here are my
timings on "git tag --contains HEAD~200" for various allowable clock
skew values:

  0 (don't allow even a second of clock skew): .035s
  86400 (one day of clock skew allowed): .034s
  8622098 (the worst skew in linux-2.6): .252s
  infinite (never cutoff for clock skew): 5.373s

So anything below a day is pointless and lost in the noise. Even 100
days yields quite a satisfactory speedup from the current code, but
obviously that number is totally arbitrary based on one repo.

As you probably guessed from the specificity of the number, I wrote a
short program to actually traverse and find the worst skew. It takes
about 5 seconds to run (unsurprisingly, since it is doing the same full
traversal that we end up doing in the above numbers). So we could
"autoskew" by setting up the configuration on clone, and then
periodically updating it as part of "git gc".

That is perhaps over-engineering (and would add a few seconds to a
clone), but I like that it would Just Work without the user doing
anything.

I'll follow this mail up with a series that implements a cleaned-up
version of the previous patches in this thread, and we'll see what
others think.

-Peff
