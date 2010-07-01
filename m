From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 1 Jul 2010 11:03:31 -0400
Message-ID: <20100701150331.GA12851@sigill.intra.peff.net>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Thu Jul 01 17:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULJn-0001hi-7V
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581Ab0GAPDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 11:03:36 -0400
Received: from peff.net ([208.65.91.99]:53688 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696Ab0GAPDe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:03:34 -0400
Received: (qmail 6407 invoked by uid 107); 1 Jul 2010 15:04:28 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 01 Jul 2010 11:04:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jul 2010 11:03:31 -0400
Content-Disposition: inline
In-Reply-To: <20100701121711.GF1333@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150039>

On Thu, Jul 01, 2010 at 08:17:11AM -0400, tytso@mit.edu wrote:

> Yeah, I'm not talking about the tag and branch names that show up in
> the top gitk box (and which you can also get via git log --annotate).
> I'm specifically talking about what you get with:
> 
> 	git tags --contains <commit-id>

I think there is room for improving the speed of "git tag --contains".
Consider these two similar operations:

  $ time git name-rev HEAD~200
  HEAD~200 tags/v1.7.1-rc2~2

  real    0m0.060s
  user    0m0.048s
  sys     0m0.012s

  $ time git tag --contains HEAD~200
  v1.7.1
  v1.7.1-rc2
  v1.7.1.1
  v1.7.2-rc0
  v1.7.2-rc1

  real    0m2.179s
  user    0m2.156s
  sys     0m0.020s

Obviously the latter is producing the full list of tags, but both should
have to do a traversal starting at each tag ref.

It looks like "git tag --contains" is implemented as something like:

  for ref in `git tag -l`; do
    if `git merge-base $ref $commit | grep $commit`; then
      echo $ref
    fi
  done

except in C. But you can see we'll do a full merge-base calculation for
each tag. And that merge-base calculation may potentially go quite far
back in history.

The name-rev code has a simple heuristic that it stops traversing when
the timestamp of the traversed commit gets more than a day behind that
of $commit. This doesn't do well with clock skew, but can save a lot of
time in practice. We should perhaps consider something like that here.

I suspect we could do even better by sharing information between
traversals. That is, walk the graph from each ref, but retain marks on
commits between each walk. For a commit c, if walking down each parent
gets us to a root without hitting $commit, then we can mark "c" as not
possibly containing the commit. We can cut short any walk when we hit a
"c" that is already marked. So by traversing from "v1.7.1", if we find
that we do not contain $commit, we will have already marked v1.7.0,
v1.6.*, etc, and will not need to traverse them again.

When you do find one that contains $commit, you can also mark it as
"definitely contains", and you can stop a traversal that definitely
contains. So if we see something is in v1.7.0, then the traversal from
v1.7.1 only needs to go as far back as v1.7.0.

-Peff
