From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 22/28] t: rebase-autostash: fix setup
Date: Fri, 30 Aug 2013 00:56:16 -0500
Message-ID: <1377842182-18724-23-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmd-0007iQ-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab3H3GB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:58 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:55365 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:56 -0400
Received: by mail-ob0-f180.google.com with SMTP id v19so1452442obq.25
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvJ4jbsGSQRKQSv3x49sztUc2gQdwRY7y6XQxsaVjBo=;
        b=v538/bQh7Zfwcb3HMY/lVHrJ10fwZBHWSWlQ11tV74zSUBNfDAuFx4JdvhpliVtyBJ
         +5bIdHrotlBz2kHPbtJz9hbgNtBrl/QDl2guibz1f5tISpqaxYMDAgNuCELPAleOgC3g
         5HXYqOwtMYd67Gkxvz3tGuRDup04UlX9InHzmjvL6a5qoJZ9tf6vIBmALEJ5o5zlEbVO
         EAWWgJDXQLif1sf8/lj68eCyO0u22bjfhbSaS3ZZ+UKO4gKbn8BJBXggoivOA9AuECYz
         PynnEzem7Unl50kenqAhXl0VTyRq34VPpaERxkfcvL9ROJXsUYriv+zxPc7K+Rj8WRVv
         HCJw==
X-Received: by 10.182.213.133 with SMTP id ns5mr5566955obc.62.1377842516476;
        Thu, 29 Aug 2013 23:01:56 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm36896015oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233414>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3420-rebase-autostash.sh | 105 ++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 90eb264..c179262 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -33,54 +33,56 @@ test_expect_success setup '
 	git commit -m "related commit"
 '
 
+setup_tmp () {
+	git clone . tmp &&
+	cd tmp &&
+	git fetch -u origin "refs/heads/*:refs/heads/*" &&
+	test_config rebase.autostash true &&
+	git checkout -b rebased-feature-branch feature-branch
+}
+
 testrebase() {
 	type=$1
 	dotest=$2
 
 	test_expect_success "rebase$type: dirty worktree, non-conflicting rebase" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		git rebase$type unrelated-onto-branch &&
 		grep unrelated file4 &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'
 
 	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		git add file3 &&
 		git rebase$type unrelated-onto-branch &&
 		grep unrelated file4 &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'
 
 	test_expect_success "rebase$type: conflicting rebase" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
-		! grep dirty file3 &&
-		rm -rf $dotest &&
-		git reset --hard &&
-		git checkout feature-branch
+		! grep dirty file3
+		)
 	'
 
 	test_expect_success "rebase$type: --continue" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
@@ -89,45 +91,43 @@ testrebase() {
 		git add file2 &&
 		git rebase --continue &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'
 
 	test_expect_success "rebase$type: --skip" '
-		test_config rebase.autostash true &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
 		! grep dirty file3 &&
 		git rebase --skip &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'
 
 	test_expect_success "rebase$type: --abort" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
 		! grep dirty file3 &&
 		git rebase --abort &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'
 
 	test_expect_success "rebase$type: non-conflicting rebase, conflicting stash" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >file4 &&
 		git add file4 &&
 		git rebase$type unrelated-onto-branch &&
@@ -138,29 +138,28 @@ testrebase() {
 		git checkout feature-branch &&
 		git stash pop &&
 		grep dirty file4
+		)
 	'
 }
 
 test_expect_success "rebase: fast-forward rebase" '
-	test_config rebase.autostash true &&
-	git reset --hard &&
-	git checkout -b behind-feature-branch feature-branch~1 &&
-	test_when_finished git branch -D behind-feature-branch &&
+	test_when_finished "rm -rf tmp" &&
+	(
+	setup_tmp &&
 	echo dirty >>file1 &&
 	git rebase feature-branch &&
-	grep dirty file1 &&
-	git checkout feature-branch
+	grep dirty file1
+	)
 '
 
 test_expect_success "rebase: noop rebase" '
-	test_config rebase.autostash true &&
-	git reset --hard &&
-	git checkout -b same-feature-branch feature-branch &&
-	test_when_finished git branch -D same-feature-branch &&
+	test_when_finished "rm -rf tmp" &&
+	(
+	setup_tmp &&
 	echo dirty >>file1 &&
 	git rebase feature-branch &&
-	grep dirty file1 &&
-	git checkout feature-branch
+	grep dirty file1
+	)
 '
 
 testrebase "" .git/rebase-apply
-- 
1.8.4-fc
