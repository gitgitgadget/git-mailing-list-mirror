From: Junio C Hamano <junkio@cox.net>
Subject: Unified merge driver pushed out to "master" branch
Date: Sat, 10 Sep 2005 19:54:19 -0700
Message-ID: <7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<20050907165012.GA20392@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 04:55:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEHzD-0000yN-RD
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 04:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVIKCyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 22:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVIKCyY
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 22:54:24 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:18669 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932335AbVIKCyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 22:54:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911025420.OLUV8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Sep 2005 22:54:20 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050907165012.GA20392@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Wed, 7 Sep 2005 18:50:12 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8267>

I've pushed out the 'git merge' along with Daniel's read-tree
updates and your 'base on merge of bases' merge strategy driver
in the "master" branch.

The last one is what I butchered your code without really
auditing the changes I made, so I'd appreciate you to take a
look at it and supply any necessary updates and fixes.  My
changes are meant to be only to adjust the calling convention to
that of 'git merge' -- that is, it gets merge bases and heads
from the command line, and it is not supposed to commit and
update HEAD itself, but is supposed to leave its best effort in
the working tree and the paths that cannot be automerged should
be left as that of HEAD version in the index file, so that the
user can run 'git diff' to see what is happening while resolving
things by hand.  I do not think my change did the last part
correctlyx.  The change to introduce '-i' option to read-tree is
also present.

I primarily used the commits found in the Linux 2.6 repository
and its derivatives that have multiple potential merge bases for
my testing.  Among them, the attempt to merge parents of this
commit triggered an assertion failure -- it may be my fault but
I have not spent much time to diagnose it.

commit 6358924b06cd1aaa031b8ba0c33e5a15e795bef0
Merge: 1da21e73bdc458f8131e6071072632b4c3b0430f 344a076110f4ecb16ea6d286b63be696604982ed
Author: Tony Luck <tony.luck@intel.com>
Date:   Thu Sep 8 14:29:32 2005 -0700

    Pull release into test branch

----------------------------------------------------------------
Here is a summary of my test results.

"Expect" names the commit being tested.  The parents of each of
these commits have more than one merge-base, and the test is to
start from one parent of it, and merge the other parent into it
using the four merge programs:

 * traditional is 'git-resolve-script' from GIT 0.99.6 (it does
   not even use Daniel's read-tree so that I can catch
   regression in read-tree).

 * dbrt is 'git-merge -s resolve', i.e. Daniel's multi-base merge.

 * stupid is 'git-merge -s stupid', supposed to be the same
   as 'git-resolve' (but internally uses Daniel's read-tree with
   only one merge base).

 * fredrik is 'git-merge -s fredrik', the one I butchered.

------------------------------------------------
Expect 0c168775709faa74c1b87f1e61046e0c51ade7f3
Method 'traditional' failed to automerge.
Method 'dbrt' failed to automerge.
Method 'stupid' failed to automerge.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

The fredrik is the only one that merged successfully, but its
result is different from the actual commit.

:100644 100644 065b702df56353a00d5f460cf385f172decccf2b cd4222ff8b925f6b92414d58729d225fccc3f310 M	include/net/ieee80211.h

------------------------------------------------
Expect 0c3e091838f02c537ccab3b6e8180091080f7df2 (case #16)
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' failed to automerge.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

The fredrik result is different from the actual commit.

:100644 100644 a7bed60b69f9e8de9a49944e22d03fb388ae93c7 51a7b7b4dd0e7c5720683a40637cdb79a31ec4c4 M	arch/ia64/hp/sim/boot/bootloader.c

------------------------------------------------
Expect 0e396ee43e445cb7c215a98da4e76d0ce354d9d7
Method 'traditional' failed to automerge.
Method 'dbrt' failed to automerge.
Method 'stupid' failed to automerge.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

The fredrik is the only one that merged successfully, and its
result matches the actual commit.

------------------------------------------------
Expect 1960ff70a6c1db8e5f8fa9ec7020ef585f8ce706
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

All results match the actual commit.

------------------------------------------------
Expect 19925d7e0af7de645d808fd973ef99049fce52f0
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

All results match the actual commit.

------------------------------------------------
Expect 3190186362466658f01b2e354e639378ce07e1a9
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

All results match the actual commit.

------------------------------------------------
Expect 467ca22d3371f132ee225a5591a1ed0cd518cb3d
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

All results match the actual commit.

------------------------------------------------
Expect 539aeb871b52233b189ae976dfded20e14db645a
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

All results match the actual commit.

------------------------------------------------
Expect 6358924b06cd1aaa031b8ba0c33e5a15e795bef0
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' failed to automerge.

Fredrik dies on asserttion failure.

------------------------------------------------
Expect 84ffa747520edd4556b136bdfc9df9eb1673ce12 (case #16)
Method 'traditional' failed to automerge.
Method 'dbrt' failed to automerge.
Method 'stupid' failed to automerge.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

The fredrik result matches the actual commit.

------------------------------------------------
Expect a855f9a4d29f0ec338c337358844389171b0bae0
Method 'traditional' failed to automerge.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' failed to automerge.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

Both fredrik and dbrt results match the actual commit.

------------------------------------------------
Expect cf70be167c085af820c0c2a606cab8c3ee819dc6
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

All results match the actual commit.

------------------------------------------------
Expect da28c12089dfcfb8695b6b555cdb8e03dda2b690
Method 'traditional' automerged
Method 'traditional' resolved cleanly.
Method 'dbrt' automerged
Method 'dbrt' resolved cleanly.
Method 'stupid' automerged
Method 'stupid' resolved cleanly.
Method 'fredrik' automerged
Method 'fredrik' resolved cleanly.

All results match the actual commit.

------------------------------------------------
