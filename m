From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 39/45] add tests for rebasing with patch-equivalence present
Date: Sun,  9 Jun 2013 11:40:51 -0500
Message-ID: <1370796057-25312-40-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulije-0007a8-Do
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab3FIQor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:47 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:58969 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab3FIQol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:41 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so8796608obc.40
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iP89EAQzEx9H8aF4KblXT2SBcOYxqkfuXe3XGl4iFJI=;
        b=R/vH2wQtvUv6m0+kfavrt6GlkdVgJCFx1PnSTPb/+JA0i1TOJwZNhe/a+m6tT5Ohfg
         GtbPbBMXWP648mKJ36V7j9hqzciXyhxOQ8xeeXlt6SXtIgM8EryHFRdO4jY4SjUhfdlh
         f0oY5aLyjEAvaTnwWfZLBB1yJY3MBBxkiPXyEGc1dtE+pS9baV6DCWUtf7HIj+Cf5P8z
         yGWxpgYOG9HrZbEbOuX440Xtds1U9UKfFjcORguLWFeHs7Dmdpx/E9sPPbMIq7JOVf9B
         RQwYhEiSfmAJy0hm4Q4qAo5EL8rZwEfJPYSjm19KaUBAEpmPIPoWCZAgsB4i6NjK9zDl
         KpbA==
X-Received: by 10.60.37.133 with SMTP id y5mr5293819oej.123.1370796280855;
        Sun, 09 Jun 2013 09:44:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm14861303obb.13.2013.06.09.09.44.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227008>

From: Martin von Zweigbergk <martinvonz@gmail.com>

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-rebase.sh                   | 17 ++++++++
 t/t3421-rebase-topology-linear.sh | 85 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 1e0ff28..4b74ae4 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -81,3 +81,20 @@ reset_rebase () {
 	git reset --hard &&
 	git clean -f
 }
+
+cherry_pick () {
+	git cherry-pick -n "$2" &&
+	git commit -m "$1" &&
+	git tag "$1"
+}
+
+revert () {
+	git revert -n "$2" &&
+	git commit -m "$1" &&
+	git tag "$1"
+}
+
+make_empty () {
+	git commit --allow-empty -m "$1" &&
+	git tag "$1"
+}
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 60365d1..ddcbfc6 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -75,4 +75,89 @@ test_run_rebase success -m
 test_run_rebase success -i
 test_run_rebase success -p
 
+#       f
+#      /
+# a---b---c---g---h
+#      \
+#       d---G---i
+#
+# uppercase = cherry-picked
+# h = reverted g
+#
+# Reverted patches are there for tests to be able to check if a commit
+# that introduced the same change as another commit is
+# dropped. Without reverted commits, we could get false positives
+# because applying the patch succeeds, but simply results in no
+# changes.
+test_expect_success 'setup of linear history for range selection tests' '
+	git checkout c &&
+	test_commit g &&
+	revert h g &&
+	git checkout d &&
+	cherry_pick G g &&
+	test_commit i &&
+	git checkout b &&
+	test_commit f
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* drops patches in upstream" "
+		reset_rebase &&
+		git rebase $* h i &&
+		test_cmp_rev h HEAD~2 &&
+		test_linear_range 'd i' h..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* can drop last patch if in upstream" "
+		reset_rebase &&
+		git rebase $* h G &&
+		test_cmp_rev h HEAD^ &&
+		test_linear_range 'd' h..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --onto drops patches in upstream" "
+		reset_rebase &&
+		git rebase $* --onto f h i &&
+		test_cmp_rev f HEAD~2 &&
+		test_linear_range 'd i' f..
+	"
+}
+test_run_rebase success ''
+test_run_rebase failure -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* --onto does not drop patches in onto" "
+		reset_rebase &&
+		git rebase $* --onto h f i &&
+		test_cmp_rev h HEAD~3 &&
+		test_linear_range 'd G i' h..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
 test_done
-- 
1.8.3.698.g079b096
