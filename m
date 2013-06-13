From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] rebase: finish_rebase() in fast-forward rebase
Date: Thu, 13 Jun 2013 21:36:12 +0530
Message-ID: <1371139573-28047-3-git-send-email-artagnon@gmail.com>
References: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 18:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnA4a-0005m0-TN
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 18:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354Ab3FMQIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 12:08:16 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:47312 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab3FMQIO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 12:08:14 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so7587146pde.18
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uZtC0eu9+xE4cYJ+EuYDE8/yTgADDx82FnkVLX2cNxw=;
        b=kn8iC+pAIg4IeYcoSb8UEjZK32S7FkV6hUHbNBI09YHCawkK5W5ys0lYFTs2LbGMrm
         m5WsbC7BXn+gVjn3d5NgP0SkxFknMMkA0QnK7/SBXRO+uUWc9dQ5WxxfakQwSFyKeqvh
         DJ6VimcDOVxVIIfzF5uHpnw8A/TBBnMGrsLot9UvRG/4VkLBA2ekq/u/hhpMcQDh/7b4
         LpjHHsTeD7frUsc3cEzKyNQ+cJBvTd8raUhP9Q2/hosejHl7E4h5XwDfvVe67Ky0uwG1
         zyvQ3GtBYnUY/5I7vcnz7KIQN7AZDZ9mjBHzdqUJ6cGweAmqdSgEF+ZWJbgbE66K1vhn
         Mb2w==
X-Received: by 10.66.150.226 with SMTP id ul2mr3545748pab.17.1371139693386;
        Thu, 13 Jun 2013 09:08:13 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm23911564pbc.12.2013.06.13.09.08.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 09:08:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.gf08dd97.dirty
In-Reply-To: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227744>

In the following case

  $ git rebase master
  Fast-forwarded autostash-fix to master.

The autostash is not applied automatically, because this codepath
forgets to call finish_rebase().  Fix this.  Also add a test to guard
against regressions.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh               |  1 +
 t/t3420-rebase-autostash.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2122fe0..154d4be 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -579,6 +579,7 @@ if test "$mb" = "$orig_head"
 then
 	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
 	move_to_original_branch
+	finish_rebase
 	exit 0
 fi
 
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 479cbb2..1bde007 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -141,6 +141,17 @@ testrebase() {
 	'
 }
 
+test_expect_success "rebase: fast-forward rebase" '
+	test_config rebase.autostash true &&
+	git reset --hard &&
+	git checkout -b behind-feature-branch feature-branch~1 &&
+	test_when_finished git branch -D behind-feature-branch &&
+	echo dirty >>file1 &&
+	git rebase feature-branch &&
+	grep dirty file1 &&
+	git checkout feature-branch
+'
+
 testrebase "" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
-- 
1.8.3.1.381.gf08dd97.dirty
