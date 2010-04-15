From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] (resend) stash bug: stash can lose data in a file removed from the index
Date: Thu, 15 Apr 2010 01:24:21 +0100
Message-ID: <1271291062-32154-1-git-send-email-charles@hashpling.org>
Cc: Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 02:24:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Csq-0003Xc-Ck
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab0DOAYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 20:24:35 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:57409 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752682Ab0DOAYe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 20:24:34 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAPf5xUtUXebi/2dsb2JhbACbW3G9cYUNBA
Received: from relay03.plus.net ([84.93.230.226])
  by relay.pcl-ipout02.plus.net with ESMTP; 15 Apr 2010 01:24:33 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by relay03.plus.net with esmtp (Exim) id 1O2Csj-0001DG-9R; Thu, 15 Apr 2010 01:24:33 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O2Csi-0008O8-Mb; Thu, 15 Apr 2010 01:24:32 +0100
X-Mailer: git-send-email 1.7.1.rc1.241.g4e72f
X-Plusnet-Relay: fe6426363d1287e43c87bd63258ab801
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144929>

If a file is removed from the index and then modified in the working
tree then stash will discard the working tree file with no way to
recover the changes.

This can might be done in one of a number of ways.

git rm file
vi file              # edit a new version
git stash

or with git mv

git mv file newfile
vi file              # make a new file with the old name
git stash

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 t/t3903-stash.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 476e5ec..c85bf44 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -228,4 +228,13 @@ test_expect_success 'stash --invalid-option' '
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
+test_expect_failure 'stash git rm' '
+    git reset --hard &&
+	git rm file &&
+	echo bar7 > file &&
+	git stash &&
+	git stash apply &&
+	test bar7 = $(cat file)
+'
+
 test_done
-- 
1.7.1.rc1.241.g4e72f
