From: Max Kirillov <max@max630.net>
Subject: [PATCH v2] setup.c: set workdir when gitdir is not default
Date: Fri,  5 Sep 2014 00:33:44 +0300
Message-ID: <1409866424-19068-1-git-send-email-max@max630.net>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPefl-00014i-DB
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 23:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbaIDVeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 17:34:24 -0400
Received: from p3plsmtpa09-08.prod.phx3.secureserver.net ([173.201.193.237]:46810
	"EHLO p3plsmtpa09-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755230AbaIDVeY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 17:34:24 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa09-08.prod.phx3.secureserver.net with 
	id n9aE1o0013gsSd6019aJ6h; Thu, 04 Sep 2014 14:34:23 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256484>

When gitfile is used, git sets GIT_DIR environment variable for
subsequent commands, and that commands start working in mode "GIT_DIR
set, workdir current", which is incorrect for the case when git runs
from subdirectory of repository. This can be observed at least for
running aliases - git fails with message "internal error: work tree has
already been set"

Fix by setting GIT_WORK_TREE environment also.

Add test which demonstrates problem with alias.

Signed-off-by: Max Kirillov <max@max630.net>
---
 setup.c            | 4 +++-
 t/t0002-gitfile.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 0a22f8b..bcf4e31 100644
--- a/setup.c
+++ b/setup.c
@@ -508,8 +508,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 	/* #0, #1, #5, #8, #9, #12, #13 */
 	set_git_work_tree(".");
-	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
+	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT)) {
 		set_git_dir(gitdir);
+		setenv(GIT_WORK_TREE_ENVIRONMENT, get_git_work_tree(), 1);
+	}
 	inside_git_dir = 0;
 	inside_work_tree = 1;
 	if (offset == len)
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 37e9396..64d59c3 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -99,4 +99,13 @@ test_expect_success 'check rev-list' '
 	test "$SHA" = "$(git rev-list HEAD)"
 '
 
+test_expect_success 'check alias call from subdirectory' '
+	test_config alias.testalias "rev-parse HEAD" &&
+	mkdir -p subdir &&
+	(
+		cd subdir &&
+		git testalias
+	)
+'
+
 test_done
-- 
2.0.1.1697.g73c6810
