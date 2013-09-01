From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Sun,  1 Sep 2013 20:06:49 +0000
Message-ID: <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, judge.packham@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 22:07:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGDvi-0001iP-4h
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 22:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab3IAUHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 16:07:16 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60031 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753071Ab3IAUHM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Sep 2013 16:07:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 43C0528078;
	Sun,  1 Sep 2013 20:07:12 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233593>

git status prints information for submodules, but it should ignore the status of
those which have submodule.<name>.ignore set to all.  Fix it so that it does
properly ignore those which have that setting either in .git/config or in
.gitmodules.

Not ignored are submodules that are added, deleted, or moved (which is
essentially a combination of the first two) because it is not easily possible to
determine the old path once a move has occurred, nor is it easily possible to
detect which adds and deletions are moves and which are not.  This also
preserves the previous behavior of always listing modules which are to be
deleted.

Tests are included which verify that this change has no effect on git submodule
summary without the --for-status option.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-submodule.sh             |  7 +++++++
 t/t7401-submodule-summary.sh | 30 ++++++++++++++++++++++++++++++
 t/t7508-status.sh            |  4 ++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 38520db..004b21c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1036,6 +1036,13 @@ cmd_summary() {
 		do
 			# Always show modules deleted or type-changed (blob<->module)
 			test $status = D -o $status = T && echo "$sm_path" && continue
+			# Respect the ignore setting for --for-status.
+			if test -n "$for_status"
+			then
+				name=$(module_name "$sm_path")
+				ignore_config=$(get_submodule_config "$name" ignore none)
+				test $status != A -a $ignore_config = all && continue
+			fi
 			# Also show added or modified modules which are checked out
 			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
 			echo "$sm_path"
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index ac2434c..ca9441e 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -104,6 +104,36 @@ EOF
 	test_cmp expected actual
 "
 
+test_expect_success '.gitmodules ignore=all has no effect' "
+	git config --add -f .gitmodules submodule.sm1.ignore all &&
+	git config --add -f .gitmodules submodule.sm1.path sm1 &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
+* sm1 $head1...$head2 (1):
+  > Add foo3
+
+EOF
+	test_cmp expected actual &&
+	git config -f .gitmodules --remove-section submodule.sm1
+"
+
+test_expect_success '.git/config ignore=all has no effect' "
+	git config --add -f .gitmodules submodule.sm1.ignore none &&
+	git config --add -f .gitmodules submodule.sm1.path sm1 &&
+	git config --add submodule.sm1.ignore all &&
+	git config --add submodule.sm1.path sm1 &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
+* sm1 $head1...$head2 (1):
+  > Add foo3
+
+EOF
+	test_cmp expected actual &&
+	git config --remove-section submodule.sm1 &&
+	git config -f .gitmodules --remove-section submodule.sm1
+"
+
+
 commit_file sm1 &&
 head3=$(
 	cd sm1 &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index ac3d0fe..fb89fb9 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1316,7 +1316,7 @@ test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	test_i18ncmp expect output
 '
 
-test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
+test_expect_success '.gitmodules ignore=all suppresses submodule summary' '
 	git config --add -f .gitmodules submodule.subname.ignore all &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
@@ -1324,7 +1324,7 @@ test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
-test_expect_failure '.git/config ignore=all suppresses submodule summary' '
+test_expect_success '.git/config ignore=all suppresses submodule summary' '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore all &&
-- 
1.8.4.rc3
