From: Linus Torvalds <torvalds@osdl.org>
Subject: Re-done kernel archive - real one?
Date: Sat, 16 Apr 2005 16:01:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 00:56:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwCz-0001cF-MC
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDPW74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVDPW74
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:59:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:5582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261182AbVDPW7t (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:59:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GMxls4017631
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 15:59:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GMxkdB030483;
	Sat, 16 Apr 2005 15:59:47 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, nobody really objected to the notion of leaving the kernel history
behind for now, and in fact most people seemed to basically agree. So with
that decided, the old kernel testing tree was actually perfectly ok,
except it had been build up with the old-style commit date handling, which
made me not want to use it as a base for any real work.

So I re-created the dang thing (hey, it takes just a few minutes), and
pushed it out, and there's now an archive on kernel.org in my public
"personal" directory called "linux-2.6.git". I'll continue the tradition
of naming git-archive directories as "*.git", since that really ends up
being the ".git" directory for the checked-out thing.

I'm not going to announce it on linux-kernel yet, because I don't think
it's useful to anybody but a git person anyway. Besides, I don't actually
know how happy the kernel.org people are about this distribution method
and whether it ends up being a horrible disaster for the mirroring setup. 

Peter made some noises about /pub/scm, which makes sense, and would be a
better place than my public tree. Apparently there are other places that
are willing and able to host things too, so we'll see.

NOTE! The roughly 10x expansion of archive size goind from BK to git ends
up in a similar 10x bandwidth expansion, in addition to just the overhead
of reading tons of directory entries and comparing them (which is what
both a wget and rsync thing ends up doing). I'm sure we can bring that
down with smarter synchronization tools, but I also suspect that's some
way away.

So is real common usage, though, so maybe it's not that bad at all. Who 
knows. We haven't hit a single real snag so far (except it took several 
days longer than I expected, but hey, I expect lots of things ;), and I'm 
sure real usage will show lots of them.

Similarly, we don't really have real merging, which makes tracking harder, 
but I suspect actually having a tree out there will make people more 
motivated and have more of a test-case. I'm feeling good enough about the 
plumbing that I think I solved the "hard" part of it, and now it's just 
the boring 95% left - scripting around it.

I think that with the new merge model, the easiest thing to do is to just 
download all new objects, and then download the HEAD file under a new 
name.

Ie we have two phases to the merge: first get the objects, with something
like

	repo=kernel.org:/pub/kernel/people/torvalds/linux-2.6.git
	rsync --ignore-existing -acv $(repo)/ .git/

which will _not_ download the new HEAD file (since you already have one of 
your own), and then when you actually decide to merge you do

	rsync -acv $(repo)/HEAD .git/MERGE_WITH

and now you can look at your old HEAD, and the MERGE_WITH thing, look up 
the parents, and then do

	read-tree -m <parent-tree> <head-tree> <merge-with-tree>
	write-tree
	commit-tree <result-tree> -p <head-tree> -p <merge-with-tree>

(which should actually _work_, assuming that the merge had no file 
conflicts).

This seems to be a sane way to do merges, and if the scripting starts from 
there and then becomes smarter...

		Linus
