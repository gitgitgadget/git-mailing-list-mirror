From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 14:56:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181440020.15725@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org>
 <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk>
 <20050418223359.A16789@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:53:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNe9I-0005Bs-6S
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 23:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDRVzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 17:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVDRVzS
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 17:55:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:58779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261170AbVDRVzC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 17:55:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3ILsns4001396
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 14:54:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3ILsmZ8006425;
	Mon, 18 Apr 2005 14:54:49 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050418223359.A16789@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Russell King wrote:
> 
> Since this happened, I've been working out what state my tree is in,
> and I restored it back to a state where I had one dangling commit head,
> which was _my_ head.

For the future, if your tree gets messed up to the point where you say 
"screw it" and just want to go back in time, you can do this (it's 
equivalent to "undo" in BK speak):

	git log | less -S

	.. find which HEAD it was that you trusted..

In this case your HEAD before I merged with it was this one:

	df4449813c900973841d0fa5a9e9bc7186956e1e

So to get back to that one, you can do

	echo df4449813c900973841d0fa5a9e9bc7186956e1e > .git/HEAD

and now

	cat-file commit $(cat .git/HEAD) | head -1

gives you

	tree a43c4447b2edc9fb01a6369f10c1165de4494c88

so you can restore your checked-out state with

	read-tree a43c4447b2edc9fb01a6369f10c1165de4494c88
	checkout-cache -f -a
	update-cache --refresh

and your tree should be valid again.

Now, to remove any bogus objects, you can then run my "git-prune-script"
(look at it carefully first to make sure you realize what you are doing).

NOTE NOTE NOTE! This will _revert_ everything you had done after the 
"trusted" point. So you may not actually want to do this. Instead:

> It's very much like I somehow committed against the _parent_ of the
> head, rather than the head itself.

That's very common if you just forget to update your new ".git/HEAD" when 
you do a commit.

Again, it's the tools that make it a bit too easy to mess up. The 
"commit-tree" thing is supposed to really only be used from scripts (which 
would do something like

	result=$(commit-tree ...) && echo $result > .git/HEAD

but when doing things by hand, if you forget to update your HEAD, your 
next commit will be done against the wrong head, and you get dangling 
commits.

The good news is that this is not that hard to fix up. The _trees_ are all
correct, and the objects are all correct, so what you can do is just
generate a few new (proper) commit objects, with the right parents. Then
you can do the "git-prune-script" thing that will throw away the old
broken commits, since they won't be reachable from your new commits (even
though their _trees_ will be there and be the same).

So in this case:

	b4a9a5114b3c6da131a832a8e2cd1941161eb348
	+- e7905b2f22eb5d5308c9122b9c06c2d02473dd4f
	   +- dc90c0db0dd5214aca5304fd17ccd741031e5493 <-- extra dangling head
	   +- 488faba31f59c5960aabbb2a5877a0f2923937a3

you can do

	cat-file commit dc90c0db0dd5214aca5304fd17ccd741031e5493

to remind you what your old tree and commit message was, and then just 
re-commit that tree with the same message but with the proper parent:

	commit-tree xxxx -p 488faba31f59c5960aabbb2a5877a0f2923937a3

and then you need to do the same thing for the other commits (which will 
now need to be re-based to have the new commit-chain as their parents).

Then, when you fixed up the final one, remember to update .git/HEAD with 
its commit ID, and now the prune-thing will get rid of the old dangling 
commits that you just created new duplicates of.

		Linus
