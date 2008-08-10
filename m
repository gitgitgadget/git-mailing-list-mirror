From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Make cherry-pick use rerere for conflict resolution.
Date: Sun, 10 Aug 2008 17:18:55 +0530
Message-ID: <1218368935-31124-1-git-send-email-ams@toroid.org>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 13:50:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS9RD-00015b-3g
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 13:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbYHJLtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 07:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbYHJLtD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 07:49:03 -0400
Received: from fugue.toroid.org ([85.10.196.113]:53723 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161AbYHJLtA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 07:49:00 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 0B1D0558395;
	Sun, 10 Aug 2008 13:48:59 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id DC2F6ADC36D; Sun, 10 Aug 2008 17:18:55 +0530 (IST)
X-Mailer: git-send-email 1.6.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91831>

Trivial change plus test, as requested by Johannes Schindelin.

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 builtin-revert.c              |    2 +
 t/t3504-cherry-pick-rerere.sh |   45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t3504-cherry-pick-rerere.sh

diff --git a/builtin-revert.c b/builtin-revert.c
index 27881e9..3667705 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -11,6 +11,7 @@
 #include "cache-tree.h"
 #include "diff.h"
 #include "revision.h"
+#include "rerere.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -395,6 +396,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die ("Error wrapping up %s", defmsg);
 		fprintf(stderr, "Automatic %s failed.%s\n",
 			me, help_msg(commit->object.sha1));
+		rerere();
 		exit(1);
 	}
 	if (commit_lock_file(&msg_file) < 0)
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
new file mode 100755
index 0000000..957b298
--- /dev/null
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='cherry-pick should rerere for conflicts'
+
+. ./test-lib.sh
+
+echo foo > foo
+git add foo && git commit -q -m 1
+
+echo foo-master > foo
+git add foo && git commit -q -m 2
+
+git checkout -b dev HEAD^
+
+echo foo-dev > foo
+git add foo && git commit -q -m 3
+
+git config rerere.enabled true
+
+test_expect_success 'conflicting merge' '
+	test_must_fail git merge master
+'
+
+echo foo-dev > foo
+git add foo && git commit -q -m 4
+
+git reset --hard HEAD^
+
+echo foo-dev > expect
+
+test_expect_success 'cherry-pick conflict' '
+	test_must_fail git cherry-pick master &&
+	test_cmp expect foo
+'
+
+git config rerere.enabled false
+
+git reset --hard
+
+test_expect_success 'cherry-pick conflict without rerere' '
+	test_must_fail git cherry-pick master &&
+	test_must_fail test_cmp expect foo
+'
+
+test_done
-- 
1.6.0.rc2
