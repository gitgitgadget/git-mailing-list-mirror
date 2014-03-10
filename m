From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 6/7] merge hook tests: fix and update tests
Date: Mon, 10 Mar 2014 19:49:36 +0100
Message-ID: <1394477377-10994-7-git-send-email-benoit.pierre@gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:50:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5HE-0005To-MG
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbaCJSuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:50:01 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:61127 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbaCJSt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:49:59 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so9081276wes.16
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9KKJ7kMhaimuJ6XbGEFJ7fPafimiqurAHuur8QuJMzM=;
        b=qZBJpV5NqYt5Ifv4gsmBOew56dOHoawfV2YRQ081k+Bu5ojtG6NfbiVhG4iRv07nMl
         eBev1vHf+wGlFr/yzGBqaa+dJk1MQh69BafKPetYjL/HeDIo3mxYERxh0B+FG71Ntgh6
         E+RrxRAfu1uPbrd58EMpwu9Hm6f9zK1YKEgtAqAp4eZVWuAIhKBKAzHurhS92QOBXxpV
         +s8byGEAnCE0RqzFGbnfXyeme6xhi4tADbJ7K5ubYd2Mk6ibjk4yOISs9S4NQtunIkTg
         7I6tW/CnjVTT9CXewA7f1j3owa4BM3YokH8KUrU+vVMwa7ROXj4QNiZ+zujbVlkwV9O0
         whng==
X-Received: by 10.194.174.197 with SMTP id bu5mr2970359wjc.71.1394477398245;
        Mon, 10 Mar 2014 11:49:58 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id bm8sm54382789wjc.12.2014.03.10.11.49.57
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 11:49:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.7.gca5104e.dirty
In-Reply-To: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243790>

- update 'no editor' hook test and add 'editor' hook test
- make sure the tree is reset to a clean state after running a test
  (using test_when_finished) so later tests are not impacted

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7505-prepare-commit-msg-hook.sh | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 5531abb..03dce09 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -134,14 +134,26 @@ test_expect_success 'with hook (-c)' '
 
 test_expect_success 'with hook (merge)' '
 
-	head=`git rev-parse HEAD` &&
-	git checkout -b other HEAD@{1} &&
-	echo "more" >> file &&
+	test_when_finished "git checkout -f master" &&
+	git checkout -B other HEAD@{1} &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m other &&
+	git checkout - &&
+	git merge --no-ff other &&
+	test "`git log -1 --pretty=format:%s`" = "merge (no editor)"
+'
+
+test_expect_success 'with hook and editor (merge)' '
+
+	test_when_finished "git checkout -f master" &&
+	git checkout -B other HEAD@{1} &&
+	echo "more" >>file &&
 	git add file &&
 	git commit -m other &&
 	git checkout - &&
-	git merge other &&
-	test "`git log -1 --pretty=format:%s`" = merge
+	env GIT_EDITOR="\"\$FAKE_EDITOR\"" git merge --no-ff -e other &&
+	test "`git log -1 --pretty=format:%s`" = "merge"
 '
 
 cat > "$HOOK" <<'EOF'
@@ -151,6 +163,7 @@ EOF
 
 test_expect_success 'with failing hook' '
 
+	test_when_finished "git checkout -f master" &&
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
@@ -160,6 +173,7 @@ test_expect_success 'with failing hook' '
 
 test_expect_success 'with failing hook (--no-verify)' '
 
+	test_when_finished "git checkout -f master" &&
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
@@ -169,6 +183,7 @@ test_expect_success 'with failing hook (--no-verify)' '
 
 test_expect_success 'with failing hook (merge)' '
 
+	test_when_finished "git checkout -f master" &&
 	git checkout -B other HEAD@{1} &&
 	echo "more" >> file &&
 	git add file &&
@@ -178,7 +193,7 @@ test_expect_success 'with failing hook (merge)' '
 	exit 1
 	EOF
 	git checkout - &&
-	test_must_fail git merge other
+	test_must_fail git merge --no-ff other
 
 '
 
-- 
1.9.0
