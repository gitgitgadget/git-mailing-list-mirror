From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 4/5] buitin-status: Add tests for submodule summary
Date: Fri, 14 Mar 2008 23:28:40 +0800
Message-ID: <1205508521-7407-5-git-send-email-pkufranky@gmail.com>
References: <1205508521-7407-1-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-2-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-3-git-send-email-pkufranky@gmail.com>
 <1205508521-7407-4-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 14 16:30:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBrI-0003kn-BB
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYCNP25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbYCNP2z
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:28:55 -0400
Received: from mail.qikoo.org ([60.28.205.235]:50532 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753597AbYCNP2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:28:48 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 7DEF0470B1; Fri, 14 Mar 2008 23:28:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
In-Reply-To: <1205508521-7407-4-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77244>

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
1.5.4.4.653.g7cf1e
