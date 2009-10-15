From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD  was
Date: Thu, 15 Oct 2009 11:36:51 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910151054190.32515@iabervon.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>  <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>  <alpine.LNX.2.00.0910141509200.32515@iabervon.org>  <alpine.LFD.2.00.0910141616530.20122@xanadu.home>  <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
  <alpine.LFD.2.00.0910141647390.20122@xanadu.home>  <7vws2xa9lu.fsf@alter.siamese.dyndns.org>  <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 17:42:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MySTX-0008Cp-Qb
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 17:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762837AbZJOPh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 11:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762810AbZJOPh3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 11:37:29 -0400
Received: from iabervon.org ([66.92.72.58]:34515 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760513AbZJOPh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 11:37:28 -0400
Received: (qmail 1734 invoked by uid 1000); 15 Oct 2009 15:36:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Oct 2009 15:36:51 -0000
In-Reply-To: <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130395>

On Thu, 15 Oct 2009, James Pickens wrote:

> On Wed, Oct 14, 2009 at 4:09 PM, Jeff King <peff@peff.net> wrote:
> > That makes the most sense to me. If "git checkout" could write metadata
> > into HEAD (or into DETACH_HEAD, as in Daniel's patch), then checkout
> > could record an "ok to commit" bit. And could also be used to change it
> > after the fact. E.g.:
> >
> >  $ git checkout --detach=commit origin/master
> >  $ git commit ;# should be ok
> >
> >  $ git checkout --detach=examine origin/master
> >  $ git commit ;# complain
> >  $ git checkout --detach=commit HEAD
> >  $ git commit ;# ok
> >
> > I guess something like "rebase" should detach with "ok to commit", since
> > it is planning on attaching the commits later. I'm not sure about "git
> > bisect". I guess probably it should be "not ok to commit" to be on the
> > safe side, and then somebody can "git checkout --detach=commit" if they
> > want to.
> 
> How about not detaching the head at all if the user checks out any ref, and
> reject commits if he checked out a tag or remote branch.  For example:
> 
> $ git checkout origin/master
> $ git status
> # On branch origin/master
> $ git commit ;# complain
>
> $ git checkout v1.0.1
> $ git status
> # On tag v1.0.1
> $ git commit ;# complain
> 
> $ git checkout v1.0.1^0 ;# detach
> $ git commit ;# ok
> 
> I think this would help the newbies and wouldn't cost the experts too much.
> Checking out anything other than a plain ref would still detach the head, and
> commits on a detached head would still be allowed.

I think reducing users' exposure to the "detached HEAD" state would just 
make it take longer for them to find that state familiar.

It's not like the concept is actually very difficult or unusual. CVS has 
it as "cvs checkout -r <something>" or "cvs checkout -D <something>"; SVN 
has it as "svn checkout -r <something>". It was weird and scary in CVS if 
you did it (it was "sticky tags", and you had to find a different option 
to get back to normal), but SVN is easier ("svn checkout -r HEAD").

I think the description used in CVS and SVN (and, I think, others) is that 
you're not at the HEAD revision. I think they both account for the state 
where you've checked out the revision by number that's the latest 
revision, but you still can't grow the branch because you can't 
simultaneously stay on r1000 (as requested explicitly) and add a new 
commit.

So maybe the right explanation is:

$ git checkout master; git branch
* master
$ git checkout origin/master; git branch
* origin/master (not at head)
$ git checkout 123cafe^5; git branch
* 123cafe^5 (not at head)
$ git checkout HEAD^2; git branch
* 123cafe^5^2
$ git commit; git branch
* (temporary branch)

Then we can say that one way that git is different from SVN is that all 
branches of other repositories are read-only, and you can't be at the 
head when you're on them (because the head of those branches are in 
different repositories); instead you grow the history locally, and you 
tell the remote branch to adopt your history.

> Perhaps as an additional safety feature, Git could refuse to switch away 
> from a detached head if the head isn't reachable from any ref

As far as I know, people don't actually seem to lose stuff this way. In 
part, that's because they get scared before they get there; in part, 
that's because they just don't think to go there; and in part, we tell 
them how to recover stuff at that point (using the ref log or the sha1).

	-Daniel
*This .sig left intentionally blank*
