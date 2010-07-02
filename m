From: Darren Hart <dvhltc@us.ibm.com>
Subject: BUG ? git-log omits changesets if the file is identical between revs
Date: Fri, 02 Jul 2010 11:50:57 -0700
Message-ID: <4C2E3511.902@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: u.kleine-koenig@pengutronix.de,
	"Hansen, Dave" <haveblue@us.ibm.com>,
	Will Schmidt <willschm@us.ibm.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 02 20:51:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlKw-000257-Qt
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 20:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758950Ab0GBSvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 14:51:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:33866 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab0GBSvf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 14:51:35 -0400
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o62Im4VR017965
	for <git@vger.kernel.org>; Fri, 2 Jul 2010 12:48:04 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o62Ip7RM096680
	for <git@vger.kernel.org>; Fri, 2 Jul 2010 12:51:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o62Ip79X031152
	for <git@vger.kernel.org>; Fri, 2 Jul 2010 12:51:07 -0600
Received: from [9.48.97.143] (sig-9-48-97-143.mts.ibm.com [9.48.97.143])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id o62Ip6OC030778;
	Fri, 2 Jul 2010 12:51:06 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150147>

Looking at the linux-tip git tree, I was having trouble understanding
the following results while trying to track down a kernel bug:

URL: git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git

$ git checkout -b 2.6.33.5-rt23 v2.6.33.5-rt23
$ git log --pretty=oneline v2.6.33.5.. arch/powerpc/kernel
ef4afcc4401e92982f4ffd3fae6a9a6745a98596 Merge stable/linux-2.6.33.y into rt/2.6.33
1540c84b5ed657ed71dce06915bba461e6b09574 Merge branch '2.6.33.4' into rt/2.6.33
ac4d7f0bed9b03204539de81c8b62b35c9f4e16a Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git
6aa4659865454a3885195aa49348c46a69e6bee2 powerpc: rtasd: do not check for irq_disabled on RT
5f854cfc024622e4aae14d7cf422f6ff86278688 Forward to 2.6.33-rc8
5a017e25b44f6e66b0254c84270c0f1bf8689ebe Merge commit 'v2.6.31' into rt/head
570f410b475b45462197d09ddca25e47616da5ac Merge branch 'rt/base' into rt/rt-2.6.31
bda9263432072d7879fe13fdaf9dbbd372b4d2fc Merge branch 'linus' into rt/base
92bfe2d63ed46764b0b0a6e9b63bb9e81023ab80 powerpc: realtime support
e7e7fcb92fc6ef2cdb8cc070e9c0d26f03f7b8eb powerpc: mmu gather and tlb fixes
b4f4919b32aeadc6e0c1a0bc996e541073e0bcf7 powerpc: kprobes: Fix missed preemption check
5b659531c96943c3eea21b3dbcb83e6320d0f46b powerpc: OF convert to atomic lock
32ff9169c2f6c94c900f08217359972e2f3eb17f powerpc: Annotate atomic_locks
5a950072e4c1036abcdb35610d053e49bdde55c9 xtime_lock: Convert to atomic_seqlock
fd2bde5dd1689cc8ede833604cc19d1c835faf61 genirq: Convert irqdesc lock to atomic_spinlock

This lists the following change of interest:
92bfe2d63ed46764b0b0a6e9b63bb9e81023ab80 powerpc: realtime support

$ git whatchanged 92bfe2d6 -n1
commit 92bfe2d63ed46764b0b0a6e9b63bb9e81023ab80
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Fri Jul 3 08:44:51 2009 -0500

    powerpc: realtime support
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:100644 100644 d00131c... 0b46b68... M  arch/powerpc/Kconfig
:100644 100644 43e0734... 4bb9ce4... M  arch/powerpc/kernel/entry_64.S
:100644 100644 88d9c1d... 1a82d48... M  arch/powerpc/kernel/idle.c
:100644 100644 054dfe5... 8f1d8cd... M  arch/powerpc/platforms/chrp/time.c
:100644 100644 e1f33a8... db7cf0d... M  arch/powerpc/xmon/xmon.c

Note that this change modified arch/powerpc/kernel/entry_64.S. However,
if we log the changes to that single file with same revision range as
for the parent directory above, we get an empty result set:

$ git log --pretty=oneline v2.6.33.5.. arch/powerpc/kernel/entry_64.S
<null>

Is this perhaps because entry_64.S is now identical between v2.6.33.5
and v.2.6.33.5-rt23?

$ git diff v2.6.33.5.. arch/powerpc/kernel/entry_64.S
<null>

If so, is this perhaps a bug? It seems like 92bfe2d6 should show up in
the log regardless...

I'm not sure of the significance, but another point of reference, using
the ... rev syntax yields:
$ git log --pretty=oneline v2.6.33.5... arch/powerpc/kernel/entry_64.S
92bfe2d63ed46764b0b0a6e9b63bb9e81023ab80 powerpc: realtime support

If this is all expected behavior, could someone please explain why it is
so?

Regards,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
