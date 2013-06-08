From: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Subject: [PATCH 2/2] status: introduce status.branch to enable --branch by default
Date: Sat,  8 Jun 2013 11:28:57 +0200
Message-ID: <1370683737-28823-2-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
References: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 11:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlFSp-0000QM-Qt
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 11:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab3FHJ30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 05:29:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35826 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571Ab3FHJ3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 05:29:24 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r589TGF3000830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 11:29:16 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r589THUl009362;
	Sat, 8 Jun 2013 11:29:17 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r589TH4E030380;
	Sat, 8 Jun 2013 11:29:17 +0200
Received: (from garciagj@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r589THRf030366;
	Sat, 8 Jun 2013 11:29:17 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 08 Jun 2013 11:29:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r589TGF3000830
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: jorge-juan.garcia-garcia@ensimag.imag.fr
MailScanner-NULL-Check: 1371288560.24765@Vxg3A8toEYKX0sdGjPb1xQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226792>

Some people often run 'git status -b'.
The config variable status.branch allows to set it by default.

Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/config.txt |    3 +++
 builtin/commit.c         |    6 ++++++
 t/t7508-status.sh        |   30 ++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 80cdf75..21ba9c2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2069,6 +2069,9 @@ status.relativePaths::
 status.short::
 	Set to true to enable --short by default in linkgit:git-status[1].
 
+status.branch::
+	Set to true to enable --branch by default in linkgit:git-status[1].
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/builtin/commit.c b/builtin/commit.c
index 0f3429f..d447857 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1121,6 +1121,12 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		}
 		return 0;
 	}
+	if (!strcmp(k, "status.branch")) {
+		if (!v)
+			return config_error_nonbool(k);
+		s->show_branch = git_config_bool(k,v);
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 4cb2b62..34cf30f 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1369,4 +1369,34 @@ test_expect_success '"status.short=false" weaker than "-s"' '
     test_cmp status1 status2
 '
 
+test_expect_success '"status.branch=true" same as "-b"' '
+    git -c status.branch=true status -s >status2 &&
+    git status -sb >status1 &&
+    test_cmp status1 status2
+'
+
+test_expect_success '"status.branch=true" different from "--no-branch"' '
+    git -c status.branch=true status -s >status2 &&
+    git status -s --no-branch  >status1 &&
+    test_must_fail test_cmp status1 status2
+'
+
+test_expect_success '"status.branch=true" weaker than "--no-branch"' '
+    git -c status.branch=true status -s --no-branch >status2 &&
+    git status -s --no-branch >status1 &&
+    test_cmp status1 status2
+'
+
+test_expect_success '"status.branch=false" same as "--no-branch"' '
+    git -c status.branch=false status -s >status2 &&
+    git status -s --no-branch >status1 &&
+    test_cmp status1 status2
+'
+
+test_expect_success '"status.branch=false" weaker than "-b"' '
+    git -c status.branch=false status -sb >status2 &&
+    git status -sb >status1 &&
+    test_cmp status1 status2
+'
+
 test_done
-- 
1.7.8
