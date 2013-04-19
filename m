From: Johan Herland <johan@herland.net>
Subject: [RFD/PATCH 1/5] t2024: Add tests verifying current DWIM behavior of 'git checkout <branch>'
Date: Fri, 19 Apr 2013 08:20:38 +0200
Message-ID: <1366352442-501-2-git-send-email-johan@herland.net>
References: <1366352442-501-1-git-send-email-johan@herland.net>
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 08:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4hd-0002hP-FB
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 08:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab3DSGVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 02:21:41 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:55080 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab3DSGVk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 02:21:40 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so3386845lbh.4
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 23:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3Wm8PWWt6a/J0ilcV/Ws2s0s16rNeqgvcLK0mEndTF4=;
        b=DjOl/o3KNs9czN2d2HIf5N+zgvFPkjIdE8wYtZBDlWMf/CFt1qxD5QdUGYwm1k4hRg
         jrzwBcyECnomqro7m9BgrbQ0QEGxWc7pWsxMTP34Drbod9R1VQbgF5MtTH2uS6cbaf4p
         znd9jhUu2+pCq6jUps25UDOsIhxPHuMc4hFtFsNirg3EUi+hnDQgcnta6lUgnSxNJ6pW
         tAUaHoRQ2DwR+nQO+H09pyXdfNsZVZEtoKJ+YvLxSb7cdHUUeMpeQDd0ai/pD/UyaUjt
         DMvE28vLq5428yMIYWr6jSgyQ3pnEjsYsRgwgFLm5N6rGQU+Ab6/foGhZdsPvwT5hQqL
         0TMA==
X-Received: by 10.152.29.102 with SMTP id j6mr7418566lah.47.1366352498699;
        Thu, 18 Apr 2013 23:21:38 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id f4sm2076904lbw.6.2013.04.18.23.21.37
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 23:21:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366352442-501-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221743>

The DWIM mode of checkout allows you to run "git checkout foo" when there is
no existing local ref or path called "foo", and there is exactly one remote
with a remote-tracking branch called "foo". Git will then automatically
create a new local branch called "foo" using the remote-tracking "foo" as
its starting point and configured upstream.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t2024-checkout-dwim.sh | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100755 t/t2024-checkout-dwim.sh

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
new file mode 100755
index 0000000..5650d21
--- /dev/null
+++ b/t/t2024-checkout-dwim.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='checkout <branch>
+
+Ensures that checkout on an unborn branch does what the user expects'
+
+. ./test-lib.sh
+
+# Arguments: <branch> <remote> <remote-tracking>
+#
+# Verify that we have checked out <branch>, and that it is at the same
+# commit as <remote-tracking>, and that has appropriate tracking config
+# setup against <remote>
+test_tracking_branch() {
+	branch=$1 &&
+	remote=$2 &&
+	remote_track=$3 &&
+	test "refs/heads/$branch" = "$(git rev-parse --symbolic-full-name HEAD)" &&
+	test "$(git rev-parse --verify HEAD)" = "$(git rev-parse --verify "$remote_track")" &&
+	test "$remote" = "$(git config "branch.$branch.remote")" &&
+	test "refs/heads/$branch" = "$(git config "branch.$branch.merge")"
+}
+
+test_expect_success 'setup' '
+	(git init repo_a &&
+	 cd repo_a &&
+	 test_commit a_master &&
+	 git checkout -b foo &&
+	 test_commit a_foo &&
+	 git checkout -b bar &&
+	 test_commit a_bar
+	) &&
+	(git init repo_b &&
+	 cd repo_b &&
+	 test_commit b_master &&
+	 git checkout -b foo &&
+	 test_commit b_foo &&
+	 git checkout -b baz &&
+	 test_commit b_baz
+	) &&
+	git remote add repo_a repo_a &&
+	git remote add repo_b repo_b &&
+	git config remote.repo_b.fetch \
+		"+refs/heads/*:refs/remotes/other_b/*" &&
+	git fetch --all
+'
+
+test_expect_success 'checkout of non-existing branch fails' '
+	test_must_fail git checkout xyzzy
+'
+
+test_expect_success 'checkout of branch from multiple remotes fails' '
+	test_must_fail git checkout foo
+'
+
+test_expect_success 'checkout of branch from a single remote succeeds #1' '
+	git checkout bar &&
+	test_tracking_branch bar repo_a refs/remotes/repo_a/bar
+'
+
+test_expect_success 'checkout of branch from a single remote succeeds #2' '
+	git checkout baz &&
+	test_tracking_branch baz repo_b refs/remotes/other_b/baz
+'
+
+test_done
-- 
1.8.1.3.704.g33f7d4f
