From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 1/2] t6300: test sort with multiple keys
Date: Sun, 19 Aug 2012 23:15:03 +0200
Message-ID: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 23:45:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3DJ4-0006fF-Jc
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 23:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab2HSVpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 17:45:09 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:43239 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab2HSVpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 17:45:07 -0400
X-Greylist: delayed 1793 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2012 17:45:07 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 1533F5F004A
	for <git@vger.kernel.org>; Sun, 19 Aug 2012 23:16:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SnqUmWzNUPaE for <git@vger.kernel.org>;
	Sun, 19 Aug 2012 23:16:05 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id A90F05F0047
	for <git@vger.kernel.org>; Sun, 19 Aug 2012 23:16:05 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 0976F46743; Sun, 19 Aug 2012 23:15:03 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203736>

Documentation of git-for-each-ref says that --sort=<key> option can be
used multiple times, in which case the last key becomes the primary key.
However this functionality was never checked in test suite and is
currently broken. This commit adds appropriate test in preparation for fix.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t6300-for-each-ref.sh | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 1721784..3d59bfc 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -242,7 +242,32 @@ test_expect_success 'Verify descending sort' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Create branches to test sort with multiple keys' '
+	git checkout -b Branch1 &&
+	echo foo >> one &&
+	git commit -a -m "Branch1 commit" &&
+	git checkout -b Branch2 &&
+	echo foo >> one &&
+	git commit -a -m "Branch2 commit"
+'
+
+test_atom refs/heads/Branch1 objectname 32fca05e9f638021a123a84226acf17756acc18b
+test_atom refs/heads/Branch2 objectname 194a5b89ac661a114566ba4374bc06c2797539f3
+
 cat >expected <<\EOF
+67a36f10722846e891fbada1ba48ed035de75581 commit	refs/heads/master
+194a5b89ac661a114566ba4374bc06c2797539f3 commit	refs/heads/Branch2
+32fca05e9f638021a123a84226acf17756acc18b commit	refs/heads/Branch1
+EOF
+
+test_expect_failure 'Verify sort with multiple keys' '
+	git for-each-ref --sort=objectname --sort=committerdate refs/heads > actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+'refs/heads/Branch1'
+'refs/heads/Branch2'
 'refs/heads/master'
 'refs/remotes/origin/master'
 'refs/tags/testtag'
@@ -264,6 +289,8 @@ test_expect_success 'Quoting style: python' '
 '
 
 cat >expected <<\EOF
+"refs/heads/Branch1"
+"refs/heads/Branch2"
 "refs/heads/master"
 "refs/remotes/origin/master"
 "refs/tags/testtag"
@@ -285,6 +312,8 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
 done
 
 cat >expected <<\EOF
+Branch1
+Branch2
 master
 testtag
 EOF
@@ -296,6 +325,8 @@ test_expect_success 'Check short refname format' '
 '
 
 cat >expected <<EOF
+
+
 origin/master
 EOF
 
@@ -309,7 +340,7 @@ cat >expected <<EOF
 EOF
 
 test_expect_success 'Check short objectname format' '
-	git for-each-ref --format="%(objectname:short)" refs/heads >actual &&
+	git for-each-ref --format="%(objectname:short)" refs/heads/master >actual &&
 	test_cmp expected actual
 '
 
-- 
1.7.12.rc3
