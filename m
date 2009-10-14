From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 4/4] add tests for git diff --submodule-summary
Date: Wed, 14 Oct 2009 20:32:08 +0200
Message-ID: <4AD61928.4000308@web.de>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org> <4AD61880.4040600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8mq-0005gB-Os
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbZJNShQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756429AbZJNShP
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:37:15 -0400
Received: from [217.72.192.221] ([217.72.192.221]:60658 "EHLO
	fmmailgate01.web.de" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbZJNShN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:37:13 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id A966412BDFAF2;
	Wed, 14 Oct 2009 20:32:15 +0200 (CEST)
Received: from [80.128.106.100] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1My8dt-0002Kp-00; Wed, 14 Oct 2009 20:32:09 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <4AD61880.4040600@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+W5GzJ09lnfly+OrZgwsnXL1mL63lyNO7B7++D
	IFzYQCZagkmdM9bY/+FCOL6uPhU7u6BqDW46ZtoM2NBJOuBXky
	F6dLPEpj4xA0RJfq5qKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130319>

Copied from the submodule summary test and changed to reflect the
differences in the output of git diff --submodule-summary.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t4041-diff-submodule-summary.sh |  206 +++++++++++++++++++++++++++++++++++++
 1 files changed, 206 insertions(+), 0 deletions(-)
 create mode 100755 t/t4041-diff-submodule-summary.sh

diff --git a/t/t4041-diff-submodule-summary.sh b/t/t4041-diff-submodule-summary.sh
new file mode 100755
index 0000000..dbb19eb
--- /dev/null
+++ b/t/t4041-diff-submodule-summary.sh
@@ -0,0 +1,206 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Jens Lehmann, based on t7401 by Ping Yin
+#
+
+test_description='Summary support for submodules implemented in git diff
+
+This test tries to verify the sanity of --submodule-summary option of git diff.
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
+add_file . foo >/dev/null
+
+head1=$(add_file sm1 foo1 foo2)
+
+test_expect_success 'added submodule' "
+	git add sm1 &&
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 0000000...$head1 (new submodule)
+EOF
+"
+
+commit_file sm1 &&
+head2=$(add_file sm1 foo3)
+
+test_expect_success 'modified submodule(forward)' "
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head1..$head2:
+  > Add foo3
+EOF
+"
+
+test_expect_success 'modified submodule(forward)' "
+	git diff --submodule-summary >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head1..$head2:
+  > Add foo3
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
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head2..$head3 (rewind):
+  < Add foo3
+  < Add foo2
+EOF
+"
+
+head4=$(add_file sm1 foo4 foo5) &&
+head4_full=$(GIT_DIR=sm1/.git git rev-parse --verify HEAD)
+test_expect_success 'modified submodule(backward and forward)' "
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head2...$head4:
+  > Add foo5
+  > Add foo4
+  < Add foo3
+  < Add foo2
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
+	git diff --submodule-summary --cached >actual &&
+	diff actual - <<-EOF
+Submodule sm1 41fbea9...0000000 (submodule deleted)
+diff --git a/sm1 b/sm1
+new file mode 100644
+index 0000000..9da5fb8
+--- /dev/null
++++ b/sm1
+@@ -0,0 +1 @@
++sm1
+EOF
+"
+
+test_expect_success 'typechanged submodule(submodule->blob)' "
+	git diff --submodule-summary >actual &&
+	diff actual - <<-EOF
+diff --git a/sm1 b/sm1
+deleted file mode 100644
+index 9da5fb8..0000000
+--- a/sm1
++++ /dev/null
+@@ -1 +0,0 @@
+-sm1
+Submodule sm1 0000000...$head4 (new submodule)
+EOF
+"
+
+rm -rf sm1 &&
+git checkout-index sm1
+test_expect_success 'typechanged submodule(submodule->blob)' "
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head4...0000000 (submodule deleted)
+diff --git a/sm1 b/sm1
+new file mode 100644
+index 0000000..$head5
+--- /dev/null
++++ b/sm1
+@@ -0,0 +1 @@
++sm1
+EOF
+"
+
+rm -f sm1 &&
+test_create_repo sm1 &&
+head6=$(add_file sm1 foo6 foo7)
+test_expect_success 'nonexistent commit' "
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head4...$head6 (commits not present)
+EOF
+"
+
+commit_file
+test_expect_success 'typechanged submodule(blob->submodule)' "
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+diff --git a/sm1 b/sm1
+deleted file mode 100644
+index $head5..0000000
+--- a/sm1
++++ /dev/null
+@@ -1 +0,0 @@
+-sm1
+Submodule sm1 0000000...$head6 (new submodule)
+EOF
+"
+
+commit_file sm1 &&
+rm -rf sm1
+test_expect_success 'deleted submodule' "
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6...0000000 (submodule deleted)
+EOF
+"
+
+test_create_repo sm2 &&
+head7=$(add_file sm2 foo8 foo9) &&
+git add sm2
+
+test_expect_success 'multiple submodules' "
+	git diff-index -p --submodule-summary HEAD >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6...0000000 (submodule deleted)
+Submodule sm2 0000000...$head7 (new submodule)
+EOF
+"
+
+test_expect_success 'path filter' "
+	git diff-index -p --submodule-summary HEAD sm2 >actual &&
+	diff actual - <<-EOF
+Submodule sm2 0000000...$head7 (new submodule)
+EOF
+"
+
+commit_file sm2
+test_expect_success 'given commit' "
+	git diff-index -p --submodule-summary HEAD^ >actual &&
+	diff actual - <<-EOF
+Submodule sm1 $head6...0000000 (submodule deleted)
+Submodule sm2 0000000...$head7 (new submodule)
+EOF
+"
+
+test_done
-- 
1.6.5.4.g707c
