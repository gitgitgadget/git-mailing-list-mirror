X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: On performance characteristics of pickaxe with -M, -C, and -C -C
Date: Sun, 05 Nov 2006 14:27:10 -0800
Message-ID: <7v4ptdo7gh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 22:27:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30989>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgqSS-0001Td-6B for gcvg-git@gmane.org; Sun, 05 Nov
 2006 23:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422749AbWKEW1N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbWKEW1M
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 17:27:12 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39110 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1161706AbWKEW1M
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 17:27:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105222711.SQCB6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 17:27:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id jATG1V00g1kojtg0000000 Sun, 05 Nov 2006
 17:27:17 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've been brewing parts of git-pickaxe in "pu" for the last week
to fix both correctness and performance issues, and it appears
it is now in a good enough shape to even replace git-blame for
everyday use, so I've placed my recent work in "next".

 - Under -M or -C, it tried to find lines that are copied
   around, but it did its scan only once.  When a scan result
   splits the blame for a block of lines into three blocks:

     original span of blame <----------------------------->
     lines matched by -M/-C            <----->     

    ==>

     result of split        <---------><.....><----------->

   the middle part that matched passed the blame to the parent,
   but the new two parts created by this split was not
   re-scanned by the old code and the blame stayed with the
   commit we were inspecting.  The updated code re-scans for
   these two new parts and allows them to pass blame to their
   parents.

 - The implementation of -C -C (aka "find copies harder") was
   very broken.  Under this flag, the program should try all the
   paths in the parent as the candidates of copies for a path
   that is new (that is, not a modification from the original
   path, nor rename/copy from an existing path).  However, it
   used diffcore incorrectly and used only the paths that were
   changed from parent to child (i.e. the same as a single -C).
   The updated code works as advertised.  This is very expensive
   but the option exists in case when you know you want to pay
   the price to find out all the possible cuts-and-pastes.

 - The old code was reading each blob typically twice -- once as
   the "parent's blob" when a commit is compared with its
   parent, and then as the "child's blob" when that parent was
   trying to pass the blame to its parent.  The updated code
   reuses these blobs between the parent and the child and is
   much more efficient.

The following is by no means a scientific test, but here are two
comparisons using blame and pickaxe with or without -M/-C/-C -C.
One is our own revision.c, and the other is kernel/sched.c from
the kernel project.  The number of minor faults in 'time' output
gives a rough indication of the memory footprint of the process.

----------------------------------------------------------------

* git-blame revision.c
0.76user 0.01system 0:00.77elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3269minor)pagefaults 0swaps
reads blob 82 times

* git-pickaxe revision.c
0.78user 0.00system 0:00.78elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2500minor)pagefaults 0swaps
reads blob 92 times

    These two give comparable results.  The only difference is
    that git-blame says line 319 is from a41e109c (2006-03-12)
    while git-pickaxe says it is from 8efdc326 (2006-03-10).
    Manual inspection of both tells me that they are both valid
    and reasonable.

* git-pickaxe -M revision.c
0.95user 0.02system 0:00.97elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2410minor)pagefaults 0swaps
reads blob 92 times

    This notices that ll. 528-531, 695-701 and 791-794 are not
    new lines introduced by the commits git-blame and
    git-pickaxe without -M place blame on, but the commits just
    shuffled existing lines.  For an example, look at output
    from:

	git show 53069686 -- revision.c

    The commit moved around the code to parse --min-age= option;
    git-pickaxe -M does not blame 53069686 for it, but git-blame
    and git-pickaxe without -M do.

    Because this flag does not cause the command to look for
    copied lines across files (other than the usual rename
    detection), the set of blobs it works on is the same as the
    command without -M.

* git-pickaxe -C revision.c
2.52user 0.03system 0:02.55elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+5262minor)pagefaults 0swaps
reads blob 486 times

    This starts noticing that a lot of the code actually came
    from rev-list.c as mentioned in an earlier message by Linus.

	Message-ID: <Pine.LNX.4.64.0610201630000.3962@g5.osdl.org>

    To find new suspects that are not the same path (or renamed
    path) in the parent, the program inspects files that were
    changed from its parent and that is how it finds that many
    lines came from rev-list.c.  Because it needs to work on
    more blobs than the above cases, it is a heavier weight
    operation.

* git-pickaxe -C -C revision.c
10.60user 0.06system 0:10.66elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+19762minor)pagefaults 0swaps
reads blob 1839 times

    This does not notice anything new compared to the above for
    this file's history.

----------------------------------------------------------------

* git-blame kernel/sched.c
4.68user 0.63system 0:05.31elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+276957minor)pagefaults 0swaps
reads blob 177 times

* git-pickaxe kernel/sched.c
5.63user 0.66system 0:06.29elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+276274minor)pagefaults 0swaps
reads blob 181 times

    The above two produce identical results.

* git-pickaxe -M kernel/sched.c
9.62user 1.35system 0:10.96elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+388517minor)pagefaults 0swaps
reads blob 181 times

    The story is the same as in our earlier example on revision.c.
    For example, look for comments about "task_timeslice()" in:

            git show 91fcdd4e -- kernel/sched.c

* git-pickaxe -C kernel/sched.c
12.94user 1.08system 0:14.04elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+407624minor)pagefaults 0swaps
reads blob 667 times

    This notices that many lines came from arch/ia64/kernel/domain.c

* git-pickaxe -C -C kernel/sched.c
13.09user 1.02system 0:14.11elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+407626minor)pagefaults 0swaps
reads blob 667 times

    For the kernel history (since 2.6.12-rc2) kernel/sched.c is not
    a new file, so there is no difference in the output or
    performance between -C and -C -C.
