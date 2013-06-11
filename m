From: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
Subject: [PATCH v4 2/2] status:introduce status.branch to enable --branch by default
Date: Tue, 11 Jun 2013 15:34:05 +0200
Message-ID: <1370957645-17905-2-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
References: <1370957645-17905-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 15:41:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmOp9-0005qG-4l
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 15:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab3FKNlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 09:41:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36013 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab3FKNlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 09:41:18 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BDYcud017179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 15:34:38 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BDYdLe015153;
	Tue, 11 Jun 2013 15:34:39 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BDYdei021023;
	Tue, 11 Jun 2013 15:34:39 +0200
Received: (from garciagj@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5BDYdIT021021;
	Tue, 11 Jun 2013 15:34:39 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1370957645-17905-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 15:34:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227440>

From: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>

Some people often run 'git status -b'.
The config variable status.branch allows to set it by default.

Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
Changes since v3:
- Changes in the order in test between expected and actual.
- The number of test is the same (all posibilities that I wanted tested).
---
 Documentation/config.txt |    4 ++++
 builtin/commit.c         |    4 ++++
 t/t7508-status.sh        |   27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1983bf7..ecdcd6d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2070,6 +2070,10 @@ status.short::
 	Set to true to enable --short by default in linkgit:git-status[1].
 	The option --no-short takes precedence over this variable.
 
+status.branch::
+	Set to true to enable --branch by default in linkgit:git-status[1].
+	The option --no-branch takes precedence over this variable.
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/builtin/commit.c b/builtin/commit.c
index 075a91c..b589ce0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1119,6 +1119,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			status_format = STATUS_FORMAT_NONE;
 		return 0;
 	}
+	if (!strcmp(k, "status.branch")) {
+		s->show_branch = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 3c0818b..d627f9b 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1366,6 +1366,33 @@ test_expect_success '"status.short=false" weaker than "-s"' '
 	test_cmp expected_short actual
 '
 
+test_expect_success '"status.branch=true" same as "-b"' '
+	git -c status.branch=true status -s >actual &&
+	git status -sb >expected_branch &&
+	test_cmp expected_branch actual
+'
+
+test_expect_success '"status.branch=true" different from "--no-branch"' '
+	git -c status.branch=true status -s >actual &&
+	git status -s --no-branch  >expected_nobranch &&
+	test_must_fail test_cmp expected_nobranch actual
+'
+
+test_expect_success '"status.branch=true" weaker than "--no-branch"' '
+	git -c status.branch=true status -s --no-branch >actual &&
+	test_cmp expected_nobranch actual
+'
+
+test_expect_success '"status.branch=false" same as "--no-branch"' '
+	git -c status.branch=false status -s >actual &&
+	test_cmp expected_nobranch actual
+'
+
+test_expect_success '"status.branch=false" weaker than "-b"' '
+	git -c status.branch=false status -sb >actual &&
+	test_cmp expected_branch actual
+'
+
 test_expect_success 'Restore default test environment' '
 	git config --unset status.showUntrackedFiles
 '
-- 
1.7.8
