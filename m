From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 1/8] t2024: Add tests verifying current DWIM behavior of 'git checkout <branch>'
Date: Sat, 20 Apr 2013 17:05:56 +0200
Message-ID: <1366470363-22309-2-git-send-email-johan@herland.net>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 17:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZN4-0008WS-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab3DTPGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:06:23 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:44378 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab3DTPGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:06:21 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so4542335lbd.38
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 08:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3Wm8PWWt6a/J0ilcV/Ws2s0s16rNeqgvcLK0mEndTF4=;
        b=b1OHi4xhVC7MiBVGJqbA8aR9vlXhSf1QrkXWcQr/dcA85PRrYgwcOc0xjVHHE6swGq
         3m6OXj90LylRA+ifQ7dR52Z+O3DqwIlHiYOs/XznkLly/V6XjHGUwYgRvyypkgcvHJok
         NLPnRKomLAJ6o8zKlGmLIX7dFuv5W2Efjzd71CX/PiC6+2zQWCV4fMnYxWPRGamsAPZI
         FgRhfne/9tl/6RnWdWB1MU+dDWcDIRtX80jTSufmPbJK7qK5mASY+FWumdWTVEIDZd0J
         3a7ejND8to1jhArJea7gTDEXZLE5FCZDYbF64V4lkjwS/yR/TzZOMOBMFpA57vupY6bl
         944Q==
X-Received: by 10.112.72.229 with SMTP id g5mr5106226lbv.64.1366470380075;
        Sat, 20 Apr 2013 08:06:20 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id sl5sm7539983lbb.10.2013.04.20.08.06.18
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 08:06:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366470363-22309-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221862>

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
