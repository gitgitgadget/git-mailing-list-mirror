From: "George Spelvin" <linux@horizon.com>
Subject: [BUG] rebase modify/delete conflict prints wrong SHA-1
Date: 30 Aug 2015 20:42:47 -0400
Message-ID: <20150831004247.17480.qmail@ns.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 02:49:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWDID-0003qO-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 02:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbHaAt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 20:49:29 -0400
Received: from ns.horizon.com ([71.41.210.147]:48079 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751433AbbHaAt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 20:49:28 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Aug 2015 20:49:28 EDT
Received: (qmail 17481 invoked by uid 1000); 30 Aug 2015 20:42:47 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276844>

I was rebasing my local kernel patches on top of v4.2 (using Debian
git_1:2.5.1-1_amd64), and ran into the following when one of the
files I modified got renamed in mainline:

Applying: drivers/ntb/ntb_hw.c: Use prandom_u32_max()
Using index info to reconstruct a base tree...
A       drivers/ntb/ntb_hw.c
Falling back to patching base and 3-way merge...
CONFLICT (modify/delete): drivers/ntb/ntb_hw.c deleted in 0ec6a07f518304248dca177405fa607822e4933d and modified in drivers/ntb/ntb_hw.c: Use prandom_u32_max(). Version drivers/ntb/ntb_hw.c: Use prandom_u32_max() of drivers/ntb/ntb_hw.c left in tree.
Failed to merge in the changes.
Patch failed at 0037 drivers/ntb/ntb_hw.c: Use prandom_u32_max()
The copy of the patch that failed is found in:
   /usr/src/linux/.git/rebase-apply/patch

The problem is that 0ec6a07f518304248dca177405fa607822e4933d is *my* patch.
And it's not the conflicting patch, either, it's some nearby patch!

The file was renamed in ec110bc7cc48d7806c9b65094e6afb19452d458f
("NTB: Move files in preparation for NTB abstraction"),
which you can find in 4.2-rc1.

It appears that there's a glitch in printing the SHA-1 in this case.


I tried to reproduce it with the trivial case: create an initial
commit with one file, delete it in one branch, modify it in another,
and then rebase the second on top of the first.

git rebase printed the right SHA-1.


But if I have two commits on each branch, I get something similar:

git init foo
cd foo
echo foo > foo
echo bar > bar
git add foo bar
git commit -m "Initial commit"
git rm foo
git commit -m "Delete foo"
git rm bar
git commit -m "Delete bar"
git checkout -b branch HEAD^^
echo baz >> foo
git commit -m "Edit foo" foo
echo baz >> bar
git commit -m "Edit bar" bar
git rebase master

First, rewinding head to replay your work on top of it...
Applying: Edit foo
Using index info to reconstruct a base tree...
A       foo
Falling back to patching base and 3-way merge...
CONFLICT (modify/delete): foo deleted in 52e1cece1e48dc21b317d4bd671fa171c3a7abd3 and modified in Edit foo. Version Edit foo of foo left in tree.
Failed to merge in the changes.
Patch failed at 0001 Edit foo
The copy of the patch that failed is found in:
   /tmp/foo/.git/rebase-apply/patch

For me, commit 52e1cece is the patch that removes bar, not foo:

$ git show 52e1cece
commit 52e1cece1e48dc21b317d4bd671fa171c3a7abd3
Author: George Spelvin <linux@horizon.com>
Date:   Sun Aug 30 18:59:09 2015 -0400

    Delete bar

diff --git a/bar b/bar
deleted file mode 100644
index 5716ca5..0000000
--- a/bar
+++ /dev/null
@@ -1 +0,0 @@
-bar
