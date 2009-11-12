From: Nicolas Pitre <nico@fluxnic.net>
Subject: Git in next is broken
Date: Thu, 12 Nov 2009 15:36:50 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911121513470.16711@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 21:37:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8gPf-00065X-Bd
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 21:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZKLUgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 15:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbZKLUgq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 15:36:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47864 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbZKLUgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 15:36:45 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KT000K61JXF3C80@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Nov 2009 15:36:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132799>

Simply issuing a "git fetch" in my copy of git.git makes glibc complain 
with this:

*** glibc detected *** git: corrupted double-linked list: 0x0000000000974180 ***

The gdb backtrace is:

(gdb) bt
#0  0x0000003c76632f05 in raise () from /lib64/libc.so.6
#1  0x0000003c76634a73 in abort () from /lib64/libc.so.6
#2  0x0000003c76672438 in __libc_message () from /lib64/libc.so.6
#3  0x0000003c76677ec8 in malloc_printerr () from /lib64/libc.so.6
#4  0x0000003c7667a23e in _int_free () from /lib64/libc.so.6
#5  0x0000003c7667a486 in free () from /lib64/libc.so.6
#6  0x0000000000493f3f in ref_remove_duplicates (ref_map=0x7562b0)
    at remote.c:756
#7  0x0000000000424afc in get_ref_map () at builtin-fetch.c:165
#8  do_fetch () at builtin-fetch.c:644
#9  cmd_fetch (argc=<value optimized out>, argv=0x7fffffffe6a0,
    prefix=<value optimized out>) at builtin-fetch.c:754
#10 0x0000000000403d83 in run_builtin () at git.c:251
#11 handle_internal_command (argc=1, argv=0x7fffffffe6a0) at git.c:396
#12 0x0000000000403f2d in run_argv () at git.c:438
#13 main (argc=1, argv=0x7fffffffe6a0) at git.c:509

Bisection reveals the following culprit:

commit 73cf0822b2a4ffa7ad559d1f0772e39718fc7776
Author: Julian Phillips <julian@quantumfyre.co.uk>
Date:   Sun Oct 25 21:28:11 2009 +0000

    remote: Make ref_remove_duplicates faster for large numbers of refs

    The ref_remove_duplicates function was very slow at dealing with very
    large numbers of refs.  This is because it was using a linear search
    through all remaining refs to find any duplicates of the current ref.

    Rewriting it to use a string list to keep track of which refs have
    already been seen and removing duplicates when they are found is much
    more efficient.

    Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Reverting that commit from next does indeed fix the problem.
Note that this problem doesn't show up with all repositoryes.


Nicolas
