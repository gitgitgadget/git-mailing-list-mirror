From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Thu, 24 May 2012 21:04:34 -0400
Message-ID: <20120525010434.GA11861@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <201205241817.46034.mfick@codeaurora.org>
 <20120525003920.GB11300@sigill.intra.peff.net>
 <201205241854.56934.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri May 25 03:04:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXixd-0002NA-AY
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 03:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759606Ab2EYBEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 21:04:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54687
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869Ab2EYBEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 21:04:36 -0400
Received: (qmail 3111 invoked by uid 107); 25 May 2012 01:05:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 21:05:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 21:04:34 -0400
Content-Disposition: inline
In-Reply-To: <201205241854.56934.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198458>

On Thu, May 24, 2012 at 06:54:56PM -0600, Martin Fick wrote:

> > Yes, exclusively warm. And all of the refs were packed,
> > which makes the warm/cold difference less interesting
> > (it's one 30MB or so file).  I don't think there's much
> > point in thinking about the performance of 400K loose
> > refs (which would be absolutely horrific cold-cache on
> > most traditional filesystems). If you have that many,
> > you would want to keep the bulk of them packed.
> 
> Mostly true, except for one strange case still I think?
> 
> When cloning a gerrit repo, users to not get the changes 
> since they are not under refs/heads but refs/changes.  So 
> later, if they choose to fetch refs/changes/*, all of those
> new incoming refs are loose.

Hmm. Yeah, clone will always write a packed-refs file, but I think "git
fetch" will always write loose refs, under the assumption that the
former will be getting a lot more refs than the latter. But of course
that is only a guess. It would be nice if fetch could fetch straight
into packed refs if we are getting more than N items.

We'd have to give some thought to potential race conditions, though.
Usually pack-refs isn't modifying the ref, so it can just write out the
value to the packed-refs file, then delete the loose ref if nobody has
touched it since we wrote. But here we're combining it with a
modification, so I suspect there would be a race with another process
trying to modify it.

> Yes, someone should pack those 
> refs right away, but I think it actually churns the hell out 
> of my disk and takes a significant amount of time during the 
> initial fetch.  I am not certain about this, and the 
> behavior may depend on the filesystem in use, but I think 
> that this time might even be asynchronous (journals and 
> all), it feels like my disk keeps churning for a while even 
> after this is over.  I believe that this might still be the 
> worst case left with refs, and it can be pretty bad,

Yeah, I wouldn't be surprised if this thrashes your disk. Writing
hundreds of thousands of 40-byte files is one of the most awful loads
for many filesystems, since each file gets its own inode. I haven't
tried btrfs, but my impression is that it can magically pack the data
from many files into one node.

-Peff
