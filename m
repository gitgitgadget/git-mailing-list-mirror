From: Jeff King <peff@peff.net>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 15:30:30 -0400
Message-ID: <20140522193030.GA22383@sigill.intra.peff.net>
References: <1400775763.1933.5.camel@stross>
 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
 <1400782642.18134.8.camel@stross>
 <20140522183930.GB1167@sigill.intra.peff.net>
 <1400785669.18134.21.camel@stross>
 <20140522190959.GA18785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 22 21:30:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnYhI-0003x1-6N
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbaEVTac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:30:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:57607 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbaEVTac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:30:32 -0400
Received: (qmail 19440 invoked by uid 102); 22 May 2014 19:30:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 14:30:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 15:30:30 -0400
Content-Disposition: inline
In-Reply-To: <20140522190959.GA18785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249939>

[+cc Junio for cache-tree expertise]

On Thu, May 22, 2014 at 03:09:59PM -0400, Jeff King wrote:

> > > does show some improvement. Perhaps "git reset" is not writing out the
> > > cache-tree extension?
> [...]
> 
> Possibly. There is a call to prime_cache_tree in builtin/reset.c, which
> looks like it should trigger during a "mixed" or "hard" reset (and
> without arguments, you should have a mixed reset). But it doesn't seem
> to get called. I haven't traced it further.

So here's what's happening. The prime_cache_tree call is in reset_index,
and was added by:

  commit 6c52ec8a9ab48b50fc8bf9559467d5a4cf7eee3b
  Author: Thomas Rast <trast@student.ethz.ch>
  Date:   Tue Dec 6 18:43:39 2011 +0100
  
      reset: update cache-tree data when appropriate
      
      In the case of --mixed and --hard, we throw away the old index and
      rebuild everything from the tree argument (or HEAD).  So we have an
      opportunity here to fill in the cache-tree data, just as read-tree
      did.
      
      Signed-off-by: Thomas Rast <trast@student.ethz.ch>
      Signed-off-by: Junio C Hamano <gitster@pobox.com>

But that was counteracted by:

  commit 3fde386a40f38dbaa684c17603e71909b862d021
  Author: Martin von Zweigbergk <martinvonz@gmail.com>
  Date:   Mon Jan 14 21:47:51 2013 -0800
  
      reset [--mixed]: use diff-based reset whether or not pathspec was given
      
      Thanks to b65982b (Optimize "diff-index --cached" using cache-tree,
      2009-05-20), resetting with paths is much faster than resetting
      without paths. Some timings for the linux-2.6 repo to illustrate this
      (best of five, warm cache):
      
              reset       reset .
      real    0m0.219s    0m0.080s
      user    0m0.140s    0m0.040s
      sys     0m0.070s    0m0.030s
      
      These two commands should do the same thing, so instead of having the
      user type the trailing " ." to get the faster do_diff_cache()-based
      implementation, always use it when doing a mixed reset, with or
      without paths (so "git reset $rev" would also be faster).
      
      Timing "git reset" shows that it indeed becomes as fast as
      "git reset ." after this patch.
      
      Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
      Signed-off-by: Junio C Hamano <gitster@pobox.com>

We never call reset_index now, because we handle it via diff.  We could
call prime_cache_tree in this case, but I'm not sure if that is a good
idea, because it primes it from scratch (and so it opens up all those
trees that we are trying to avoid touching). I'm not sure if there's an
easy way to update it incrementally; I don't know the cache-tree code
very well.

-Peff
