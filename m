From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "git-send-pack"
Date: Fri, 1 Jul 2005 01:01:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507010033080.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506301655310.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 06:57:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoDZz-0002RF-GD
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 06:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbVGAFDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 01:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbVGAFDh
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 01:03:37 -0400
Received: from iabervon.org ([66.92.72.58]:37380 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263219AbVGAFDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 01:03:09 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DoDeD-0002VZ-00; Fri, 1 Jul 2005 01:01:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301655310.14331@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Linus Torvalds wrote:

> On Thu, 30 Jun 2005, Daniel Barkalow wrote:
> > 
> > My expectation is that the puller will have a ref "remote-branch", and
> > will therefore: (1) want to update it, and (2) know the last commit pulled
> > from it. In this situation, we can skip figuring out the start (the two
> > points I didn't quote), because we saved it from before.
> 
> This is _never_ how I do things, so I think that's a bad expectation. I 
> have other peoples trees "just show up", since they are actually based on 
> mine..

Okay, so my next task will be to support this case.

What I'm doing now is:

 - if the source is using an old version, fall back on individual objects

 - send one (or more) ids to exclude

 - find out if the server recognized any of the ids

 - if not, fall back on transferring individual objects (or we could try
   another batch)

 - request a pack for the given hash, excluding whatever we've said to
   exclude

I've implemented this for the case of updating a head, and got it to
transfer a pack of 11 objects. It took 31s (including connecting) to
transfer the entire history of git (3973 objects) over a DSL-DSL link with
a 39ms ping time. I sent the same thing with the old method previously,
and it took ages (wasn't timing it, though).

It should be possible to notice that we're not updating a ref, send all
the refs you have instead, see if the source recognized any, try again
with the next 70 commits, check, and repeat. Does this match what you were
suggesting?

I can send you the messy version tomorrow if you want to hack on it or
test it, and I'll have a clean patch series over the weekend.

	-Daniel
*This .sig left intentionally blank*
