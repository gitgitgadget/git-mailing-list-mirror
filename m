From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] filter-branch: Test renaming directories in a tree-filter
Date: Mon, 31 Mar 2008 09:14:14 +0200
Message-ID: <1206947655-20272-1-git-send-email-johannes.sixt@telecom.at>
References: <C46D6D0D-44E1-4976-8956-1D84B6351535@yahoo.ca>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: =?utf-8?q?Jean-Fran=C3=A7ois=20Veillette?= 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Mon Mar 31 09:40:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgEcw-0003tH-03
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 09:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbYCaHj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 03:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbYCaHj2
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 03:39:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7328 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbYCaHj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 03:39:28 -0400
X-Greylist: delayed 1508 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Mar 2008 03:39:27 EDT
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1JgECl-0007D4-0x; Mon, 31 Mar 2008 09:13:20 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 153E16B7; Mon, 31 Mar 2008 09:14:16 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id D1FAAFA46; Mon, 31 Mar 2008 09:14:15 +0200 (CEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <C46D6D0D-44E1-4976-8956-1D84B6351535@yahoo.ca>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78565>

This test currently fails.

If b is a directory then 'mv a b' is not a plain "rename", but really a
"move", so we must also test that the directory does not exist with the
old name in the directory with the new name.

There's also some cleanup in the corresponding "rename file" test to avoid
spurious shell syntax errors and "ambigous ref" error from 'git show' (but
these should show up only if the test would fail anyway). Plus we also
test for the non-existence of the old file.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 t/t7003-filter-branch.sh |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 6827249..53b5ce6 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -17,6 +17,8 @@ test_expect_success 'setup' '
 	make_commit B
 	git checkout -b branch B
 	make_commit D
+	mkdir dir
+	make_commit dir/D
 	make_commit E
 	git checkout master
 	make_commit C
@@ -41,9 +43,23 @@ test_expect_success 'rewrite, renaming a specific file' '
 '
 
 test_expect_success 'test that the file was renamed' '
-	test d = $(git show HEAD:doh) &&
+	test d = "$(git show HEAD:doh --)" &&
+	! test -f d &&
 	test -f doh &&
-	test d = $(cat doh)
+	test d = "$(cat doh)"
+'
+
+test_expect_success 'rewrite, renaming a specific directory' '
+	git-filter-branch -f --tree-filter "mv dir diroh || :" HEAD
+'
+
+test_expect_failure 'test that the directory was renamed' '
+	test dir/d = "$(git show HEAD:diroh/d --)" &&
+	! test -d dir &&
+	test -d diroh &&
+	! test -d diroh/dir &&
+	test -f diroh/d &&
+	test dir/d = "$(cat diroh/d)"
 '
 
 git tag oldD HEAD~4
-- 
1.5.4.4
