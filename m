From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] t: branch: improve test rollback
Date: Thu, 31 Oct 2013 03:27:11 -0600
Message-ID: <1383211631-9244-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vboda-0000Ac-Dw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab3JaJdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:33:54 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:42850 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3JaJdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:33:53 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so2781949obc.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=83RzFZqUG9Z/szTTW56xdEXfVW/7rIJxGYfvqk8gyoM=;
        b=LPaqqR2Kg5qc0EWmYIZZzfj0w2T5xToJjAuQ3W7oDOjY/tRGxMwTsxfWOLk16x7Gry
         WzIOKuTRhg9sWzlZ0naFBXECBa2ZSb8CwuKEZp7wfCXvjgg9h9IzwSnIl188cgD1Q24r
         b/XjiEJ8cIByHdiCcnTVd363z4nswAGNAfT9Td35WKG1ntEWfH4WeXHIJ/F/hhvnkqB0
         s1sWUBvxZlrL3WY3fSN6hahO5c5YevozGwEOInsRX6eYnlerWQL67PvHnSD7+QqJGyIf
         Ngyhmvi25nSgXMA0LEMrTpN/ul34/94uJaSwZalpR95GQGbcEJKocHq48FYIZGgOgpE1
         CY7Q==
X-Received: by 10.60.36.133 with SMTP id q5mr1585528oej.63.1383212033071;
        Thu, 31 Oct 2013 02:33:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm4497505obu.4.2013.10.31.02.33.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:33:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237101>

After every test the environment should be as close as to how it was
before as possible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3200-branch.sh | 71 +++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 0fe7647..33673e0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -329,7 +329,7 @@ test_expect_success 'tracking setup fails on non-matching refspec' '
 '
 
 test_expect_success 'test tracking setup via config' '
-	git config branch.autosetupmerge true &&
+	test_config branch.autosetupmerge true &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -339,20 +339,18 @@ test_expect_success 'test tracking setup via config' '
 '
 
 test_expect_success 'test overriding tracking setup via --no-track' '
-	git config branch.autosetupmerge true &&
+	test_config branch.autosetupmerge true &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track my2 local/master &&
-	git config branch.autosetupmerge false &&
 	! test "$(git config branch.my2.remote)" = local &&
 	! test "$(git config branch.my2.merge)" = refs/heads/master
 '
 
 test_expect_success 'no tracking without .fetch entries' '
-	git config branch.autosetupmerge true &&
+	test_config branch.autosetupmerge true &&
 	git branch my6 s &&
-	git config branch.autosetupmerge false &&
 	test -z "$(git config branch.my6.remote)" &&
 	test -z "$(git config branch.my6.merge)"
 '
@@ -387,9 +385,8 @@ test_expect_success 'test --track without .fetch entries' '
 '
 
 test_expect_success 'branch from non-branch HEAD w/autosetupmerge=always' '
-	git config branch.autosetupmerge always &&
-	git branch my9 HEAD^ &&
-	git config branch.autosetupmerge false
+	test_config branch.autosetupmerge always &&
+	git branch my9 HEAD^
 '
 
 test_expect_success 'branch from non-branch HEAD w/--track causes failure' '
@@ -406,9 +403,9 @@ test_expect_success '--set-upstream-to fails on multiple branches' '
 '
 
 test_expect_success '--set-upstream-to fails on detached HEAD' '
+	test_when_finished "git checkout -" &&
 	git checkout HEAD^{} &&
-	test_must_fail git branch --set-upstream-to master &&
-	git checkout -
+	test_must_fail git branch --set-upstream-to master
 '
 
 test_expect_success '--set-upstream-to fails on a missing dst branch' '
@@ -460,9 +457,9 @@ test_expect_success '--unset-upstream should fail on multiple branches' '
 '
 
 test_expect_success '--unset-upstream should fail on detached HEAD' '
+	test_when_finished "git checkout -" &&
 	git checkout HEAD^{} &&
-	test_must_fail git branch --unset-upstream &&
-	git checkout -
+	test_must_fail git branch --unset-upstream
 '
 
 test_expect_success 'test --unset-upstream on a particular branch' '
@@ -541,7 +538,8 @@ test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates
 '
 
 test_expect_success 'avoid ambiguous track' '
-	git config branch.autosetupmerge true &&
+	test_when_finished "git remote rm ambi1 && git remote rm ambi2" &&
+	test_config branch.autosetupmerge true &&
 	git config remote.ambi1.url lalala &&
 	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
 	git config remote.ambi2.url lilili &&
