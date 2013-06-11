From: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
Subject: [PATCH v4 1/2] status: introduce status.short to enable --short by default
Date: Tue, 11 Jun 2013 15:34:04 +0200
Message-ID: <1370957645-17905-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 15:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmOig-0008Ho-D8
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 15:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab3FKNei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 09:34:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42014 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab3FKNeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 09:34:37 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5BDYVia018881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 15:34:31 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BDYW16015151;
	Tue, 11 Jun 2013 15:34:32 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BDYWO2020862;
	Tue, 11 Jun 2013 15:34:32 +0200
Received: (from garciagj@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5BDYWFl020861;
	Tue, 11 Jun 2013 15:34:32 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Jun 2013 15:34:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227437>

From: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>

Some people always run 'git status -s'.
The configuration variable status.short allows to set it by default.

Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
Changes since v3:
- Changes the order of the test between expected and actual.
- Format by default when status.short is not defined adequately.
- The number of test is the same (all posibilities that I wanted tested).
---
 Documentation/config.txt |    4 ++++
 builtin/commit.c         |    7 +++++++
 t/t7508-status.sh        |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 0 deletions(-)

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
index 1621dfc..075a91c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1112,6 +1112,13 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			s->submodule_summary = -1;
 		return 0;
 	}
+	if (!strcmp(k, "status.short")) {
+		if (git_config_bool(k, v))
+			status_format = STATUS_FORMAT_SHORT;
+		else
+			status_format = STATUS_FORMAT_NONE;
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e2ffdac..3c0818b 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1335,4 +1335,39 @@ test_expect_failure '.git/config ignore=all suppresses submodule summary' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success 'Setup of test environment' '
+	git config status.showUntrackedFiles no
+'
+
+test_expect_success '"status.short=true" same as "-s"' '
+	git -c status.short=true status >actual &&
+	git status -s >expected_short &&
+	test_cmp expected_short actual
+'
+
+test_expect_success '"status.short=true" different from "--no-short"' '
+	git status --no-short >expected_noshort &&
+	test_must_fail test_cmp expected_noshort actual
+'
+
+test_expect_success '"status.short=true" weaker than "--no-short"' '
+	git -c status.short=true status --no-short >actual &&
+	test_cmp expected_noshort actual
+'
+
+test_expect_success '"status.short=false" same as "--no-short"' '
+	git -c status.short=false status >actual &&
+	git status -s >expected_short &&
+	test_cmp expected_noshort actual
+'
+
+test_expect_success '"status.short=false" weaker than "-s"' '
+	git -c status.short=false status -s >actual &&
+	test_cmp expected_short actual
+'
+
+test_expect_success 'Restore default test environment' '
+	git config --unset status.showUntrackedFiles
+'
+
 test_done
-- 
1.7.8
