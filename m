From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t7510: Skip all if GPG isn't installed
Date: Tue, 24 Jun 2014 00:52:16 -0400
Message-ID: <1403585536-32185-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:00:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzIq0-0006Ru-LR
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 07:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbaFXFAC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 01:00:02 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52879 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaFXFAB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 01:00:01 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2014 01:00:01 EDT
Received: from localhost.localdomain (c-50-133-228-236.hsd1.ma.comcast.net [50.133.228.236])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 738AF16218A7;
	Tue, 24 Jun 2014 04:52:20 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.582.g8574df7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252385>

Since the setup requires the GPG prerequisite, it doesn't make much
sense to try and run any tests without it.  So rather than using a
prereq on each individual test and possibly forgetting it on new ones
(as just happened), skip the entire file if GPG isn't found.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t7510-signed-commit.sh | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 9810242..414f9d1 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -4,7 +4,13 @@ test_description='signed commit tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-test_expect_success GPG 'create signed commits' '
+if ! test_have_prereq GPG
+then
+	skip_all='skipping signed commit tests; gpg not available'
+	test_done
+fi
+
+test_expect_success 'create signed commits' '
 	test_when_finished "test_unconfig commit.gpgsign" &&
 
 	echo 1 >file && git add file &&
@@ -48,7 +54,7 @@ test_expect_success GPG 'create signed commits' '
 	git tag eighth-signed-alt
 '
 
-test_expect_success GPG 'show signatures' '
+test_expect_success 'show signatures' '
 	(
 		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
 		do
@@ -79,7 +85,7 @@ test_expect_success GPG 'show signatures' '
 	)
 '
 
-test_expect_success GPG 'detect fudged signature' '
+test_expect_success 'detect fudged signature' '
 	git cat-file commit seventh-signed >raw &&
 
 	sed -e "s/seventh/7th forged/" raw >forged1 &&
@@ -89,7 +95,7 @@ test_expect_success GPG 'detect fudged signature' '
 	! grep "Good signature from" actual1
 '
 
-test_expect_success GPG 'detect fudged signature with NUL' '
+test_expect_success 'detect fudged signature with NUL' '
 	git cat-file commit seventh-signed >raw &&
 	cat raw >forged2 &&
 	echo Qwik | tr "Q" "\000" >>forged2 &&
@@ -99,7 +105,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
 	! grep "Good signature from" actual2
 '
 
-test_expect_success GPG 'amending already signed commit' '
+test_expect_success 'amending already signed commit' '
 	git checkout fourth-signed^0 &&
 	git commit --amend -S --no-edit &&
 	git show -s --show-signature HEAD >actual &&
@@ -107,7 +113,7 @@ test_expect_success GPG 'amending already signed commit' '
 	! grep "BAD signature from" actual
 '
 
-test_expect_success GPG 'show good signature with custom format' '
+test_expect_success 'show good signature with custom format' '
 	cat >expect <<-\EOF &&
 	G
 	13B6F51ECDDE430D
@@ -117,7 +123,7 @@ test_expect_success GPG 'show good signature with custom format' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'show bad signature with custom format' '
+test_expect_success 'show bad signature with custom format' '
 	cat >expect <<-\EOF &&
 	B
 	13B6F51ECDDE430D
@@ -127,7 +133,7 @@ test_expect_success GPG 'show bad signature with custom format' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'show unknown signature with custom format' '
+test_expect_success 'show unknown signature with custom format' '
 	cat >expect <<-\EOF &&
 	U
 	61092E85B7227189
@@ -137,7 +143,7 @@ test_expect_success GPG 'show unknown signature with custom format' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG 'show lack of signature with custom format' '
+test_expect_success 'show lack of signature with custom format' '
 	cat >expect <<-\EOF &&
 	N
 
-- 
2.0.0.495.gf681aa8
