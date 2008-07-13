From: Sverre Hvammen Johansen <hvammen+git@gmail.com>
Subject: [PATCH/Test] Build in merge is broken
Date: Sun, 13 Jul 2008 08:13:55 +0000 (UTC)
Message-ID: <loom.20080713T073129-112@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 10:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHwpO-0002MD-Dv
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 10:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbYGMIUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 04:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYGMIUG
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 04:20:06 -0400
Received: from main.gmane.org ([80.91.229.2]:36933 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbYGMIUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 04:20:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KHwoM-0001qu-6r
	for git@vger.kernel.org; Sun, 13 Jul 2008 08:20:02 +0000
Received: from c66-235-35-214.sea2.cablespeed.com ([66.235.35.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 08:20:02 +0000
Received: from hvammen+git by c66-235-35-214.sea2.cablespeed.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 08:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.235.35.214 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9) Gecko/2008061816 Remi/fc7 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88291>


This test case shows breakage of build in merge.  This have been
bisected to 1c7b76be Build in merge.

---
Great that we now are introducing merge in C.  Great job Miklos.
However, it is broken as this patch shows.  This have been
bisected to 1c7b76be Build in merge.

The test case when run will record the parents that were asked for which is
fine.  However, only c2 is recorded as a parent in the commit object.  Both
c1 and c2 should have been recorded.  The merge is otherwise working
correctly.

 t/t7600-merge.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 16f4608..a96a497 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -465,4 +465,15 @@ test_expect_success 'merge log message' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c0, c2, c0, and c1' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c0 c2 c0 c1 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.5.5.54.gc6550
