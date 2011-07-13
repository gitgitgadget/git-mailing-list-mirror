From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Wed, 13 Jul 2011 16:58:44 -0400
Message-ID: <20110713205844.GA15435@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
 <20110713072350.GA18614@sigill.intra.peff.net>
 <7vaach7wfh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 22:59:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh6WK-0002r0-Ku
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 22:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab1GMU6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 16:58:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52688
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab1GMU6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 16:58:47 -0400
Received: (qmail 29026 invoked by uid 107); 13 Jul 2011 20:59:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 16:59:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 16:58:44 -0400
Content-Disposition: inline
In-Reply-To: <7vaach7wfh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177081>

On Wed, Jul 13, 2011 at 01:33:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It takes barely any time to get the generation of the new commit, but we
> > spend .25 seconds writing the whole new cache file out. This could be
> > improved with a more clever disk format that contained a journal of
> > unsorted newly written entries. You'd still write the full cache out
> > once in a while, but the cost would be amortized.
> 
> This series consists of three somewhat related ideas:
> 
>  - A generic API to persistently annotate 20-byte keys (typically object
>    names);
> 
>  - Using that API to implement commit generation numbers;
> 
>  - Using commit generation numbers in "tag --contains" traversal.

Yup, I think that is accurate.

> I think the first one is independently a good change, but I have been
> wondering if the entire history needs to be annotated with the generation
> number for the goal of the third item. There may be stretches of history
> where timestamps are screwed up, but if the commits we should dig through
> while traversing (because they, their parents or their children record
> skewed timestamps) are minority in the history, the same generic API could
> be used to mark only these commits as such, by using far smaller number of
> disk I/Os, no?

I'm not sure it's workable. To use generations as a cutoff, even
for a subset the subset of commits with broken timestamps, you have to
know the generations of other commits, so you know where the cutoff is.
E.g., in "git tag --contains HEAD~1000", I want to search no farther
back than the generation of HEAD~1000. Which means I need to know what
its generation is, which involves going to the roots at least once. We
don't want to go to the roots on-demand and cache only that one value,
since doing so is expensive. So we may as well cache all generations
as we figure them out, not knowing which ones will be needed for future
traversals.

Or are you suggesting dropping generations entirely, and just using
marked-up commit timestamps (or even a flag saying "this timestamp is
bogus, don't use it for cutoffs")?  I sent such a patch with timings
earlier in this discussion (I can dig it up if you want). Even based on
a notes-cache[1], it's fast (because there aren't very many entries).

But there's a big question of deciding which timestamps are bogus. You
can only compare commits against their ancestors.  A commit skewed to
the past is easy to find; its timestamp is less than one of its
ancestors. But for a commit skewed to the future, its descendants will
all look skewed into the past.

I think we can write our algorithms such that future-skewed timestamps
don't give _wrong_ answers, but are just suboptimal (i.e., they may mark
many legitimate commits as "don't trust this timestamp for cutoff", even
though it is their future-skewed ancestor that is actually the problem).
But I think I still like generation numbers because:

  1. They're simple, complete, and unambiguous. It makes them easy to
     understand and use. And I suspect they can be applied in more
     places than just cutoff. For example, I seem to recall somebody
     mentioning that we could do topo-sorting much more efficiently with
     generation numbers. I'm not sure the same "future-skewed commits
     are correct but slow" property would hold there.

  2. The cache can be generated and maintained on the fly. A cache that
     is simply "if you are in this list, your timestamp is bogus"
     suffers from the problem I mentioned elsewhere. If a commit is not
     in the list, is the timestamp good, or has it simply not been
     checked yet?

If the performance numbers were way worse, I would be more inclined to
stay with a timestamp solution. But they're not really worse. The
performance for initial cache build is about the same (you have to go to
the roots in both cases), and the performance for using the cache is
about the same. The only slowness for the generation slowness is the
extra I/O on writing out the cache. But it's not very much, and it's
actually not that hard a problem to solve; I'm mainly leaving it because
I'm lazy. But it's not as if file system implementors and key/value
database designers haven't been solving the problem for the past 30
years.

-Peff

[1] If we did want to go the route of "is this commit in the set of
commits with bogus timestamps", you could probably make things even
simpler by using a fixed-size bloom filter. Sized appropriately, it will
occasionally give a false positive "this commit has a bogus timestamp".
But as discussed above, that is not going to cause a traversal cutoff to
do the wrong thing, but rather only to consider one extra commit it
might not have otherwise.
