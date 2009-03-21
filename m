From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 06/16] t3600: Use test prerequisite tags
Date: Sat, 21 Mar 2009 22:26:29 +0100
Message-ID: <70f789fecee6955c362391b33272223c7ba74cc6.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:28:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8kI-0003u8-AE
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbZCUV1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755147AbZCUV1N
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27926 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4DB78CDF82;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1B8055BC07;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114061>

The are two prerequisites.

- The filesystem support names with tabs or new-lines.

- Files cannot be removed if their containing directory is read-only.

Previously, whether these preconditions are satisified was tested inside
test_expect_success. We move these tests outside because, strictly
speaking, they are not part of the tests.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3600-rm.sh |   58 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 2aefbcf..76b1bb4 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -12,31 +12,37 @@ test_expect_success \
     'Initialize test directory' \
     "touch -- foo bar baz 'space embedded' -q &&
      git add -- foo bar baz 'space embedded' -q &&
-     git commit -m 'add normal files' &&
-     test_tabs=y &&
-     if touch -- 'tab	embedded' 'newline
-embedded'
-     then
+     git commit -m 'add normal files'"
+
+if touch -- 'tab	embedded' 'newline
+embedded' 2>/dev/null
+then
+	test_set_prereq FUNNYNAMES
+else
+	say 'Your filesystem does not allow tabs in filenames.'
+fi
+
+test_expect_success FUNNYNAMES 'add files with funny names' "
      git add -- 'tab	embedded' 'newline
 embedded' &&
      git commit -m 'add files with tabs and newlines'
-     else
-         test_tabs=n
-     fi"
-
-test "$test_tabs" = n && say 'Your filesystem does not allow tabs in filenames.'
+"
 
+# Determine rm behavior
 # Later we will try removing an unremovable path to make sure
 # git rm barfs, but if the test is run as root that cannot be
 # arranged.
-test_expect_success \
-    'Determine rm behavior' \
-    ': >test-file
-     chmod a-w .
-     rm -f test-file
-     test -f test-file && test_failed_remove=y
-     chmod 775 .
-     rm -f test-file'
+: >test-file
+chmod a-w .
+rm -f test-file 2>/dev/null
+if test -f test-file
+then
+	test_set_prereq RO_DIR
+else
+	say 'skipping removal failure test (perhaps running as root?)'
+fi
+chmod 775 .
+rm -f test-file
 
 test_expect_success \
     'Pre-check that foo exists and is in index before git rm foo' \
@@ -101,20 +107,16 @@ test_expect_success \
     'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
     'git rm -- -q'
 
-test "$test_tabs" = y && test_expect_success \
+test_expect_success FUNNYNAMES \
     "Test that \"git rm -f\" succeeds with embedded space, tab, or newline characters." \
     "git rm -f 'space embedded' 'tab	embedded' 'newline
 embedded'"
 
-if test "$test_failed_remove" = y; then
-chmod a-w .
-test_expect_success \
-    'Test that "git rm -f" fails if its rm fails' \
-    'test_must_fail git rm -f baz'
-chmod 775 .
-else
-    say 'skipping removal failure test (perhaps running as root?)'
-fi
+test_expect_success RO_DIR 'Test that "git rm -f" fails if its rm fails' '
+	chmod a-w . &&
+	test_must_fail git rm -f baz &&
+	chmod 775 .
+'
 
 test_expect_success \
     'When the rm in "git rm -f" fails, it should not remove the file from the index' \
-- 
1.6.2.1.224.g2225f
