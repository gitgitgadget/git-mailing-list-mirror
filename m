From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 1/8] t5520: prevent field splitting in content comparisons
Date: Mon, 18 May 2015 21:32:51 +0800
Message-ID: <1431955978-17890-2-git-send-email-pyokagan@gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLAd-0000yh-Jt
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbbERNdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:33:20 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34623 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbbERNdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:33:16 -0400
Received: by pabru16 with SMTP id ru16so152703682pab.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3o90tWBwqX6qGs3t8yrTmmt6gbxOufw670z3lMPjoF0=;
        b=tovxjmtd1d/i4nF9R7nxLuwTY2FUOWg/VEJdHuI0YL+y7GS8GNTIMCv0P7+C0/6mF2
         vizLMQiKZcpAOlI8lQOPjUos3u0EZdxHtqlRZNv7rfe4X4McIgOuzIvfuReipQexglfy
         pwOCfoW5juw3m+NYWuuGQhyvQcoIQDltKQs+TD7aO4SW0Q3WXhW17E3g2OX68/UJ8ukJ
         XGOTEFEuWDPbHdtM1bRPrsDSnn0++7W0DB0I3Uy5dUk74aB+qNnDfuWezKnvpcONgvXh
         53qSLxBkXb9MlG9V5tvh3ikbLeP5TaTz9aedAe1xjgHoqexfsyajqJcTDPrKSikOUew8
         fnaQ==
X-Received: by 10.68.226.4 with SMTP id ro4mr44776624pbc.108.1431955996004;
        Mon, 18 May 2015 06:33:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id da2sm10119540pbb.57.2015.05.18.06.33.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:33:14 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269237>

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
* Removed use of "verbose"

* The use of "wc -l" is not quoted, as the output of "wc -l" on a Mac contains
  leading whitespace. See [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/268950/focus=269052

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
