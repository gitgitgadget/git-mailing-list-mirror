From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/5 v2] t7609: test merge and checkout error messages
Date: Wed, 11 Aug 2010 10:38:08 +0200
Message-ID: <1281515888-31089-5-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq8w4fse8w.fsf@bauges.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 11 10:44:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6uo-0004m1-1y
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803Ab0HKInv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 04:43:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:38590 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801Ab0HKInu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 04:43:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7B8eBEs019661
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Aug 2010 10:40:11 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6r4-000282-V2; Wed, 11 Aug 2010 10:40:10 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oj6r4-00086g-Tw; Wed, 11 Aug 2010 10:40:10 +0200
X-Mailer: git-send-email 1.7.2.1.52.g95e25.dirty
In-Reply-To: <vpq8w4fse8w.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 11 Aug 2010 10:40:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153213>

From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>

Test porcelain and plumbing error messages for different types of errors
of merge and checkout.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7609-merge-co-error-msgs.sh |  125 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100755 t/t7609-merge-co-error-msgs.sh

diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
new file mode 100755
index 0000000..1a109b4
--- /dev/null
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -0,0 +1,125 @@
+#!/bin/sh
+
+test_description='unpack-trees error messages'
+
+. ./test-lib.sh
+
+
+test_expect_success 'setup' '
+	echo one >one &&
+	git add one &&
+	git commit -a -m First &&
+
+	git checkout -b branch &&
+	echo two >two &&
+	echo three >three &&
+	echo four >four &&
+	echo five >five &&
+	git add two three four five &&
+	git commit -m Second &&
+
+	git checkout master &&
+	echo other >two &&
+	echo other >three &&
+	echo other >four &&
+	echo other >five
+'
+
+cat >expect <<\EOF
+error: The following untracked working tree files would be overwritten by merge:
+	two
+	three
+	four
+	five
+Please move or remove them before you can merge.
+EOF
+
+test_expect_success 'untracked files overwritten by merge' '
+	test_must_fail git merge branch 2>out &&
+	test_cmp out expect
+'
+
+cat >expect <<\EOF
+error: Your local changes to the following files would be overwritten by merge:
+	two
+	three
+	four
+Please, commit your changes or stash them before you can merge.
+error: The following untracked working tree files would be overwritten by merge:
+	five
+Please move or remove them before you can merge.
+EOF
+
+test_expect_success 'untracked files or local changes ovewritten by merge' '
+	git add two &&
+	git add three &&
+	git add four &&
+	test_must_fail git merge branch 2>out &&
+	test_cmp out expect
+'
+
+cat >expect <<\EOF
+error: Your local changes to the following files would be overwritten by checkout:
+	rep/two
+	rep/one
+Please, commit your changes or stash them before you can switch branches.
+EOF
+
+test_expect_success 'cannot switch branches because of local changes' '
+	git add five &&
+	mkdir rep &&
+	echo one >rep/one &&
+	echo two >rep/two &&
+	git add rep/one rep/two &&
+	git commit -m Fourth &&
+	git checkout master &&
+	echo uno >rep/one &&
+	echo dos >rep/two &&
+	test_must_fail git checkout branch 2>out &&
+	test_cmp out expect
+'
+
+cat >expect <<\EOF
+error: Your local changes to the following files would be overwritten by checkout:
+	rep/two
+	rep/one
+Please, commit your changes or stash them before you can switch branches.
+EOF
+
+test_expect_success 'not uptodate file porcelain checkout error' '
+	git add rep/one rep/two &&
+	test_must_fail git checkout branch 2>out &&
+	test_cmp out expect
+'
+
+cat >expect <<\EOF
+error: Updating the following directories would lose untracked files in it:
+	rep2
+	rep
+
+EOF
+
+test_expect_success 'not_uptodate_dir porcelain checkout error' '
+	git init uptodate &&
+	cd uptodate &&
+	mkdir rep &&
+	mkdir rep2 &&
+	touch rep/foo &&
+	touch rep2/foo &&
+	git add rep/foo rep2/foo &&
+	git commit -m init &&
+	git checkout -b branch &&
+	git rm rep -r &&
+	git rm rep2 -r &&
+	>rep &&
+	>rep2 &&
+	git add rep rep2&&
+	git commit -m "added test as a file" &&
+	git checkout master &&
+	>rep/untracked-file &&
+	>rep2/untracked-file &&
+	test_must_fail git checkout branch 2>out &&
+	test_cmp out ../expect
+'
+
+test_done
-- 
1.7.2.1.52.g95e25.dirty
