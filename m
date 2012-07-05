From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 07/12] git-remote-mediawiki (t9363): test 'File:' import and export
Date: Thu,  5 Jul 2012 09:36:07 +0200
Message-ID: <1341473772-28023-8-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:37:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smgcu-0001cS-PL
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab2GEHhC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:37:02 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38990 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628Ab2GEHg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:36:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q657ZbZu011257
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:37 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcJ-0006Zw-G7; Thu, 05 Jul 2012 09:36:47 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcJ-0007jz-EJ; Thu, 05 Jul 2012 09:36:47 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Jul 2012 09:35:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ZbZu011257
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078541.05847@8C+F2F/5qly+DG8xZxtVFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201031>

From: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 .../mw-to-git/t/t9363-mw-to-git-export-import.sh   | 198 +++++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100755 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh

diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
new file mode 100755
index 0000000..3a4dce1
--- /dev/null
+++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
@@ -0,0 +1,198 @@
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
+. $TEST_DIRECTORY/test-lib.sh
+
+
+test_check_precond
+
+
+test_git_reimport () {
+	git -c remote.origin.dumbPush=true push &&
+	git -c remote.origin.mediaImport=true pull --rebase
+}
+
+# Don't bother with permissions, be administrator by default
+test_expect_success 'setup config' '
+	git config --global remote.origin.mwLogin WikiAdmin &&
+	git config --global remote.origin.mwPassword AdminPass &&
+	test_might_fail git config --global --unset remote.origin.mediaImport
+'
+
+test_expect_success 'git push can upload media (File:) files' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
+	(
+		cd mw_dir &&
+		echo "hello world" >Foo.txt &&
+		git add Foo.txt &&
+		git commit -m "add a text file" &&
+		git push &&
+		perl -e "print STDOUT \"binary content: \".chr(255);" >Foo.txt &&
+		git add Foo.txt &&
+		git commit -m "add a text file with binary content" &&
+		git push
+	)
+'
+
+test_expect_success 'git clone works on previously created wiki with media files' '
+	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
+	git clone -c remote.origin.mediaimport=true \
+		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
+	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt &&
+	(cd mw_dir_clone && git checkout HEAD^) &&
+	(cd mw_dir && git checkout HEAD^) &&
+	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt
+'
+
+test_expect_success 'git push & pull work with locally renamed media files' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
+	test_when_finished "rm -fr mw_dir" &&
+	(
+		cd mw_dir &&
+		echo "A File" >Foo.txt &&
+		git add Foo.txt &&
+		git commit -m "add a file" &&
+		git mv Foo.txt Bar.txt &&
+		git commit -m "Rename a file" &&
+		test_git_reimport &&
+		echo "A File" >expect &&
+		test_cmp expect Bar.txt &&
+		test_path_is_missing Foo.txt
+	)
+'
+
+test_expect_success 'git push can propagate local page deletion' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
+	test_when_finished "rm -fr mw_dir" &&
+	(
+		cd mw_dir &&
+		test_path_is_missing Foo.mw &&
+		echo "hello world" >Foo.mw &&
+		git add Foo.mw &&
+		git commit -m "Add the page Foo" &&
+		git push &&
+		rm -f Foo.mw &&
+		git commit -am "Delete the page Foo" &&
+		test_git_reimport &&
+		test_path_is_missing Foo.mw
+	)
+'
+
+test_expect_success 'git push can propagate local media file deletion' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
+	test_when_finished "rm -fr mw_dir" &&
+	(
+		cd mw_dir &&
+		echo "hello world" >Foo.txt &&
+		git add Foo.txt &&
+		git commit -m "Add the text file Foo" &&
+		git rm Foo.txt &&
+		git commit -m "Delete the file Foo" &&
+		test_git_reimport &&
+		test_path_is_missing Foo.txt
+	)
+'
+
+# test failure: the file is correctly uploaded, and then deleted but
+# as no page link to it, the import (which looks at page revisions)
+# doesn't notice the file deletion on the wiki. We fetch the list of
+# files from the wiki, but as the file is deleted, it doesn't appear.
+test_expect_failure 'git pull correctly imports media file deletion when no page link to it' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
+	test_when_finished "rm -fr mw_dir" &&
+	(
+		cd mw_dir &&
+		echo "hello world" >Foo.txt &&
+		git add Foo.txt &&
+		git commit -m "Add the text file Foo" &&
+		git push &&
+		git rm Foo.txt &&
+		git commit -m "Delete the file Foo" &&
+		test_git_reimport &&
+		test_path_is_missing Foo.txt
+	)
+'
+
+test_expect_success 'git push properly warns about insufficient permissions' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir &&
+	test_when_finished "rm -fr mw_dir" &&
+	(
+		cd mw_dir &&
+		echo "A File" >foo.forbidden &&
+		git add foo.forbidden &&
+		git commit -m "add a file" &&
+		git push 2>actual &&
+		test_i18ngrep "foo.forbidden is not a permitted file" actual
+	)
+'
+
+test_expect_success 'setup a repository with media files' '
+	wiki_reset &&
+	wiki_editpage testpage "I am linking a file [[File:File.txt]]" false &&
+	echo "File content" >File.txt &&
+	wiki_upload_file File.txt &&
+	echo "Another file content" >AnotherFile.txt &&
+	wiki_upload_file AnotherFile.txt
+'
+
+test_expect_success 'git clone works with one specific page cloned and mediaimport=true' '
+	git clone -c remote.origin.pages=testpage \
+		  -c remote.origin.mediaimport=true \
+			mediawiki::'"$WIKI_URL"' mw_dir_15 &&
+	test_when_finished "rm -rf mw_dir_15" &&
+	test_contains_N_files mw_dir_15 3 &&
+	test_path_is_file mw_dir_15/Testpage.mw &&
+	test_path_is_file mw_dir_15/File:File.txt.mw &&
+	test_path_is_file mw_dir_15/File.txt &&
+	test_path_is_missing mw_dir_15/Main_Page.mw &&
+	test_path_is_missing mw_dir_15/File:AnotherFile.txt.mw &&
+	test_path_is_missing mw_dir_15/AnothetFile.txt &&
+	wiki_check_content mw_dir_15/Testpage.mw Testpage &&
+	test_cmp mw_dir_15/File.txt File.txt
+'
+
+test_expect_success 'git clone works with one specific page cloned and mediaimport=false' '
+	test_when_finished "rm -rf mw_dir_16" &&
+	git clone -c remote.origin.pages=testpage \
+			mediawiki::'"$WIKI_URL"' mw_dir_16 &&
+	test_contains_N_files mw_dir_16 1 &&
+	test_path_is_file mw_dir_16/Testpage.mw &&
+	test_path_is_missing mw_dir_16/File:File.txt.mw &&
+	test_path_is_missing mw_dir_16/File.txt &&
+	test_path_is_missing mw_dir_16/Main_Page.mw &&
+	wiki_check_content mw_dir_16/Testpage.mw Testpage
+'
+
+# should behave like mediaimport=false
+test_expect_success 'git clone works with one specific page cloned and mediaimport unset' '
+	test_when_finished "rm -fr mw_dir_17" &&
+	git clone -c remote.origin.pages=testpage \
+		mediawiki::'"$WIKI_URL"' mw_dir_17 &&
+	test_contains_N_files mw_dir_17 1 &&
+	test_path_is_file mw_dir_17/Testpage.mw &&
+	test_path_is_missing mw_dir_17/File:File.txt.mw &&
+	test_path_is_missing mw_dir_17/File.txt &&
+	test_path_is_missing mw_dir_17/Main_Page.mw &&
+	wiki_check_content mw_dir_17/Testpage.mw Testpage
+'
+
+test_done
-- 
1.7.11.1.147.g47a574d
