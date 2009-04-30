From: Jeff King <peff@peff.net>
Subject: Re: question about a merge result
Date: Thu, 30 Apr 2009 11:42:40 -0400
Message-ID: <20090430154240.GA27416@coredump.intra.peff.net>
References: <38b2ab8a0904300521m9e31867j7848135acfae0faa@mail.gmail.com> <49F99AE3.5090406@gmx.net> <20090430142635.GB23550@coredump.intra.peff.net> <38b2ab8a0904300805j5ce19617mdda3254c37d06d38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Gaber <Michael.Gaber@gmx.net>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 17:43:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzYQL-0005bd-9C
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 17:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbZD3Pmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 11:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbZD3Pmx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 11:42:53 -0400
Received: from peff.net ([208.65.91.99]:43213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762459AbZD3Pmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 11:42:47 -0400
Received: (qmail 19785 invoked by uid 107); 30 Apr 2009 15:43:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 30 Apr 2009 11:43:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2009 11:42:40 -0400
Content-Disposition: inline
In-Reply-To: <38b2ab8a0904300805j5ce19617mdda3254c37d06d38@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118028>

On Thu, Apr 30, 2009 at 05:05:19PM +0200, Francis Moreau wrote:

> Well, obviously it's how git works since it's what I got.

Yes, I meant also "this is what it is supposed to do, by design".

> But the question was more about if the cortectness of the end result:
> should 'B' removed after the merge.
> 
> IOW if someone works on its own branch remove B file and thought it
> was a bad idea and restore it whereas another person remove B file but
> miss the fact that it was a bad idea, does the merge should silently
> remove B file ?

Yes, it should be removed. And it has nothing to do with removal. Both
branches performed some action, but only one reverted it. Thus you still
have one branch wanting to make the change, and the other side leaving
it alone (in aggregate). So we want to take the changed side.

The only other thing that might make sense would be a conflict (because
both sides touched the same area and ended with different results). Git
doesn't try to find such a conflict because:

  1. Fundamentally, git cares about endpoints, not changelogs. So by
     design, you can arrive at the same tree state by many different
     routes and the merge will still happen in the same way.

  2. Finding such a conflict in the general case would be quite
     expensive, because you have to track every bit of content changed
     on one branch through every commit on the other branch, to see if
     they ever overlap.

If you want the result of the merge to keep it, you should do one of:

  - revert the removal in _both_ branches

  - merge with "--no-commit", add it back in, and then commit. The
    resulting commit will be a merge commit with the state you specify.

  - merge the early part of one branch, with the removal, into the other
    branch. Then "removed" becomes your basis for comparison, and then
    when you re-merge, the branch that re-adds it will be the only
    change.

-Peff
