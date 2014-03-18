From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 6/7] merge hook tests: fix and update tests
Date: Tue, 18 Mar 2014 11:00:55 +0100
Message-ID: <1395136856-17225-6-git-send-email-benoit.pierre@gmail.com>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
 <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 11:01:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPqq5-0003wX-DI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 11:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbaCRKBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 06:01:34 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:53815 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaCRKBd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 06:01:33 -0400
Received: by mail-wg0-f49.google.com with SMTP id a1so5605722wgh.8
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9KKJ7kMhaimuJ6XbGEFJ7fPafimiqurAHuur8QuJMzM=;
        b=tvruhytk4lN6ZTOv9805H/XrUQ3LtaHH4B+mH4K8KE6GX87GLAENK/45XZ3suBwnAn
         tGgljp8TrDsY/0o22XG4O0NL42l5oMTav14wbL7zY9z+Z3tu6Gf4P2UyuEQb//soPLke
         uaMDlZp7NgFwURR4ZLtQWk4u7S7zjVdPBIp63vfzd973kYs90mylakzp/KBqn0P1dU8p
         wi8q7+9DdYW2gMbdunw4xAfdcSZBdMgqXBr5nOmI59NQwDL38szgU0TS2NrDyXvL6X0b
         8DrnCRueFs2lr0eneyHaMY3F00t9Jzy91h/Fvp59IyE0uAyplSXgkMXnl+YQ8+t+LYZ7
         uZxw==
X-Received: by 10.180.108.199 with SMTP id hm7mr13819961wib.1.1395136892214;
        Tue, 18 Mar 2014 03:01:32 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id c7sm1577584wjf.19.2014.03.18.03.01.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Mar 2014 03:01:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244345>

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
