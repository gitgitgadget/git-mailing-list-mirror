From: tony.luck@intel.com
Subject: "git checkout" says Entry blah would be overwritten by merge ...
Date: Tue, 23 Aug 2005 13:59:03 -0700
Message-ID: <200508232059.j7NKx3nM025339@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 23:00:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7frQ-0001xC-RK
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 22:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVHWU7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 16:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVHWU7F
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 16:59:05 -0400
Received: from fmr24.intel.com ([143.183.121.16]:45227 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750840AbVHWU7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 16:59:04 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr004.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7NKx4DL012147
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 20:59:04 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7NL1WAi015468
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 21:01:32 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j7NKx35o025340
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 13:59:03 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j7NKx3nM025339;
	Tue, 23 Aug 2005 13:59:03 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7668>

I'm a little closer to understanding how I got into the situation
where I made that ugly commit last week that included 10 files that
I didn't want, because I just had another failed merge (but this
time I know how to recover :).

The approximate sequence of events was:

SGI told me one of the pending fixes in my test tree was causing
an oops during boot on a whole class of machines.  They asked whether
it could get into 2.6.13.  I agreed it was a good candidate, and ran
my script to pull it from its temporary branch (named prarit-bus-sysdata
in this case) into my release branch.  The script is trivial after the
argument sanity checks it just does:

 $ git checkout release && git resolve release prarit-bus-sysdata "Pull prarit-bus-sysdata into release branch"

Only one file was touched by this:
  arch/ia64/sn/kernel/io_init.c

I think that this would have gone through a non-trivial merge as this file
had subsequently been touched by another patch, but the merge did complete
automatically.

Next I pushed the release branch up to kernel.org, asked Linus to pull.

I then applied a totally independent patch to a new branch, pulled it
to the test branch, and pushed to kernel.org ... net effect was that
my tree ended up in "git checkout test" state.

Later I noticed that Linus had pulled from my tree (and from other
trees too), so I pulled his latest tree down from kernel.org using:

  $ git checkout linus && git pull linus

Then I tried to update my test branch with these changes using:

  $ git checkout test && git resolve test linus "Auto-update from upstream"

This spat out these messages:

fatal: Entry 'arch/ia64/sn/kernel/io_init.c' would be overwritten by merge. Cannot merge.
Trying to merge 8065e2... into cde7fe...
fatal: Entry 'arch/ia64/hp/sim/boot/boot_head.S' would be overwritten by merge. Cannot merge.

There is one obvious bug here: "git checkout test" failed with the first error (from
its invocation of git-read-tree) ... but returned an exit status of 0, so my
script went ahead and tried to do the resolve, which the && should have
prevented.

The less obvious (i.e. I have no clue what I did wrong) thing is why the
"git checkout" had a problem with this file.  Yes, it had been touched
earlier ... but in a way that should have left the index up to date. And
two subsequent "git checkout" commands had switched first to the test
branch, and then to the linus branch without a complaint.

-Tony
