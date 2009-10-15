From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Thu, 15 Oct 2009 14:51:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyVYy-0007nG-Pk
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 21:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155AbZJOSvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 14:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757871AbZJOSvn
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 14:51:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13388 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273AbZJOSvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 14:51:42 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRK003MQKD021J0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Oct 2009 14:51:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

I agree.

> Checking out anything other than a plain ref would still detach the 
> head, and commits on a detached head would still be allowed.  Perhaps 
> as an additional safety feature, Git could refuse to switch away from 
> a detached head if the head isn't reachable from any ref, and require 
> -f to override:
> 
> $ git checkout $sha1
> $ git commit
> $ git checkout master ;# complain
> $ git checkout -f master ;# ok

Nah.  This is obnoxious.  The usual "this is not a local branch" warning 
could be displayed at that point, and if one really ignores the warning 
then any commit made that way is always reachable through the reflog.  
You would have had to work a bit harder to detach HEAD already anyway, 
so at that point you're not supposed to be such a newbie anymore.

> Maybe I'm missing something and this all can't be done, but it seems simpler
> than the other options I've seen in this thread.

It is indeed simpler.  It makes the checkout command less verbose as 
well.  Only the commit command would need to warn the user and only if a 
forbidden operation is attempted (like committing on a non 
refs/heads/*). I think I like this.


Nicolas
