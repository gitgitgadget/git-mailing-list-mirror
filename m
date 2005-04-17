From: Linus Torvalds <torvalds@osdl.org>
Subject: First ever real kernel git merge!
Date: Sun, 17 Apr 2005 15:10:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171455070.7211@ppc970.osdl.org>
References: <20050417195935.GI1461@pasky.ji.cz>
 <Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>
 <20050417215854.H13233@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 00:05:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNHsl-0008OB-Rr
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVDQWIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVDQWIj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:08:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:59046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261501AbVDQWIf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 18:08:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HM8Rs4023026
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 15:08:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HM8Q3l010475;
	Sun, 17 Apr 2005 15:08:27 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417215854.H13233@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


It may not be pretty, but it seems to have worked fine!

Here's my history log (with intermediate checking removed - I was being
pretty anal ;):

	rsync -avz --ignore-existing master.kernel.org:/home/rmk/linux-2.6-rmk.git/ .git/
	rsync -avz --ignore-existing master.kernel.org:/home/rmk/linux-2.6-rmk.git/HEAD .git/MERGE-HEAD
	merge-base $(cat .git/HEAD) $(cat .git/MERGE-HEAD)
	for i in e7905b2f22eb5d5308c9122b9c06c2d02473dd4f $(cat .git/HEAD) $(cat .git/MERGE-HEAD); do cat-file commit $i | head -1; done
	read-tree -m cf9fd295d3048cd84c65d5e1a5a6b606bf4fddc6 9c78e08d12ae8189f3bd5e03accc39e3f08e45c9 a43c4447b2edc9fb01a6369f10c1165de4494c88
	write-tree 
	commit-tree 7792a93eddb3f9b8e3115daab8adb3030f258ce6 -p $(cat .git/HEAD) -p $(cat .git/MERGE-HEAD)
	echo 5fa17ec1c56589476c7c6a2712b10c81b3d5f85a > .git/HEAD 
	fsck-cache --unreachable 5fa17ec1c56589476c7c6a2712b10c81b3d5f85a

which looks really messy, because I really wanted to do each step slowly 
by hand, so those magic revision numbers are just cut-and-pasted from the 
results that all the previous stages had printed out.

NOTE! As expected, this merge had absolutely zero file-level clashes,
which is why I could just do the "read-tree -m" followed by a write-tree. 
But it's a real merge: I had some extra commits in my tree that were not
in Russell's tree, and obviously vice versa.

Also note! The end result is not actually written back to the corrent 
working directory, so to see what the merge result actually is, there's 
another final phase:

	read-tree 7792a93eddb3f9b8e3115daab8adb3030f258ce6
	update-cache --refresh
	checkout-cache -f -a

which just updates the current working directory to the results. I'm _not_
caring about old dirty state for now - the theory was to get this thing
working first, and worry about making it nice to use later.

A second note: a real "merge" thing should notice that if the "merge-base"  
output ends up being one of the inputs (it one side is a strict subset of
the other side), then the merge itself should never be done, and the
script should just update directly to which-ever is non-common HEAD.

But as far as I can tell, this really did work out correctly and 100% 
according to plan. As a result, if you update to my current tree, the 
top-of-tree commit should be:

	cat-file commit $(cat .git/HEAD)

	tree 7792a93eddb3f9b8e3115daab8adb3030f258ce6
	parent 8173055926cdb8534fbaed517a792bd45aed8377
	parent df4449813c900973841d0fa5a9e9bc7186956e1e
	author Linus Torvalds <torvalds@ppc970.osdl.org> 1113774444 -0700
	committer Linus Torvalds <torvalds@ppc970.osdl.org> 1113774444 -0700

	Merge with master.kernel.org:/home/rmk/linux-2.6-rmk.git - ARM changes

	First ever true git merge. Let's see if it actually works.

Yehaa! It did take basically zero time, btw. Except for my bunbling about,
and the first "rsync the objects from rmk's directory" part (which wasn't
horrible, it just wasn't instantaneous like the other phases).

Btw, to see the output, you really want to have a "git log" that sorts by 
date. I had an old "gitlog.sh" that did the old recursive thing, and while 
it shows the right thing, the ordering ended up making it be very 
non-obvious that rmk's changes had been added recently, since they ended 
up being at the very bottom.

			Linus
