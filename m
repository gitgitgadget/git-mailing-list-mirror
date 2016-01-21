From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] unpack-trees: fix accidentally quadratic behavior
Date: Thu, 21 Jan 2016 16:30:56 -0500
Message-ID: <20160121213056.GA6664@sigill.intra.peff.net>
References: <1453410708-23951-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 22:31:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMMor-0008S7-8t
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 22:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbcAUVbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 16:31:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:58162 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752109AbcAUVa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 16:30:59 -0500
Received: (qmail 15449 invoked by uid 102); 21 Jan 2016 21:30:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Jan 2016 16:30:59 -0500
Received: (qmail 24987 invoked by uid 107); 21 Jan 2016 21:31:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Jan 2016 16:31:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jan 2016 16:30:56 -0500
Content-Disposition: inline
In-Reply-To: <1453410708-23951-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284530>

On Thu, Jan 21, 2016 at 04:11:48PM -0500, David Turner wrote:

> While unpacking trees (e.g. during git checkout), when we hit a cache
> entry that's past and outside our path, we cut off iteration.
> 
> This provides about a 45% speedup on git checkout between master and
> master^20000 on Twitter's monorepo.  Speedup in general will depend on
> repostitory structure, number of changes, and packfile packing
> decisions.

I feel like I'm missing the explanation of the quadratic part. From
looking at the patch, my guess is:

  1. We're doing a linear walk in a data structure (a "struct
     index_state").

  2. For each element, we look it up in another structure
     ("struct traverse_info") with a linear search.

     That leaves us at O(m*n), but if we assume both are on the same
     order of magnitude, that's quadratic.

  3. The fix works by knowing that once a lookup in (2) fails once, it's
     likely to fail for all the remainder, and we short-cut that case
     and skip out of (1) completely.

But that makes me wonder. Aren't we still quadratic in the case that
ce_in_traverse_path() returns true? If so, would we benefit from either:

  a. Improving the complexity of ce_in_traverse_path, to say O(log n),
     which would give us O(n log n) for the whole operation in all
     cases?

  b. If both lists are already sorted, maybe doing a list-merge to
     compare them in O(2n) time?

I'm fairly ignorant of this part of the code, so there's probably a good
reason why my suggestion is unworkable.

-Peff
