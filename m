From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add `ignore_missing_links` mode to revwalk
Date: Tue, 1 Apr 2014 03:54:52 -0400
Message-ID: <20140401075452.GB22591@sigill.intra.peff.net>
References: <533239ED.5040503@fb.com>
 <20140328100043.GA16502@sigill.intra.peff.net>
 <5339E2BD.3090303@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Siddharth Agarwal <sid0@fb.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 09:55:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUtXA-0001XT-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 09:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbaDAHyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 03:54:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:51562 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750786AbaDAHyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 03:54:54 -0400
Received: (qmail 12249 invoked by uid 102); 1 Apr 2014 07:54:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 02:54:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 03:54:52 -0400
Content-Disposition: inline
In-Reply-To: <5339E2BD.3090303@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245576>

On Mon, Mar 31, 2014 at 02:48:45PM -0700, Siddharth Agarwal wrote:

> On 03/28/2014 03:00 AM, Jeff King wrote:
> >From: Vicent Marti <tanoku@gmail.com>
> >
> >When pack-objects is computing the reachability bitmap to serve a
> >fetch request, it can erroneously die() if some of the UNINTERESTING
> >objects are not present. Upload-pack throws away HAVE lines from the
> >client for objects we do not have, but we may have a tip object
> >without all of its ancestors (e.g., if the tip is no longer reachable
> >and was new enough to survive a `git prune`, but some of its
> >reachable objects did get pruned).
> 
> Thanks for this patch. It looks pretty sensible.
> 
> Unfortunately, I can't provide feedback on running it in production
> because we've decided to set aside experimenting with bitmaps for a
> bit. I hope to get back to it in a couple of months.

Bummer. Thanks for taking a look at it.

I do think this patch is definitely fixing a bug, and needs to be
pursued.  We've been running with bitmaps in production on GitHub since
last summer, but have never run into this situation. However, I think it
is largely caused by our pruning parameters:

  1. We tend not to prune very often, and instead keep unreachable
     objects around as a safety mechanism.

  2. When we do prune, we use a very tight cutoff, rather than the
     default 2-week period. So the window of opportunity is much smaller
     for a repo to prune an object but not its descendant (typically
     either we keep both, or they both get pruned).

So if you do come back to it later, the fix should have filtered through
to "master" by then. :)

-Peff
