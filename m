From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v2] branch -d: refuse deleting a branch which is currently checked out
Date: Mon, 28 Mar 2016 16:22:51 +0900
Message-ID: <1459149771-14790-1-git-send-email-k@rhe.jp>
References: <cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp> <CAPig+cSCC+OzotkTx89iS+t4DRd3F+QoHP4n-v_+rxXU2R+2LA@mail.gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 09:23:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akRW3-0004ar-8A
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 09:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbcC1HXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 03:23:04 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:53316 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbcC1HXB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 03:23:01 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 828705BB25;
	Mon, 28 Mar 2016 07:22:59 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.17.gdb328b3
In-Reply-To: <cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290027>

When a branch is checked out by current working tree, deleting the
branch is forbidden. However when the branch is checked out only by
other working trees, deleting is allowed.
Use find_shared_symref() to check if the branch is in use, not just
comparing with the current working tree's HEAD.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---

  % git worktree list
  /path/to      2c3c5f2 [master]
  /path/to/wt   2c3c5f2 [branch-a]
  % git branch -d branch-a
  error: Cannot delete the branch 'branch-a' which is currently checked out at '/path/to/wt'

 builtin/branch.c  | 22 ++++++++++++++--------
 t/t3200-branch.sh |  6 ++++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6bd6b80..de1641306c9e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -20,6 +20,7 @@
 #include "utf8.h"
 #include "wt-status.h"
 #include "ref-filter.h"
+#include "worktree.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
@@ -215,16 +216,21 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		int flags = 0;
 
 		strbuf_branchname(&bname, argv[i]);
-		if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
-			error(_("Cannot delete the branch '%s' "
-			      "which you are currently on."), bname.buf);
-			ret = 1;
-			continue;
-		}
-
 		free(name);
-
 		name = mkpathdup(fmt, bname.buf);
+
+		if (kinds == FILTER_REFS_BRANCHES) {
+			char *worktree = find_shared_symref("HEAD", name);
+			if (worktree) {
+				error(_("Cannot delete the branch '%s' "
+					"which is currently checked out at '%s'"),
+				      bname.buf, worktree);
+				free(worktree);
+				ret = 1;
+				continue;
+			}
+		}
+
 		target = resolve_ref_unsafe(name,
 					    RESOLVE_REF_READING
 					    | RESOLVE_REF_NO_RECURSE
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a89724849065..508007fd3772 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -403,6 +403,12 @@ test_expect_success 'test deleting branch without config' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'deleting currently checked out branch fails' '
+	git worktree add -b my7 my7 &&
+	test_must_fail git -C my7 branch -d my7 &&
+	test_must_fail git branch -d my7
+'
+
 test_expect_success 'test --track without .fetch entries' '
 	git branch --track my8 &&
 	test "$(git config branch.my8.remote)" &&
-- 
2.8.0.rc4.17.gdb328b3
