From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] test-lib: user-friendly alternatives to test [!] [-d|-f]
Date: Sat,  7 Aug 2010 10:56:05 +0200
Message-ID: <1281171365-15399-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqeiealsez.fsf@bauges.imag.fr>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 07 14:13:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhiGq-0004JG-9z
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 14:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761499Ab0HGI4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 04:56:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59161 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246Ab0HGI4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 04:56:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o778jsGm028283
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 7 Aug 2010 10:45:54 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OhfCj-0005S6-9E; Sat, 07 Aug 2010 10:56:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OhfCj-00041F-84; Sat, 07 Aug 2010 10:56:33 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <vpqeiealsez.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 07 Aug 2010 10:45:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o778jsGm028283
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281775557.38081@oXO3C/uNQiy91yMdkWlvKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152850>

The helper functions are implemented, documented, and used in a few
places to validate them, but not everywhere to avoid useless code churn.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
(this one hasn't been modified since last time)

 t/README                      |    8 ++++++++
 t/t3404-rebase-interactive.sh |   18 +++++++++---------
 t/t3407-rebase-abort.sh       |    6 +++---
 t/test-lib.sh                 |   32 ++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/t/README b/t/README
index 0d1183c..be760b9 100644
--- a/t/README
+++ b/t/README
@@ -467,6 +467,14 @@ library for your script to use.
    <expected> file.  This behaves like "cmp" but produces more
    helpful output when the test is run with "-v" option.
 
+ - test_file_must_exist <file> [<diagnosis>]
+   test_file_must_not_exist <file> [<diagnosis>]
+   test_dir_must_exist <dir> [<diagnosis>]
+   test_dir_must_not_exist <dir> [<diagnosis>]
+
+   check whether a file/directory exists or doesn't. <diagnosis> will
+   be displayed if the test fails.
+
  - test_when_finished <script>
 
    Prepend <script> to a list of commands to run to clean up
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7b0026e..aacdc8a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -69,18 +69,18 @@ test_expect_success 'rebase -i with the exec command' '
 	FAKE_LINES="1 exec_touch_touch-one 2 exec_touch_touch-two exec_false exec_touch_touch-three 3 4
 		exec_touch_\"touch-file__name_with_spaces\";_touch_touch-after-semicolon 5" \
 		test_must_fail git rebase -i A &&
-	test -f touch-one &&
-	test -f touch-two &&
-	! test -f touch-three &&
+	test_file_must_exist touch-one &&
+	test_file_must_exist touch-two &&
+	test_file_must_not_exist touch-three "(Rebase should have stopped before)" &&
 	test $(git rev-parse C) = $(git rev-parse HEAD) || {
 		echo "Stopped at wrong revision:"
 		echo "($(git describe --tags HEAD) instead of C)"
 		false
 	} &&
 	git rebase --continue &&
-	test -f touch-three &&
-	test -f "touch-file  name with spaces" &&
-	test -f touch-after-semicolon &&
+	test_file_must_exist touch-three &&
+	test_file_must_exist "touch-file  name with spaces" &&
+	test_file_must_exist touch-after-semicolon &&
 	test $(git rev-parse master) = $(git rev-parse HEAD) || {
 		echo "Stopped at wrong revision:"
 		echo "($(git describe --tags HEAD) instead of master)"
@@ -95,7 +95,7 @@ test_expect_success 'rebase -i with the exec command runs from tree root' '
 	FAKE_LINES="1 exec_touch_touch-subdir" \
 		git rebase -i HEAD^ &&
 	cd .. &&
-	test -f touch-subdir &&
+	test_file_must_exist touch-subdir &&
 	rm -fr subdir
 '
 
@@ -191,7 +191,7 @@ test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
-	! test -d .git/rebase-merge
+	test_dir_must_not_exist .git/rebase-merge
 '
 
 test_expect_success 'abort with error when new base cannot be checked out' '
@@ -200,7 +200,7 @@ test_expect_success 'abort with error when new base cannot be checked out' '
 	test_must_fail git rebase -i master > output 2>&1 &&
 	grep "Untracked working tree file .file1. would be overwritten" \
 		output &&
-	! test -d .git/rebase-merge &&
+	test_dir_must_not_exist .git/rebase-merge &&
 	git reset --hard HEAD^
 '
 
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 2999e78..0ca81fe 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -38,7 +38,7 @@ testrebase() {
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type master &&
-		test -d "$dotest" &&
+		test_dir_must_exist "$dotest" &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
 		test ! -d "$dotest"
@@ -49,7 +49,7 @@ testrebase() {
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type master &&
-		test -d "$dotest" &&
+		test_dir_must_exist "$dotest" &&
 		test_must_fail git rebase --skip &&
 		test $(git rev-parse HEAD) = $(git rev-parse master) &&
 		git rebase --abort &&
@@ -62,7 +62,7 @@ testrebase() {
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type master &&
-		test -d "$dotest" &&
+		test_dir_must_exist "$dotest" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e8f21d5..694bbe8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -541,6 +541,38 @@ test_external_without_stderr () {
 	fi
 }
 
+# debugging-friendly alternatives to "test [!] [-f|-d]"
+# The commands test the existence or non-existance of $1. $2 can be
+# given to provide a more precise diagnosis.
+test_file_must_exist () {
+	if ! [ -f "$1" ]; then
+		echo "file $1 doesn't exist. $*"
+		false
+	fi
+}
+
+test_file_must_not_exist () {
+	if [ -f "$1" ]; then
+		echo "file $1 exists. $*"
+		false
+	fi
+}
+
+test_dir_must_exist () {
+	if ! [ -d "$1" ]; then
+		echo "directory $1 doesn't exist. $*"
+		false
+	fi
+}
+
+test_dir_must_not_exist () {
+	if [ -d "$1" ]; then
+		echo "directory $1 exists. $*"
+		false
+	fi
+}
+
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #
-- 
1.7.2.1.52.g95e25.dirty
