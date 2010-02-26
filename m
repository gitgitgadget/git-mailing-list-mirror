From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH] t/t0001-init.sh: add test for 'init with init.templatedir set'
Date: Fri, 26 Feb 2010 17:00:21 +1300
Message-ID: <7bce5804fd71ac19c9164c9c2deb9dd714dc7aee.1267156694.git.sdrake@xnet.co.nz>
References: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 05:08:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkrV7-0001PF-21
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 05:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935166Ab0BZEIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 23:08:24 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:46581 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935155Ab0BZEIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 23:08:22 -0500
Received: from localhost.localdomain (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id 56DF2170891
	for <git@vger.kernel.org>; Fri, 26 Feb 2010 17:08:21 +1300 (NZDT)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141101>

Requires a small change to wrap-for-bin.sh in order to work.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 t/t0001-init.sh |   19 +++++++++++++++++++
 wrap-for-bin.sh |    3 ++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5386504..6757734 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -167,6 +167,25 @@ test_expect_success 'init with --template (blank)' '
 	! test -f template-blank/.git/info/exclude
 '
 
+test_expect_success 'init with init.templatedir set' '
+	mkdir templatedir-source &&
+	echo Content >templatedir-source/file &&
+	(
+		HOME="`pwd`" &&
+		export HOME &&
+		test_config="${HOME}/.gitconfig" &&
+		git config -f "$test_config"  init.templatedir "${HOME}/templatedir-source" &&
+		mkdir templatedir-set &&
+		cd templatedir-set &&
+		unset GIT_CONFIG_NOGLOBAL &&
+		unset GIT_TEMPLATE_DIR &&
+		NO_SET_GIT_TEMPLATE_DIR=t &&
+		export NO_SET_GIT_TEMPLATE_DIR &&
+		git init
+	) &&
+	test_cmp templatedir-source/file templatedir-set/.git/file
+'
+
 test_expect_success 'init --bare/--shared overrides system/global config' '
 	(
 		HOME="`pwd`" &&
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index c5075c9..aece782 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -7,7 +7,8 @@
 # @@BUILD_DIR@@ and @@PROG@@.
 
 GIT_EXEC_PATH='@@BUILD_DIR@@'
-GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
+test -z "$NO_SET_GIT_TEMPLATE_DIR" &&
+	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
 GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GIT_TEMPLATE_DIR GITPERLLIB PATH
-- 
1.6.6
