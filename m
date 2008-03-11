From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule summary: test
Date: Tue, 11 Mar 2008 13:15:49 +0800
Message-ID: <1205212549-31541-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 11 06:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYwqx-0001O2-2f
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 06:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbYCKFP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 01:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbYCKFP4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 01:15:56 -0400
Received: from mail.qikoo.org ([60.28.205.235]:54365 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751592AbYCKFPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 01:15:55 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id E5288470AE; Tue, 11 Mar 2008 13:15:49 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76795>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 t/t7401-submodule-summary.sh |  195 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100755 t/t7401-submodule-summary.sh

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
new file mode 100755
index 0000000..0f3c42a
--- /dev/null
+++ b/t/t7401-submodule-summary.sh
@@ -0,0 +1,195 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Ping Yin
+#
+
+test_description='Summary support for submodules
+
+This test tries to verify the sanity of summary subcommand of git-submodule.
+'
+
+. ./test-lib.sh
+
+add_file () {
+	sm=$1
+	shift
+	owd=$(pwd)
+	cd "$sm"
+	for name; do
+		echo "$name" > "$name" &&
+		git add "$name" &&
+		test_tick &&
+		git commit -m "Add $name"
+	done >/dev/null
+	git rev-parse --verify HEAD | cut -c1-7
+	cd "$owd"
+}
+commit_file () {
+	test_tick &&
+	git commit "$@" -m "Commit $*" >/dev/null
+}
+
+test_create_repo sm1 &&
+add_file . foo
+
+head1=$(add_file sm1 foo1 foo2)
+
+test_expect_success 'added submodule' "
+	git add sm1 &&
+	git submodule summary >actual &&
+	diff actual - <<-EOF
+* sm1 0000000...$head1 (2):
+  > Add foo2
+
+EOF
+"
+
+commit_file sm1 &&
+head2=$(add_file sm1 foo3)
+
+test_expect_success 'modified submodule(forward)' "
+	git submodule summary >actual &&
+	diff actual - <<-EOF
+* sm1 $head1...$head2 (1):
+  > Add foo3
+
+EOF
+"
+
+commit_file sm1 &&
+cd sm1 &&
+git reset --hard HEAD~2 >/dev/null &&
+head3=$(git rev-parse --verify HEAD | cut -c1-7) &&
+cd ..
+
+test_expect_success 'modified submodule(backward)' "
+    git submodule summary >actual &&
+    diff actual - <<-EOF
+* sm1 $head2...$head3 (2):
+  < Add foo3
+  < Add foo2
+
+EOF
+"
+
+head4=$(add_file sm1 foo4 foo5) &&
+head4_full=$(GIT_DIR=sm1/.git git rev-parse --verify HEAD)
+test_expect_success 'modified submodule(backward and forward)' "
+    git submodule summary >actual &&
+    diff actual - <<-EOF
+* sm1 $head2...$head4 (4):
+  > Add foo5
+  > Add foo4
+  < Add foo3
+  < Add foo2
+
+EOF
+"
+
+test_expect_success '--summary-limit' "
+    git submodule summary -n 3 >actual &&
+    diff actual - <<-EOF
+* sm1 $head2...$head4 (4):
+  > Add foo5
+  > Add foo4
+  < Add foo3
+
+EOF
+"
+
+commit_file sm1 &&
+mv sm1 sm1-bak &&
+echo sm1 >sm1 &&
+head5=$(git hash-object sm1 | cut -c1-7) &&
+git add sm1 &&
+rm -f sm1 &&
+mv sm1-bak sm1
+
+test_expect_success 'typechanged submodule(submodule->blob), --cached' "
+    git submodule summary --cached >actual &&
+    diff actual - <<-EOF
+* sm1 $head4(submodule)->$head5(blob) (3):
+  < Add foo5
+
+EOF
+"
+
+rm -rf sm1 &&
+git checkout-index sm1
+test_expect_success 'typechanged submodule(submodule->blob)' "
+    git submodule summary >actual &&
+    diff actual - <<-EOF
+* sm1 $head4(submodule)->$head5(blob):
+
+EOF
+"
+
+rm -f sm1 &&
+test_create_repo sm1 &&
+head6=$(add_file sm1 foo6 foo7)
+test_expect_success 'nonexistent commit' "
+    git submodule summary >actual &&
+    diff actual - <<-EOF
+* sm1 $head4...$head6:
+  Warn: sm1 doesn't contain commit $head4_full
+
+EOF
+"
+
+commit_file
+test_expect_success 'typechanged submodule(blob->submodule)' "
+    git submodule summary >actual &&
+    diff actual - <<-EOF
+* sm1 $head5(blob)->$head6(submodule) (2):
+  > Add foo7
+
+EOF
+"
+
+commit_file sm1 &&
+rm -rf sm1
+test_expect_success 'deleted submodule' "
+    git submodule summary >actual &&
+    diff actual - <<-EOF
+* sm1 $head6...0000000:
+
+EOF
+"
+
+test_create_repo sm2 &&
+head7=$(add_file sm2 foo8 foo9) &&
+git add sm2
+
+test_expect_success 'multiple submodules' "
+    git submodule summary >actual &&
+    diff actual - <<-EOF
+* sm1 $head6...0000000:
+
+* sm2 0000000...$head7 (2):
+  > Add foo9
+
+EOF
+"
+
+test_expect_success 'path filter' "
+    git submodule summary sm2 >actual &&
+    diff actual - <<-EOF
+* sm2 0000000...$head7 (2):
+  > Add foo9
+
+EOF
+"
+
+commit_file sm2
+test_expect_success 'given commit' "
+    git submodule summary HEAD^ >actual &&
+    diff actual - <<-EOF
+* sm1 $head6...0000000:
+
+* sm2 0000000...$head7 (2):
+  > Add foo9
+
+EOF
+"
+
+test_done
-- 
1.5.4.3.347.g5314c
