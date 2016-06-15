From: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Subject: [PATCH v2 1/2] status: introduce status.short to enable --short by default
Date: Mon, 10 Jun 2013 16:40:25 +0200
Message-ID: <1370875226-31392-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 16:40:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3H6-000805-Vv
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab3FJOkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:40:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59965 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638Ab3FJOkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:40:40 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AEeZ6H030852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 16:40:35 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5AEebul015784;
	Mon, 10 Jun 2013 16:40:37 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5AEebHf013446;
	Mon, 10 Jun 2013 16:40:37 +0200
Received: (from garciagj@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5AEebvE013445;
	Mon, 10 Jun 2013 16:40:37 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 16:40:35 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227294>

Some people always run 'git status -s'.
The configuration variable status.short allows to set it by default.

Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---

Changes since v1:
 -documentation more accurate
 -removal of unappropriate function calls
 -clean-up in the test

 Documentation/config.txt |    4 ++++
 builtin/commit.c         |    5 +++++
 t/t7508-status.sh        |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..1983bf7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2066,6 +2066,10 @@ status.relativePaths::
 	relative to the repository root (this was the default for Git
 	prior to v1.5.4).
 
+status.short::
+	Set to true to enable --short by default in linkgit:git-status[1].
+	The option --no-short takes precedence over this variable.
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/builtin/commit.c b/builtin/commit.c
index 1621dfc..287f1cb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1112,6 +1112,11 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			s->submodule_summary = -1;
 		return 0;
 	}
+	if (!strcmp(k, "status.short")) {
+		if (git_config_bool(k, v))
+			status_format = STATUS_FORMAT_SHORT;
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e2ffdac..9a07f15 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1335,4 +1335,39 @@ test_expect_failure '.git/config ignore=all suppresses submodule summary' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success '"Setup of environment of test"' '
+	git config status.showUntrackedFiles no
+'
+
+test_expect_success '"status.short=true" same as "-s"' '
+	git -c status.short=true status >actual &&
+	git status -s >expected_short &&
+	test_cmp actual expected_short
+'
+
+test_expect_success '"status.short=true" different from "--no-short"' '
+	git status --no-short >expected_noshort &&
+	test_must_fail test_cmp actual expected_noshort
+'
+
+test_expect_success '"status.short=true" weaker than "--no-short"' '
+	git -c status.short=true status --no-short >actual &&
+	test_cmp actual expected_noshort
+'
+
+test_expect_success '"status.short=false" same as "--no-short"' '
+	git -c status.short=false status >actual &&
+	git status -s >expected_short &&
+	test_cmp actual expected_noshort
+'
+
+test_expect_success '"status.short=false" weaker than "-s"' '
+	git -c status.short=false status -s >actual &&
+	test_cmp actual expected_short
+'
+
+test_expect_success '"Back to environment of test by default"' '
+	git config status.showUntrackedFiles yes
+'
+
 test_done
-- 
1.7.8
