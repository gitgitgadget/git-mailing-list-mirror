From: Jeff King <peff@peff.net>
Subject: Re: Bug: Branch Deletion Doesn't Clean Up
Date: Thu, 4 Feb 2016 03:17:59 -0500
Message-ID: <20160204081759.GA23259@sigill.intra.peff.net>
References: <4AC354E1-9E78-42A8-9828-BF1C084A6CBB@me.com>
 <20160204075500.GA21161@sigill.intra.peff.net>
 <20160204081220.GA11434@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karl Moskowski <kmoskowski@me.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 09:18:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRF7A-0000Si-7z
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 09:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbcBDISD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 03:18:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:37275 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751816AbcBDISC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 03:18:02 -0500
Received: (qmail 16404 invoked by uid 102); 4 Feb 2016 08:18:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 03:18:02 -0500
Received: (qmail 374 invoked by uid 107); 4 Feb 2016 08:18:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 03:18:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 03:17:59 -0500
Content-Disposition: inline
In-Reply-To: <20160204081220.GA11434@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285410>

On Thu, Feb 04, 2016 at 05:12:20PM +0900, Mike Hommey wrote:

> > > It seems like git branch -d ascend the hierarchy (up to
> > > .git/refs/heads/), deleting any empty directories.
> > 
> > Yes, though it needs to be coupled with making the branch-creation
> > process more robust to races (since we might create "refs/heads/foo" in
> > order to make "refs/heads/foo/bar" while somebody else is deleting it to
> > get rid of "refs/heads/foo/baz").
> 
> Can't we come up with a system that would update packed-refs directly
> instead of creating files?

There are a few reasons not to:

  - it breaks backwards compatibility (unless we continue to create the
    directory in order to put the dot-lock in it, but then I don't think
    we've gained anything)

  - the usual update method for packed-refs is to take a dot-lock, do a
    whole-file update, and then atomically rename into place.  That
    makes writing a ref O(# of refs) instead of O(1), and increases lock
    contention on the packed-refs file.

  - if we abandon atomic renames as the update mechanism and just update
    in place via lseek/write, then we need read-locking, or we need to
    hope that a reader will never see a sheared write

But if we're willing to break compatibility, we should ditch packed-refs
entirely and move to a _real_ concurrent database. And there is work
underway already to do that (see David Turner's ref-backend-lmdb
series).

-Peff
