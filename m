From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 2/8] t2024: Show failure to use refspec when DWIMming remote branch names
Date: Sat, 20 Apr 2013 17:05:57 +0200
Message-ID: <1366470363-22309-3-git-send-email-johan@herland.net>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 17:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZN5-0008WS-5U
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab3DTPGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:06:25 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45597 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab3DTPGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:06:24 -0400
Received: by mail-lb0-f175.google.com with SMTP id o10so4534603lbi.34
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 08:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jja2K8ihKI01n8Z67MAYgfPy2e0Mj6JJhXt0s7bZenI=;
        b=gvp+HsYxzrLmdMAAEsNyJzd63tCYD4wWpqWAjB53OEbrgugJrMKqb7ZgLhxTxK1CY6
         RrvHQNX48GyuGXMixv4AuhjJ+szIs0FEIxkUJAjshCLcvfhM7XXUnSdTOC7NjcFksScA
         uV1UMub0OAvqUqzuodxtvHbsHy6aFQ1HK40d5SA5BH8ayDv5GY0oTpjyq5a1b7KDNjRe
         vkprHOh+TzV/HxR3zVQAByj+wndbUMLa8FZsMFOsikeaXm+cefurDD4sLQL0kruZ6oDQ
         N026jQGIQMZHQ39IoHm8wFHR0HvLsSYPyW9LKnysCWGBFOGsFq/G6YHSHR7kuMwGzE6Y
         HB4g==
X-Received: by 10.112.73.70 with SMTP id j6mr1854166lbv.39.1366470383084;
        Sat, 20 Apr 2013 08:06:23 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id sl5sm7539983lbb.10.2013.04.20.08.06.21
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 08:06:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366470363-22309-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221863>

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
