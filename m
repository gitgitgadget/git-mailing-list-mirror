From: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
Subject: [PATCH] git-svn: Add test for --ignore-paths parameter
Date: Mon, 26 Jan 2009 00:21:42 +0200
Message-ID: <1232922102-6144-3-git-send-email-public_vi@tut.by>
References: <1232922102-6144-1-git-send-email-public_vi@tut.by>
 <1232922102-6144-2-git-send-email-public_vi@tut.by>
Cc: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 23:26:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDR4-0003cx-TQ
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbZAYWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbZAYWZH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:25:07 -0500
Received: from mail.tut.by ([195.137.160.40]:53381 "EHLO speedy.tutby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbZAYWZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:25:05 -0500
Received: from [91.149.148.191] (account public_vi@tut.by HELO localhost.localdomain)
  by speedy.tutby.com (CommuniGate Pro SMTP 5.1.12)
  with ESMTPSA id 136627234; Mon, 26 Jan 2009 00:22:15 +0200
X-Mailer: git-send-email 1.6.1.288.gff3b4
In-Reply-To: <1232922102-6144-2-git-send-email-public_vi@tut.by>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107111>

Added a test for this option, similar to (and based on) t9133 about ignorance of .git directories

Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>
---
 t/t9134-git-svn-ignore-paths.sh |   97 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100755 t/t9134-git-svn-ignore-paths.sh

diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
new file mode 100755
index 0000000..094cb6a
--- /dev/null
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong
+#
+
+test_description='git svn property tests'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup test repository' '
+	svn co "$svnrepo" s &&
+	(
+		cd s &&
+		mkdir qqq www &&
+		echo test_qqq > qqq/test_qqq.txt &&
+		echo test_www > www/test_www.txt &&
+		svn add qqq &&
+		svn add www &&
+		svn commit -m "create some files" &&
+		svn up &&
+		echo hi >> www/test_www.txt &&
+		svn commit -m "modify www/test_www.txt" &&
+		svn up
+	)
+'
+
+test_expect_success 'clone an SVN repository with ignored www directory' '
+	git svn clone --ignore-paths="^www" "$svnrepo" g &&
+	echo test_qqq > expect &&
+	for i in g/*/*.txt; do cat $i >> expect2; done &&
+	test_cmp expect expect2
+'
+
+test_expect_success 'SVN-side change outside of www' '
+	(
+		cd s &&
+		echo b >> qqq/test_qqq.txt &&
+		svn commit -m "SVN-side change outside of www" &&
+		svn up &&
+		svn log -v | fgrep "SVN-side change outside of www"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo' '
+	(
+		cd g &&
+		git svn rebase --ignore-paths="^www" &&
+		echo -e "test_qqq\nb" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'SVN-side change inside of ignored www' '
+	(
+		cd s &&
+		echo zaq >> www/test_www.txt
+		svn commit -m "SVN-side change inside of www/test_www.txt" &&
+		svn up &&
+		svn log -v | fgrep "SVN-side change inside of www/test_www.txt"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo' '
+	(
+		cd g &&
+		git svn rebase --ignore-paths="^www" &&
+		echo -e "test_qqq\nb" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_expect_success 'SVN-side change in and out of ignored www' '
+	(
+		cd s &&
+		echo cvf >> www/test_www.txt
+		echo ygg >> qqq/test_qqq.txt
+		svn commit -m "SVN-side change in and out of ignored www" &&
+		svn up &&
+		svn log -v | fgrep "SVN-side change in and out of ignored www"
+	)
+'
+
+test_expect_success 'update git svn-cloned repo again' '
+	(
+		cd g &&
+		git svn rebase --ignore-paths="^www" &&
+		echo -e "test_qqq\nb\nygg" > expect &&
+		for i in */*.txt; do cat $i >> expect2; done &&
+		test_cmp expect2 expect &&
+		rm expect expect2
+	)
+'
+
+test_done
-- 
1.5.6.5
