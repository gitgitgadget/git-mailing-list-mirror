From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 13:51:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607141256170.9789@iabervon.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org> 
 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
  <1152840456.31372.75.camel@shinybook.infradead.org> 
 <Pine.LNX.4.64.0607132157370.5623@g5.osdl.org> <1152872626.3191.56.camel@pmac.infradead.org>
 <Pine.LNX.4.64.0607140843570.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 19:51:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Row-0008Og-5V
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 19:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWGNRvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 13:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWGNRvS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 13:51:18 -0400
Received: from iabervon.org ([66.92.72.58]:18445 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1422685AbWGNRvR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 13:51:17 -0400
Received: (qmail 12881 invoked by uid 1000); 14 Jul 2006 13:51:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Jul 2006 13:51:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607140843570.5623@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23900>

On Fri, 14 Jul 2006, Linus Torvalds wrote:

> On Fri, 14 Jul 2006, David Woodhouse wrote:
> 
> > On Thu, 2006-07-13 at 22:16 -0700, Linus Torvalds wrote:
> > > 
> > >         HEAD  ->     A
> > >                     / \
> > >                    B   C
> > >                   / \   \
> > >                  D   E   F
> > >                   \ /   / \
> > >                    G   H  I
> > >                   .......
> > > 
> > 
> > So working from your example above, and assuming that only commits I and
> > E actually change the files we care about. This means that merges A, B
> > and F are _also_ going to show up in the output of 'rev-list -- myfile'.
> 
> Not necessarily.
> 
> > So the slave tree will look like this:
> > 
> >         A'
> >        / \
> >       B'  F'
> >       |   |
> >       E'  I'
> 
> Yes, but ONLY IF the following is true: A is different from _both_ F and B 
> in the relevant files.

Actually, this is an unlikely result, because B' and F' wouldn't appear 
unless they either have multiple children that appear or they have new
modifications made to the files during the merge.

The result under the conditions that the only changes are in E and I is:

   A'
  / \
 E'  I'

Which, of course, is what you should expect: it only includes E, I, and 
merges which create a novel combination of changes (even if the changes 
they include have appeared alone before).

> NOTE NOTE NOTE! This is how "git rev-list" (and all the other related git 
> tools, like "git log" etc) simplify the tree. It is, in my opinion, the 
> only sane way to do it, although you can pass in "--full-history" to say 
> that you don't want any merge simplification at all.
> 
> The reason I mention it is that _your_ simplifications may obviously do 
> something else entirely, and you may obviously have different rules for 
> how you simplify the tree further. But it sounds like you don't simplify 
> the history at all (apart from the simplification that git-rev-list did 
> for you)?

It seems like we ought to be able to provide the simplification procedure 
to code that's done further filtering on the set of commits somehow, or 
provide a framework with a callback, but it's a non-trivial design.

I think that a program to generate a slave git tree based in some 
user-modifiable way on a parent repository would be useful and 
implementable. I'd thought a bunch about it a while ago, for extracting 
separable parts of projects (e.g., make a kbuild project that's pulled out 
of the kernel tree, but is still a regular git project to anyone who 
doesn't know this). My conclusion was that you need a cache of mappings, 
because otherwise you can't identify that you already have a transformed 
version of a commit, because you don't know its transformed parents, 
unless you've gone all the way back to the root (which doesn't have 
parents). But I think a "git2git" script wouldn't be any harder than the 
other import scripts, and would solve this problem nicely.

	-Daniel
*This .sig left intentionally blank*
