From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 20:13:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504152000570.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504152221070.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 05:08:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdfj-0007FB-4n
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 05:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVDPDML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 23:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVDPDML
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 23:12:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:42928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbVDPDMD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 23:12:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G3Bss4001411
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 20:11:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G3BrcW031096;
	Fri, 15 Apr 2005 20:11:53 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504152221070.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Daniel Barkalow wrote:
> 
> So you want to merge someone else's tree into your committed state, and
> then merge the result with your working directory to get the working
> directory you continue with, provided that the second merge is trivial?

No, you don't even "merge" the working directory.

The low-level tools should entirely ignore the working directory. To a
low-level merge, the working directory doesn't even exist. It just gets
three commits (or trees) and merges two of them with the third as a
parent, and does all of it in it's own temporary "merge working
directory".

So on a technical level, the "plumbing" part really really doesn't care at 
all.

However, from a _usability_ part, you expect after a merge that your 
working directory has been updated to be the merged tree. And that's where 
the "if I have a working tree that is dirty, I want that part to fail" 
comes in. In other words, the final phase (after the "tree-merge" has 
actually successfully already finished) is to go back to the working 
directory, and check out the merged results.

But that checkout would be a variation on "checkout-cache -a" which first
checks that none of the files it is going to overwrite are dirty.

Don't worry about this part. It's really totally separate from the true
merge itself. The "real work" has already been done by the time we notice
that "oops, we can't actually show him the newly merged tree, because he
has got dirty data where we want to show it".

> > I care. Even if the best common parent is 3 months ago, I care. I'd much 
> > rather get a big explicit conflict than a "clean merge" that ends up being 
> > debatable because people played games with per-file merging or something 
> > questionable like that.
> 
> Are you thinking that the best common ancestor is the one that ties up
> absolutely all of the chains of commits, or the closest one that the sides
> have in common?

The closest common one.

> For the latter, there are sometimes multiple ancestors which fit this
> criterion

Yes. Let's just pick one at random (or more likely, the latest one by 
date - let's not actually be _random_ random) at first. 

There are other heuristics we can try, ie if it turns out that it's common
to have a couple of alternatives (but no more than some small number, say
five or so), we can literally just -try- to do a tree-only merge, and see
how many lines out common output you get from "diff-tree".

Because that "how mnay files do we need to merge" is the number you want
to minimize, and doing a couple of extra "diff-tree" + "join"  operations
should be so fast that nobody will notice that we actually tried five
different merges to see which one looked the best.

But hey, especially if the merge fails with real clashes (ie there are
changes in common and running "merge" leaves conflicts), and there were
other alternate parents to choose, there's nothing wrong with just
printing them out and saying "you might try to specify one of these
manually".

I really don't think we should worry too much about this until we've 
actually used the system for a while and seen what it does. So just start 
with "nearest common parent with most recent date". Which I think you 
already implemented, no?

		Linus
