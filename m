From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] multi item packed files
Date: Thu, 21 Apr 2005 15:47:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504211530370.2344@ppc970.osdl.org>
References: <200504211113.13630.mason@suse.com> <Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org>
 <m3u0m0q69a.fsf@defiant.localdomain> <200504211622.48065.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Krzysztof Halasa <khc@pm.waw.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:41:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkM6-00011R-Uk
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDUWpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVDUWpb
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:45:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:31105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261200AbVDUWpU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 18:45:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3LMjDs4004078
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Apr 2005 15:45:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3LMjA1L029347;
	Thu, 21 Apr 2005 15:45:12 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504211622.48065.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, Chris Mason wrote:
> 
> Shrug, we shouldn't need help from the kernel for something like this.  git as 
> a database hits worst case scenarios for almost every FS.

I really disagree. 

> We've got:
> 
> 1) subdirectories with lots of files
> 2) wasted space for tiny files
> 3) files that are likely to be accessed together spread across the whole disk

On the other hand, git does a lot of things that are just _lovely_ for a 
filesystem:

 - it never rewrites a file. Rewriting a file is unquestionably _the_ 
   single worst access pattern for any filesystem. In contrast, never
   writing to a file again means that filesystems can optimize their
   layout and that things like defragmentation actually works.

 - it caches beautifully, and efficiently. Part of it comes from never 
   modifying files after they are written (which means that any network 
   filesystem automatically breathes a huge sign of relief), but part of 
   it is that it always reads full files, and the layout is done so that 
   it really actually _uses_ everything it reads.

   It also caches beautifully on a memory subsystem level, largely for the
   same reasons.

 - it doesn't use tons of directories.

   You say that "subdirectories with lots of files" is painful, but that's 
   not really the whole story. A _deep_ directory structure tends to 
   actually be worse in many ways, because it's much easier to optimize a 
   flat directory structure than a deep one. In other words, git ends up 
   making name hashing etc _productive_. 

So yes, it's a bit wasteful. But it's wasteful of what is absolutely the
cheapest resource around: disk space. It's not a huge downside, and in
fact I really do believe that the biggest downside _by_far_ in diskspace
utilization is the _seek_ costs, not the space itself. Let's face it, 
anybody who wants three years of kernel archives and thinks that 3GB of 
disk is too much, has some serious problems.

The _seek_ issue is real, but git actually has a very nice architecture
even there: not only dos it cache really really well (and you can do a
simple "ls-tree $(cat .git/HEAD)" and populate the case from the results),
but the low level of indirection in a git archive means that it's almost
totally prefetchable with near-perfect access patterns.

In seeking, the real cost is synchronization, and the git model actually
means that there are very few seeks that have to be synchronized. You
could literally do the "ls-tree" thing and make an absolutely trivial
prefetcher that did the prefetching with enough parallellism that the
filesystem could probably get decent IO performance out of a disk.

In other words, we really could have a "git prefetch" command that would 
populate the cache of the current head quite efficiently. Because the data 
layout supports that.

		Linus
