From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Tue, 6 Jul 2010 07:58:28 -0400
Message-ID: <20100706115826.GA15413@sigill.intra.peff.net>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705141012.GA25518@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 06 13:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW6nN-0000O8-Uq
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 13:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781Ab0GFL6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 07:58:32 -0400
Received: from peff.net ([208.65.91.99]:52104 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756438Ab0GFL6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 07:58:31 -0400
Received: (qmail 28360 invoked by uid 107); 6 Jul 2010 11:59:26 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 06 Jul 2010 07:59:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jul 2010 07:58:28 -0400
Content-Disposition: inline
In-Reply-To: <20100705141012.GA25518@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150343>

On Mon, Jul 05, 2010 at 10:10:12AM -0400, tytso@mit.edu wrote:

> As time progresses, the clock skew breakage should be less likely to
> be hit by a typical developer, right?  That is, unless you are
> specifically referencing one of the commits which were skewed, two
> years from now, the chances of someone (who isn't doing code
> archeology) of getting hit by a problem should be small, right?  This

It's not about directly referencing skewed commits. It's about
traversing history that contains skewed commits. So if I have a history
like:

  A -- B -- C -- D

and "B" is skewed, then I will generally give up on finding "A" when
searching backwards from "C" or "D", or their descendants. So as time
moves forward, you will continue to have your old tags pointing to "C"
or "D", but also tags pointing to their descendants. Doing "git tag
--contains A" will continue to be inaccurate, since it will continue to
look for "A" from "C" and "D", but also from newer tags, all of which
involve traversing the skewed "B".

What I think is true is that people will be less likely to look at "A"
as time goes on, as code it introduced presumably becomes less relevant
(either bugs are shaken out, or it gets replaced, or whatever). And
obviously looking at "C" from "D", the skew in "B" will be irrelevant.

So I think typical developers become less likely to hit the issue as
time goes on, but software archaeologists will hit it forever.

> If so, I could imagine the automagic scheme choosing a default that
> only finds the worst skew in the past N months.  This would speed up
> things up for users who are using repositories that have skews in the
> distant past, at the cost of introducing potentially confusuing edge
> cases for people doing code archeology.

How do you decide, when looking for commits that have bogus timestamps,
which ones happened in the past N months? Certainly you can do some
statistical analysis to pick out anomalous ones. And you could perhaps
favor future skewing over past skewing, since that skew doesn't tend to
impact traversal cutoffs (and large past skewing seems to be more
common). But that is getting kind of complex.

> I'm not sure this is a good tradeoff, but given in practice how rarely
> most developers go back in time more than say, 12-24 months, maybe
> it's worth doing.  What do you think?

I'm not sure. I am tempted to just default it to 86400 and go no
further.  People who care about archaeology can turn off traversal
cutoffs if they like, and as the skewed history ages, people get less
likely to look at it. We could also pick half a year or some high number
as the default allowable. The performance increase is still quite
noticeable there, and it covers the only large skew we know about. I'd
be curious to see if other projects have skew, and how much.

-Peff
