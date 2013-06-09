From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 38/45] add simple tests of consistency across rebase types
Date: Sun,  9 Jun 2013 11:40:50 -0500
Message-ID: <1370796057-25312-39-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlijV-0007SX-HM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab3FIQom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:42 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:64031 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab3FIQoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:38 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so4923976oag.22
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2TQHSBr/bCD2LIGXGRobpoEU9mcNPZGQ1pZ+ulMCWYI=;
        b=JIHtiJP9I7BuEe3Sf1ZVm5aPNTGUvlRVqBDr+F7NgGC7H5dwwoPCWvYXAF8Lmo4iEI
         FVXAWQRG6ZBlkgIhvZeBpyGrd2hyXXpf9DuCVfg3BEC+e7Kgg5Fc3vHqpaXW8H0JeuL/
         6cOE9GoiKHQqJGHRZQqOXFl+iMqaYxLaEJlC8npTOtKh7x+bLDzN/xmSbK5L/1ZtB5hT
         tQvOs+CXdUxF9At5emUvfAFYDqTN6+TkTZqJ7ST7i8o7WJBu7Ji5OoQlYwKWq9ozf1Az
         bn1RWLCvtfVYEYauXR7ycmTshuAYGpnfjv5t3rIPxIyevrctHg7tEqDeGOb9QJ9fGvGl
         8JAA==
X-Received: by 10.60.44.209 with SMTP id g17mr5274477oem.23.1370796277996;
        Sun, 09 Jun 2013 09:44:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm15199762oel.2.2013.06.09.09.44.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227004>

From: Martin von Zweigbergk <martinvonz@gmail.com>

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-rebase.sh                   | 16 ++++++++
 t/t3421-rebase-topology-linear.sh | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100755 t/t3421-rebase-topology-linear.sh

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6ccf797..1e0ff28 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -65,3 +65,19 @@ EOF
 	test_set_editor "$(pwd)/fake-editor.sh"
 	chmod a+x fake-editor.sh
 }
+
+# checks that the revisions in "$2" represent a linear range with the
+# subjects in "$1"
+test_linear_range () {
+	revlist_merges=$(git rev-list --merges "$2") &&
+	test -z "$revlist_merges" &&
+	expected=$1
+	set -- $(git log --reverse --format=%s "$2")
+	test "$expected" = "$*"
+}
+
+reset_rebase () {
+	test_might_fail git rebase --abort &&
+	git reset --hard &&
+	git clean -f
+}
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
new file mode 100755
index 0000000..60365d1
--- /dev/null
+++ b/t/t3421-rebase-topology-linear.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='basic rebase topology tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+# a---b---c
+#      \
+#       d---e
+test_expect_success 'setup' '
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	git checkout b &&
+	test_commit d &&
+	test_commit e
+'
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "simple rebase $*" "
+		reset_rebase &&
+		git rebase $* c e &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'd e' c..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* is no-op if upstream is an ancestor" "
+		reset_rebase &&
+		git rebase $* b e &&
+		test_cmp_rev e HEAD
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* -f rewrites even if upstream is an ancestor" "
+		reset_rebase &&
+		git rebase $* -f b e &&
+		! test_cmp_rev e HEAD &&
+		test_cmp_rev b HEAD~2 &&
+		test_linear_range 'd e' b..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase failure -p
+
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* fast-forwards from ancestor of upstream" "
+		reset_rebase &&
+		git rebase $* e b &&
+		test_cmp_rev e HEAD
+	"
+}
+test_run_rebase success ''
+test_run_rebase success -m
+test_run_rebase success -i
+test_run_rebase success -p
+
+test_done
-- 
1.8.3.698.g079b096
