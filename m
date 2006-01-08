From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/7] Add a minimal test for git-cherry
Date: Sun, 8 Jan 2006 01:38:15 +0100
Message-ID: <20060108003815.GI1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 08 01:35:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOX7-00074R-0J
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWAHAfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWAHAfi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:35:38 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:3462 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161084AbWAHAfi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:35:38 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D94475C547
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 01:35:36 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvOZc-0003S2-3l
	for git@vger.kernel.org; Sun, 08 Jan 2006 01:38:16 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14289>

This test checks that git-cherry finds the expected number of patches
in two simple cases.

Signed-off-by: Yann Dirson <ydirson@altern.org>


---

 t/t3500-cherry.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t3500-cherry.sh

e9d999acb2653af449e3122872cbd4e8f8260c71
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
new file mode 100755
index 0000000..f2f9109
--- /dev/null
+++ b/t/t3500-cherry.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson, based on t3400 by Amos Waterland
+#
+
+test_description='git-cherry should detect patches integrated upstream
+
+This test cherry-picks one local change of two into master branch, and
+checks that git-cherry only returns the second patch in the local branch
+'
+. ./test-lib.sh
+
+export GIT_AUTHOR_EMAIL=bogus_email_address
+
+test_expect_success \
+    'prepare repository with topic branch, and check cherry finds the 2 patches from there' \
+    'echo First > A &&
+     git-update-index --add A &&
+     git-commit -m "Add A." &&
+
+     git-checkout -b my-topic-branch &&
+
+     echo Second > B &&
+     git-update-index --add B &&
+     git-commit -m "Add B." &&
+
+     echo AnotherSecond > C &&
+     git-update-index --add C &&
+     git-commit -m "Add C." &&
+
+     git-checkout -f master &&
+
+     echo Third >> A &&
+     git-update-index A &&
+     git-commit -m "Modify A." &&
+
+     expr "$(echo $(git-cherry master my-topic-branch) )" : "+ [^ ]* + .*"
+'
+
+test_expect_success \
+    'cherry-pick one of the 2 patches, and check cherry recognized one and only one as new' \
+    'git-cherry-pick my-topic-branch^0 &&
+     echo $(git-cherry master my-topic-branch) &&
+     expr "$(echo $(git-cherry master my-topic-branch) )" : "+ [^ ]* - .*"
+'
+
+test_done
-- 
1.0.6-g8ecb

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
