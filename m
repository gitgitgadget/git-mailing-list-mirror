From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 04/23] Introduce --untracked.
Date: Sat, 23 Apr 2011 17:22:33 +1000
Message-ID: <1303543372-77843-5-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCR-0004jf-9b
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab1DWHYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:05 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab1DWHX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:23:56 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=FEpu+HlZNRpW/l4SFjM+mME9xOn0w4MSNtQo3vLGcUA=;
        b=Qi4h7wnGRWRVjNAm08/f/bLzncJvA6n1UMf9Mhy3DlqeQiF9QjSPQ7ZfVLWklLmBz6
         0lPmBwCU//IQf2g+v7WGFlI2pEHXZPGEMfP7bPdxIf4VRnpy9ZkTKF9Yq1gay4eLMSbu
         EY139TLKKuWE6/GoelUKJ8b9lyV74EO7shWzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f0aTwZZA/6heRCU5lxFM0KjfFlc3dA39cYWyHuUBvkhP12SLKSMR/jnY1rSa7w5FyN
         RFgMiYnXzqe8bjNYa5nBrPgq1JZ3Y7XJdcoY1mntx7Xuqjvd48ZMw+VTPmbVRmMQs+LL
         QEBtLXEjviZslfPHxJhDCuk3+Tmjrv4DHOu3U=
Received: by 10.68.11.196 with SMTP id s4mr2940899pbb.301.1303543436567;
        Sat, 23 Apr 2011 00:23:56 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.23.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:23:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171958>

Add tests for --untracked, --not-untracked.
---
 Documentation/git-test.txt |    3 ++-
 git-conditions-lib.sh      |   11 +++++++++++
 t/t1520-test.sh            |   24 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 9264c90..9f6a4c3 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -68,7 +68,8 @@ CONDITIONS
 	Tests if there are (not) any unstaged changes in the working tree.
 '--staged'|'--not-staged'::
         Tests if there are (not) any staged changes in the index.
-
+'--untracked'|'--not-untracked'::
+	Tests if there are (not) any untracked files in the working tree.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 55b4131..7198e6a 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -30,5 +30,16 @@ check_staged_0()
 	fi
 }
 
+check_untracked_0()
+{
+	if test $(git ls-files -o --exclude-standard | wc -l) -ne 0
+	then
+		echo "There are untracked files."
+	else
+		echo "There are no untracked files."
+		false
+	fi
+}
+
 
 fi
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index 7438f93..ebff63c 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -250,6 +250,30 @@ test_expect_success 'git test --staged # when there are only unstaged files' \
 	git test --not-staged
 '
 
+test_expect_success 'git test --untracked # should fail' \
+'
+	test_must_fail git test --untracked
+'
+
+test_expect_success 'git test --not-untracked' \
+'
+	git test --not-untracked
+'
+
+test_expect_success 'git test --untracked # when there are untracked files' \
+'
+	test_when_finished "git clean -fd" && 
+	:> untracked &&
+	git test --untracked
+'
+
+test_expect_success 'git test --not-untracked # when there are untracked files - should fail' \
+'
+	test_when_finished "git clean -fd" && 
+	:> untracked &&
+	test_must_fail git test --not-untracked
+'
+
 '
     test_when_finished "git reset --hard HEAD && git checkout master" && 
     git test --not-staged --not-unstaged && 
-- 
1.7.5.rc1.23.g7f622
