From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: bisect gives strange answer
Date: Thu, 04 Aug 2005 00:53:21 -0400
Message-ID: <E1E0XjN-000102-Un@approximate.corpus.cam.ac.uk>
X-From: git-owner@vger.kernel.org Thu Aug 04 06:58:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Xoi-0005I1-Go
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 06:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVHDE6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 00:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVHDEzh
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 00:55:37 -0400
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:38563 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261806AbVHDExj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 00:53:39 -0400
Received: from [24.63.67.76] (helo=approximate.corpus.cam.ac.uk)
	by smtpauth04.mail.atl.earthlink.net with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1E0XjZ-0004Vb-E4
	for git@vger.kernel.org; Thu, 04 Aug 2005 00:53:33 -0400
Received: from sanjoy by approximate.corpus.cam.ac.uk with local (Exim 4.52)
	id 1E0XjN-000102-Un
	for git@vger.kernel.org; Thu, 04 Aug 2005 00:53:22 -0400
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 21.4.1
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478819d4bc37d9c2ebf0cb2d80a9d60869e2167c1f0940bc1ea350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.63.67.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have been having lots of fun using 'git bisect' to find the commit
that broke S3 wake on my laptop.  But in its last step it gives an
answer that cannot be right.  I had not used git until now, so I may be
missing something obvious: Corrections will be gratefully received.  I'm
using git from git-2005-08-03.tar.gz on i386 (TP 600X, Debian testing).

Before using git bisect, I had tested enough to know that 2.6.13-rc1 was
fine and 2.6.13-rc2-git1 was not (it would sleep but waking up would
hang).  So I compiled all the 2.6.13-rc1-git* snapshots and found that
2.6.13-rc1-git7 was the last one that worked, and 2.6.13-rc2-git1 was
the first to fail (see <http://bugzilla.kernel.org/show_bug.cgi?id=4989>
if you are curious about the bug itself).

Time to use 'git bisect' to find where in between the S3 wake got
broken.  I'll give all the commands I did so you can (hopefully!)
reproduce the problem.

I began by following the useful directions at
<http://linux.yyz.us/git-howto.html> to download the 2.6 repository:

repo=rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
git clone $repo linux-2.6
cd linux-2.6                  
rsync -a --verbose --stats --progress $repo/ .git/

Then I binary searched, compiling and testing, until bisect told me I
was done.  Here's the output of a script (run with #!/bin/bash -x) that
reproduces the problem in the clean archive made above.

======================================================================
+ git checkout
+ git bisect reset
+ git bisect start
+ git bisect good 17af691cd19765b782d891fc50c1568d0f1276b3  # 2.6.13-rc1-git7
+ git bisect bad c101f3136cc98a003d0d16be6fab7d0d950581a6   # 2.6.13-rc2-git1
Bisecting: 42 revisions left to test after this
+ cat .git/HEAD
b2f571026594884e7a2a3f8bc6ad5c92e0703330
+ git bisect good
Bisecting: 30 revisions left to test after this
+ cat .git/HEAD
450008b5a62bb09445ae05c4d01d510386c9435d
+ git bisect good
Bisecting: 15 revisions left to test after this
+ cat .git/HEAD
a9df3597fec5472d0840fbfdc2a3fac5268f7d08
+ git bisect bad
Bisecting: 8 revisions left to test after this
+ cat .git/HEAD
28e8c3ad9464de54a632f00ab3df88fa5f4652d1
+ git bisect bad
Bisecting: 4 revisions left to test after this
+ cat .git/HEAD
c774e93e2152d0be2612739418689e6e6400f4eb
+ git bisect bad
Bisecting: 2 revisions left to test after this
+ cat .git/HEAD
b4634484815e1879512a23e4f59eef648135c30a
+ git bisect bad
b4634484815e1879512a23e4f59eef648135c30a is first bad commit
diff-tree b4634484815e1879512a23e4f59eef648135c30a (from 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737)
Author: Greg KH <greg@kroah.com>
Date:   Wed Jul 6 08:51:03 2005 -0700

    [PATCH] Fix bt87x.c build problem
    
    Missing forward declaration
    
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 5717e17e384b0b40e409966403e2b8dfdab615a9 4ba0c028e80bf81c5c782e9047bd484a1eeadca4 M	sound
======================================================================

The answer makes no sense since my .config doesn't use the bt87x driver
(the TP600X uses a snd-cs46xx).  To be sure, I checked the diff with

  git diff 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737..b4634484815e1879512a23e4f59eef648135c30a

The commit changed only sound/pci/bt87x.c

I do believe this line at the end of the bisection:

  b4634484815e1879512a23e4f59eef648135c30a is first bad commit

But 
  diff-tree b4634484815e1879512a23e4f59eef648135c30a (from 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737)

cannot be right.  Where did 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737
come from?  The last good commit was
  450008b5a62bb09445ae05c4d01d510386c9435d 
so shouldn't bisect (if there's really only 1 commit in left now) say

  diff-tree b4634484815e1879512a23e4f59eef648135c30a (from 450008b5a62bb09445ae05c4d01d510386c9435d)

  $ git diff 450008b5a62bb09445ae05c4d01d510386c9435d \
              b4634484815e1879512a23e4f59eef648135c30a \
    | grep 'diff --git' | awk '{print $3}'

produces this list of changed files (I'm sure there's an easier way):

a/arch/arm/kernel/armksyms.c
a/arch/arm/mach-ixp4xx/common-pci.c
a/arch/arm/mach-ixp4xx/coyote-setup.c
a/arch/arm/mach-ixp4xx/ixdp425-setup.c
a/arch/arm/mm/proc-v6.S
a/drivers/pci/pci-driver.c
a/include/asm-arm/arch-ixp4xx/io.h
a/sound/pci/bt87x.c

I suspect that bisect jumped the gun at the end, and that there are a
few more revisions to test.  Maybe the revision tree structure gets a
bit complicated and breaks an implicit linearity assumption  in bisect?

Probably 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737 is the commit just
before b4634484815e1879512a23e4f59eef648135c30a (the first one I know to
be bad), and I'm guessing that 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737
is bad too.

The suspect change is probably to drivers/pci/pci-driver.c since all the
other changed files are the unused bt87x sound driver or are for the arm
architecture.  Here is that diff:

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -17,13 +17,13 @@
  * Dynamic device IDs are disabled for !CONFIG_HOTPLUG
  */
 
+#ifdef CONFIG_HOTPLUG
+
 struct pci_dynid {
 	struct list_head node;
 	struct pci_device_id id;
 };
 
-#ifdef CONFIG_HOTPLUG
-
 /**
  * store_new_id
  *


But whether moving back the CONFIG_HOTPLUG fixes my S3 wake is another
story, one for the acpi-devel list (once I do the experiment).
