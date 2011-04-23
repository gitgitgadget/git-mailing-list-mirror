From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 03/23] Introduce --staged
Date: Sat, 23 Apr 2011 17:22:32 +1000
Message-ID: <1303543372-77843-4-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCQ-0004jf-PB
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab1DWHYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:01 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1DWHXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:23:53 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=pqvgcXPqqXSdZg/hqLAXtRlo0Ey3zL68m/KBrLSJlgE=;
        b=H3dpQgv2oBcsUbmKoOdj80EU8gIOLeczefsKlG9ogRfcl8x+TnFKrOL+j9Ez3t1Cm3
         PR2QwzdwRAA2sXW63qJxmVNW35/GhATiWeL0Z9GJVoNyGkhBwbOk8d9mE6/KTHG5eH71
         J/EYphE2KZqR0O1DC1rklqPw5lqMznZ46OvQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vghEufBiBtEk9Cz2/hS58+7JsMMYY1UC5HNpIMExfviV7k3bqgNO9kw+44Qe7LjevM
         xNdQBvlEyoni13fwhb7FdEYNeeyPYPWE0E2DonyTQc3PmJnD+mIMyfNt2P87Var6K56p
         Ye/NZHypVe9gwd1M21t+Zn/LVd/n4uTNFf2n0=
Received: by 10.68.64.193 with SMTP id q1mr2925544pbs.488.1303543433243;
        Sat, 23 Apr 2011 00:23:53 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.23.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:23:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171957>

test_must_fail: --not-staged
---
 Documentation/git-test.txt |    3 ++
 git-conditions-lib.sh      |   11 ++++++++++
 t/t1520-test.sh            |   45 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 4b2c129..9264c90 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -66,6 +66,9 @@ CONDITIONS
 ----------
 '--unstaged'|'--not-unstaged'::
 	Tests if there are (not) any unstaged changes in the working tree.
+'--staged'|'--not-staged'::
+        Tests if there are (not) any staged changes in the index.
+
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index f9ff0b9..55b4131 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -19,5 +19,16 @@ check_unstaged_0()
 	fi
 }
 
+check_staged_0()
+{
+	if test $(git diff-index --cached --name-only HEAD | wc -l) -ne 0
+	then
+		echo "There are staged files."
+	else
+		echo "There are no staged files."
+		false
+	fi
+}
+
 
 fi
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index 8543943..7438f93 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -216,5 +216,50 @@ test_expect_success 'git test --unstaged # when there are only staged files' \
 	git test --not-unstaged
 '
 
+test_expect_success 'git test --staged # should fail' \
 '
+	test_must_fail git test --staged
+'
+
+test_expect_success 'git test --not-staged' \
+'
+	git test --not-staged
+'
+
+test_expect_success 'git test --staged # when there are staged files' \
+'
+	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	git checkout -f M^0 &&
+	git stash apply --index STASH_STAGED &&
+	git test --staged
+'
+
+test_expect_success 'git test --not-staged # when there are staged files - should fail' \
+'
+	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	git checkout -f M^0 &&
+	git stash apply --index STASH_STAGED &&
+	test_must_fail git test --not-staged
+'
+
+test_expect_success 'git test --staged # when there are only unstaged files' \
+'
+	test_when_finished "git reset --hard HEAD && git checkout master" && 
+	git checkout -f M^0 &&
+	git stash apply --index STASH_UNSTAGED &&
+	git test --not-staged
+'
+
+'
+    test_when_finished "git reset --hard HEAD && git checkout master" && 
+    git test --not-staged --not-unstaged && 
+    ! git test --staged && 
+    ! git test --unstaged && 
+    git checkout M^0 &&
+    git stash apply --index STASH_STAGED &&
+    git test --not-unstaged --staged &&
+    ! git test --unstaged &&
+    ! git test --not-staged 
+'
+
 test_done
-- 
1.7.5.rc1.23.g7f622
