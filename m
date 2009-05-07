From: Dave O <cxreg@pobox.com>
Subject: Segfault during merge
Date: Thu, 7 May 2009 01:28:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:43:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zCJ-0005q9-HL
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZEGInL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbZEGInK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:43:10 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:40106 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752217AbZEGInI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 04:43:08 -0400
X-Greylist: delayed 880 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2009 04:43:08 EDT
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id n478SRJT016201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 7 May 2009 03:28:28 -0500
X-X-Sender: count@narbuckle.genericorp.net
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118445>

Hi, I've encountered a particular merge that causes a segfault, and was
able to successfully bisect git to commit 36e3b5e.  However, I'm unable
to come up with a simple repro that doesn't involve the source tree that
I found it on, which unfortunately I'm not able to share.

I've debugged this a bit, and it seems to happen only when there's
sufficient file creations and deletions to surpass rename_limit in
diffcore_rename, and a rename/delete conflict is encountered.  I don't
know enough about the index operations that are performed at that point
to understand why it crashes git, though.

Here's a backtrace:

#0  0x080c071f in sha_eq (a=0x4 <Address 0x4 out of bounds>, b=0x8cd931c "\001:??????\tAR???`") at cache.h:597
#1  0x080c1c2d in merge_trees (o=0xbff274d0, head=0x8cd9338, merge=0x8cd9318, common=0x0, result=0xbff27484)
     at merge-recursive.c:1155
#2  0x080c3613 in merge_recursive (o=0xbff274d0, h1=0x8ccd3a0, h2=0x8ccd310, ca=0x8d9abb8, result=0xbff27528)
     at merge-recursive.c:1285
#3  0x0807b86e in try_merge_strategy (strategy=<value optimized out>, common=0x8d8f798,
     head_arg=0x80fe14a "HEAD") at builtin-merge.c:565
#4  0x0807cc23 in cmd_merge (argc=1, argv=0xbff28c08, prefix=0x0) at builtin-merge.c:1110
#5  0x0804b777 in handle_internal_command (argc=2, argv=0xbff28c08) at git.c:247
#6  0x0804b962 in main (argc=2, argv=0xbff28c08) at git.c:438

common=0x0 in the merge_trees() call is the culprit, and that seems to
happen when a previous recursive call incurs "There are unmerged index
entries" in write_tree_from_memory, presumably due to the index issue
referenced above.

I was able to stop the segfault by copying the "make an empty tree"
block into the block following the return from recursion where
make_virtual_commit is called, but I suspect this is not the correct
solution.

Please let me know how I can further help debug this issue, or possibly
come up with a repro that will help someone else debug it.  Thanks!

     Dave Olszewski
