From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v2 5/5] branch -d: refuse deleting a branch which is currently checked out
Date: Sat, 26 Mar 2016 03:28:23 +0900
Message-ID: <cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
References: <cover.1458927521.git.k@rhe.jp>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 19:29:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWUE-0008G9-JP
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbcCYS3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:29:24 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:51618 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbcCYS3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:29:22 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 553165B006;
	Fri, 25 Mar 2016 18:29:20 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.21.g05df949
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
In-Reply-To: <cover.1458927521.git.k@rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp> <cover.1458927521.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289932>

When a branch is checked out by current working tree, deleting the
branch is forbidden. However when the branch is checked out only by
other working trees, deleting is allowed.
Use find_shared_symref() to check if the branch is in use, not just
comparing with the current working tree's HEAD.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 builtin/branch.c  | 12 +++++++-----
 t/t3200-branch.sh |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 31eb473d3e6a..e64aa68cf722 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -20,6 +20,7 @@
 #include "utf8.h"
 #include "wt-status.h"
 #include "ref-filter.h"
+#include "worktree.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
@@ -215,16 +216,17 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		int flags = 0;
 
 		strbuf_branchname(&bname, argv[i]);
-		if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
+		free(name);
+		name = mkpathdup(fmt, bname.buf);
+
+		if (kinds == FILTER_REFS_BRANCHES &&
+		    find_shared_symref("HEAD", name)) {
 			error(_("Cannot delete the branch '%s' "
-			      "which you are currently on."), bname.buf);
+			      "which is currently checked out."), bname.buf);
 			ret = 1;
 			continue;
 		}
 
-		free(name);
-
-		name = mkpathdup(fmt, bname.buf);
 		target = resolve_ref_unsafe(name,
 					    RESOLVE_REF_READING
 					    | RESOLVE_REF_NO_RECURSE
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f7d438bd7d1d..f3e3b6cf2eab 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -424,6 +424,12 @@ test_expect_success 'test deleting branch without config' '
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
2.8.0.rc4.21.g05df949
