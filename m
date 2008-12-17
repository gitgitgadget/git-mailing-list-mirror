From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Notes idea.
Date: Wed, 17 Dec 2008 12:38:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812171233270.28560@intel-tinevez-2-302>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com> <alpine.DEB.1.00.0812170003540.14632@racer>
 <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com> <alpine.DEB.1.00.0812170420560.14632@racer> <20081217101110.GC18265@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 12:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCulE-0001Kw-Hu
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 12:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYLQLi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 06:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbYLQLi5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 06:38:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:58315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750859AbYLQLi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 06:38:56 -0500
Received: (qmail invoked by alias); 17 Dec 2008 11:38:54 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp052) with SMTP; 17 Dec 2008 12:38:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rBEtxhTUruHtDJu3pd1xql/xuz8RPtix9SEgMZr
	c/ZG6q19JrDYJt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20081217101110.GC18265@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103331>

Hi,

On Wed, 17 Dec 2008, Jeff King wrote:

> On Wed, Dec 17, 2008 at 04:43:57AM +0100, Johannes Schindelin wrote:
> 
> > > I agree, I haven't thought of any fix along these lines other than 
> > > to make gc do the clean up.
> > 
> > I have, and IIRC I briefly mentioned it back then.  Basically, you 
> > will have to add a "git notes gc" or some such, which basically reads 
> > in the whole notes, traverses all reachable commits, marking the 
> > corresponding notes, and then writes out all marked notes (leaving the 
> > other notes behind).
> 
> I was thinking something similar, but I think it is even easier. Make
> the rule "if we still have the object, then we still have the note".
> That has three benefits:
> 
>  - implementation is simple: for each note $n, delete it unless
>    has_sha1_file($n).
> 
>  - it handles notes on non-commit objects
> 
>  - it kills off notes when an object is _pruned_, not when it stops
>    being _reachable_. So if I delete a branch with a commit found
>    nowhere else, its notes will hang around until it is actually pruned.
>    If I pull it from lost+found, I still keep the notes.
> 
> Note that all of this garbage collection of notes is really just 
> removing them from the most current notes _tree_. If the notes structure 
> is actually composed of commits, then old notes that are "deleted" will 
> still be available historically.

Right.  So my original proposal to use separate refs for separate purposes 
might make sense again, so you can have private as well as public notes.

> > I wonder why you speak as if none of that had been implemented yet.  
> > From my work, it is obvious that hashtable is better than sorted list 
> > (except for the fan-out, which obviously wants to be an array), and 
> > from Peff's it is obvious that we want to keep the hashtables in 
> > memory.
> 
> If he is planning on doing a separate pyrite implementation, then it 
> _hasn't_ been implemented yet. And I don't care there if he uses hash 
> tables or sorted lists or whatever. I think the most important thing is 
> getting down the design of the _data structure_, so that we can have a 
> compatible implementation inside git itself.

Well, I don't care about pyrite.  As far as I am concerned, it might as 
well use an incompatible version.  I really don't care.

> > > IMO notes are just a generallized tag.
> > 
> > IMO notes have nothing to do with a tag.  Tags point to commits (or 
> > other objects, but that's beside the point here).  Notes are pointed 
> > _to_ by commits.
> 
> I think maybe we are just talking about semantics, but I think notes are
> not pointed to by commits. There is an external mapping of commits to
> notes, which is very different. I can give you the commit without you
> knowing the notes, or that the notes even exist.
> 
> But in practice, I don't know if this distinction is going to influence 
> any of the design or use.

You are correct, of course, that the commit does not point to the notes 
explicitely, by having a SHA-1 _in_ the commit object.  But the main point 
still stands: you go from commit to note, not from note to commit.  And 
this is in stark contrast to tags, where you go from tag to commit, _not_ 
from commit to tag.

That is a fundamental _difference_ between tags and notes, so that I 
refuse to accept the notion of notes being a generalized form of tags.

Ciao,
Dscho
