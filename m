From: Nicolas Pitre <nico@cam.org>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 12:32:07 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802141147200.2732@xanadu.home>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
 <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
 <18355.42595.377377.433309@lisa.zopyra.com>
 <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com>
 <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org> <20080214140152.GT27535@lavos.net>
 <alpine.LFD.1.00.0802140945520.2732@xanadu.home>
 <20080214151752.GB3889@coredump.intra.peff.net>
 <alpine.LFD.1.00.0802141103280.2732@xanadu.home>
 <20080214163101.GA24673@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:33:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhxM-00082D-0e
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758809AbYBNRcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbYBNRcK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:32:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62253 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758559AbYBNRcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:32:08 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW800HZROPJ9MA0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Feb 2008 12:32:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080214163101.GA24673@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73897>

On Thu, 14 Feb 2008, Jeff King wrote:

> On Thu, Feb 14, 2008 at 11:16:20AM -0500, Nicolas Pitre wrote:
> 
> > > How is that any different than accumulating old entries in reflog files
> > > for branches that _do_ exist? In both cases, they should be dealt with
> > > via time-based pruning.
> > 
> > Branches that do exist are more likely to be interesting to you than 
> > branches that, hopefully in 99% of all cases, you willfully deleted.
> 
> I agree that they tend to be more interesting, but the point of reflogs
> is to have a log of operations performed for later examination. We
> already have a well-defined boundary for "interesting": things that are
> older than N days. Why introduce another such boundary? Are your reflogs
> for deleted branches so large that you aren't willing to keep them?

I typically have lots of branches.  Many of those are fairly dynamic -- 
they come and go.  Keeping reflogs for them would only clutter the 
reflog space, especially when the same names are reused.  I prefer to 
have a clean reflog for the currently alive branch of a given name 
rather than having a log of anything that occurred under that name.  And 
if I really want to find out about that old branch then there is always 
the HEAD reflog.

> (There is actually one reason I can think of to get rid of reflogs for
> deleted branches. Branch naming rules depend on which branches exist.
> Thus I can have "foo/bar" only if "foo" does not exist, which means that
> I can only have a reflog for "foo/bar" if the one for "foo" has been
> deleted. But that is a limitation of the current scheme for storing
> reflogs).

Sure, and that limitation is IMHO quite sane.  I don't think it is worth 
stretching it just for the convenience of having refs for deleted 
branches elsewhere than from the HEAD reflog.

> For one thing, just because a modification wasn't _yours_ doesn't mean
> it isn't valuable. It entered your repository, and therefore it may be
> of interest.

And if you delete it then you can retrieve it again from its origin.  
If, on the other hand, you _checkout_ that branch (it now entered the 
HEAD reflog), and _commit_ to it (which commit would be unreachable 
from other sources) then _that_ is a ref worth keeping a log of.

> Secondly, you _can_ change a ref without it being the HEAD. Try
> 
>   git branch -f foo bar

Sure.  And what information would become unreachable if you delete 'foo' 
at that point?  The 'bar' commit is not lost, and likely to still exist 
in some other reflog.

> > > In other words, I don't see "oops, I deleted this branch and its history
> > > is valuable to me" as significantly less likely than "oops, I got rid of
> > > this commit and its history is valuable to me."
> > 
> > But you still have it, in the HEAD reflog, at least for your own 
> > changes. I therefore don't see the value of having to keep named branch 
> > reflogs around just for the small convenience, especially with the 
> > semantic issues that comes with it.
> 
> My HEAD reflog has almost 1000 items in it. Finding out which commit
> would have been branch@{0} in there is non-trivial.

This is trivial.

$ git log -g HEAD | grep -C2 "^Reflog.*moving from branch to"

If the first hit is HEAD@{x} then your branch@{0} is just HEAD@{x+1}.

> I agree that this information is less likely to be interesting than the
> usual use of reflogs. But I don't agree that the semantics are that
> difficult. What issues are you talking about?

The naming of deleted reflogs when new branches with same name are 
created, or the concatenation of entries for unrelated branches that 
might happen to have existed under the same name.

And because the relevant entries are already in the HEAD reflog anyway, 
and trivially retrieved as demonstrated above, I don't think it is worth 
adding any additional complexity for what is only a convenience feature 
that is not supposed to be used many times a day after all.


Nicolas
