From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 3/3] buitin-status: Add tests for submodule summary
Date: Wed, 12 Mar 2008 10:21:52 +0800
Message-ID: <1205288512-20435-3-git-send-email-pkufranky@gmail.com>
References: <1205288512-20435-1-git-send-email-pkufranky@gmail.com>
 <1205288512-20435-2-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 03:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZGcB-0003AZ-SG
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 03:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbYCLCWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 22:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbYCLCV7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 22:21:59 -0400
Received: from mail.qikoo.org ([60.28.205.235]:55355 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751351AbYCLCV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 22:21:59 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 6DE43470AF; Wed, 12 Mar 2008 10:21:53 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
In-Reply-To: <1205288512-20435-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76909>

---
 t/t7502-status.sh |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index e006074..d48c0fe 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -149,4 +149,80 @@ test_expect_success 'status of partial commit excluding new file in index' '
 	diff -u expect output
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
+cat > expect << \EOF
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
+cd sm &&
+head=$(git rev-parse --verify HEAD | cut -c1-7) &&
+cd ..
+
+cat > expect <<-EOF
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
 test_done
-- 
1.5.4.3.347.g5314c
