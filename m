From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/2] submodule: don't print status output with ignore=all
Date: Sat, 17 Aug 2013 17:25:43 +0000
Message-ID: <1376760343-741047-3-git-send-email-sandals@crustytoothpaste.net>
References: <1376760343-741047-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 17 19:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAkGF-0007U7-Ku
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 19:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab3HQRZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 13:25:53 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45915 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753878Ab3HQRZw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Aug 2013 13:25:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4F5F728073
	for <git@vger.kernel.org>; Sat, 17 Aug 2013 17:25:52 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc2
In-Reply-To: <1376760343-741047-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232465>

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

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-submodule.sh  | 7 +++++++
 t/t7508-status.sh | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 38520db..c1ba0f8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1036,6 +1036,13 @@ cmd_summary() {
 		do
 			# Always show modules deleted or type-changed (blob<->module)
 			test $status = D -o $status = T && echo "$sm_path" && continue
+			# Respect the ignore setting for --for-status.
+			if test -n $for_status
+			then
+				name=$(module_name "$sm_path")
+				ignore_config=$(get_submodule_config "$name" ignore none)
+				test $status != A -a $ignore_config = all && continue
+			fi
 			# Also show added or modified modules which are checked out
 			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
 			echo "$sm_path"
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
1.8.4.rc2.564.g10ce5ae
