From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 6/7] merge hook tests: fix and update tests
Date: Sat, 15 Mar 2014 22:42:29 +0100
Message-ID: <1394919750-28432-6-git-send-email-benoit.pierre@gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
 <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 22:43:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOwMS-0002ET-W0
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbaCOVnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:43:16 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:59337 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaCOVnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 17:43:15 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so811573wiw.6
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9KKJ7kMhaimuJ6XbGEFJ7fPafimiqurAHuur8QuJMzM=;
        b=jDkUE0WSoN/rhVTdaLATa4K6n2dKBnloHiX02tMobkyFmi1rFJG3PdEz7jkJ6YXAxk
         gFJzJPv5baYp8PySi4By0pgNnNQB4QumhM2peWFHsgd/4mugdkLwtMJM1Jza8+4tL6Yw
         Ls7paL/auYKZstXif4Ek6JOGEt5vY6V2VVS6hSfTw8oN6NeLsi5lWMUr/mGClZAXXA1J
         Os8aZPR1pGLH/4exZigjTwLT//My8sAIbkE0ZAJASEN3TcUUGg4FWWwSmFBKTHQcsldl
         edvZ5itFlYzKKkVnV9jOlwsM9E0zlVSYPfxyt+grDFQGWLwKYD8Wue/cl/YUtbJcBD+g
         S/3A==
X-Received: by 10.180.164.107 with SMTP id yp11mr3523828wib.37.1394919794458;
        Sat, 15 Mar 2014 14:43:14 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id fq16sm24370076wjc.3.2014.03.15.14.43.11
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2014 14:43:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244174>

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
