From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 3/3] buitin-status: Add tests for submodule summary
Date: Thu, 10 Apr 2008 23:50:20 +0800
Message-ID: <1207842625-9210-6-git-send-email-pkufranky@gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-3-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-4-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 17:53:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjz4Z-0005Y2-Kl
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514AbYDJPul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757677AbYDJPuj
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:50:39 -0400
Received: from mail.qikoo.org ([60.28.205.235]:37792 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757484AbYDJPuc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:50:32 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id CB3BB470B6; Thu, 10 Apr 2008 23:50:25 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
In-Reply-To: <1207842625-9210-5-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79232>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 t/t7502-status.sh |  134 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 134 insertions(+), 0 deletions(-)

diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index cd08516..33882c9 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -149,4 +149,138 @@ test_expect_success 'status of partial commit excluding new file in index' '
 	test_cmp expect output
 '
 
+test_expect_success "setup status submodule summary" '
+	test_create_repo sm &&
+	cd sm &&
+	: >foo &&
+	git add foo &&
+	git commit -m "Add foo" &&
+	cd .. &&
+	git add sm
+'
+
+cat > expect <<EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	new file:   dir2/added
+#	new file:   sm
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+EOF
+test_expect_success "status submodule summary is disabled by default" '
+	git status > output &&
+	git diff expect output
+'
+
+head=$(cd sm && git rev-parse --short=7 --verify HEAD)
+
+cat > expect <<EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	new file:   dir2/added
+#	new file:   sm
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   dir1/modified
+#
+# Modified submodules:
+#
+# * sm 0000000...$head (1):
+#   > Add foo
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+EOF
+test_expect_success "status submodule summary" '
+	git config status.submodulesummary 10 &&
+	git status > output &&
+	git diff expect output
+'
+
+
+cat > expect <<EOF
+# On branch master
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+no changes added to commit (use "git add" and/or "git commit -a")
+EOF
+test_expect_success "status submodule summary (clean submodule)" '
+	git commit -m "commit submodule" &&
+	git config status.submodulesummary 10 &&
+	! git status > output &&
+	git diff expect output
+'
+
+cat > expect <<EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD^1 <file>..." to unstage)
+#
+#	new file:   dir2/added
+#	new file:   sm
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   dir1/modified
+#
+# Modified submodules:
+#
+# * sm 0000000...$head (1):
+#   > Add foo
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+EOF
+test_expect_success "status submodule summary (--amend)" '
+	git config status.submodulesummary 10 &&
+	git status --amend > output &&
+	git diff expect output
+'
+
 test_done
-- 
1.5.5.23.g2a5f
