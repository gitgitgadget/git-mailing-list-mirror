From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Wed, 7 Jul 2010 13:45:46 -0400
Message-ID: <20100707174546.GA4979@coredump.intra.peff.net>
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
Content-Type: text/plain; charset=utf-8
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 19:45:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWYh1-000072-AQ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 19:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab0GGRpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 13:45:50 -0400
Received: from peff.net ([208.65.91.99]:50987 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab0GGRpt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 13:45:49 -0400
Received: (qmail 20371 invoked by uid 107); 7 Jul 2010 17:46:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Jul 2010 13:46:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jul 2010 13:45:46 -0400
Content-Disposition: inline
In-Reply-To: <1278430303.32094.15.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150485>

On Tue, Jul 06, 2010 at 04:31:43PM +0100, Will Palmer wrote:

> Is it wrong to expect that git perform poorly in the edge-cases (hugely
> skewed timestamps), but that it perform /correctly/ in all cases?

When you put it that way, yes, I think the ideal behavior is that we are
always correct, fast in the common case, and slow for edge cases.

But there are some fuzzy areas here:

  1. Is clock skew more than a day (or some number of seconds, whatever
     it may be) an edge case, or is it simply breakage in the repo? In
     an ideal world, it would simply be an edge case that causes
     slowdown. But git already implements traversal-cutoff based on
     date, at least in "git name-rev", so this is not a new issue. I
     know we also look at the date for some other traversals (in fact, I
     see lots of other cutoffs that don't even seem to have the one-day
     slop). But I haven't looked closely enough to see just what will
     break with a huge skew.

  2. Not implementing traversal-cutoff based on date doesn't slow just
     edge cases. It slows _all_ cases, by a factor of a hundred, on the
     off chance that you might have an edge case.

     By pre-calculating the per-repo max skew during clone and gc, you
     can turn it into your "always correct, slower for edge cases". But:

       a. It makes clone and gc a bit slower, even for non-edge cases.

       b. It is not _always_ correct, as you have a lag period between
          when skew is introduced into your repo (either by commit or by
          fetch) and when you gc it. But it's closer.

     And of course it's just complex, and I tend to shy away from
     complexity when I can. The question to me comes back to (1) above.
     Is massive clock skew a breakage that should produce a few
     incorrect results, or is it something we should always handle?

-Peff
