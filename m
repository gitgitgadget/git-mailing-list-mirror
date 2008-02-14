From: Jeff King <peff@peff.net>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 11:31:01 -0500
Message-ID: <20080214163101.GA24673@coredump.intra.peff.net>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com> <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com> <18355.42595.377377.433309@lisa.zopyra.com> <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com> <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org> <20080214140152.GT27535@lavos.net> <alpine.LFD.1.00.0802140945520.2732@xanadu.home> <20080214151752.GB3889@coredump.intra.peff.net> <alpine.LFD.1.00.0802141103280.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:31:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPh01-0006we-Gc
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 17:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbYBNQbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 11:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbYBNQbH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 11:31:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2371 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271AbYBNQbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 11:31:05 -0500
Received: (qmail 8582 invoked by uid 111); 14 Feb 2008 16:31:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 11:31:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 11:31:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802141103280.2732@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73885>

On Thu, Feb 14, 2008 at 11:16:20AM -0500, Nicolas Pitre wrote:

> > How is that any different than accumulating old entries in reflog files
> > for branches that _do_ exist? In both cases, they should be dealt with
> > via time-based pruning.
> 
> Branches that do exist are more likely to be interesting to you than 
> branches that, hopefully in 99% of all cases, you willfully deleted.

I agree that they tend to be more interesting, but the point of reflogs
is to have a log of operations performed for later examination. We
already have a well-defined boundary for "interesting": things that are
older than N days. Why introduce another such boundary? Are your reflogs
for deleted branches so large that you aren't willing to keep them?

(There is actually one reason I can think of to get rid of reflogs for
deleted branches. Branch naming rules depend on which branches exist.
Thus I can have "foo/bar" only if "foo" does not exist, which means that
I can only have a reflog for "foo/bar" if the one for "foo" has been
deleted. But that is a limitation of the current scheme for storing
reflogs).

> >   1. it's much more convenient to type branch@{1} than to sift through
> >      HEAD's reflog looking for checkout events and guessing which branch
> >      we were on
> 
> Exact.  But that doesn't apply to non existent branches, surely?  And 
> what would you do with the reflog of a deleted branch when a new branch 
> is created with the same name?

I think it does. Reflogs protect against changes in the "commit" space
within a ref (things like "git reset HEAD^"). But there is no protection
against changes in the "ref" space (like "git branch -D foo").

As for the behavior, I would just append. Your reflog would look like:

  branch@{0} - commit
  branch@{1} - create branch
  branch@{2} - delete branch
  branch@{3} - commit

The behavior would be identical for recently logged items. But instead
of there being no branch@{3}, it would go back into the deleted branch.

> >   2. it's possible to change a ref without it being on the HEAD, in
> >      which case the HEAD reflog doesn't contain the change.
> 
> And in those cases this can't be due to your own modifications, hence 
> nothing valuable is lost if you then delete that branch.

For one thing, just because a modification wasn't _yours_ doesn't mean
it isn't valuable. It entered your repository, and therefore it may be
of interest.

Secondly, you _can_ change a ref without it being the HEAD. Try

  git branch -f foo bar

> > In other words, I don't see "oops, I deleted this branch and its history
> > is valuable to me" as significantly less likely than "oops, I got rid of
> > this commit and its history is valuable to me."
> 
> But you still have it, in the HEAD reflog, at least for your own 
> changes. I therefore don't see the value of having to keep named branch 
> reflogs around just for the small convenience, especially with the 
> semantic issues that comes with it.

My HEAD reflog has almost 1000 items in it. Finding out which commit
would have been branch@{0} in there is non-trivial.

I agree that this information is less likely to be interesting than the
usual use of reflogs. But I don't agree that the semantics are that
difficult. What issues are you talking about?

-Peff
