From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 4/6] merge hook tests: fix and update tests
Date: Thu,  6 Mar 2014 15:50:22 +0100
Message-ID: <1394117424-29780-5-git-send-email-benoit.pierre@gmail.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 15:50:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLZdG-00058Z-3F
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 15:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbaCFOun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 09:50:43 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33506 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaCFOul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 09:50:41 -0500
Received: by mail-wg0-f46.google.com with SMTP id z12so3275548wgg.29
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=tFmCmghU+rAHmW1xlxAZuV75KX7EgB64SwU7vGEdh3Q=;
        b=AQxIe/b/fJenoook2e9nG6IwOH3k58FK6w+cC2EUvi13bJ1Xf3nsfB3pTXl+t5fgz3
         jscl2DXPLHxKYaEwEKDuBmVgHC7rZyGhIasIlyB3LeAESqzA3nurGWIEr/ULJadePZ0e
         HVylFcu0dUoo73iIIGq/AHu5ajs3f1jZ+RMVcKMPjQUD9RcFOTih7WHtkas3VJd3jW0m
         0L0ACpwUqp6+dj2LRG7k22HtxF+lGQxvs/AuzbBvW8j5tXs78aht67hVVhjlHdMnF6Ih
         45Ka8+Qi9SCIDBIu6YCokJDSqtoZPUowXWfJHCAYZ9SW8maKJ/qJB0O+l2q2YV+W9/PK
         bk/Q==
X-Received: by 10.194.202.230 with SMTP id kl6mr10941691wjc.9.1394117440895;
        Thu, 06 Mar 2014 06:50:40 -0800 (PST)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id br10sm17969738wjb.3.2014.03.06.06.50.39
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2014 06:50:40 -0800 (PST)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243514>

- update 'no editor' hook test and add 'editor' hook test
- reset tree at the beginning of failing hook tests to avoid failures
  due to an unclean tree after running a previous test

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7505-prepare-commit-msg-hook.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 3573751..ae7b2db 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -141,7 +141,19 @@ test_expect_success 'with hook (merge)' '
 	git commit -m other &&
 	git checkout - &&
 	git merge other &&
-	test "`git log -1 --pretty=format:%s`" = merge
+	test "`git log -1 --pretty=format:%s`" = "merge (no editor)"
+'
+
+test_expect_success 'with hook and editor (merge)' '
+
+	head=`git rev-parse HEAD` &&
+	git checkout -B other HEAD@{1} &&
+	echo "more" >> file &&
+	git add file &&
+	git commit -m other &&
+	git checkout - &&
+	env GIT_EDITOR="\"\$FAKE_EDITOR\"" git merge -e other &&
+	test "`git log -1 --pretty=format:%s`" = "merge"
 '
 
 cat > "$HOOK" <<'EOF'
@@ -151,6 +163,7 @@ EOF
 
 test_expect_success 'with failing hook' '
 
+	git reset --hard &&
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
@@ -160,6 +173,7 @@ test_expect_success 'with failing hook' '
 
 test_expect_success 'with failing hook (--no-verify)' '
 
+	git reset --hard &&
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
@@ -169,6 +183,7 @@ test_expect_success 'with failing hook (--no-verify)' '
 
 test_expect_success 'with failing hook (merge)' '
 
+	git reset --hard &&
 	git checkout -B other HEAD@{1} &&
 	echo "more" >> file &&
 	git add file &&
-- 
1.9.0
