From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 2/8] t2024: Show failure to use refspec when DWIMming remote branch names
Date: Sun, 21 Apr 2013 23:52:00 +0200
Message-ID: <1366581126-3880-3-git-send-email-johan@herland.net>
References: <1366581126-3880-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 21 23:52:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2Bm-0000Mj-Te
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab3DUVws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:52:48 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:55473 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab3DUVwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:52:47 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so5113562lbd.30
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sIQg3DyAZlZVnCt5kn7oRM0BxyQ5zTn64COfhqv7wwE=;
        b=dNDuBJilm34mXDKlIL5S4rXTaRwSiGbDdyQPQh05QYsDjhaRquZ4xgorY/9YUVv76q
         lpIzAkfRX83LX3GkeK6NQGDylqqvIkca8j56+8J7PAFEp0pfH12CXhaM6wijFZCP+heR
         tHht+lH08PqsKBUlbPdB4G+8JD+dkgULH8FL42W9UqoWac7Zm/j0gCVg3bhVPNlsLY9L
         SSL4O6FRhRJ9k2wo5wOAdrO+3C5nptKWPOX2Xbs61GL71rUh7EcZ948QDAVhcCB4Gl1r
         s0RiIXCyeZ4Ttyc6ihAqZGg1LKygv+ymzdFIxYWJSS/MwldynuSonG5ib/7LqWdAuYtS
         pJbQ==
X-Received: by 10.112.133.72 with SMTP id pa8mr12181088lbb.114.1366581165751;
        Sun, 21 Apr 2013 14:52:45 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id ak4sm9489460lbc.12.2013.04.21.14.52.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:52:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366581126-3880-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221970>

When using "git checkout foo" to DWIM the creation of local "foo" from some
existing upstream "foo", we assume conventional refspecs as created by "git
clone" or "git remote add", and fail to work correctly if the current
refspecs do not follow the conventional "refs/remotes/$remote/*" pattern.

Improved-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t2024-checkout-dwim.sh | 70 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 1452bea..b1e3444 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -24,6 +24,7 @@ test_branch_upstream () {
 }
 
 test_expect_success 'setup' '
+	test_commit my_master &&
 	git init repo_a &&
 	(
 		cd repo_a &&
@@ -58,7 +59,7 @@ test_expect_success 'checkout of non-existing branch fails' '
 	test_branch master
 '
 
-test_expect_success 'checkout of branch from multiple remotes fails' '
+test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	git checkout -B master &&
 	test_might_fail git branch -D foo &&
 
@@ -96,4 +97,71 @@ test_expect_success '--no-guess suppresses branch auto-vivification' '
 	test_branch master
 '
 
+test_expect_success 'setup more remotes with unconventional refspecs' '
+	git checkout -B master &&
+	git init repo_c &&
+	(
+		cd repo_c &&
+		test_commit c_master &&
+		git checkout -b bar &&
+		test_commit c_bar
+		git checkout -b spam &&
+		test_commit c_spam
+	) &&
+	git init repo_d &&
+	(
+		cd repo_d &&
+		test_commit d_master &&
+		git checkout -b baz &&
+		test_commit f_baz
+		git checkout -b eggs &&
+		test_commit c_eggs
+	) &&
+	git remote add repo_c repo_c &&
+	git config remote.repo_c.fetch \
+		"+refs/heads/*:refs/remotes/extra_dir/repo_c/extra_dir/*" &&
+	git remote add repo_d repo_d &&
+	git config remote.repo_d.fetch \
+		"+refs/heads/*:refs/repo_d/*" &&
+	git fetch --all
+'
+
+test_expect_failure 'checkout of branch from multiple remotes fails #2' '
+	git checkout -B master &&
+	test_might_fail git branch -D bar &&
+
+	test_must_fail git checkout bar &&
+	test_must_fail git rev-parse --verify refs/heads/bar &&
+	test_branch master
+'
+
+test_expect_failure 'checkout of branch from multiple remotes fails #3' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz &&
+	test_must_fail git rev-parse --verify refs/heads/baz &&
+	test_branch master
+'
+
+test_expect_failure 'checkout of branch from a single remote succeeds #3' '
+	git checkout -B master &&
+	test_might_fail git branch -D spam &&
+
+	git checkout spam &&
+	test_branch spam &&
+	test_cmp_rev refs/remotes/extra_dir/repo_c/extra_dir/spam HEAD &&
+	test_branch_upstream spam repo_c spam
+'
+
+test_expect_failure 'checkout of branch from a single remote succeeds #4' '
+	git checkout -B master &&
+	test_might_fail git branch -D eggs &&
+
+	git checkout eggs &&
+	test_branch eggs &&
+	test_cmp_rev refs/repo_d/eggs HEAD &&
+	test_branch_upstream eggs repo_d eggs
+'
+
 test_done
-- 
1.8.1.3.704.g33f7d4f
