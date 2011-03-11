From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Fri, 11 Mar 2011 00:22:35 -0500
Message-ID: <20110311052235.GA16605@sigill.intra.peff.net>
References: <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
 <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
 <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
 <7vipvq1hpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 06:22:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxuoI-000599-Li
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 06:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780Ab1CKFWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 00:22:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51339
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab1CKFWi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 00:22:38 -0500
Received: (qmail 2541 invoked by uid 107); 11 Mar 2011 05:23:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Mar 2011 00:23:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2011 00:22:35 -0500
Content-Disposition: inline
In-Reply-To: <7vipvq1hpw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168881>

On Thu, Mar 10, 2011 at 07:03:39PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Hmph, why?
> >
> > That 979f79 one already have enough other objects with similar names, so
> > compared to 83c3c that doesn't, it is natural that you would need more
> > digits to protect its uniqueness, no?
> 
> Yuck, this is showing my total non-understanding of statistics and secure
> hashing.  The example does not mean the next object we will create in
> git.git project somehow magically is more likely to have 979 prefix than
> 83c prefix.  In other words, 979f7929 is much less likely to collide with
> new objects than 83c3c, simply because it has 4 more digits in it (making
> the likelyhood of collision with the next one by four orders of magnitude
> in base-16), the likelyhood does not depend on what other objects happen
> to share the same prefix right now, and adding one digits to each would
> make it 1/16 less likely to have collision relative to the likelyhood with
> their current length.

This is basically the birthday problem used in hash collision analysis.
Which means that if we decide on some acceptable probability of
collision, we can figure out the hash-length required to keep the
probability of collision below that acceptable level for a repository
with objects.

You can find the formulas here:

  http://en.wikipedia.org/wiki/Birthday_problem

The closest version to what we want is:

  n(p,d) ~ sqrt(2d * ln(1/(1-p)))

where "n" is the number of objects in the repository, "p" is the
probability of a collision, and "d" is the size of the distribution
space. In our case, for sha1 subset with "l" hex characters, it is
2^(4l). And note that this is an approximation, but it should be close
enough for our purposes.

We can arrange the formula into:

  d(n,p) = n^2 / 2 / ln(1/(1-p))

and rearrange our length relationship into:

  l(d) = log2(d) / 4

Then we just pick an acceptable probability of collision. Let's say one
in a million, 10^-6.

So for a repository with 175,000 objects (close to git.git), to keep the
probability of collision at 10^-6, we get d(n,p) = 1.5e16, or 53 bits,
or 13 hex characters.

Which is obviously a lot more than we're doing now. But remember that
this is for _any_ collision. So it's not likely to be for one of the few
numbers you write down for reference later. So we could probably get by
with a much higher collision probability. At one-in-a-thousand, it's 43
bits or 10 characters.

Or we could just take it all the way down to 50%: we are likely to have
ae collision, but that's probably OK since it's unlikely to be one of
the n out of 175,000 that we actually remember and care about. That's 34
bits, or 8.5 hex characters.

For the kernel repository, there are 1.8 million objects. So to hit 50%,
we're talking about 41 bits or about 10 characters. Which, as a quick
sanity check, matches what Linus said earlier: they are seeing
collisions around the 10-character mark now in the kernel repo.

So all of this is more or less what Linus has been saying, but with
numbers and formulas to back it up.

One observation I should note are that these probabilities are what we
would guess knowing _nothing_ about what is in the repo. That is, if you
gave me an empty repo and told me you were going to populate it with N
objects, these are the probabilities I would calculate. But of course
the problem we actually have is that we already have N objects, and we
expect to have N+M at some point in the future; we already know which
collisions we have in the first N, and we want to future proof against
the next M.

So in theory we could say "we currently are unique at 8 characters; we
anticipate 50,000 new objects per year and want to future proof for 4
years (so M=200,000). What is the length we need to keep the probability
of collision for just this _one_ sha1 below some acceptable level?"

Which I think is just:

  p(M) = 1 - d^-M

but when I tried solving for d, I ended up with nonsensical numbers.
Which means I'm either wrong or I'm way too sleepy to be doing algebra.

Anyway, point being if we wanted to make a table of reasonable lengths
for repos with N objects, it would look like this (for p=0.5):

   N  | bits | hex
  ------------------
  1e2 |  13  |  3
  1e3 |  19  |  5
  1e4 |  26  |  7
  1e5 |  33  |  8
  1e6 |  39  | 10
  2e6 |  41  | 10
  5e6 |  44  | 11
  1e7 |  46  | 12

So '11' would take the kernel repo to 5 million objects, which is more
than doubling. 12 would take it to 10 million. Most smaller projects are
probably fine at 8 or 9.

But you can see that it takes quite a lot of objects to require a bump
in the hex length, meaning we don't need to re-check it very often. If
we really wanted to tweak it automatically, we could probably just set
core.defaultAbbrev (or whatever) during git-gc based on the number of
objects in the repository. We could do the formula, or even just have a
precomputed table (it would be the inverse of the table above, mapping
the switch points for hex characters to numbers of objects).

-Peff
