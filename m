From: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Subject: [PATCH 1/2] status: introduce status.short to enable --short by default
Date: Sat,  8 Jun 2013 11:28:56 +0200
Message-ID: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 11:29:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlFSp-0000QM-9y
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 11:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab3FHJ3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 05:29:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33928 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568Ab3FHJ3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 05:29:23 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r589TEod030213
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jun 2013 11:29:14 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r589TFuN009359;
	Sat, 8 Jun 2013 11:29:15 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r589TFCh030269;
	Sat, 8 Jun 2013 11:29:15 +0200
Received: (from garciagj@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r589TEBp030226;
	Sat, 8 Jun 2013 11:29:14 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 08 Jun 2013 11:29:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r589TEod030213
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: jorge-juan.garcia-garcia@ensimag.imag.fr
MailScanner-NULL-Check: 1371288558.10835@aPqIVrwunTsTZbt2ovgkZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226793>

Some people always run 'git status -s'.
The configuration variable status.short allows to set it by default.

Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/config.txt |    3 +++
 builtin/commit.c         |    9 +++++++++
 config.c                 |    1 +
 t/t7508-status.sh        |   34 ++++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..80cdf75 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2066,6 +2066,9 @@ status.relativePaths::
 	relative to the repository root (this was the default for Git
 	prior to v1.5.4).
 
+status.short::
+	Set to true to enable --short by default in linkgit:git-status[1].
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/builtin/commit.c b/builtin/commit.c
index 1621dfc..0f3429f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1112,6 +1112,15 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			s->submodule_summary = -1;
 		return 0;
 	}
+	if (!strcmp(k, "status.short")) {
+		if (!v)
+			return config_error_nonbool(k);
+		if (git_config_bool(k,v)) {
+			status_format = STATUS_FORMAT_SHORT;
+			wt_shortstatus_print(s);
+		}
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
diff --git a/config.c b/config.c
index 7a85ebd..85ddbf2 100644
--- a/config.c
+++ b/config.c
@@ -9,6 +9,7 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "commit.h"
 
 typedef struct config_file {
 	struct config_file *prev;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e2ffdac..4cb2b62 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1334,5 +1334,39 @@ test_expect_failure '.git/config ignore=all suppresses submodule summary' '
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
+test_expect_success 'setup for testing status.short' '
+    >status1 &&
+    >status2
+'
+
+test_expect_success '"status.short=true" same as "-s"' '
+    git -c status.short=true status >status2 &&
+    git status -s >status1 &&
+    test_cmp status1 status2
+'
+
+test_expect_success '"status.short=true" different from "--no-short"' '
+    git -c status.short=true status >status2 &&
+    git status --no-short >status1 &&
+    test_must_fail test_cmp status1 status2
+'
+
+test_expect_success '"status.short=true" weaker than "--no-short"' '
+    git -c status.short=true status --no-short >status2 &&
+    git status --no-short >status1 &&
+    test_cmp status1 status2
+'
+
+test_expect_success '"status.short=false" same as "--no-short"' '
+    git -c status.short=false status >status2 &&
+    git status --no-short >status1 &&
+    test_cmp status1 status2
+'
+
+test_expect_success '"status.short=false" weaker than "-s"' '
+    git -c status.short=false status -s >status2 &&
+    git status -s >status1 &&
+    test_cmp status1 status2
+'
 
 test_done
-- 
1.7.8
