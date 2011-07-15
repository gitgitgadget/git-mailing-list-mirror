From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Fri, 15 Jul 2011 17:14:41 -0400
Message-ID: <20110715211441.GB1943@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
 <7vpqlb1k1g.fsf@alter.siamese.dyndns.org>
 <20110715204002.GC356@sigill.intra.peff.net>
 <7vzkkfz261.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:14:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhpij-0004Bc-6t
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab1GOVOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:14:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35288
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab1GOVOo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:14:44 -0400
Received: (qmail 27113 invoked by uid 107); 15 Jul 2011 21:15:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 17:15:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 17:14:41 -0400
Content-Disposition: inline
In-Reply-To: <7vzkkfz261.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177234>

On Fri, Jul 15, 2011 at 02:04:06PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>    So how about marking commits (using the metainfo-cache facility) that
> >>    has an ancestor (not necessarily its direct parent) that records a
> >>    younger timestamp (e.g. 1 is such a commit, as its ancestors include
> >>    things like 2 and 4)? There should be relatively small number of them,
> >>    and still_interesting() logic can be told to dig through such commits
> >>    even if everybody is uninteresting in the active list.
> > ...
> >>  * As to "tag --contains", when timestamp based heuristics breaks down is
> >>    when a tagged commit incorrectly records way young timestamp or the
> >>    "want" commit records way old timetsamp. I haven't thought things
> >>    through, but the same metainfo-cache may be useful to detect which
> >>    commit to dig through ignoring the cutoff heuristics.
> >
> > It can also break down if intermediate commits are wrong, because we
> > have to traverse backwards, and we may erroneously cutoff early.
> >
> > For example:
> >
> >    A--B--C
> >
> >    timestamp(A) = 2
> >    timestamp(B) = 1 # skewed!
> >    timestamp(C) = 3
> >
> > If tag=C and want=A, then we traverse backwards from C. We can't stop
> > immediately because we know that 2 < 3. But we go back to B, and see
> > that 2 > 1, and assume that A cannot possibly be an ancestor of B.
> 
> I envisioned that the metainfo-cache to help rev-list I mentioned earlier
> would mark B having an ancestor A that has a timestamp younger than it, so
> I think we can certainly notice that we have to "dig through" B.

Right. I thought you were talking about the case where we did not have
such a cache. But given your response, did you mean:

  If we have such a cache, then the only thing left to worry about is
  when we specifically ask about a commit (either a tag or a "want"
  commit) that is skewed.

That I agree with.

-Peff
