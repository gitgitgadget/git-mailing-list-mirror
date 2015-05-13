From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Wed, 13 May 2015 17:08:48 +0800
Message-ID: <1431508136-15313-2-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:09:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfU-0003FQ-NP
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbbEMJJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:27 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33027 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbbEMJJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:25 -0400
Received: by pacwv17 with SMTP id wv17so44613037pac.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SW5DlN25fyUzfvjBS5I+prWYMwg+Qmw+h96x9odY/6Q=;
        b=pMQnbgYB/Q9vsqKHdUUZQB69t6+cvVM6NnbeubAcjJRh4P2U41bd/xA8Gogoz7zUk2
         yRR9PrfIZS9eSqugaHFyMAwXZQR0DMOOL8hZqniANyMRy5EHH0oRz5/LTo2Hz4AjUfsE
         /S4Aym5IgtIHlZSI/Mrr+9LbWaIETWw9GOekdP6dLjTkbqRRlqiO2qZH3JnWaX0xGSKr
         BZWtoLZIk+UL4gtwTqwolQuS8PEDyY6q1pK2yG1eugZyNrkuxu8DR2SfrqXeLtllAb6n
         3GKgh+2Iu30kyHvEfg09sxXowc70xrlPxOYn+nqUl7r7cEN4dZ1OQHqxDVrUlJgpionT
         a7+w==
X-Received: by 10.70.55.199 with SMTP id u7mr35709913pdp.42.1431508164789;
        Wed, 13 May 2015 02:09:24 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268951>

Many tests in t5520 used the following to test the contents of files:

	test `cat file` = expected

or

	test $(cat file) = expected

These 2 forms, however, will be affected by field splitting and,
depending on the value of $IFS, may be split into multiple arguments,
making the test fail in mysterious ways.

Replace the above 2 forms with:

	verbose test "$(cat file)" = expected

as quoting the command substitution will prevent field splitting, and
the verbose function will print the failed test command on failure for
easier debugging.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
* This is a new patch

 t/t5520-pull.sh | 84 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7efd45b..20ad373 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -81,7 +81,7 @@ test_expect_success 'pulling into void must not create an octopus' '
 	(
 		cd cloned-octopus &&
 		test_must_fail git pull .. master master &&
-		! test -f file
+		verbose test ! -f file
 	)
 '
 
@@ -93,9 +93,9 @@ test_expect_success 'test . as a remote' '
 	echo updated >file &&
 	git commit -a -m updated &&
 	git checkout copy &&
-	test `cat file` = file &&
+	verbose test "$(cat file)" = file &&
 	git pull &&
-	test `cat file` = updated
+	verbose test "$(cat file)" = updated
 '
 
 test_expect_success 'the default remote . should not break explicit pull' '
@@ -104,9 +104,9 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git commit -a -m modified &&
 	git checkout copy &&
 	git reset --hard HEAD^ &&
-	test `cat file` = file &&
+	verbose test "$(cat file)" = file &&
 	git pull . second &&
-	test `cat file` = modified
+	verbose test "$(cat file)" = modified
 '
 
 test_expect_success '--rebase' '
@@ -119,23 +119,23 @@ test_expect_success '--rebase' '
 	git commit -m "new file" &&
 	git tag before-rebase &&
 	git pull --rebase . copy &&
-	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
-	test new = $(git show HEAD:file2)
+	verbose test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	verbose test new = "$(git show HEAD:file2)"
 '
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
-	test new = $(git show HEAD:file2)
+	verbose test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	verbose test new = "$(git show HEAD:file2)"
 '
 
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
-	test new = $(git show HEAD:file2)
+	verbose test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	verbose test new = "$(git show HEAD:file2)"
 '
 
 test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
@@ -143,8 +143,8 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test_config pull.rebase true &&
 	test_config branch.to-rebase.rebase false &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^) != $(git rev-parse copy) &&
-	test new = $(git show HEAD:file2)
+	verbose test "$(git rev-parse HEAD^)" != "$(git rev-parse copy)" &&
+	verbose test new = "$(git show HEAD:file2)"
 '
 
 # add a feature branch, keep-merge, that is merged into master, so the
@@ -163,33 +163,33 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase false &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
-	test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	verbose test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
+	verbose test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
+	verbose test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success 'pull.rebase=true flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	verbose test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	verbose test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase 1 &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	verbose test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	verbose test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+	verbose test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	verbose test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
 test_expect_success 'pull.rebase=invalid fails' '
@@ -202,25 +202,25 @@ test_expect_success '--rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=false . copy &&
-	test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
-	test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	verbose test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
+	verbose test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
+	verbose test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase=true . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	verbose test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	verbose test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success '--rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=preserve . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
+	verbose test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	verbose test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
 test_expect_success '--rebase=invalid fails' '
@@ -232,8 +232,8 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
+	verbose test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	verbose test file3 = "$(git show HEAD:file3.t)"
 '
 
 test_expect_success '--rebase with rebased upstream' '
@@ -249,8 +249,8 @@ test_expect_success '--rebase with rebased upstream' '
 	git commit -m to-rebase file2 &&
 	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = $(cat file2)
+	verbose test "conflicting modification" = "$(cat file)" &&
+	verbose test file = "$(cat file2)"
 
 '
 
@@ -260,8 +260,8 @@ test_expect_success '--rebase with rebased default upstream' '
 	git checkout --track -b to-rebase2 me/copy &&
 	git reset --hard to-rebase-orig &&
 	git pull --rebase &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = $(cat file2)
+	verbose test "conflicting modification" = "$(cat file)" &&
+	verbose test file = "$(cat file2)"
 
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
+	verbose test "$COPY" = "$(git rev-parse --verify me/copy)" &&
 	git checkout HEAD -- file &&
 	git pull &&
-	test $COPY != $(git rev-parse --verify me/copy)
+	verbose test "$COPY" != "$(git rev-parse --verify me/copy)"
 
 '
 
@@ -332,7 +332,7 @@ test_expect_success 'setup for detecting upstreamed changes' '
 test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(cd dst &&
 	 git pull --rebase &&
-	 test -z "$(git ls-files -u)"
+	 verbose test -z "$(git ls-files -u)"
 	)
 '
 
@@ -361,15 +361,15 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 test_must_fail git pull --rebase &&
-	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+	 verbose test 1 = "$(find .git/rebase-apply -name "000*" | wc -l)"
 	)
 '
 
 test_expect_success 'git pull --rebase against local branch' '
 	git checkout -b copy2 to-rebase-orig &&
 	git pull --rebase . to-rebase &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = "$(cat file2)"
+	verbose test "conflicting modification" = "$(cat file)" &&
+	verbose test file = "$(cat file2)"
 '
 
 test_done
-- 
2.1.4
