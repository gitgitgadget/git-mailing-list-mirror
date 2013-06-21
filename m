From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH] t0020-crlf: test rebase with text conversion and safecrlf
Date: Fri, 21 Jun 2013 16:15:24 +0200
Message-ID: <1371824124-4242-1-git-send-email-ydroneaud@opteya.com>
References: <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 16:17:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq29A-0007V3-1l
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 16:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161489Ab3FUOQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 10:16:57 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:58869 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161447Ab3FUOQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 10:16:56 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id BCAA7CA963C
	for <git@vger.kernel.org>; Fri, 21 Jun 2013 16:16:52 +0200 (CEST)
Received: from localhost.localdomain (unknown [37.161.76.205])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 3776F4B002C;
	Fri, 21 Jun 2013 16:16:12 +0200 (CEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.7/8.14.5) with ESMTP id r5LEG6BN004326;
	Fri, 21 Jun 2013 16:16:07 +0200
Received: (from ydroneaud@localhost)
	by localhost.localdomain (8.14.7/8.14.7/Submit) id r5LEFdI8004281;
	Fri, 21 Jun 2013 16:15:39 +0200
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228615>

This patch add two tests to reproduce the problems described
in thread "git rebase fail with CRLF conversion"
 <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
 <http://thread.gmane.org/gmane.comp.version-control.git/228613>
 <http://marc.info/?l=git&m=137182211414404&w=2>

- Add and commit a file with CRLF,
- Add and commit a .gitattributes with text flag for the file,
- Convert CRLF to LF in file, commit the change,
- Rebase the whole on top of another parent
  The rebase currently failed.

This scenario is repeated twice, first with core.safecrlf set to warn,
a second time with core.safecrlf set to true.

git diff will also fail when core.safecrlf is set to true
and the file is not already converted to LF.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t0020-crlf.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 1a8f44c..12147ba 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -506,4 +506,56 @@ test_expect_success 'New CRLF file gets LF in repo' '
 	test_cmp alllf alllf2
 '
 
+test_expect_success 'Prepare rebase test' '
+	test_config core.autocrlf false &&
+	test_config core.safecrlf warn &&
+	test_config core.eol native &&
+	git branch rebase-initial &&
+	git checkout -b rebase-other rebase-initial &&
+	git commit --allow-empty -m "Another commit" &&
+	git checkout rebase-initial
+'
+
+# git rebase will failed to apply the "normalization" commit
+test_expect_success 'Rebase with core.safecrlf set to warn (default)' '
+	test_config core.autocrlf false &&
+	test_config core.safecrlf warn &&
+	test_config core.eol native &&
+	git checkout -b rebase-warn rebase-initial &&
+	for w in A couple of lines ; do echo $w ; done | append_cr >rebase-warn.txt &&
+	git add rebase-warn.txt && git commit -m "Added raw text" &&
+	echo rebase-warn.txt text >> .gitattributes &&
+	git add .gitattributes && git commit -m "Added .gitattributes" &&
+	git rm --cached rebase-warn.txt && git reset --hard &&
+	git add rebase-warn.txt && git commit -m "Normalized" &&
+	git rebase rebase-other || {
+		git status && git diff &&
+		git add rebase-warn.txt && git rebase --continue ;
+	}
+'
+
+#
+# git rebase will failed to apply the "normalization" commit
+# additionnaly
+# git diff and git add will failed when core.safecrlf is set to true
+#
+test_expect_success 'Rebase with core.safecrlf set to true' '
+	test_config core.autocrlf false &&
+	test_config core.safecrlf true &&
+	test_config core.eol native &&
+	git checkout -b rebase-true rebase-initial &&
+	for w in Another couple of lines ; do echo $w ; done | append_cr >rebase-true.txt &&
+	git add rebase-true.txt && git commit -m "Added raw text" &&
+	echo rebase-true.txt text >> .gitattributes &&
+	git add .gitattributes && git commit -m "Added .gitattributes" &&
+	git diff || git add rebase-true.txt ||
+	for w in Another couple of lines ; do echo $w ; done >rebase-true.txt &&
+	git add rebase-true.txt && git commit -m "Normalized" &&
+	git rebase rebase-other || {
+		git status && git diff || git add rebase-true.txt ||
+		for w in Another couple of lines ; do echo $w ; done >rebase-true.txt &&
+		git add rebase-true.txt && git rebase --continue ;
+	}
+'
+
 test_done
-- 
1.8.2.1
