From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] t: branch: improve test rollback
Date: Fri, 30 Aug 2013 23:31:51 -0500
Message-ID: <1377923511-20787-5-git-send-email-felipe.contreras@gmail.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 06:36:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFcvZ-00066U-Qb
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 06:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab3HaEgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 00:36:47 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:65265 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425Ab3HaEgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 00:36:46 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so2665243obc.13
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 21:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8rleVI1ZNLNX8iJAuop+T6eWt+DL/OPBK+HNxvRq6Q=;
        b=ofp1jnD4BgCcXV/Y6pLk9kiabKjOlKHcfhoSrPkbc7G/mlMVZqKczivmfnQsbC8WQD
         1rlRxswayjJxq8EAmwRRArS1eEduVJv5mX7SPyUqdd4FtIYpOq+An13cFE/Q0ZycOUw5
         DtLpg3KGoA7dIulQaKF6r4pdedxy5uNTHyHXEAQ//Qda77QrNJp2ErfkB0+wUbBfT288
         XguAmlyatJ3mPOAtqisSvohGf4wH+23Ct8YIUBA+f1xcSzcF6Dkw3jvbeHMOYYVYAWiz
         lxRNAWH82ZXxCB/LLyUFKkoAHCoCnxb+3IFYgVy0TPsyaPBSIXuvO4cMaYuIN/Za//0e
         3ASw==
X-Received: by 10.60.83.46 with SMTP id n14mr8049836oey.34.1377923805813;
        Fri, 30 Aug 2013 21:36:45 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm1809343oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 21:36:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233502>

After every test the environment should be as close as to how it was
before as possible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3200-branch.sh | 71 +++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d85306f..3d4f634 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -328,7 +328,7 @@ test_expect_success 'tracking setup fails on non-matching refspec' '
 '
 
 test_expect_success 'test tracking setup via config' '
-	git config branch.autosetupmerge true &&
+	test_config branch.autosetupmerge true &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -338,20 +338,18 @@ test_expect_success 'test tracking setup via config' '
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
@@ -386,9 +384,8 @@ test_expect_success 'test --track without .fetch entries' '
 '
 
 test_expect_success 'branch from non-branch HEAD w/autosetupmerge=always' '
-	git config branch.autosetupmerge always &&
-	git branch my9 HEAD^ &&
-	git config branch.autosetupmerge false
+	test_config branch.autosetupmerge always &&
+	git branch my9 HEAD^
 '
 
 test_expect_success 'branch from non-branch HEAD w/--track causes failure' '
@@ -405,9 +402,9 @@ test_expect_success '--set-upstream-to fails on multiple branches' '
 '
 
 test_expect_success '--set-upstream-to fails on detached HEAD' '
+	test_when_finished "git checkout -" &&
 	git checkout HEAD^{} &&
-	test_must_fail git branch --set-upstream-to master &&
-	git checkout -
+	test_must_fail git branch --set-upstream-to master
 '
 
 test_expect_success '--set-upstream-to fails on a missing dst branch' '
@@ -459,9 +456,9 @@ test_expect_success '--unset-upstream should fail on multiple branches' '
 '
 
 test_expect_success '--unset-upstream should fail on detached HEAD' '
+	test_when_finished "git checkout -" &&
 	git checkout HEAD^{} &&
-	test_must_fail git branch --unset-upstream &&
-	git checkout -
+	test_must_fail git branch --unset-upstream
 '
 
 test_expect_success 'test --unset-upstream on a particular branch' '
@@ -540,7 +537,8 @@ test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates
 '
 
 test_expect_success 'avoid ambiguous track' '
-	git config branch.autosetupmerge true &&
+	test_when_finished "git remote rm ambi1 && git remote rm ambi2" &&
+	test_config branch.autosetupmerge true &&
 	git config remote.ambi1.url lalala &&
 	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
 	git config remote.ambi2.url lilili &&
@@ -552,7 +550,7 @@ test_expect_success 'avoid ambiguous track' '
 test_expect_success 'autosetuprebase local on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase local &&
+	test_config branch.autosetuprebase local &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase &&
 	git branch --track myr1 mybase &&
@@ -564,7 +562,7 @@ test_expect_success 'autosetuprebase local on a tracked local branch' '
 test_expect_success 'autosetuprebase always on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase always &&
+	test_config branch.autosetuprebase always &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase2 &&
 	git branch --track myr2 mybase &&
@@ -576,7 +574,7 @@ test_expect_success 'autosetuprebase always on a tracked local branch' '
 test_expect_success 'autosetuprebase remote on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase3 &&
 	git branch --track myr3 mybase2 &&
@@ -588,7 +586,7 @@ test_expect_success 'autosetuprebase remote on a tracked local branch' '
 test_expect_success 'autosetuprebase never on a tracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase never &&
+	test_config branch.autosetuprebase never &&
 	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase4 &&
 	git branch --track myr4 mybase2 &&
@@ -600,7 +598,7 @@ test_expect_success 'autosetuprebase never on a tracked local branch' '
 test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase local &&
+	test_config branch.autosetuprebase local &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr5 local/master &&
 	test "$(git config branch.myr5.remote)" = local &&
@@ -611,7 +609,7 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
 test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase never &&
+	test_config branch.autosetuprebase never &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr6 local/master &&
 	test "$(git config branch.myr6.remote)" = local &&
@@ -622,7 +620,7 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
 test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr7 local/master &&
 	test "$(git config branch.myr7.remote)" = local &&
@@ -633,7 +631,7 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr8 local/master &&
 	test "$(git config branch.myr8.remote)" = local &&
@@ -642,7 +640,7 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
-	git config --unset branch.autosetuprebase &&
+	test_unconfig branch.autosetuprebase &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -684,7 +682,7 @@ test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase never on an untracked local branch' '
-	git config branch.autosetuprebase never &&
+	test_config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -695,7 +693,7 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 '
 
 test_expect_success 'autosetuprebase local on an untracked local branch' '
-	git config branch.autosetuprebase local &&
+	test_config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -706,7 +704,7 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 '
 
 test_expect_success 'autosetuprebase remote on an untracked local branch' '
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -717,7 +715,7 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 '
 
 test_expect_success 'autosetuprebase always on an untracked local branch' '
-	git config branch.autosetuprebase always &&
+	test_config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -728,7 +726,7 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 '
 
 test_expect_success 'autosetuprebase never on an untracked remote branch' '
-	git config branch.autosetuprebase never &&
+	test_config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -739,7 +737,7 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase local on an untracked remote branch' '
-	git config branch.autosetuprebase local &&
+	test_config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -750,7 +748,7 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase remote on an untracked remote branch' '
-	git config branch.autosetuprebase remote &&
+	test_config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -761,7 +759,7 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase always on an untracked remote branch' '
-	git config branch.autosetuprebase always &&
+	test_config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
@@ -772,8 +770,8 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
-	git config branch.autosetupmerge always &&
-	test_when_finished git checkout master &&
+	test_when_finished "git checkout -" &&
+	test_config branch.autosetupmerge always &&
 	git checkout HEAD^0 &&
 	git branch my11 &&
 	test -z "$(git config branch.my11.remote)" &&
@@ -781,15 +779,15 @@ test_expect_success 'autosetuprebase always on detached HEAD' '
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
@@ -856,6 +854,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 '
 
 test_expect_success 'refuse --edit-description on unborn branch for now' '
+	test_when_finished "git checkout -" &&
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
-- 
1.8.4-fc
