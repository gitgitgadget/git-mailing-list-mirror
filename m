From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 18:25:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506301731220.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 00:20:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do7OO-0002Y6-2U
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 00:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVF3W1o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 18:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbVF3W1o
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 18:27:44 -0400
Received: from iabervon.org ([66.92.72.58]:54789 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263050AbVF3W1c (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 18:27:32 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Do7Tb-0001K9-00; Thu, 30 Jun 2005 18:25:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Linus Torvalds wrote:

> On Thu, 30 Jun 2005, Daniel Barkalow wrote:
> > 
> > I suspect that I'll be able to merge send-pack/receive-pack with
> > ssh-push/ssh-pull this evening, and then it'll have the feature of not
> > caring too much which side your command line is on.
> 
> The simple thing to do is to just get one commit at a time, see if you 
> have it already, parse if it not, and go on to the parents.
> 
> That would fit the current git-pull thing, and may be good enough, but it 
> has the downside that it can need a _lot_ of back-and-forth fecthing of 
> commit objects from the other side until you find the one you want. That's 
> going to be _very_ slow over a high-latency connection.
> 
> So what I'd suggest is:
> 
> 1- puller starts by just asking "what's your SHA1 for the ref I want"
> 
>    The puller wants to know this, because a common case may be that it 
>    already has it, in which case it doesn't need to do anything. But more 
>    importantly, the puller will need to know this anyway if it gets an 
>    object-pack, so that the puller can update it's FETCH_HEAD.

Already have this, for the non-pack case.

>  - At some point the server sees the first SHA1 it recognizes, and at that 
>    point the server will have to start working. It will just send back an 
>    "ok, got it" message (telling the client to not bother continuing to 
>    send it any more commit ID's), and then does
> 
> 	git-rev-list --objects ref-client-wants ^first-common-sha1 |
> 		git-pack-objects --stdout

Right.

>  - the client just unpacks the objects, and if successful, it puts the new 
>    top ref it got into FETCH_HEAD. It's now done.

Or wherever it's been told to, yes.

> And I do _not_ think that it makes a lot of sense to try to be symmetric.  
> For one thing, while a "git-send-pack" should update all the refs
> in-place, a "git-pull-pack" should _not_ update the ref, it should just
> set FETCH_HEAD instead and the puller can decide what he wants to do with
> that ref (possibly merge it, but possibly just make it be a new local
> branch "remote-branch").

My expectation is that the puller will have a ref "remote-branch", and
will therefore: (1) want to update it, and (2) know the last commit pulled
from it. In this situation, we can skip figuring out the start (the two
points I didn't quote), because we saved it from before.

At least, this is how I've always done it; I've got a "linus" branch that
follows the public repo, and I commit changes to a different branch. I
suppose one could skip hanging onto this info, but it seems like an
obviously useful thing to keep, if for no other reason than that I want to
diff against it. This is essentially promoting FETCH_HEAD to a refs/heads/
thing, and having separate ones when you pull from separate sources.

I suppose things are different if you do a lot of one-shot pulls, rather
than tracking branches that you pull from; I'll need to think about this
case (assuming that's actually what you do).

	-Daniel
*This .sig left intentionally blank*
