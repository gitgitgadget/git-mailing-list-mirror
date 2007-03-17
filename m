From: koreth@midwinter.com
Subject: [PATCH] Add test cases for handling of name conflicts between files and directories.
Date: Fri, 16 Mar 2007 17:00:04 -0700
Message-ID: <20070317000004.GA14919@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 01:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSMLF-0001QQ-A7
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 01:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992458AbXCQAAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 20:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992469AbXCQAAJ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 20:00:09 -0400
Received: from tater.midwinter.com ([216.32.86.90]:55233 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992464AbXCQAAH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 20:00:07 -0400
Received: (qmail 14998 invoked by uid 1001); 17 Mar 2007 00:00:04 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42411>

Here are a few test cases for the file/directory name conflict patch.

---
 t/t7201-co.sh |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 867bbd2..6692f25 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -36,6 +36,9 @@ test_expect_success setup '
 	git update-index --add --remove one two three &&
 	git commit -m "Side M one, D two, A three" &&
 
+	git branch with-file master &&
+	git branch with-dir master &&
+
 	git checkout master
 '
 
@@ -129,4 +132,71 @@ test_expect_success 'checkout -m with merge conflict' '
 	! test -s current
 '
 
+test_expect_success 'checkout with file/directory conflict' '
+
+	git checkout -f with-dir && git clean &&
+
+	mv one one- &&
+	mkdir one &&
+	mv one- one/file &&
+	git add one/file &&
+	git commit -m "with-dir D one A one/file" &&
+	
+	git checkout with-file &&
+	git checkout with-dir
+'
+
+test_expect_success 'checkout with file/directory conflict and modified file in dir' '
+
+	git checkout -f with-dir && git-clean &&
+
+	fill 1 2 3 4 5 6 7 > one/file &&
+	if git checkout with-file
+	then
+		echo Should have detected modified file in subdirectory
+		false
+	else
+		echo "happy - failed correctly"
+	fi
+'
+
+test_expect_success 'checkout with file/directory conflict and untracked file in dir' '
+
+	git checkout -f with-dir && git-clean &&
+
+	fill 1 2 3 > one/file2 &&
+	if git checkout with-file
+	then
+		echo Should have detected untracked file in subdirectory
+		false
+	else
+		echo "happy - failed correctly"
+	fi &&
+	rm one/file2
+'
+
+test_expect_success 'checkout with file/directory conflict and deleted file in dir' '
+
+	git checkout -f with-dir && git-clean &&
+
+	rm one/file &&
+	git checkout with-file
+'
+
+test_expect_success 'checkout with file/directory conflict and modified file' '
+
+	git checkout -f with-file && git-clean &&
+
+	fill 1 2 3 > one &&
+	if git checkout with-dir
+	then
+		echo Should have detected modified file
+		false
+	else
+		echo "happy - failed correctly"
+	fi &&
+
+	git reset --hard
+'
+
 test_done
-- 
1.5.0.4.404.gdbb2-dirty
