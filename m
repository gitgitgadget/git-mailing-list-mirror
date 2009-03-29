From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] t6030: test bisecting with paths
Date: Sun, 29 Mar 2009 11:45:01 +0200
Message-ID: <20090329114501.d6dca210.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnrcB-0004CJ-Cg
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 11:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbZC2JqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 05:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbZC2JqH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:46:07 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:55878 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbZC2JqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 05:46:05 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id DD085D4817C;
	Sun, 29 Mar 2009 11:45:56 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id C5844D481CE;
	Sun, 29 Mar 2009 11:45:53 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115008>

This patch adds some tests to check that "git bisect" works fine when
passing paths to "git bisect start" to reduce the number of
bisection steps.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6030-bisect-porcelain.sh |   60 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 052a6c9..54b7ea6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -506,6 +506,66 @@ test_expect_success 'optimized merge base checks' '
 	unset GIT_TRACE
 '
 
+# This creates another side branch called "parallel" with some files
+# in some directories, to test bisecting with paths.
+#
+# We should have the following:
+#
+#    P1-P2-P3-P4-P5-P6-P7
+#   /        /        /
+# H1-H2-H3-H4-H5-H6-H7
+#            \  \     \
+#             S5-A     \
+#              \        \
+#               S6-S7----B
+#
+test_expect_success '"parallel" side branch creation' '
+	git bisect reset &&
+	git checkout -b parallel $HASH1 &&
+	mkdir dir1 dir2 &&
+	add_line_into_file "1(para): line 1 on parallel branch" dir1/file1 &&
+	PARA_HASH1=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "2(para): line 2 on parallel branch" dir2/file2 &&
+	PARA_HASH2=$(git rev-parse --verify HEAD) &&
+	add_line_into_file "3(para): line 3 on parallel branch" dir2/file3 &&
+	PARA_HASH3=$(git rev-parse --verify HEAD)
+	git merge -m "merge HASH4 and PARA_HASH3" "$HASH4" &&
+	PARA_HASH4=$(git rev-parse --verify HEAD)
+	add_line_into_file "5(para): add line on parallel branch" dir1/file1 &&
+	PARA_HASH5=$(git rev-parse --verify HEAD)
+	add_line_into_file "6(para): add line on parallel branch" dir2/file2 &&
+	PARA_HASH6=$(git rev-parse --verify HEAD)
+	git merge -m "merge HASH7 and PARA_HASH6" "$HASH7" &&
+	PARA_HASH7=$(git rev-parse --verify HEAD)
+'
+
+test_expect_success 'restricting bisection on one dir' '
+	git bisect reset &&
+	git bisect start HEAD $HASH1 -- dir1 &&
+	para1=$(git rev-parse --verify HEAD) &&
+	test "$para1" = "$PARA_HASH1" &&
+	git bisect bad > my_bisect_log.txt &&
+	grep "$PARA_HASH1 is first bad commit" my_bisect_log.txt
+'
+
+test_expect_success 'restricting bisection on one dir and a file' '
+	git bisect reset &&
+	git bisect start HEAD $HASH1 -- dir1 hello &&
+	para4=$(git rev-parse --verify HEAD) &&
+	test "$para4" = "$PARA_HASH4" &&
+	git bisect bad &&
+	hash3=$(git rev-parse --verify HEAD) &&
+	test "$hash3" = "$HASH3" &&
+	git bisect good &&
+	hash4=$(git rev-parse --verify HEAD) &&
+	test "$hash4" = "$HASH4" &&
+	git bisect good &&
+	para1=$(git rev-parse --verify HEAD) &&
+	test "$para1" = "$PARA_HASH1" &&
+	git bisect good > my_bisect_log.txt &&
+	grep "$PARA_HASH4 is first bad commit" my_bisect_log.txt
+'
+
 #
 #
 test_done
-- 
1.6.2.1.404.gb0085.dirty