@@ -553,7 +551,7 @@ test_expect_success 'avoid ambiguous track' '
 test_expect_success 'autosetuprebase local on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase local &&
+	test_config branch.autosetuprebase local &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase &&
 	git branch --track myr1 mybase &&
@@ -565,7 +563,7 @@ test_expect_success 'autosetuprebase local on a tracked local branch' '
 test_expect_success 'autosetuprebase always on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase always &&
+	test_config branch.autosetuprebase always &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase2 &&
 	git branch --track myr2 mybase &&
@@ -577,7 +575,7 @@ test_expect_success 'autosetuprebase always on a tracked local branch' '
 test_expect_success 'autosetuprebase remote on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase3 &&
 	git branch --track myr3 mybase2 &&
@@ -589,7 +587,7 @@ test_expect_success 'autosetuprebase remote on a tracked local branch' '
 test_expect_success 'autosetuprebase never on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase never &&
+	test_config branch.autosetuprebase never &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase4 &&
 	git branch --track myr4 mybase2 &&
@@ -601,7 +599,7 @@ test_expect_success 'autosetuprebase never on a tracked local branch' '
 test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase local &&
+	test_config branch.autosetuprebase local &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr5 local/master &&
 	test "$(git config branch.myr5.remote)" = local &&
@@ -612,7 +610,7 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
 test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase never &&
+	test_config branch.autosetuprebase never &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr6 local/master &&
 	test "$(git config branch.myr6.remote)" = local &&
@@ -623,7 +621,7 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
 test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr7 local/master &&
 	test "$(git config branch.myr7.remote)" = local &&
@@ -634,7 +632,7 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr8 local/master &&
 	test "$(git config branch.myr8.remote)" = local &&
@@ -643,7 +641,7 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
-	git config --unset branch.autosetuprebase &&
+	test_unconfig branch.autosetuprebase &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -685,7 +683,7 @@ test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase never on an untracked local branch' '
-	git config branch.autosetuprebase never &&
+	test_config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -696,7 +694,7 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 '
 
 test_expect_success 'autosetuprebase local on an untracked local branch' '
-	git config branch.autosetuprebase local &&
+	test_config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -707,7 +705,7 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 '
 
 test_expect_success 'autosetuprebase remote on an untracked local branch' '
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -718,7 +716,7 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 '
 
 test_expect_success 'autosetuprebase always on an untracked local branch' '
-	git config branch.autosetuprebase always &&
+	test_config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -729,7 +727,7 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 '
 
 test_expect_success 'autosetuprebase never on an untracked remote branch' '
-	git config branch.autosetuprebase never &&
+	test_config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -740,7 +738,7 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase local on an untracked remote branch' '
-	git config branch.autosetuprebase local &&
+	test_config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -751,7 +749,7 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase remote on an untracked remote branch' '
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -762,7 +760,7 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase always on an untracked remote branch' '
-	git config branch.autosetuprebase always &&
+	test_config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -773,8 +771,8 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
-	git config branch.autosetupmerge always &&
-	test_when_finished git checkout master &&
+	test_when_finished "git checkout -" &&
+	test_config branch.autosetupmerge always &&
 	git checkout HEAD^0 &&
 	git branch my11 &&
 	test -z "$(git config branch.my11.remote)" &&
@@ -782,15 +780,15 @@ test_expect_success 'autosetuprebase always on detached HEAD' '
 '
 
 test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
-	git config branch.autosetuprebase garbage &&
+	test_config branch.autosetuprebase garbage &&
 	test_must_fail git branch
 '
 
 test_expect_success 'detect misconfigured autosetuprebase (no value)' '
-	git config --unset branch.autosetuprebase &&
+	test_when_finished "test_unconfig branch.autosetuprebase" &&
+	test_unconfig branch.autosetuprebase &&
 	echo "[branch] autosetuprebase" >>.git/config &&
-	test_must_fail git branch &&
-	git config --unset branch.autosetuprebase
+	test_must_fail git branch
 '
 
 test_expect_success 'attempt to delete a branch without base and unmerged to HEAD' '
@@ -857,6 +855,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 '
 
 test_expect_success 'refuse --edit-description on unborn branch for now' '
+	test_when_finished "git checkout -" &&
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
-- 
1.8.4.2+fc1
