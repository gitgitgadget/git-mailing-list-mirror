From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Thu, 15 Oct 2009 15:03:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910151451120.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <m3bpk8g6nj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:11:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyVj3-00050f-SG
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 21:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762909AbZJOTE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762906AbZJOTE1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 15:04:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35422 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762117AbZJOTE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 15:04:26 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRK0043CKY8S380@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Oct 2009 15:03:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3bpk8g6nj.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130412>

On Thu, 15 Oct 2009, Jakub Narebski wrote:

> James Pickens <jepicken@gmail.com> writes:
> 
> > I think this would help the newbies and wouldn't cost the experts too much.
> > Checking out anything other than a plain ref would still detach the head, and
> > commits on a detached head would still be allowed.
> 
> I think it is a very good idea.
> 
> This makes it easy to checkout remote-tracking branch or a tag for
> viewing, something that was (I think) one of problems (use cases) that
> lead to invention of detached HEAD... and then it turned out that
> detached HEAD (unnamed branch) is scary for newbie git users.  (So the
> difficulty of having to create new branch or rewind some branch to
> view non-committable ref was replaced by scary detached HEAD concept.)

I don't think detached head is scary at all (unless viewed in another 
context other than git) but if that encounter can be kept away from most 
users without denying its use then all for the better.

> With this idea there are no problems with git commands that use
> detached HEAD such as git-bisect (which uses it in viewing mode, but
> then skips through history, so detached HEAD is a good solution here)
> or git-rebase (which does committing on detached HEAD for easier
> aborting and cleanup).

I do like and actively use manual committing on a detached HEAD as well, 
so please let's not forget about that use case.

> Let me propose additional feature: "smart" (context sensitive)
> warnings, namely that in the following sequence
> 
>   $ git checkout origin/master
>   $ git status
>   # On remote-tracking branch origin/master of remote origin
>   # ...

Sure.

>   $ git commit
> 
> 'git commit' would refuse committing on non-heads ref, and propose,
> beside _always_ proposing detaching HEAD and committing on such
> detached HEAD (unnamed branch) via "git checkout HEAD^0", or
> "git checkout --detach [HEAD]":

... or the current "this is not a local branch -- use checkout -b to 
create one" warning, just like what we have today when checking out a 
tag or remote branch, except that the warning is deferred to the commit 
operation which in fact might even not take place.

> 1. If there is no local branch which follows 'origin/master'
>    (which has 'origin/master' as upstream, which tracks 'origin/master')
>    propose creating it before comitting:
> 
>     $ git checkout -t origin/master
> 
> 2. If there is single local branch that follows 'origin/master',
>    and it fast-forwards to 'origin/master' propose... 
>    errr, something that would mean fast-forwarding this branch
>    and making a commit on local branch that has 'origin/master'
>    as upstream.
>    
> 3. If there is single local branch that follows 'origin/master', but
>    it has changes / diverges from 'origin/master' we are viewing,
>    propose... hmmm, what then?
> 
> 4. If there are more than one local branch that has 'origin/master'
>    as upstream, list all those branches in message.

I wouldn't go too far in that direction though.  Too many suggestions 
would simply bring back confusion to the new user who at that point 
might not even understand yet what all the different concepts are.


Nicolas
