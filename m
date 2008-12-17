From: Jeff King <peff@peff.net>
Subject: Re: Git Notes idea.
Date: Wed, 17 Dec 2008 05:11:10 -0500
Message-ID: <20081217101110.GC18265@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com> <alpine.DEB.1.00.0812170003540.14632@racer> <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com> <alpine.DEB.1.00.0812170420560.14632@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 17 11:12:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCtOK-0004eb-C3
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 11:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYLQKLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 05:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYLQKLO
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 05:11:14 -0500
Received: from peff.net ([208.65.91.99]:3823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbYLQKLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 05:11:13 -0500
Received: (qmail 25262 invoked by uid 111); 17 Dec 2008 10:11:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Dec 2008 05:11:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2008 05:11:10 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812170420560.14632@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103330>

On Wed, Dec 17, 2008 at 04:43:57AM +0100, Johannes Schindelin wrote:

> > I agree, I haven't thought of any fix along these lines other than to 
> > make gc do the clean up.
> 
> I have, and IIRC I briefly mentioned it back then.  Basically, you will 
> have to add a "git notes gc" or some such, which basically reads in the 
> whole notes, traverses all reachable commits, marking the corresponding 
> notes, and then writes out all marked notes (leaving the other notes 
> behind).

I was thinking something similar, but I think it is even easier. Make
the rule "if we still have the object, then we still have the note".
That has three benefits:

 - implementation is simple: for each note $n, delete it unless
   has_sha1_file($n).

 - it handles notes on non-commit objects

 - it kills off notes when an object is _pruned_, not when it stops
   being _reachable_. So if I delete a branch with a commit found
   nowhere else, its notes will hang around until it is actually pruned.
   If I pull it from lost+found, I still keep the notes.

Note that all of this garbage collection of notes is really just
removing them from the most current notes _tree_. If the notes structure
is actually composed of commits, then old notes that are "deleted" will
still be available historically.

> I wonder why you speak as if none of that had been implemented yet.  From 
> my work, it is obvious that hashtable is better than sorted list (except 
> for the fan-out, which obviously wants to be an array), and from Peff's it 
> is obvious that we want to keep the hashtables in memory.

If he is planning on doing a separate pyrite implementation, then it
_hasn't_ been implemented yet. And I don't care there if he uses
hash tables or sorted lists or whatever. I think the most important
thing is getting down the design of the _data structure_, so that we can
have a compatible implementation inside git itself.

> > IMO notes are just a generallized tag.
> 
> IMO notes have nothing to do with a tag.  Tags point to commits (or other 
> objects, but that's beside the point here).  Notes are pointed _to_ by 
> commits.

I think maybe we are just talking about semantics, but I think notes are
not pointed to by commits. There is an external mapping of commits to
notes, which is very different. I can give you the commit without you
knowing the notes, or that the notes even exist.

But in practice, I don't know if this distinction is going to influence
any of the design or use.

> Has the tree changed?  Sure it has.  Because Junio committed and pushed 
> some changes.

I think it is safe to say the tree generally changes for rebase, but not
necessarily for something like an amended commit, or a pull of a patch
sent by mail. So there are times when it changes, and times when it
doesn't.

And if there were some simple way of handling the times when it didn't
change at no general cost, I think going that way would be fine. But:

> And the worst part about your idea to attach notes to trees rather than 
> commits:  For things like Acked-by:... you very much want to annotate the 
> commit, _not_ the tree.  The tree is useless here.  It says nothing about 
> the patch, nothing about the explanation, and nothing about the history.

This is a huge cost, IMHO. I think you generally want to annotate
commits, not trees, and the semantic difference is important (but again,
I think all of the proposals are capable of doing either -- but if you
want a "show me the notes on this commit" feature to interoperate, it
needs to pick one).

> > root/
> >      12/
> >          34567890123456789012345678901234567890/
> >              <type>
> 
> Funny.  That is Peff's proposal.

Clearly we have independent verification that it's a good idea. ;)

-Peff
