From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/5] t3600: update the test for updated git rm
Date: Mon, 25 Dec 2006 03:11:17 -0800
Message-ID: <7v3b74mdre.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 25 12:11:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gynjl-0003Z0-Jt
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 12:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbWLYLLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 06:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754426AbWLYLLS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 06:11:18 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48017 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbWLYLLS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 06:11:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225111117.FWTZ25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 06:11:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2zBW1W00o1kojtg0000000; Mon, 25 Dec 2006 06:11:31 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35384>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t3600-rm.sh |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 201d164..e31cf93 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -43,19 +43,19 @@ test_expect_success \
 
 test_expect_success \
     'Test that git-rm foo succeeds' \
-    'git-rm foo'
+    'git-rm --cached foo'
 
 test_expect_success \
     'Post-check that foo exists but is not in index after git-rm foo' \
     '[ -f foo ] && ! git-ls-files --error-unmatch foo'
 
 test_expect_success \
-    'Pre-check that bar exists and is in index before "git-rm -f bar"' \
+    'Pre-check that bar exists and is in index before "git-rm bar"' \
     '[ -f bar ] && git-ls-files --error-unmatch bar'
 
 test_expect_success \
-    'Test that "git-rm -f bar" succeeds' \
-    'git-rm -f bar'
+    'Test that "git-rm bar" succeeds' \
+    'git-rm bar'
 
 test_expect_success \
     'Post-check that bar does not exist and is not in index after "git-rm -f bar"' \
@@ -84,4 +84,74 @@ test_expect_success \
     'When the rm in "git-rm -f" fails, it should not remove the file from the index' \
     'git-ls-files --error-unmatch baz'
 
+# Now, failure cases.
+test_expect_success 'Re-add foo and baz' '
+	git add foo baz &&
+	git ls-files --error-unmatch foo baz
+'
+
+test_expect_success 'Modify foo -- rm should refuse' '
+	echo >>foo &&
+	! git rm foo baz &&
+	test -f foo &&
+	test -f baz &&
+	git ls-files --error-unmatch foo baz
+'
+
+test_expect_success 'Modified foo -- rm -f should work' '
+	git rm -f foo baz &&
+	test ! -f foo &&
+	test ! -f baz &&
+	! git ls-files --error-unmatch foo &&
+	! git ls-files --error-unmatch bar
+'
+
+test_expect_success 'Re-add foo and baz for HEAD tests' '
+	echo frotz >foo &&
+	git checkout HEAD -- baz &&
+	git add foo baz &&
+	git ls-files --error-unmatch foo baz
+'
+
+test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
+	! git rm foo baz &&
+	test -f foo &&
+	test -f baz &&
+	git ls-files --error-unmatch foo baz
+'
+
+test_expect_success 'but with -f it should work.' '
+	git rm -f foo baz &&
+	test ! -f foo &&
+	test ! -f baz &&
+	! git ls-files --error-unmatch foo
+	! git ls-files --error-unmatch baz
+'
+
+test_expect_success 'Recursive test setup' '
+	mkdir -p frotz &&
+	echo qfwfq >frotz/nitfol &&
+	git add frotz &&
+	git commit -m "subdir test"
+'
+
+test_expect_success 'Recursive without -r fails' '
+	! git rm frotz &&
+	test -d frotz &&
+	test -f frotz/nitfol
+'
+
+test_expect_success 'Recursive with -r but dirty' '
+	echo qfwfq >>frotz/nitfol
+	! git rm -r frotz &&
+	test -d frotz &&
+	test -f frotz/nitfol
+'
+
+test_expect_success 'Recursive with -r -f' '
+	git rm -f -r frotz &&
+	! test -f frotz/nitfol &&
+	! test -d frotz
+'
+
 test_done
-- 
1.4.4.3.g50da
