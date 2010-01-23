From: Alex Scarborough <alex@gameclay.com>
Subject: [PATCH] rebase -p: Preserve fast-forwardable merges
Date: Fri, 22 Jan 2010 23:29:26 -0800
Message-ID: <dd10f5481001222329i58e7b709m2c547c74161b6771@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Alex Scarborough <alex@gameclay.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 08:35:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYaWr-0004MD-4L
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 08:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab0AWHf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 02:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933Ab0AWHf3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 02:35:29 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:42638 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab0AWHf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 02:35:27 -0500
Received: by ywh6 with SMTP id 6so1720341ywh.4
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 23:35:24 -0800 (PST)
Received: by 10.151.58.8 with SMTP id l8mr5431636ybk.59.1264231766552; Fri, 22 
	Jan 2010 23:29:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137814>

Previously, rebase -p would not preserve a merge commit if the merge
could be resolved as a fast-forward.  rebase -p now passes --no-ff to
git merge when recreating a merge commit, which ensures that merge
commits created with git merge --no-ff are preserved.

Signed-off-by: Alex Scarborough <alex@gameclay.com>
---
First patch, so here's hoping neither I nor my mail client messed up
too much.

This patch will not apply cleanly to branches which do not have
mh/rebase-fixup merged in, as that series removed the wrap of the
line I changed.

 git-rebase--interactive.sh                         |    2 +-
 t/t3416-rebase-preserve-fast-forwardable-merges.sh |   41 ++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletions(-)
 create mode 100755 t/t3416-rebase-preserve-fast-forwardable-merges.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c2f6089..a7a2acc 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -343,7 +343,7 @@ pick_one_preserving_merges () {
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! do_with_author output \
-				git merge $STRATEGY -m "$msg" $new_parents
+				git merge --no-ff $STRATEGY -m "$msg" $new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
diff --git a/t/t3416-rebase-preserve-fast-forwardable-merges.sh
b/t/t3416-rebase-preserve-fast-forwardable-merges.sh
new file mode 100755
index 0000000..d46bf91
--- /dev/null
+++ b/t/t3416-rebase-preserve-fast-forwardable-merges.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='git rebase preserve fastforwardable merges
+
+This test runs git rebase with -p and checks that merges created by
+git merge --no-ff are properly carried along.
+'
+. ./test-lib.sh
+
+# set up three branches like this:
+#
+# A1 - C1 - - - E1
+#   \   \       /
+#    \   -- D1 --
+#     \
+#      -- B1
+
+test_expect_success 'setup' '
+	test_commit A1 &&
+	test_commit B1 &&
+	git reset --hard A1 &&
+	test_commit C1 &&
+	test_commit D1 &&
+	git reset --hard C1 &&
+	test_tick &&
+	git merge --no-ff -m "E1" "D1" &&
+	git tag "E1"
+'
+
+# Should result in:
+#
+# A1 - B1 - C2 - - - E2
+#            \       /
+#             -- D2 --
+#
+test_expect_success 'rebase C1 onto B1' '
+	git rebase -p B1 &&
+	git rev-parse HEAD^2
+'
+
+test_done
-- 
1.6.6
