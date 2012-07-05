From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 04/12] git-remote-mediawiki (t9361): test git-remote-mediawiki pull and push
Date: Thu,  5 Jul 2012 09:36:04 +0200
Message-ID: <1341473772-28023-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:36:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmgcO-0000ir-BV
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab2GEHgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:36:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58604 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753Ab2GEHgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:36:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q657ZVvK029163
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:32 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Smgc5-0006Xf-5H; Thu, 05 Jul 2012 09:36:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Smgc5-0007i2-3J; Thu, 05 Jul 2012 09:36:33 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Jul 2012 09:35:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ZVvK029163
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078535.29515@7AdH2U581rH5Xo0ma5w3sg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201026>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

This patch provides a set of tests for the pull and push fonctionnality
of git-remote-mediawiki. The actual tests are kept in a separate function
to allow further tests to re-run the same set of commands with different
push and pull strategies.

Signed-off-by: Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/t/push-pull-tests.sh           | 144 +++++++++++++++++++++++
 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh |  24 ++++
 2 files changed, 168 insertions(+)
 create mode 100644 contrib/mw-to-git/t/push-pull-tests.sh
 create mode 100755 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh

diff --git a/contrib/mw-to-git/t/push-pull-tests.sh b/contrib/mw-to-git/t/push-pull-tests.sh
new file mode 100644
index 0000000..b9e38dc
--- /dev/null
+++ b/contrib/mw-to-git/t/push-pull-tests.sh
@@ -0,0 +1,144 @@
+test_push_pull () {
+
+	test_expect_success 'Git pull works after adding a new wiki page' '
+		wiki_reset &&
+	
+		git clone mediawiki::'"$WIKI_URL"' mw_dir_1 &&
+		wiki_editpage Foo "page created after the git clone" false &&
+	
+		(
+			cd mw_dir_1 &&
+			git pull
+		) &&
+	
+		wiki_getallpage ref_page_1 &&
+		test_diff_directories mw_dir_1 ref_page_1
+	'
+
+	test_expect_success 'Git pull works after editing a wiki page' '
+		wiki_reset &&
+	
+		wiki_editpage Foo "page created before the git clone" false &&
+		git clone mediawiki::'"$WIKI_URL"' mw_dir_2 &&
+		wiki_editpage Foo "new line added on the wiki" true &&
+	
+		(
+			cd mw_dir_2 &&
+			git pull
+		) &&
+	
+		wiki_getallpage ref_page_2 &&
+		test_diff_directories mw_dir_2 ref_page_2
+	'
+
+	test_expect_success 'git pull works on conflict handled by auto-merge' '
+		wiki_reset &&
+	
+		wiki_editpage Foo "1 init
+3
+5
+	" false &&
+		git clone mediawiki::'"$WIKI_URL"' mw_dir_3 &&
+	
+		wiki_editpage Foo "1 init
+2 content added on wiki after clone
+3
+5
+	" false &&
+	
+		(
+			cd mw_dir_3 &&
+		echo "1 init
+3
+4 content added on git after clone
+5
+" >Foo.mw &&
+			git commit -am "conflicting change on foo" &&
+			git pull &&
+			git push
+		)
+	'
+
+	test_expect_success 'Git push works after adding a file .mw' '
+		wiki_reset &&
+		git clone mediawiki::'"$WIKI_URL"' mw_dir_4 &&
+		wiki_getallpage ref_page_4 &&
+		(
+			cd mw_dir_4 &&
+			test ! -f Foo.mw &&
+			touch Foo.mw &&
+			echo "hello world" >>Foo.mw &&
+			git add Foo.mw &&
+			git commit -m "Foo" &&
+			git push
+		) &&
+		wiki_getallpage ref_page_4 &&
+		test_diff_directories mw_dir_4 ref_page_4
+	'
+
+	test_expect_success 'Git push works after editing a file .mw' '
+		wiki_reset &&
+		wiki_editpage "Foo" "page created before the git clone" false &&
+		git clone mediawiki::'"$WIKI_URL"' mw_dir_5 &&
+	
+		(
+			cd mw_dir_5 &&
+			echo "new line added in the file Foo.mw" >>Foo.mw &&
+			git commit -am "edit file Foo.mw" &&
+			git push
+		) &&
+	
+		wiki_getallpage ref_page_5 &&
+		test_diff_directories mw_dir_5 ref_page_5
+	'
+
+	test_expect_failure 'Git push works after deleting a file' '
+		wiki_reset &&
+		wiki_editpage Foo "wiki page added before git clone" false &&
+		git clone mediawiki::'"$WIKI_URL"' mw_dir_6 &&
+	
+		(
+			cd mw_dir_6 &&
+			git rm Foo.mw &&
+			git commit -am "page Foo.mw deleted" &&
+			git push
+		) &&
+	
+		test ! wiki_page_exist Foo
+	'
+
+	test_expect_success 'Merge conflict expected and solving it' '
+		wiki_reset &&
+	
+		git clone mediawiki::'"$WIKI_URL"' mw_dir_7 &&
+		wiki_editpage Foo "1 conflict
+3 wiki
+4" false &&
+	
+		(
+			cd mw_dir_7 &&
+		echo "1 conflict
+2 git
+4" >Foo.mw &&
+			git add Foo.mw &&
+			git commit -m "conflict created" &&
+			test_must_fail git pull &&
+			perl -pi -e "s/[<=>].*//g" Foo.mw &&
+			git commit -am "merge conflict solved" &&
+			git push
+		)
+	'
+
+	test_expect_failure 'git pull works after deleting a wiki page' '
+		wiki_reset &&
+		wiki_editpage Foo "wiki page added before the git clone" false &&
+		git clone mediawiki::'"$WIKI_URL"' mw_dir_8 &&
+	
+		wiki_delete_page Foo &&
+		(
+			cd mw_dir_8 &&
+			git pull &&
+			test ! -f Foo.mw
+		)
+	'
+}
diff --git a/contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh b/contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh
new file mode 100755
index 0000000..9ea2014
--- /dev/null
+++ b/contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#
+# License: GPL v2 or later
+
+# tests for git-remote-mediawiki
+
+test_description='Test the Git Mediawiki remote helper: git push and git pull simple test cases'
+
+. ./test-gitmw-lib.sh
+. ./push-pull-tests.sh
+. $TEST_DIRECTORY/test-lib.sh
+
+test_check_precond
+
+test_push_pull
+
+test_done
-- 
1.7.11.1.147.g47a574d
