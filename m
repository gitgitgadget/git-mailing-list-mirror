From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 3/6] filter-branch: invoke post-rewrite hook
Date: Sun, 14 Feb 2010 17:17:08 +0100
Message-ID: <0ad4b8c1a5377d697513cd8e49f64419cd8deef4.1266164150.git.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:17:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngh9v-0003AW-C1
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab0BNQRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:17:20 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:37742 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468Ab0BNQRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:17:16 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:14 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:17:12 +0100
X-Mailer: git-send-email 1.7.0.216.g74d8e
In-Reply-To: <cover.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139917>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-filter-branch.sh         |   10 ++++++++++
 t/t5407-post-rewrite-hook.sh |   20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 88fb0f0..531cc8e 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -358,6 +358,10 @@ while read commit parents; do
 	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
 		$(git write-tree) $parentstr < ../message > ../map/$commit ||
 			die "could not write rewritten commit"
+	new_commit=$(map $commit)
+	if test $commit != $new_commit; then
+		echo $commit $new_commit >> "$workdir"/../rewritten
+	fi
 done <../revs
 
 # If we are filtering for paths, as in the case of a subdirectory
@@ -484,6 +488,12 @@ if [ "$filter_tag_name" ]; then
 fi
 
 cd ../..
+
+if test -x "$GIT_DIR"/hooks/post-rewrite &&
+	test -s "$workdir"/../rewritten; then
+	"$GIT_DIR"/hooks/post-rewrite filter-branch < "$workdir"/../rewritten
+fi
+
 rm -rf "$tempdir"
 
 trap - 0
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 1020af9..ff23ebf 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -49,4 +49,24 @@ test_expect_success 'git commit --amend --no-post-rewrite' '
 	test ! -f post-rewrite.data
 '
 
+test_expect_success 'git filter-branch' '
+	git reset --hard D &&
+	clear_hook_input &&
+	git filter-branch -f --tree-filter "touch newfile" B..HEAD &&
+	echo filter-branch >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD^)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
+test_expect_success 'git filter-branch (no-op)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	git filter-branch -f B..HEAD &&
+	test ! -f post-rewrite.args &&
+	test ! -f post-rewrite.data
+'
+
 test_done
-- 
1.7.0.216.g74d8e
