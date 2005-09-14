From: Junio C Hamano <junkio@cox.net>
Subject: Another merge test case from the kernel tree.
Date: Tue, 13 Sep 2005 22:56:45 -0700
Message-ID: <7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<20050907165012.GA20392@c165.ib.student.liu.se>
	<7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Tony Luck <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 07:57:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFQGO-0001rO-7n
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 07:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVINF4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 01:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVINF4t
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 01:56:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62377 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965024AbVINF4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 01:56:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914055646.VINB6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 01:56:46 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 10 Sep 2005 19:54:19 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8510>

One more merge test case you would be interested.  What's most
interesting about this commit is that it has three merge bases,
not two.

commit c820884e4f35a40f88b787c3891a23d629ef6bfd
Merge: aa2dca4563b0629ecd9d9994dfdf39f29ff1b43f 357d596bd552ad157a906289ab13ea6ba7e66e3d
Author: Tony Luck <tony.luck@intel.com>
Date:   Sun Sep 11 18:35:10 2005 -0700

    Auto-update from upstream

Attempt to reproduce this commit is somewhat troubling.  The
'stupid' strategy and git-resolve resolves cleanly and Tony's
commit matches what 'git-resolve' does (obviously that is the
algorithm everybody uses).

But the 'resolve' strategy says this is case #16 (and resolves
this case differently but I think it is just by luck). This
indicates that Tony _might_ have committed what he did not
wanted to.  The path involved is arch/mips/kernel/offset.c.

    [Tony, I think you've seen this one once in different
    commit.  The terminology "case #16" means your merge has
    more than one merge base candidates:

        Ancestor#1 -- -- Your tree
                     X
        Ancestor#2 -- -- Other tree

    and when a path in your tree matches Ancestor #i and the
    same path in the other tree matches Ancestor #j (i!=j).

    The default git merge algorithm picks a single ancestor that
    gives the least number of conflicting paths during the
    merge, and compares your tree and other tree against it and
    pick the one that changed since that ancestor if only one
    side changed that path.  But in case #16, depending on which
    ancestor we pick, the result may come from your tree or
    other tree, and obviously we do a wrong thing with 50%
    probability.

    Thie _could_ indicate that you _might_ be losing a reverted
    you made in your line of development being overwritten by
    what the other tree did.]

BTW, Fredrik, the 'recursive' merge dies with this:

Trying merge strategy recursive...
Merging 357d596bd552ad157a906289ab13ea6ba7e66e3d with aa2dca4563b0629ecd9d9994dfdf39f29ff1b43f
Merging: 
357d596bd552ad157a906289ab13ea6ba7e66e3d Merge branch 'release' of master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6  
aa2dca4563b0629ecd9d9994dfdf39f29ff1b43f Manual merge of kernel/sched.c and arch/ia64/kernel/mca_asm.S 
found 3 common ancestor(s): 
a1cddb88920b915eaba10712ecfd0fc698b00a22 [IA64-SGI] Add new vendor-specific SAL calls for: 
6cf07a8cc86a0b471466c7fe45892f7ef434015b [IA64] Fix nasty VMLPT problem... 
49a28cc8fd26f5317c47a9aeb2bdd1c33e21738e [IA64] MCA/INIT: remove obsolete unwind code 
  Merging: 
  a1cddb88920b915eaba10712ecfd0fc698b00a22 [IA64-SGI] Add new vendor-specific SAL calls for: 
  6cf07a8cc86a0b471466c7fe45892f7ef434015b [IA64] Fix nasty VMLPT problem... 
  found 1 common ancestor(s): 
  d8971fcb702e24d1e22c77fd1772f182ffee87e3 [INET]: compile errors when DEBUG is defined 
Traceback (most recent call last):
  File "/home/junio/bin/Linux/git-merge-recursive", line 429, in ?
    firstBranch, secondBranch, graph)
  File "/home/junio/bin/Linux/git-merge-recursive", line 54, in merge
    graph, callDepth+1)
  File "/home/junio/bin/Linux/git-merge-recursive", line 62, in merge
    runProgram(['git-read-tree', h1.tree()])
  File "/home/junio/share/git-core/python/gitMergeCommon.py", line 93, in runProgram
    raise ProgramError(progStr, out)
ProgramError: git-read-tree 1d20af805193ab9982a48cb4c828c0f6af034c6c: fatal: failed to unpack tree object 1d20af805193ab9982a48cb4c828c0f6af034c6c
