From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 1/2] test that git status works with merge conflict in,
 .gitmodules
Date: Sat, 14 May 2011 18:26:30 +0200
Message-ID: <4DCEAD36.6090605@web.de>
References: <4DCEACF8.50503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 18:26:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLHfo-0000Zr-EI
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 18:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab1ENQ0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 12:26:32 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60889 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab1ENQ0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 12:26:31 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 60EFF18EE8A8C;
	Sat, 14 May 2011 18:26:30 +0200 (CEST)
Received: from [93.240.103.149] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QLHfi-0006AG-00; Sat, 14 May 2011 18:26:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DCEACF8.50503@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX199lS3VBm4QOviCorC8MLP0r//fJK2QN41ypxPp
	e7lXUT16hhZ8pk8YCUMV7wVW2Q+yAM/d1CvCRkqlI5OWXUd2PK
	wjrlCuInirX/Tn7Eb+bQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173591>

From: Heiko Voigt <hvoigt@hvoigt.net>

For example: Two users independently adding a submodule will result in a
merge conflict in .gitmodules. Since configuration of the status and
diff machinery depends on the file being parseable they currently
fail to produce useable output in case .gitmodules is marked with a
merge conflict.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t7506-status-submodule.sh |   92 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index c8d50a6..61a5680 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -4,17 +4,21 @@ test_description='git status for submodule'

 . ./test-lib.sh

-test_expect_success 'setup' '
-	test_create_repo sub &&
+test_create_repo_with_commit () {
+	test_create_repo "$1" &&
 	(
-		cd sub &&
+		cd "$1" &&
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
@@ -187,4 +191,84 @@ test_expect_success 'status -a clean (empty submodule dir)' '
 	test_i18ngrep "nothing to commit" output
 '

+cat >status_expect <<\EOF
+AA .gitmodules
+A  sub1
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
+		git status -s >../status_actual 2>&1
+	) &&
+	test_cmp status_actual status_expect
+'
+
+sha1_merge_sub1=$(cd sub1 && git rev-parse HEAD)
+sha1_merge_sub2=$(cd sub2 && git rev-parse HEAD)
+short_sha1_merge_sub1=$(cd sub1 && git rev-parse --short HEAD)
+short_sha1_merge_sub2=$(cd sub2 && git rev-parse --short HEAD)
+cat >diff_expect <<\EOF
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
+cat >diff_submodule_expect <<\EOF
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
+		git diff >../diff_actual 2>&1
+	) &&
+	test_cmp diff_actual diff_expect
+'
+
+test_expect_failure 'diff --submodule with merge conflict in .gitmodules' '
+	(
+		cd super &&
+		git diff --submodule >../diff_submodule_actual 2>&1
+	) &&
+	test_cmp diff_submodule_actual diff_submodule_expect
+'
+
 test_done
-- 
1.7.5.1.291.g080bb
