From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 1/8] t5520: prevent field splitting in content comparisons
Date: Fri, 29 May 2015 19:44:38 +0800
Message-ID: <1432899885-25143-2-git-send-email-pyokagan@gmail.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIin-0003qw-PG
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbbE2LpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:45:00 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33653 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbbE2Lo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:44:57 -0400
Received: by padbw4 with SMTP id bw4so55980569pad.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BVzvFulqTEEg/mzjr5FEUR5z5b6F3styF/1OIHLP8x0=;
        b=k4+3T3iMbVukoSn/Rv54fDCz4vP/Q5bh7H0vhecu5poduitKDk94aVbLOLn6AxDfjV
         r27X+ijtdMPMd0g8VF/iFux9nMy2OMY4Q64Et76uu8KyG1F33+dSZhhbfvoaRx8EpmHy
         XoYoMvdKSqOwgNFpJyYl92w60Nf16KuYqbCmhfvEqBqWETi/gHkoMEjiVYksSo/AgRvK
         yrE11PPZcVKXRzIZJVcQgj/wxHD4tK2chItA72O14PC1tKjCszsjhk5gp1gA/yX3+m4T
         Q4zMmRahVS4+b4M/k27k3nKW9oabnrqkOmzkkughnxyKeg7S5x1Lccm/Lue9Ww63tag2
         ODDQ==
X-Received: by 10.66.184.133 with SMTP id eu5mr13937178pac.75.1432899896857;
        Fri, 29 May 2015 04:44:56 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.44.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:44:55 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270229>

Many tests in t5520 used the following to test the contents of files:

	test `cat file` = expected

or

	test $(cat file) = expected

These 2 forms, however, will be affected by field splitting and,
depending on the value of $IFS, may be split into multiple arguments,
making the test fail in mysterious ways.

Replace the above 2 forms with:

	test "$(cat file)" = expected

as quoting the command substitution will prevent field splitting.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t5520-pull.sh | 70 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7efd45b..5e4db67 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -93,9 +93,9 @@ test_expect_success 'test . as a remote' '
 	echo updated >file &&
 	git commit -a -m updated &&
 	git checkout copy &&
-	test `cat file` = file &&
+	test "$(cat file)" = file &&
 	git pull &&
-	test `cat file` = updated
+	test "$(cat file)" = updated
 '
 
 test_expect_success 'the default remote . should not break explicit pull' '
@@ -104,9 +104,9 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git commit -a -m modified &&
 	git checkout copy &&
 	git reset --hard HEAD^ &&
-	test `cat file` = file &&
+	test "$(cat file)" = file &&
 	git pull . second &&
-	test `cat file` = modified
+	test "$(cat file)" = modified
 '
 
 test_expect_success '--rebase' '
@@ -119,23 +119,23 @@ test_expect_success '--rebase' '
 	git commit -m "new file" &&
 	git tag before-rebase &&
 	git pull --rebase . copy &&
-	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
-	test new = $(git show HEAD:file2)
+	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test new = "$(git show HEAD:file2)"
 '
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
-	test new = $(git show HEAD:file2)
+	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test new = "$(git show HEAD:file2)"
 '
 
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
-	test new = $(git show HEAD:file2)
+	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test new = "$(git show HEAD:file2)"
 '
 
 test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
@@ -143,8 +143,8 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test_config pull.rebase true &&
 	test_config branch.to-rebase.rebase false &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^) != $(git rev-parse copy) &&
-	test new = $(git show HEAD:file2)
+	test "$(git rev-parse HEAD^)" != "$(git rev-parse copy)" &&
+	test new = "$(git show HEAD:file2)"
 '
 
 # add a feature branch, keep-merge, that is merged into master, so the
@@ -163,33 +163,33 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase false &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
-	test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
+	test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success 'pull.rebase=true flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase 1 &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
 test_expect_success 'pull.rebase=invalid fails' '
@@ -202,25 +202,25 @@ test_expect_success '--rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=false . copy &&
-	test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
-	test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
+	test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase=true . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success '--rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=preserve . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
 test_expect_success '--rebase=invalid fails' '
@@ -232,8 +232,8 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success '--rebase with rebased upstream' '
@@ -250,7 +250,7 @@ test_expect_success '--rebase with rebased upstream' '
 	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
 	test "conflicting modification" = "$(cat file)" &&
-	test file = $(cat file2)
+	test file = "$(cat file2)"
 
 '
 
@@ -261,7 +261,7 @@ test_expect_success '--rebase with rebased default upstream' '
 	git reset --hard to-rebase-orig &&
 	git pull --rebase &&
 	test "conflicting modification" = "$(cat file)" &&
-	test file = $(cat file2)
+	test file = "$(cat file2)"
 
 '
 
@@ -282,7 +282,7 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 
 	git checkout to-rebase &&
 	git update-ref refs/remotes/me/copy copy^ &&
-	COPY=$(git rev-parse --verify me/copy) &&
+	COPY="$(git rev-parse --verify me/copy)" &&
 	git rebase --onto $COPY copy &&
 	test_config branch.to-rebase.remote me &&
 	test_config branch.to-rebase.merge refs/heads/copy &&
@@ -290,10 +290,10 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	echo dirty >> file &&
 	git add file &&
 	test_must_fail git pull &&
-	test $COPY = $(git rev-parse --verify me/copy) &&
+	test "$COPY" = "$(git rev-parse --verify me/copy)" &&
 	git checkout HEAD -- file &&
 	git pull &&
-	test $COPY != $(git rev-parse --verify me/copy)
+	test "$COPY" != "$(git rev-parse --verify me/copy)"
 
 '
 
-- 
2.1.4
