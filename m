From: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Subject: [PATCH v2 2/2] status:introduce status.branch to enable --branch by default
Date: Mon, 10 Jun 2013 16:40:26 +0200
Message-ID: <1370875226-31392-2-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
References: <1370875226-31392-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 16:40:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3H7-000805-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab3FJOkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:40:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33534 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879Ab3FJOkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:40:41 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5AEebtY019571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 16:40:37 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5AEedMC015787;
	Mon, 10 Jun 2013 16:40:39 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5AEedPP013616;
	Mon, 10 Jun 2013 16:40:39 +0200
Received: (from garciagj@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5AEedql013615;
	Mon, 10 Jun 2013 16:40:39 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1370875226-31392-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 16:40:37 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227293>

Some people often run 'git status -b'.
The config variable status.branch allows to set it by default.

Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---

Changes since v1:
 -Documentation more accurate
 -removal of unappropriate function calls
 -clean up in the test

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
index 287f1cb..f2b5d44 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1117,6 +1117,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			status_format = STATUS_FORMAT_SHORT;
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
index 9a07f15..958617a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1366,6 +1366,33 @@ test_expect_success '"status.short=false" weaker than "-s"' '
 	test_cmp actual expected_short
 '
 
+test_expect_success '"status.branch=true" same as "-b"' '
+	git -c status.branch=true status -s >actual &&
+	git status -sb >expected_branch &&
+	test_cmp actual expected_branch
+'
+
+test_expect_success '"status.branch=true" different from "--no-branch"' '
+	git -c status.branch=true status -s >actual &&
+	git status -s --no-branch  >expected_nobranch &&
+	test_must_fail test_cmp actual expected_nobranch
+'
+
+test_expect_success '"status.branch=true" weaker than "--no-branch"' '
+	git -c status.branch=true status -s --no-branch >actual &&
+	test_cmp actual expected_nobranch
+'
+
+test_expect_success '"status.branch=false" same as "--no-branch"' '
+	git -c status.branch=false status -s >actual &&
+	test_cmp actual expected_nobranch
+'
+
+test_expect_success '"status.branch=false" weaker than "-b"' '
+	git -c status.branch=false status -sb >actual &&
+	test_cmp actual expected_branch
+'
+
 test_expect_success '"Back to environment of test by default"' '
 	git config status.showUntrackedFiles yes
 '
-- 
1.7.8
