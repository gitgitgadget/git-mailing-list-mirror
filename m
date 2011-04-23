From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 07/23] Introduce --detached
Date: Sat, 23 Apr 2011 17:22:36 +1000
Message-ID: <1303543372-77843-8-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCg-0004tb-92
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab1DWHY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:28 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab1DWHYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:05 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=wIqT2f6BXt0wYyghgCyNmbn74FgXKBawYn7RxyxeDR0=;
        b=TeyPiV4V/4DHS15oGdXkNhA3ZhVEKL1MMf9SbXdbucg8unLhoiL2EdLj6s1QBkSGxH
         EkW2Xx+XY+yuePic/NFRnFzz7Vv4kZFSWQ3veSARkG26T+NTgqTpoX5f+CjFeNtYI9dP
         StrcAfFPs3CUupApni1etkThrQFBEaCH0ukJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=btRoo1EpGt1+K1V5kxOUrPhoZXcaVJegDht4jeu0YvcTbqli8vdoMLDXEZuidyufDE
         RBY7Eyiw0x111OV1Xwv7hCuQr1M1INeRLICkLbFLL1IiZWdsLfjy3Db0zGkHv2O/zruV
         Bgf/5T7HDjz+lIat3A7V4cXlkz5b3pCe79ArQ=
Received: by 10.68.15.161 with SMTP id y1mr38911pbc.240.1303543445646;
        Sat, 23 Apr 2011 00:24:05 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171963>

detached
---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   11 +++++++++++
 t/t1520-test.sh            |   30 +++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index e872608..501725c 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -74,6 +74,8 @@ CONDITIONS
 	Tests if there are (not) any merge conflicts in the index.
 '--rebasing'|'--not-rebasing'::
         Tests if a rebase is (not) in progress.
+'--detached'|'--not-detached'::
+	Tests if the head is (not) detached.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 0d6e0a1..34de896 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -64,5 +64,16 @@ check_rebasing_0()
 	fi
 }
 
+check_detached_0()
+{
+	if ! git symbolic-ref -q HEAD >/dev/null
+	then
+		echo "HEAD is detached."
+	else
+		echo "HEAD is not detached."
+		false
+	fi
+}
+
 
 fi
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index ebff63c..bb39050 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -274,16 +274,28 @@ test_expect_success 'git test --not-untracked # when there are untracked files -
 	test_must_fail git test --not-untracked
 '
 
+test_expect_success 'git test --not-detached' \
 '
-    test_when_finished "git reset --hard HEAD && git checkout master" && 
-    git test --not-staged --not-unstaged && 
-    ! git test --staged && 
-    ! git test --unstaged && 
-    git checkout M^0 &&
-    git stash apply --index STASH_STAGED &&
-    git test --not-unstaged --staged &&
-    ! git test --unstaged &&
-    ! git test --not-staged 
+	git test --not-detached
+'
+
+test_expect_success 'git test --detached # should fail' \
+'
+	test_must_fail git test --detached
+'
+
+test_expect_success 'git test --not-detached # when detached, should fail' \
+'
+	test_when_finished "git checkout -f master" && 
+	git checkout HEAD^0 &&
+	test_must_fail git test --not-detached
+'
+
+test_expect_success 'git test --detached # when detached' \
+'
+	test_when_finished "git checkout -f master" && 
+	git checkout HEAD^0 &&
+	git test --detached
 '
 
 test_done
-- 
1.7.5.rc1.23.g7f622
