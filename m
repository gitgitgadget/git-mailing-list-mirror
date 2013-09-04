From: Jeff King <peff@peff.net>
Subject: Re: Transfer notes when rebasing
Date: Wed, 4 Sep 2013 04:28:03 -0400
Message-ID: <20130904082803.GA17308@sigill.intra.peff.net>
References: <CAC9WiBiSLMO+JM3aEHZ8xdwKE=jh+mDuo4REQ7rnQ-rTDNb9qA@mail.gmail.com>
 <20130904075310.GB9637@sigill.intra.peff.net>
 <20130904075941.GA2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Francis Moreau <francis.moro@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 04 10:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH8Ri-0001Gp-Vf
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934343Ab3IDI2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:28:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:34613 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab3IDI2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:28:07 -0400
Received: (qmail 30085 invoked by uid 102); 4 Sep 2013 08:28:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Sep 2013 03:28:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Sep 2013 04:28:03 -0400
Content-Disposition: inline
In-Reply-To: <20130904075941.GA2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233821>

On Wed, Sep 04, 2013 at 08:59:41AM +0100, John Keeping wrote:

> On Wed, Sep 04, 2013 at 03:53:10AM -0400, Jeff King wrote:
> > On Wed, Sep 04, 2013 at 09:51:26AM +0200, Francis Moreau wrote:
> > 
> > > When rebasing a branch which contains commits with notes onto another
> > > branch it happens that some commits are already presents in the target
> > > branch.
> > > 
> > > In that case git-rebase correctly drops those (already present)
> > > commits but it also drops the notes associated with them.
> > > 
> > > Can the notes be transfered somehow in the target branch on the
> > > already present commits ?
> > 
> > Yes, see the notes.rewriteRef config option to enable this.
> 
> Does that actually work for this case?  It sounds like Francis has the
> notes copying correctly when commits are rewritten but the notes are not
> copied anywhere if the commit becomes empty.

Ah, I misunderstood. If we are dropping commits from the rebase because
their counterpart is already applied upstream, then no, there isn't an
automatic way to do this.

If the commits are dropped because a commit with the same patch-id
already exists upstream, you could match them up by patch-id and copy
the notes. Annoyingly, while we have things like "log --cherry-mark" to
show which commits are already present on each side, I do not think
there is a way to correlate them commit for commit. So I think you are
stuck doing something in the shell like:

  patch_ids() {
    git rev-list "$1" |
    git diff-tree --stdin -p |
    git patch-id |
    sort
  }

  patch_ids $upstream..HEAD >us
  patch_ids HEAD..$upstream >them

  join us them |
  cut -d' ' -f2-3 |
  git notes copy --stdin

However, if the commit is dropped because we find while applying that it
becomes empty, there is not much we can do. It may have been obsoleted
by its counterpart patch that had a different patch-id, or it may even
have been obsoleted by unrelated patches. In the latter case, there is
nothing to copy to. In the former, you would have to trying to match up
the commit messages or similar to guess that the two commits correspond.

-Peff
