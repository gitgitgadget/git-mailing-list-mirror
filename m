From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] cache-tree: avoid infinite loop on zero-entry tree
Date: Wed, 29 Oct 2014 14:52:50 -0400
Message-ID: <20141029185249.GA26740@peff.net>
References: <20141029171158.GA32188@peff.net>
 <xmqqppdayal7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 19:52:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjYMa-0004YG-Il
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 19:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbaJ2Swx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 14:52:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:34944 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751145AbaJ2Sww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 14:52:52 -0400
Received: (qmail 30198 invoked by uid 102); 29 Oct 2014 18:52:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 13:52:52 -0500
Received: (qmail 2148 invoked by uid 107); 29 Oct 2014 18:52:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 14:52:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2014 14:52:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqppdayal7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 11:50:12AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm a little iffy on this just because it is fixing one particular bug,
> > and I am sure there are probably a bunch of other ways to have a bogus
> > index. Fundamentally, I think we pretty much trust that the index was
> > not maliciously generated (unlike packfiles, for instance, which can
> > come from elsewhere).  Still, this is one step closer to safe, and the
> > bug was seen in the wild, so maybe it is worth doing.
> 
> Is it cheap to sanity-check the input when we map in the cache-tree
> upon read_cache()?  Then we can just invalidate the cache-tree,
> either in its entirety (easy) or just the bogus subpart (maybe not
> worth doing).

I think it is not super-expensive, but it is not as easy as:

  if (!it->entry_count)
	return -1;

> > We could alternatively (or in addition) reject 0-entry cache trees when
> > reading them from disk. The trick, though, is that it is not just
> > records with 0 entries, but ones where the sum of the entries and
> > subtree entries is 0. Given that it is not something we expect to
> > happen, it is easier to catch it here. And we know there can be no
> > regressions for missed corner cases, because the case we are catching
> > here would _always_ have gone into an infinite loop before this patch.
> 
> OK.  I wonder if we can instead die here but propagate the error
> back up the callchain and have the ultimate caller rebuild the cache
> tree without paying attention to the existing data that we now know
> is bogus.

Yeah, that would make sense to me, but I was not familiar with the
cache-tree code to do it easily (and given that this is not something
that should ever happen, I didn't want to spend time digging in).

I can provide you with a real-world test case if you want to explore it
further.

-Peff
