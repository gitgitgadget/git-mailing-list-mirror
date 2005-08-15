From: tony.luck@intel.com
Subject: Some tutorial text (was git/cogito workshop/bof at linuxconf au?)
Date: Mon, 15 Aug 2005 12:17:41 -0700
Message-ID: <200508151917.j7FJHfFv009367@agluck-lia64.sc.intel.com>
References: <46a038f90508130034858ad34@mail.gmail.com> 
 <Pine.LNX.4.58.0508131111270.19049@g5.osdl.org> <46a038f905081316056e83ebec@mail.gmail.com>
Cc: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 21:19:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4kTo-0007zx-IC
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 21:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVHOTRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 15:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVHOTRx
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 15:17:53 -0400
Received: from fmr23.intel.com ([143.183.121.15]:17053 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964892AbVHOTRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 15:17:52 -0400
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7FJHfJ3022508;
	Mon, 15 Aug 2005 19:17:41 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7FJ9Upw022452;
	Mon, 15 Aug 2005 19:09:30 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j7FJHfXk009368;
	Mon, 15 Aug 2005 12:17:41 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j7FJHfFv009367;
	Mon, 15 Aug 2005 12:17:41 -0700
To: Linus Torvalds <torvalds@osdl.org>
cc: GIT <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508131625010.3553@g5.osdl.org>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> I'll happily help anybody who wants to try to write some nice
> documentation (answer questions etc), but I'm just not very good at doing
> it myself.

Here's something that I've been putting together on how I'm using
GIT as a Linux subsystem maintainer.

I suspect that I'm a bit slap-happy with the "git checkout" commands in
the examples below, and perhaps missing some of the _true-git_ ways of
doing things.

-Tony

Linux subsystem maintenance using GIT
-------------------------------------

My requirements here are to be able to create two public trees:

1) A "test" tree into which patches are initially placed so that they
can get some exposure when integrated with other ongoing development.
This tree is available to Andrew for pulling into -mm whenever he wants.

2) A "release" tree into which tested patches are moved for final
sanity checking, and as a vehicle to send them upstream to Linus
(by sending him a "please pull" request.)

Note that the period of time that each patch spends in the "test" tree
is dependent on the complexity of the change.  Since GIT does not support
cherry picking, it is not practical to simply apply all patches to the
test tree and then pull to the release tree as that would leave trivial
patches blocked in the test tree waiting for complex changes to accumulate
enough test time to graduate.

Back in the BitKeeper days I achieved this my creating small forests of
temporary trees, one tree for each logical grouping of patches, and then
pulling changes from these trees first to the test tree, and then to the
release tree.  At first I replicated this in GIT, but then I realised
that I could so this far more efficiently using branches inside a single
GIT repository.

So here is the step-by-step guide how this all works for me.

First create your work tree by cloning Linus's public tree:

 $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work

Change directory into the cloned tree you just created

 $ cd work

Make a GIT branch named "linus", and rename the "origin" branch as linus too:

 $ git checkout -b linus
 $ mv .git/branches/origin .git/branches/linus

The "linus" branch will be used to track the upstream kernel.  To update it,
you simply run:

 $ git checkout linus && git pull linus

you can do this frequently (as long as you don't have any uncommited work
in your tree).

If you need to keep track of other public trees, you can add branches for
them too:

 $ git checkout -b another linus
 $ echo URL-for-another-public-tree > .git/branches/another

Now create the branches in which you are going to work, these start
out at the current tip of the linus branch.

 $ git checkout -b test linus
 $ git checkout -b release linus

These can be easily kept up to date by merging from the "linus" branch:

 $ git checkout test && git resolve test linus "Auto-update from upstream"
 $ git checkout release && git resolve release linus "Auto-update from upstream"

Set up so that you can push upstream to your public tree:

 $ echo master.kernel.org:/ftp/pub/scm/linux/kernel/git/aegl/linux-2.6.git > .git/branches/origin

and then push each of the test and release branches using:

 $ git push origin test
and
 $ git push origin release

Now to apply some patches from the community.  Think of a short
snappy name for a branch to hold this patch (or related group of
patches), and create a new branch from the current tip of the
linus branch:

 $ git checkout -b speed-up-spinlocks linus

Now you apply the patch(es), run some tests, and commit the change(s).  If
the patch is a multi-part series, then you should apply each as a separate
commit to this branch.

 $ ... patch ... test  ... commit [ ... patch ... test ... commit ]*

When you are happy with the state of this change, you can pull it into the
"test" branch in preparation to make it public:

 $ git checkout test && git resolve test speed-up-spinlocks "Pull speed-up-spinlock changes"

It is unlikely that you would have any conflicts here ... but you might if you
spent a while on this step and had also pulled new versions from upstream.

Some time later when enough time has passed and testing done, you can pull the
same branch into the "release" tree ready to go upstream.  This is where you
see the value of keeping each patch (or patch series) in its own branch.  It
means that the patches can be moved into the "release" tree in any order.

 $ git checkout release && git resolve release speed-up-spinlocks "Pull speed-up-spinlock changes"

After a while, you will have a number of branches, and despite the
well chosen names you picked for each of them, you may forget what
they are for, or what status they are in.  To get a reminder of what
changes are in a specific branch, use:

 $ git-whatchanged branchname ^linus | git-shortlog

To see whether it has already been merged into the test or release branches
use:

 $ git-rev-list branchname ^test
or
 $ git-rev-list branchname ^release

[If this branch has not yet been merged you will see a set of SHA1 values
for the commits, if it has been merged, then there will be no output]

Once a patch completes the great cycle (moving from test to release, then
pulled by Linus, and finally coming back into your local "linus" branch)
the branch for this change is no longer needed.  You detect this when the
output from:

 $ git-rev-list branchname ^linus

is empty.  At this point the branch can be deleted:

 $ rm .git/refs/heads/branchname

To create diffstat and shortlog summaries of changes to include in a "please
pull" request to Linus you can use:

 $ git-whatchanged -p release ^linus | diffstat -p1
and
 $ git-whatchanged release ^linus | git-shortlog
