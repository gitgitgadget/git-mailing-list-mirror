From: Jeff King <peff@peff.net>
Subject: Re: git gc and worktrees
Date: Tue, 31 May 2016 18:14:15 -0400
Message-ID: <20160531221415.GA3824@sigill.intra.peff.net>
References: <574D382A.8030809@kdbg.org>
 <CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:14:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7rvd-0007s0-3O
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbcEaWOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:14:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:46773 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750730AbcEaWOT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:14:19 -0400
Received: (qmail 826 invoked by uid 102); 31 May 2016 22:14:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:14:18 -0400
Received: (qmail 27759 invoked by uid 107); 31 May 2016 22:14:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:14:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 18:14:15 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296020>

On Tue, May 31, 2016 at 07:02:15PM +0700, Duy Nguyen wrote:

> On Tue, May 31, 2016 at 2:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > Earlier this year I had a largish merge going on in a separate worktree.
> > With a mix of staged resolutions and unmerged paths in the index, I ran 'git
> > gc' in the main worktree. This removed a lot of objects that were recorded
> > in that separate worktree index. (I was able to recover them because the
> > content was still on disk.)
> >
> > Now I wanted to derive a test case that shows that breakage, but I am unable
> > to. The objects recorded in a separate worktree index, but not committed,
> > yet, are not pruned anymore.
> >
> > Have there been any fixes in this regard recently? Or does this look like
> > something else going on?
> 
> Not sure. I vaguely recall Jeff touched this pruning issue once,
> something about recent objects will not be pruned based on mtime. But
> maybe some of those objects in the index are not so young, and because
> I think we never check indexes in git-gc/git-prune, they have a chance
> to be deleted.
> 
> No I'm wrong. mark_reachable_objects() which is used by git-prune,
> does add objects from index and HEAD, which only covers those from
> _current_ worktree. This should be fixed even if it is not the root
> cause of your problem. I'll look into it.

Right, we use the index for reachability checks (both in "prune", but
also during a "repack -a", which uses the revision parser's
'--indexed-objects" option). That obviously should handle per-worktree
index files, but I don't know whether it currently does.

Michael (cc'd) noted to me off-list recently that there may be some
special cases there regarding reflogs in other worktrees (i.e., that we
don't always include them for our reachability checks). I don't know the
details, though.

The "recent object" stuff you're thinking of is that we will keep a
non-recent object X if it is referenced (directly or indirectly) by
another object Y that _is_ recent, but not otherwise reachable. That
should work independent of worktrees, because it finds the recent
objects directly in the object database, and then walks their graphs
(but it could indeed make writing tests a little trickier, as it may be
harder to convince some objects to get pruned in the first place).

-Peff
