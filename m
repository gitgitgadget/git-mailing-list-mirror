From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 11/21] git p4 test: newline handling
Date: Fri, 28 Sep 2012 08:04:15 -0400
Message-ID: <1348833865-6093-12-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:08:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZMi-0002tr-Id
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab2I1MIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:08:11 -0400
Received: from honk.padd.com ([74.3.171.149]:34976 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756195Ab2I1MIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:08:10 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 541AD5AF2;
	Fri, 28 Sep 2012 05:08:09 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0034531413; Fri, 28 Sep 2012 08:08:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206568>

P4 stores newlines in the depos as \n.  By default, git does this
too, both on unix and windows.  Test to make sure that this stays
true.

Both git and p4 have mechanisms to use \r\n in the working
directory.  Exercise these.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9802-git-p4-filetype.sh | 117 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 21924df..c5ab626 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -8,6 +8,123 @@ test_expect_success 'start p4d' '
 	start_p4d
 '
 
+#
+# This series of tests checks newline handling  Both p4 and
+# git store newlines as \n, and have options to choose how
+# newlines appear in checked-out files.
+#
+test_expect_success 'p4 client newlines, unix' '
+	(
+		cd "$cli" &&
+		p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
+		printf "unix\ncrlf\n" >f-unix &&
+		printf "unix\r\ncrlf\r\n" >f-unix-as-crlf &&
+		p4 add -t text f-unix &&
+		p4 submit -d f-unix &&
+
+		# LineEnd: unix; should be no change after sync
+		cp f-unix f-unix-orig &&
+		p4 sync -f &&
+		test_cmp f-unix-orig f-unix &&
+
+		# make sure stored in repo as unix newlines
+		# use sed to eat python-appened newline
+		p4 -G print //depot/f-unix | marshal_dump data 2 |\
+		    sed \$d >f-unix-p4-print &&
+		test_cmp f-unix-orig f-unix-p4-print &&
+
+		# switch to win, make sure lf -> crlf
+		p4 client -o | sed "/LineEnd/s/:.*/:win/" | p4 client -i &&
+		p4 sync -f &&
+		test_cmp f-unix-as-crlf f-unix
+	)
+'
+
+test_expect_success 'p4 client newlines, win' '
+	(
+		cd "$cli" &&
+		p4 client -o | sed "/LineEnd/s/:.*/:win/" | p4 client -i &&
+		printf "win\r\ncrlf\r\n" >f-win &&
+		printf "win\ncrlf\n" >f-win-as-lf &&
+		p4 add -t text f-win &&
+		p4 submit -d f-win &&
+
+		# LineEnd: win; should be no change after sync
+		cp f-win f-win-orig &&
+		p4 sync -f &&
+		test_cmp f-win-orig f-win &&
+
+		# make sure stored in repo as unix newlines
+		# use sed to eat python-appened newline
+		p4 -G print //depot/f-win | marshal_dump data 2 |\
+		    sed \$d >f-win-p4-print &&
+		test_cmp f-win-as-lf f-win-p4-print &&
+
+		# switch to unix, make sure lf -> crlf
+		p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
+		p4 sync -f &&
+		test_cmp f-win-as-lf f-win
+	)
+'
+
+test_expect_success 'ensure blobs store only lf newlines' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init &&
+		git p4 sync //depot@all &&
+
+		# verify the files in .git are stored only with newlines
+		o=$(git ls-tree p4/master -- f-unix | cut -f1 | cut -d\  -f3) &&
+		git cat-file blob $o >f-unix-blob &&
+		test_cmp "$cli"/f-unix-orig f-unix-blob &&
+
+		o=$(git ls-tree p4/master -- f-win | cut -f1 | cut -d\  -f3) &&
+		git cat-file blob $o >f-win-blob &&
+		test_cmp "$cli"/f-win-as-lf f-win-blob &&
+
+		rm f-unix-blob f-win-blob
+	)
+'
+
+test_expect_success 'gitattributes setting eol=lf produces lf newlines' '
+	test_when_finished cleanup_git &&
+	(
+		# checkout the files and make sure core.eol works as planned
+		cd "$git" &&
+		git init &&
+		echo "* eol=lf" >.gitattributes &&
+		git p4 sync //depot@all &&
+		git checkout master &&
+		test_cmp "$cli"/f-unix-orig f-unix &&
+		test_cmp "$cli"/f-win-as-lf f-win
+	)
+'
+
+test_expect_success 'gitattributes setting eol=crlf produces crlf newlines' '
+	test_when_finished cleanup_git &&
+	(
+		# checkout the files and make sure core.eol works as planned
+		cd "$git" &&
+		git init &&
+		echo "* eol=crlf" >.gitattributes &&
+		git p4 sync //depot@all &&
+		git checkout master &&
+		test_cmp "$cli"/f-unix-as-crlf f-unix &&
+		test_cmp "$cli"/f-win-orig f-win
+	)
+'
+
+test_expect_success 'crlf cleanup' '
+	(
+		cd "$cli" &&
+		rm f-unix-orig f-unix-as-crlf &&
+		rm f-win-orig f-win-as-lf &&
+		p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 client -i &&
+		p4 sync -f
+	)
+'
+
 test_expect_success 'utf-16 file create' '
 	(
 		cd "$cli" &&
-- 
1.7.12.1.403.g28165e1
