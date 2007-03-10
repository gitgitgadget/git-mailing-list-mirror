From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] fast-import slow on large directories
Date: Sat, 10 Mar 2007 14:15:15 -0500
Message-ID: <20070310191515.GA3416@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 20:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ72M-0003Jt-Af
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 20:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbXCJTPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 14:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbXCJTPT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 14:15:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4581 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751345AbXCJTPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 14:15:18 -0500
Received: (qmail 19120 invoked from network); 10 Mar 2007 14:15:38 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Mar 2007 14:15:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Mar 2007 14:15:15 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41877>

The short story:

I wanted to import into git a dataset consisting of a single directory
with 300,000 files. I tried using git-fast-import, but it wasn't able to
handle the large directory size. This patchset optimizes the algorithms
used for tree handling, and I get orders of magnitude improvements in
memory and CPU consumption.

The patches are (see commit messages for more explanation):

  1. grow tree storage more aggressively
  2. code rearranging to make patch 3 easier to read
  3. keep tree entries sorted and use binary instead of linear searches

The long story, with numbers:

Originally I just tried git-fast-import from 'next'. It built the pack
file (about 65M) from the blobs after a few minutes, and then while
building the commit, consumed all system memory (about 1G) and crashed.
The culprit was the constant increase in allocation as the tree size
grew, coupled with failure to pass allocated pool memory back to the OS.
Patch 1 doubles the allocated size each time we run out of space.

With patch 1, the memory usage was much more reasonable (it ends up
using about 46M). However, the process still ran for over an hour before
I killed it (bear in mind that doing deltas on all of the blobs takes
about 5 minutes). The culprit this time was the linear search through
the tree entries looking to see if each 'M' line was a new entry or an
update. Patch 3 turns this into a binary search.

To do some testing, I cut my original dataset down to 20,000 entries,
which I could feasibly do with the stock git-fast-import. Here are the
numbers:

For reference, just adding the blobs using stock git-fast-import without
making a commit (the memory report is the "Memory total" from gfi):
mem: 2673 KiB
5.86user 3.67system 0:09.57elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+405366minor)pagefaults 0swaps

Now here's stock git-fast-import making the commit (note the memory)
mem: 101992 KiB
37.07user 4.15system 0:41.55elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+430469minor)pagefaults 0swaps

Now here's with just patch 1 (better memory, but still slow):
mem: 3688 KiB
30.00user 3.73system 0:34.80elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+406064minor)pagefaults 0swaps

And with patches 1, 2, and 3:
mem: 3688 KiB
6.08user 3.71system 0:10.10elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+406064minor)pagefaults 0swaps

And my final 300,000 item dataset with patches 1, 2, and 3:
mem: 46378 KiB
414.17user 69.82system 8:11.92elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7730960minor)pagefaults 0swaps


Yes, this dataset is pathological. But I suspect the speed improvements
will help even modest projects a little, and almost certainly not hurt
(the aggressive memory growth will probably waste a bit more memory).

-Peff
