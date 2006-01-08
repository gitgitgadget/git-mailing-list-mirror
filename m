From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/7] Add a test for rebase when a change was picked upstream
Date: Sun, 8 Jan 2006 01:39:48 +0100
Message-ID: <20060108003948.GL1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 08 01:37:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOYd-0007Tf-Hb
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWAHAhM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWAHAhM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:37:12 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:56975 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161089AbWAHAhK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:37:10 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BB08F3A72C
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 01:37:09 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvOb7-0003Se-02
	for git@vger.kernel.org; Sun, 08 Jan 2006 01:39:49 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14292>

This test exercises the standard feature that makes rebase useful.

Signed-off-by: Yann Dirson <ydirson@altern.org>


---

 t/t3401-rebase-partial.sh |   57 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100755 t/t3401-rebase-partial.sh

90bb1e981d99331bdc39acb2ab97ed0c88b06630
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
new file mode 100755
index 0000000..7c2d7f9
--- /dev/null
+++ b/t/t3401-rebase-partial.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson, based on t3400 by Amos Waterland
+#
+
+test_description='git rebase should detect patches integrated upstream
+
+This test cherry-picks one local change of two into master branch, and
+checks that git rebase succeeds with only the second patch in the
+local branch.
+'
+. ./test-lib.sh
+
+export GIT_AUTHOR_EMAIL=bogus_email_address
+
+test_expect_success \
+    'prepare repository with topic branch' \
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
+     git-commit -m "Modify A."
+'
+
+test_expect_success \
+    'pick top patch from topic branch into master' \
+    'git-cherry-pick my-topic-branch^0 &&
+     git-checkout -f my-topic-branch
+'
+
+test_debug \
+    'git-cherry master &&
+     git-format-patch -k --stdout --full-index master >/dev/null &&
+     gitk --all & sleep 1
+'
+
+test_expect_success \
+    'rebase topic branch against new master and check git-am did not get halted' \
+    'sh -x git-rebase master &&
+     test ! -d .dotest
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
