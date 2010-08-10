From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] test-lib: user-friendly alternatives to test [-d|-f|-e]
Date: Tue, 10 Aug 2010 13:00:55 +0200
Message-ID: <1281438055-6971-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vvd7j7nys.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 10 13:01:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oimae-0007Oc-AV
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 13:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab0HJLBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 07:01:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49249 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555Ab0HJLBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 07:01:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7AAwXKL018330
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Aug 2010 12:58:33 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OimZm-0008Oe-Rn; Tue, 10 Aug 2010 13:00:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OimZm-0001p5-P9; Tue, 10 Aug 2010 13:00:58 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <7vvd7j7nys.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 10 Aug 2010 12:58:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7AAwXKL018330
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1282042717.66918@lOwz1evF/jScUZSHbRKEXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153090>

The helper functions are implemented, documented, and used in a few
places to validate them, but not everywhere to avoid useless code churn.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> I'd say we would probably want three primitives instead of four:
> 
>     test_path_is_file        <path>
>     test_path_is_directory   <path>
>     test_path_is_missing     <path>

I buy this. Thanks,

 t/README                      |    7 +++++++
 t/t3404-rebase-interactive.sh |   18 +++++++++---------
 t/t3407-rebase-abort.sh       |    6 +++---
 t/test-lib.sh                 |   32 ++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/t/README b/t/README
index 0d1183c..410499a 100644
--- a/t/README
+++ b/t/README
@@ -467,6 +467,13 @@ library for your script to use.
    <expected> file.  This behaves like "cmp" but produces more
    helpful output when the test is run with "-v" option.
 
+ - test_path_is_file <file> [<diagnosis>]
+   test_path_is_dir <dir> [<diagnosis>]
+   test_path_is_missing <path> [<diagnosis>]
+
+   Check whether a file/directory exists or doesn't. <diagnosis> will
+   be displayed if the test fails.
+
  - test_when_finished <script>
 
    Prepend <script> to a list of commands to run to clean up
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7b0026e..f78c364 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -69,18 +69,18 @@ test_expect_success 'rebase -i with the exec command' '
 	FAKE_LINES="1 exec_touch_touch-one 2 exec_touch_touch-two exec_false exec_touch_touch-three 3 4
 		exec_touch_\"touch-file__name_with_spaces\";_touch_touch-after-semicolon 5" \
 		test_must_fail git rebase -i A &&
-	test -f touch-one &&
-	test -f touch-two &&
-	! test -f touch-three &&
+	test_path_is_file touch-one &&
+	test_path_is_file touch-two &&
+	test_path_is_missing touch-three "(Rebase should have stopped before)" &&
 	test $(git rev-parse C) = $(git rev-parse HEAD) || {
 		echo "Stopped at wrong revision:"
 		echo "($(git describe --tags HEAD) instead of C)"
 		false
 	} &&
 	git rebase --continue &&
-	test -f touch-three &&
-	test -f "touch-file  name with spaces" &&
-	test -f touch-after-semicolon &&
+	test_path_is_file touch-three &&
+	test_path_is_file "touch-file  name with spaces" &&
+	test_path_is_file touch-after-semicolon &&
 	test $(git rev-parse master) = $(git rev-parse HEAD) || {
 		echo "Stopped at wrong revision:"
 		echo "($(git describe --tags HEAD) instead of master)"
@@ -95,7 +95,7 @@ test_expect_success 'rebase -i with the exec command runs from tree root' '
 	FAKE_LINES="1 exec_touch_touch-subdir" \
 		git rebase -i HEAD^ &&
 	cd .. &&
-	test -f touch-subdir &&
+	test_path_is_file touch-subdir &&
 	rm -fr subdir
 '
 
@@ -191,7 +191,7 @@ test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
-	! test -d .git/rebase-merge
+	test_path_is_missing .git/rebase-merge
 '
 
 test_expect_success 'abort with error when new base cannot be checked out' '
@@ -200,7 +200,7 @@ test_expect_success 'abort with error when new base cannot be checked out' '
 	test_must_fail git rebase -i master > output 2>&1 &&
 	grep "Untracked working tree file .file1. would be overwritten" \
 		output &&
-	! test -d .git/rebase-merge &&
+	test_path_is_missing .git/rebase-merge &&
 	git reset --hard HEAD^
 '
 
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 2999e78..fbb3f2e 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -38,7 +38,7 @@ testrebase() {
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type master &&
-		test -d "$dotest" &&
+		test_path_is_dir "$dotest" &&
 		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
 		test ! -d "$dotest"
@@ -49,7 +49,7 @@ testrebase() {
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type master &&
-		test -d "$dotest" &&
+		test_path_is_dir "$dotest" &&
 		test_must_fail git rebase --skip &&
 		test $(git rev-parse HEAD) = $(git rev-parse master) &&
 		git rebase --abort &&
@@ -62,7 +62,7 @@ testrebase() {
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type master &&
-		test -d "$dotest" &&
+		test_path_is_dir "$dotest" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e8f21d5..a2173dd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -541,6 +541,38 @@ test_external_without_stderr () {
 	fi
 }
 
+# debugging-friendly alternatives to "test [-f|-d|-e]"
+# The commands test the existence or non-existance of $1. $2 can be
+# given to provide a more precise diagnosis.
+test_path_is_file () {
+	if ! [ -f "$1" ]
+	then
+		echo "File $1 doesn't exist. $*"
+		false
+	fi
+}
+
+test_path_is_dir () {
+	if ! [ -d "$1" ]
+	then
+		echo "Directory $1 doesn't exist. $*"
+		false
+	fi
+}
+
+test_path_is_missing () {
+	if [ -e "$1" ]
+	then
+		echo "Path exists:"
+		ls -ld "$1"
+		if [ $# -ge 1 ]; then
+			echo "$*"
+		fi
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
