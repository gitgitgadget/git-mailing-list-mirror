From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] Test that git-am does not lose -C/-p/--whitespace
 options
Date: Thu,  4 Dec 2008 18:23:00 -0800
Message-ID: <1228443780-3386-5-git-send-email-gitster@pobox.com>
References: <1228443780-3386-1-git-send-email-gitster@pobox.com>
 <1228443780-3386-2-git-send-email-gitster@pobox.com>
 <1228443780-3386-3-git-send-email-gitster@pobox.com>
 <1228443780-3386-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 03:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8QN3-0002VO-KE
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbYLECXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 21:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754980AbYLECXW
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:23:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbYLECXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:23:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 360A4846DB
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1E7B7846DA for
 <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:17 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.60.g1d1d7
In-Reply-To: <1228443780-3386-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AE49ECB0-C273-11DD-B57C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102393>

These tests make sure that "git am" does not lose command line options
specified when it was started, after it is interrupted by a patch that
does not apply earlier in the series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4252-am-options.sh |   54 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t4252/am-test-1-1   |   19 +++++++++++++++++
 t/t4252/am-test-1-2   |   21 +++++++++++++++++++
 t/t4252/am-test-2-1   |   19 +++++++++++++++++
 t/t4252/am-test-2-2   |   21 +++++++++++++++++++
 t/t4252/am-test-3-1   |   19 +++++++++++++++++
 t/t4252/am-test-3-2   |   21 +++++++++++++++++++
 t/t4252/am-test-4-1   |   19 +++++++++++++++++
 t/t4252/am-test-4-2   |   22 ++++++++++++++++++++
 t/t4252/file-1-0      |    7 ++++++
 t/t4252/file-2-0      |    7 ++++++
 11 files changed, 229 insertions(+), 0 deletions(-)
 create mode 100755 t/t4252-am-options.sh
 create mode 100644 t/t4252/am-test-1-1
 create mode 100644 t/t4252/am-test-1-2
 create mode 100644 t/t4252/am-test-2-1
 create mode 100644 t/t4252/am-test-2-2
 create mode 100644 t/t4252/am-test-3-1
 create mode 100644 t/t4252/am-test-3-2
 create mode 100644 t/t4252/am-test-4-1
 create mode 100644 t/t4252/am-test-4-2
 create mode 100644 t/t4252/file-1-0
 create mode 100644 t/t4252/file-2-0

diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
new file mode 100755
index 0000000..1a1946d
--- /dev/null
+++ b/t/t4252-am-options.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='git am not losing options'
+. ./test-lib.sh
+
+tm="$TEST_DIRECTORY/t4252"
+
+test_expect_success setup '
+	cp "$tm/file-1-0" file-1 &&
+	cp "$tm/file-2-0" file-2 &&
+	git add file-1 file-2 &&
+	test_tick &&
+	git commit -m initial &&
+	git tag initial
+'
+
+test_expect_success 'interrupted am --whitespace=fix' '
+	rm -rf .git/rebase-apply &&
+	git reset --hard initial &&
+	test_must_fail git am --whitespace=fix "$tm"/am-test-1-? &&
+	git am --skip &&
+	grep 3 file-1 &&
+	grep "^Six$" file-2
+'
+
+test_expect_success 'interrupted am -C1' '
+	rm -rf .git/rebase-apply &&
+	git reset --hard initial &&
+	test_must_fail git am -C1 "$tm"/am-test-2-? &&
+	git am --skip &&
+	grep 3 file-1 &&
+	grep "^Three$" file-2
+'
+
+test_expect_success 'interrupted am -p2' '
+	rm -rf .git/rebase-apply &&
+	git reset --hard initial &&
+	test_must_fail git am -p2 "$tm"/am-test-3-? &&
+	git am --skip &&
+	grep 3 file-1 &&
+	grep "^Three$" file-2
+'
+
+test_expect_success 'interrupted am -C1 -p2' '
+	rm -rf .git/rebase-apply &&
+	git reset --hard initial &&
+	test_must_fail git am -p2 -C1 "$tm"/am-test-4-? &&
+	cat .git/rebase-apply/apply_opt_extra &&
+	git am --skip &&
+	grep 3 file-1 &&
+	grep "^Three$" file-2
+'
+
+test_done
diff --git a/t/t4252/am-test-1-1 b/t/t4252/am-test-1-1
new file mode 100644
index 0000000..b0c09dc
--- /dev/null
+++ b/t/t4252/am-test-1-1
@@ -0,0 +1,19 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Three
+
+Application of this should be rejected because the first line in the
+context does not match.
+
+diff --git i/file-1 w/file-1
+index 06e567b..10f8342 100644
+--- i/file-1
++++ w/file-1
+@@ -1,6 +1,6 @@
+ One
+ 2
+-3
++Three 
+ 4
+ 5
+ 6
diff --git a/t/t4252/am-test-1-2 b/t/t4252/am-test-1-2
new file mode 100644
index 0000000..1b874ae
--- /dev/null
+++ b/t/t4252/am-test-1-2
@@ -0,0 +1,21 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Six
+
+Applying this patch with --whitespace=fix should lose 
+the trailing whitespace after "Six".
+
+diff --git i/file-2 w/file-2
+index 06e567b..b6f3a16 100644
+--- i/file-2
++++ w/file-2
+@@ -1,7 +1,7 @@
+ 1
+ 2
+-3
++Three
+ 4
+ 5
+-6
++Six 
+ 7
diff --git a/t/t4252/am-test-2-1 b/t/t4252/am-test-2-1
new file mode 100644
index 0000000..feda94a
--- /dev/null
+++ b/t/t4252/am-test-2-1
@@ -0,0 +1,19 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Three
+
+Application of this should be rejected even with -C1 because the
+preimage line in the context does not match.
+
+diff --git i/file-1 w/file-1
+index 06e567b..10f8342 100644
+--- i/file-1
++++ w/file-1
+@@ -1,6 +1,6 @@
+ 1
+ 2
+-Tres
++Three 
+ 4
+ 5
+ 6
diff --git a/t/t4252/am-test-2-2 b/t/t4252/am-test-2-2
new file mode 100644
index 0000000..2ac6600
--- /dev/null
+++ b/t/t4252/am-test-2-2
@@ -0,0 +1,21 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Six
+
+Applying this patch with -C1 should be successful even though 
+the first line in the context does not match.
+
+diff --git i/file-2 w/file-2
+index 06e567b..b6f3a16 100644
+--- i/file-2
++++ w/file-2
+@@ -1,7 +1,7 @@
+ One
+ 2
+-3
++Three
+ 4
+ 5
+-6
++Six
+ 7
diff --git a/t/t4252/am-test-3-1 b/t/t4252/am-test-3-1
new file mode 100644
index 0000000..608e5ab
--- /dev/null
+++ b/t/t4252/am-test-3-1
@@ -0,0 +1,19 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Three
+
+Application of this should be rejected even with -p2 because the
+preimage line in the context does not match.
+
+diff --git i/junk/file-1 w/junk/file-1
+index 06e567b..10f8342 100644
+--- i/junk/file-1
++++ w/junk/file-1
+@@ -1,6 +1,6 @@
+ 1
+ 2
+-Tres
++Three 
+ 4
+ 5
+ 6
diff --git a/t/t4252/am-test-3-2 b/t/t4252/am-test-3-2
new file mode 100644
index 0000000..0081b96
--- /dev/null
+++ b/t/t4252/am-test-3-2
@@ -0,0 +1,21 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Six
+
+Applying this patch with -p2 should be successful even though
+the patch is against a wrong level.
+
+diff --git i/junk/file-2 w/junk/file-2
+index 06e567b..b6f3a16 100644
+--- i/junk/file-2
++++ w/junk/file-2
+@@ -1,7 +1,7 @@
+ 1
+ 2
+-3
++Three
+ 4
+ 5
+-6
++Six
+ 7
diff --git a/t/t4252/am-test-4-1 b/t/t4252/am-test-4-1
new file mode 100644
index 0000000..e48cd6c
--- /dev/null
+++ b/t/t4252/am-test-4-1
@@ -0,0 +1,19 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Three
+
+Application of this should be rejected even with -C1 -p2 because
+the preimage line in the context does not match.
+
+diff --git i/junk/file-1 w/junk/file-1
+index 06e567b..10f8342 100644
+--- i/junk/file-1
++++ w/junk/file-1
+@@ -1,6 +1,6 @@
+ 1
+ 2
+-Tres
++Three 
+ 4
+ 5
+ 6
diff --git a/t/t4252/am-test-4-2 b/t/t4252/am-test-4-2
new file mode 100644
index 0000000..0e69bfa
--- /dev/null
+++ b/t/t4252/am-test-4-2
@@ -0,0 +1,22 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Six
+
+Applying this patch with -C1 -p2 should be successful even though
+the patch is against a wrong level and the first context line does
+not match.
+
+diff --git i/junk/file-2 w/junk/file-2
+index 06e567b..b6f3a16 100644
+--- i/junk/file-2
++++ w/junk/file-2
+@@ -1,7 +1,7 @@
+ One
+ 2
+-3
++Three
+ 4
+ 5
+-6
++Six
+ 7
diff --git a/t/t4252/file-1-0 b/t/t4252/file-1-0
new file mode 100644
index 0000000..06e567b
--- /dev/null
+++ b/t/t4252/file-1-0
@@ -0,0 +1,7 @@
+1
+2
+3
+4
+5
+6
+7
diff --git a/t/t4252/file-2-0 b/t/t4252/file-2-0
new file mode 100644
index 0000000..06e567b
--- /dev/null
+++ b/t/t4252/file-2-0
@@ -0,0 +1,7 @@
+1
+2
+3
+4
+5
+6
+7
-- 
1.6.1.rc1.60.g1d1d7
