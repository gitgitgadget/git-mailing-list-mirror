From: Johan Herland <johan@herland.net>
Subject: [RFD/PATCH 2/5] t2024: Show failure to use refspec when DWIMming remote branch names
Date: Fri, 19 Apr 2013 08:20:39 +0200
Message-ID: <1366352442-501-3-git-send-email-johan@herland.net>
References: <1366352442-501-1-git-send-email-johan@herland.net>
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 08:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4hd-0002hP-UE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 08:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab3DSGVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 02:21:42 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:49594 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664Ab3DSGVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 02:21:41 -0400
Received: by mail-lb0-f170.google.com with SMTP id 13so259272lba.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 23:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jja2K8ihKI01n8Z67MAYgfPy2e0Mj6JJhXt0s7bZenI=;
        b=cxRodbAju1FtMUAAMdT5hH6dXCWnXpBBtDogbCW7zFayoZA0PwWEWSPcxZnwZ5tSOM
         tVeTbHoR8JwsXV0hwT9Z+fRa+FBXUhZqpn1tKG7aFJpBfDvrY50WHpD1iSZ9LuRytsqj
         hroioUy6WBeGzQ7s5D4FeIxiqQjKoorxOtEYu94ga/Xk5KuigBamgsRexzBBttaQ0Awe
         LrG3tbvQiXk3tjM2Sa/rJwKfBnkP1ZTeANC6aykEQCaaTiI+RVOBsQmYYVk1Lc+y2PD4
         lglgNeMfCneUaSv3AHRoYXys/F2kl6vjXSSsxY7769xYHkyFeBpY7OAGkcig5ooDIKUm
         m8IQ==
X-Received: by 10.112.201.138 with SMTP id ka10mr7285186lbc.134.1366352500345;
        Thu, 18 Apr 2013 23:21:40 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id f4sm2076904lbw.6.2013.04.18.23.21.38
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 23:21:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366352442-501-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221744>

When using "git checkout foo" to DWIM the creation of local "foo" from some
existing upstream "foo", we assume conventional refspecs as created by "git
clone" or "git remote add", and fail to work correctly if the current
refspecs do not follow the conventional "refs/remotes/$remote/*" pattern.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t2024-checkout-dwim.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 5650d21..36bf52f 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -22,6 +22,7 @@ test_tracking_branch() {
 }
 
 test_expect_success 'setup' '
+	test_commit my_master &&
 	(git init repo_a &&
 	 cd repo_a &&
 	 test_commit a_master &&
@@ -49,7 +50,7 @@ test_expect_success 'checkout of non-existing branch fails' '
 	test_must_fail git checkout xyzzy
 '
 
-test_expect_success 'checkout of branch from multiple remotes fails' '
+test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_must_fail git checkout foo
 '
 
@@ -63,4 +64,53 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 	test_tracking_branch baz repo_b refs/remotes/other_b/baz
 '
 
+test_expect_success 'setup more remotes with unconventional refspecs' '
+	git checkout master &&
+	git branch -D bar &&
+	git branch -D baz &&
+	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify my_master)" &&
+	(git init repo_c &&
+	 cd repo_c &&
+	 test_commit c_master &&
+	 git checkout -b bar &&
+	 test_commit c_bar
+	 git checkout -b spam &&
+	 test_commit c_spam
+	) &&
+	(git init repo_d &&
+	 cd repo_d &&
+	 test_commit d_master &&
+	 git checkout -b baz &&
+	 test_commit f_baz
+	 git checkout -b eggs &&
+	 test_commit c_eggs
+	) &&
+	git remote add repo_c repo_c &&
+	git config remote.repo_c.fetch \
+	    "+refs/heads/*:refs/remotes/extra_dir/repo_c/extra_dir/*" &&
+	git fetch repo_c &&
+	git remote add repo_d repo_d &&
+	git config remote.repo_d.fetch \
+	    "+refs/heads/*:refs/repo_d/*" &&
+	git fetch repo_d
+'
+
+test_expect_failure 'checkout of branch from multiple remotes fails #2' '
+	test_must_fail git checkout bar
+'
+
+test_expect_failure 'checkout of branch from multiple remotes fails #3' '
+	test_must_fail git checkout baz
+'
+
+test_expect_failure 'checkout of branch from a single remote succeeds #3' '
+	git checkout spam &&
+	test_tracking_branch spam repo_c refs/remotes/extra_dir/repo_c/extra_dir/spam
+'
+
+test_expect_failure 'checkout of branch from a single remote succeeds #4' '
+	git checkout eggs &&
+	test_tracking_branch eggs repo_d refs/repo_d/eggs
+'
+
 test_done
-- 
1.8.1.3.704.g33f7d4f
