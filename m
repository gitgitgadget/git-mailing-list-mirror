From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/4] t4014: check for empty files from git format-patch --stdout
Date: Mon, 29 Aug 2011 22:10:46 +0200
Message-ID: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8Ab-0005R6-08
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab1H2UKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:10:51 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:55607 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885Ab1H2UKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:10:50 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:10:49 +0200
Received: from localhost.localdomain (129.132.153.219) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:10:49 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180340>

Most kinds of failure in 'git format-patch --stdout >output' will
result in an empty 'output'.  This slips past checks that only verify
absence of output, such as the '! grep ...' that are quite prevalent
in t4014.

Introduce a helper check_patch() that checks that at least From, Date
and Subject are present, thus making sure it looks vaguely like a
patch (or cover letter) email.  Then insert calls to it in all tests
that do have positive checks for content.

This makes two of the tests fail.  Mark them as such; they'll be
fixed in a moment.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I noticed "fatal: unrecognized argument: --no-add-headers" in the
slow-moving 'make valgrind' output, and unearthed some more
problems...  The other three patches are a corollary of this.

 t/t4014-format-patch.sh |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 92248d2..b4d4207 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -179,12 +179,21 @@ test_expect_success 'configuration To: header' '
 	grep "^To: R. E. Cipient <rcipient@example.com>\$" patch9
 '
 
+# check_patch <patch>: Verify that <patch> looks like a half-sane
+# patch email to avoid a false positive with !grep
+check_patch () {
+	grep -e "^From:" "$1" &&
+	grep -e "^Date:" "$1" &&
+	grep -e "^Subject:" "$1"
+}
+
 test_expect_success '--no-to overrides config.to' '
 
 	git config --replace-all format.to \
 		"R. E. Cipient <rcipient@example.com>" &&
 	git format-patch --no-to --stdout master..side |
 	sed -e "/^\$/q" >patch10 &&
+	check_patch patch10 &&
 	! grep "^To: R. E. Cipient <rcipient@example.com>\$" patch10
 '
 
@@ -195,6 +204,7 @@ test_expect_success '--no-to and --to replaces config.to' '
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
 		--stdout master..side |
 	sed -e "/^\$/q" >patch11 &&
+	check_patch patch11 &&
 	! grep "^To: Someone <someone@out.there>\$" patch11 &&
 	grep "^To: Someone Else <else@out.there>\$" patch11
 '
@@ -205,15 +215,17 @@ test_expect_success '--no-cc overrides config.cc' '
 		"C. E. Cipient <rcipient@example.com>" &&
 	git format-patch --no-cc --stdout master..side |
 	sed -e "/^\$/q" >patch12 &&
+	check_patch patch12 &&
 	! grep "^Cc: C. E. Cipient <rcipient@example.com>\$" patch12
 '
 
-test_expect_success '--no-add-headers overrides config.headers' '
+test_expect_failure '--no-add-headers overrides config.headers' '
 
 	git config --replace-all format.headers \
 		"Header1: B. E. Cipient <rcipient@example.com>" &&
 	git format-patch --no-add-headers --stdout master..side |
 	sed -e "/^\$/q" >patch13 &&
+	check_patch patch13 &&
 	! grep "^Header1: B. E. Cipient <rcipient@example.com>\$" patch13
 '
 
@@ -480,6 +492,7 @@ test_expect_success 'cover-letter inherits diff options' '
 	git mv file foo &&
 	git commit -m foo &&
 	git format-patch --cover-letter -1 &&
+	check_patch 0000-cover-letter.patch &&
 	! grep "file => foo .* 0 *\$" 0000-cover-letter.patch &&
 	git format-patch --cover-letter -1 -M &&
 	grep "file => foo .* 0 *\$" 0000-cover-letter.patch
@@ -657,6 +670,7 @@ test_expect_success 'format-patch --no-signature ignores format.signature' '
 	git config format.signature "config sig" &&
 	git format-patch --stdout --signature="my sig" --no-signature \
 		-1 >output &&
+	check_patch output &&
 	! grep "config sig" output &&
 	! grep "my sig" output &&
 	! grep "^-- \$" output
@@ -673,17 +687,20 @@ test_expect_success 'format-patch --signature --cover-letter' '
 test_expect_success 'format.signature="" supresses signatures' '
 	git config format.signature "" &&
 	git format-patch --stdout -1 >output &&
+	check_patch output &&
 	! grep "^-- \$" output
 '
 
 test_expect_success 'format-patch --no-signature supresses signatures' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --no-signature -1 >output &&
+	check_patch output &&
 	! grep "^-- \$" output
 '
 
-test_expect_success 'format-patch --signature="" supresses signatures' '
+test_expect_failure 'format-patch --signature="" supresses signatures' '
 	git format-patch --signature="" -1 >output &&
+	check_patch output &&
 	! grep "^-- \$" output
 '
 
-- 
1.7.7.rc0.370.gdcae57
