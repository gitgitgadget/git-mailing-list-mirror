From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] Add tests for git-sh-setup's require_clean_work_tree()
Date: Tue, 24 Nov 2015 15:45:44 +0100
Message-ID: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 15:46:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ErP-0005O7-4F
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 15:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbbKXOqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 09:46:10 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57097 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319AbbKXOqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2015 09:46:09 -0500
Received: from x4db01475.dyn.telefonica.de ([77.176.20.117] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a1Er6-0007BA-I5; Tue, 24 Nov 2015 15:46:05 +0100
X-Mailer: git-send-email 2.6.3.418.gc3b7987
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1448376366.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281616>

Add tests that check require_clean_work_tree() in the common cases,
i.e. on a branch with all combinations of clean and dirty index and
worktree, and also add tests that exercise it on an orphan branch.

require_clean_work_tree()'s behavior in the orphan branch cases is
questionable, as it exits with error on an orphan branch independently
from whether the index and worktree are clean or dirty (and it does so
because of the invalid HEAD, meaning that even when it should exit
with error, it does so for the wrong reason).  As scripts might rely
on the current behavior, we err on the side of compatibility and
safety, and expect the current behavior as success.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t2301-require-clean-work-tree.sh | 63 ++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 t/t2301-require-clean-work-tree.sh

diff --git a/t/t2301-require-clean-work-tree.sh b/t/t2301-require-clean=
-work-tree.sh
new file mode 100755
index 0000000000..1bb41b59a5
--- /dev/null
+++ b/t/t2301-require-clean-work-tree.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description=3D'require_clean_work_tree'
+
+. ./test-lib.sh
+
+run_require_clean_work_tree () {
+	(
+		. "$(git --exec-path)"/git-sh-setup &&
+		require_clean_work_tree "do-something"
+	)
+}
+
+test_expect_success 'setup' '
+	test_commit initial file
+'
+
+test_expect_success 'success on clean index and worktree' '
+	run_require_clean_work_tree
+'
+
+test_expect_success 'error on dirty worktree' '
+	test_when_finished "git reset --hard" &&
+	echo dirty >file &&
+	test_must_fail run_require_clean_work_tree
+'
+
+test_expect_success 'error on dirty index' '
+	test_when_finished "git reset --hard" &&
+	echo dirty >file &&
+	git add file &&
+	test_must_fail run_require_clean_work_tree
+'
+
+test_expect_success 'error on dirty index and worktree' '
+	test_when_finished "git reset --hard" &&
+	echo dirty >file &&
+	git add file &&
+	echo dirtier >file &&
+	test_must_fail run_require_clean_work_tree
+'
+
+test_expect_success 'error on clean index and worktree while on orphan=
 branch' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	git reset --hard &&
+	test_must_fail run_require_clean_work_tree
+'
+
+test_expect_success 'error on dirty index while on orphan branch' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	test_must_fail run_require_clean_work_tree
+'
+
+test_expect_success 'error on dirty index and work tree while on orpha=
n branch' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan orphan &&
+	echo dirty >file &&
+	test_must_fail run_require_clean_work_tree
+'
+
+test_done
--=20
2.6.3.418.gc3b7987
