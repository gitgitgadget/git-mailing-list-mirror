From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] Add pack-refs and show-ref test cases.
Date: Thu, 28 Sep 2006 06:58:03 +0200
Message-ID: <20060928065803.2774a63c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:51:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSnsA-0006ml-Hs
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWI1Evn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWI1Evn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:51:43 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:41410 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751560AbWI1Evm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 00:51:42 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 7BC557597A;
	Thu, 28 Sep 2006 06:51:41 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27987>

Some of these test cases are from Junio.
One test case is commented out because it doesn't work right now.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t3210-pack-refs.sh |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
new file mode 100755
index 0000000..2cc03e6
--- /dev/null
+++ b/t/t3210-pack-refs.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Amos Waterland
+# Copyright (c) 2006 Christian Couder
+#
+
+test_description='git pack-refs should not change the branch semantic
+
+This test runs git pack-refs and git show-ref and checks that the branch
+semantic is still the same.
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'prepare a trivial repository' \
+    'echo Hello > A &&
+     git-update-index --add A &&
+     git-commit -m "Initial commit." &&
+     HEAD=$(git-rev-parse --verify HEAD)'
+
+SHA1=
+
+test_expect_success \
+    'see if git show-ref works as expected' \
+    'git-branch a &&
+     SHA1=$(< .git/refs/heads/a) &&
+     echo "$SHA1 refs/heads/a" >expect &&
+     git-show-ref a >result &&
+     diff expect result'
+
+test_expect_success \
+    'see if a branch still exists when packed' \
+    'git-branch b &&
+     git-pack-refs &&
+     rm .git/refs/heads/b &&
+     echo "$SHA1 refs/heads/b" >expect &&
+     git-show-ref b >result &&
+     diff expect result'
+
+# test_expect_failure \
+#     'git branch c/d should barf if branch c exists' \
+#     'git-branch c &&
+#      git-pack-refs &&
+#      rm .git/refs/heads/c &&
+#      git-branch c/d'
+
+test_expect_success \
+    'see if a branch still exists after git pack-refs --prune' \
+    'git-branch e &&
+     git-pack-refs --prune &&
+     echo "$SHA1 refs/heads/e" >expect &&
+     git-show-ref e >result &&
+     diff expect result'
+
+test_expect_failure \
+    'see if git pack-refs --prune remove ref files' \
+    'git-branch f &&
+     git-pack-refs --prune &&
+     ls .git/refs/heads/f'
+
+test_expect_success \
+    'git branch g should work when git branch g/h has been deleted' \
+    'git-branch g/h &&
+     git-pack-refs --prune &&
+     git-branch -d g/h &&
+     git-branch g &&
+     git-pack-refs &&
+     git-branch -d g'
+
+test_done
-- 
1.4.2.1.g4f95-dirty
