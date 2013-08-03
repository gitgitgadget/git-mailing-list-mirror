From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] submodule: don't print status output with ignore=all
Date: Sat,  3 Aug 2013 17:14:20 +0000
Message-ID: <1375550060-5406-3-git-send-email-sandals@crustytoothpaste.net>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
Cc: judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 19:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5fPd-0003iD-C0
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 19:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab3HCROj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 13:14:39 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45644 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752106Ab3HCROh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 13:14:37 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7D1E728076;
	Sat,  3 Aug 2013 17:14:37 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc1
In-Reply-To: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231611>

git status prints information for submodules, but it should ignore the status of
those which have submodule.<name>.ignore set to all.  Fix it so that it does
properly ignore those which have that setting either in .git/config or in
.gitmodules.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-submodule.sh  | 2 ++
 t/t7508-status.sh | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 30b7fc1..5694ae6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1034,6 +1034,8 @@ cmd_summary() {
 		sane_egrep '^:([0-7]* )?160000' |
 		while read mod_src mod_dst sha1_src sha1_dst status path
 		do
+			name=$(module_name "$path")
+			test $(get_submodule_config "$name" ignore none) = all && continue
 			# Always show modules deleted or type-changed (blob<->module)
 			test $status = D -o $status = T && echo "$path" && continue
 			# Also show added or modified modules which are checked out
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
1.8.4.rc1
