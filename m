From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 5/5] Guards test suite
Date: Mon, 30 Jul 2007 20:11:21 -0700
Message-ID: <11858514811776-git-send-email-eclesh@ucla.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Jul 31 05:12:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFi9Q-0001t4-Ht
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 05:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764417AbXGaDLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 23:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965575AbXGaDLn
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 23:11:43 -0400
Received: from smtp-5.smtp.ucla.edu ([169.232.47.137]:34518 "EHLO
	smtp-5.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764417AbXGaDLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 23:11:37 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.151])
	by smtp-5.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BUYV028598;
	Mon, 30 Jul 2007 20:11:30 -0700
Received: from localhost (adsl-75-26-197-236.dsl.scrm01.sbcglobal.net [75.26.197.236])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BT90009304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 20:11:30 -0700
Received: by localhost (Postfix, from userid 1000)
	id AF6E31E80AE; Mon, 30 Jul 2007 20:11:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <1185851481190-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.47.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54313>

The guards patches touch a lot of guilt, so make sure they don't muck
anything up.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 regression/070-guards.sh |  184 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100755 regression/070-guards.sh

diff --git a/regression/070-guards.sh b/regression/070-guards.sh
new file mode 100755
index 0000000..d6917f2
--- /dev/null
+++ b/regression/070-guards.sh
@@ -0,0 +1,184 @@
+#!/bin/bash
+#
+# Test the commands that use get_*_series, while applying guards
+#
+
+source scaffold
+source generic_test_data
+
+function prepare_for_tests
+{
+	# generic_test_data's patches all depend on each other
+	# that's no good for guards testing
+
+	echo "abc" > def
+	git-add def
+	git-commit -s -m "initial" 2> /dev/null > /dev/null
+
+	cat << DONE > .git/patches/master/first
+diff --git a/first b/first
+new file mode 100644
+index 0000000..9c59e24
+--- /dev/null
++++ b/first
+@@ -0,0 +1 @@
++first
+DONE
+
+	cat << DONE > .git/patches/master/second
+diff --git a/second b/second
+new file mode 100644
+index 0000000..e019be0
+--- /dev/null
++++ b/second
+@@ -0,0 +1 @@
++second
+DONE
+
+	cat << DONE > .git/patches/master/third
+diff --git a/third b/third
+new file mode 100644
+index 0000000..234496b
+--- /dev/null
++++ b/third
+@@ -0,0 +1 @@
++third
+DONE
+
+	cat << DONE > .git/patches/master/fourth
+diff --git a/fourth b/fourth
+new file mode 100644
+index 0000000..285a4e6
+--- /dev/null
++++ b/fourth
+@@ -0,0 +1 @@
++fourth
+DONE
+
+	cat << DONE > .git/patches/master/series
+first
+second
+third
+fourth
+DONE
+
+	touch -d "$GIT_COMMITTER_DATE" .git/patches/master/first
+	touch -d "$GIT_COMMITTER_DATE" .git/patches/master/second
+	touch -d "$GIT_COMMITTER_DATE" .git/patches/master/third
+	touch -d "$GIT_COMMITTER_DATE" .git/patches/master/fourth
+}
+
+function expected_applied_none
+{
+	echo "first"
+	echo "second"
+	echo "third"
+	echo "fourth"
+}
+
+function expected_applied_positive
+{
+	echo "second"
+	echo "third"
+	echo "fourth"
+}
+
+function expected_applied_positive_selected
+{
+	echo "first"
+	echo "second"
+	echo "third"
+	echo "fourth"
+}
+
+function expected_applied_negative
+{
+	echo "first"
+	echo "second"
+	echo "third"
+	echo "fourth"
+}
+
+function expected_applied_negative_selected
+{
+	echo "second"
+	echo "third"
+	echo "fourth"
+}
+
+function expected_next
+{
+	echo "second"
+}
+
+function expected_unapplied
+{
+	echo "second"
+	echo "third"
+	echo "fourth"
+}
+
+empty_repo
+cd $REPODIR
+guilt-init
+
+prepare_for_tests
+
+# test with no guarded patches and no guards selected
+guilt-push -a > /dev/null
+guilt-applied > /tmp/reg.$$
+expected_applied_none | diff -u - /tmp/reg.$$
+echo -n "[none] "
+
+# test with one positive guarded patch and no guards selected
+guilt-pop -a > /dev/null
+guilt-guard first +foo
+guilt-push -a > /dev/null
+guilt-applied > /tmp/reg.$$
+expected_applied_positive | diff -u - /tmp/reg.$$
+echo -n "[positive] "
+
+# test with one positive guarded patch with that guard selected
+guilt-pop -a > /dev/null
+guilt-select foo
+guilt-push -a > /dev/null
+guilt-applied > /tmp/reg.$$
+expected_applied_positive_selected | diff -u - /tmp/reg.$$
+echo -n "[positive selected] "
+
+# test with one negative guarded patch and no guards selected
+guilt pop -a > /dev/null
+guilt-select -n
+guilt-guard first -foo
+guilt-push -a > /dev/null
+guilt-applied > /tmp/reg.$$
+expected_applied_negative | diff -u - /tmp/reg.$$
+echo -n "[negative] "
+
+# test with one negative guarded patch with that guard selected
+guilt pop -a > /dev/null
+guilt-select foo
+guilt-push -a > /dev/null
+guilt-applied > /tmp/reg.$$
+expected_applied_negative_selected | diff -u - /tmp/reg.$$
+echo -n "[negative selected] "
+
+# test that guilt-next works
+guilt-pop -a > /dev/null
+guilt-select -n
+guilt-guard first +foo
+guilt-next > /tmp/reg.$$
+expected_next | diff -u - /tmp/reg.$$
+echo -n "[next] "
+
+# test that guilt-unapplied works
+guilt-pop -a > /dev/null
+guilt-select -n
+guilt-guard first +foo
+guilt-unapplied > /tmp/reg.$$
+expected_unapplied | diff -u - /tmp/reg.$$
+echo -n "[unapplied] "
+
+rm -f /tmp/reg.$$
+
+complete_test
-- 
1.5.2
