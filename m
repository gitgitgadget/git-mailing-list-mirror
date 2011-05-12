From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH 1/2] test that git status works with merge conflict in
 .gitmodules
Date: Thu, 12 May 2011 23:02:24 +0200
Message-ID: <4DCC4AE0.6020902@web.de>
References: <4DCC4A9D.3060007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 23:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKd1j-0005KV-GL
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 23:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758647Ab1ELVC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 17:02:27 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60663 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758634Ab1ELVC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 17:02:26 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0786419F50620;
	Thu, 12 May 2011 23:02:25 +0200 (CEST)
Received: from [93.240.105.8] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QKd1c-0003iF-00; Thu, 12 May 2011 23:02:24 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DCC4A9D.3060007@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19kbg78t/psNxbFI5TM6EPsZVDbYZBkMzkB31DD
	5xiCjw/1Ng1ERXbT08mDShrOpLfayLQFAeXymWZ9afgusZGl7G
	U05u2gztWpp9HicW7AoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173498>

From: Heiko Voigt <hvoigt@hvoigt.net>

For example: Two users independently adding a submodule will result in a
merge conflict in .gitmodules. Since configuration of the status and
diff machinery depends on the file being parseable they currently
fail to produce useable output in case .gitmodules is marked with a
merge conflict.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t7506-status-submodule.sh |  100 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index c8d50a6..3b1806c 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -4,17 +4,21 @@ test_description='git status for submodule'

 . ./test-lib.sh

-test_expect_success 'setup' '
-	test_create_repo sub &&
+test_create_repo_with_commit () {
+	test_create_repo $1 &&
 	(
-		cd sub &&
+		cd $1 &&
 		: >bar &&
 		git add bar &&
 		git commit -m " Add bar" &&
 		: >foo &&
 		git add foo &&
 		git commit -m " Add foo"
-	) &&
+	)
+}
+
+test_expect_success 'setup' '
+	test_create_repo_with_commit sub &&
 	echo output > .gitignore &&
 	git add sub .gitignore &&
 	git commit -m "Add submodule sub"
@@ -187,4 +191,92 @@ test_expect_success 'status -a clean (empty submodule dir)' '
 	test_i18ngrep "nothing to commit" output
 '

+cat > status_expect << EOF
+# On branch merge_conflict_gitmodules
+# Changes to be committed:
+#
+#	new file:   sub1
+#
+# Unmerged paths:
+#   (use "git add/rm <file>..." as appropriate to mark resolution)
+#
+#	both added:         .gitmodules
+#
+EOF
+
+test_expect_failure 'status with merge conflict in .gitmodules' '
+	git clone . super &&
+	test_create_repo_with_commit sub1 &&
+	test_tick &&
+	test_create_repo_with_commit sub2 &&
+	(
+		cd super &&
+		prev=$(git rev-parse HEAD) &&
+		git checkout -b add_sub1 &&
+		git submodule add ../sub1 &&
+		git commit -m "add sub1" &&
+		git checkout -b add_sub2 $prev &&
+		git submodule add ../sub2 &&
+		git commit -m "add sub2" &&
+		git checkout -b merge_conflict_gitmodules &&
+		test_must_fail git merge add_sub1 &&
+		git status > ../status_actual 2>&1
+	) &&
+	test_cmp status_actual status_expect
+'
+
+sha1_merge_sub1=$(cd sub1 && git rev-parse HEAD)
+sha1_merge_sub2=$(cd sub2 && git rev-parse HEAD)
+short_sha1_merge_sub1=$(cd sub1 && git rev-parse --short HEAD)
+short_sha1_merge_sub2=$(cd sub2 && git rev-parse --short HEAD)
+cat > diff_expect << EOF
+diff --cc .gitmodules
+index badaa4c,44f999a..0000000
+--- a/.gitmodules
++++ b/.gitmodules
+@@@ -1,3 -1,3 +1,9 @@@
+++<<<<<<< HEAD
+ +[submodule "sub2"]
+ +	path = sub2
+ +	url = ../sub2
+++=======
++ [submodule "sub1"]
++ 	path = sub1
++ 	url = ../sub1
+++>>>>>>> add_sub1
+EOF
+
+cat > diff_submodule_expect << EOF
+diff --cc .gitmodules
+index badaa4c,44f999a..0000000
+--- a/.gitmodules
++++ b/.gitmodules
+@@@ -1,3 -1,3 +1,9 @@@
+++<<<<<<< HEAD
+ +[submodule "sub2"]
+ +	path = sub2
+ +	url = ../sub2
+++=======
++ [submodule "sub1"]
++ 	path = sub1
++ 	url = ../sub1
+++>>>>>>> add_sub1
+EOF
+
+test_expect_failure 'diff with merge conflict in .gitmodules' '
+	(
+		cd super &&
+		git diff > ../diff_actual 2>&1
+	) &&
+	test_cmp diff_actual diff_expect
+'
+
+test_expect_failure 'diff --submodule with merge conflict in .gitmodules' '
+	(
+		cd super &&
+		git diff --submodule > ../diff_submodule_actual 2>&1
+	) &&
+	test_cmp diff_submodule_actual diff_submodule_expect
+'
+
 test_done
-- 
1.7.5.1.251.ga75dd
