From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Skip t3403 selftests if stdin is not a terminal
Date: Fri, 15 Sep 2006 12:59:10 +0000
Message-ID: <20060915125910.10514.qmail@26499ea44f2ee3.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 15 14:59:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GODHg-0004XV-2t
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 14:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWIOM6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 08:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWIOM6t
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 08:58:49 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:28090 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751360AbWIOM6s (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 08:58:48 -0400
Received: (qmail 10515 invoked by uid 1000); 15 Sep 2006 12:59:10 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27085>

sh t3403-rebase-skip.sh </dev/null fails because stdin is not connected
to a terminal, as in the Debian autobuild environment.  This disbales
the test 3 and 7 in this case.

Signed-off-by: Gerrit Pape <pape@smarden.org>

---
 t/t3403-rebase-skip.sh |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 8ab63c5..983d152 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -39,10 +39,16 @@ test_expect_success setup '
 
 test_expect_failure 'rebase with git am -3 (default)' 'git rebase master'
 
-test_expect_success 'rebase --skip with am -3' '
-	git reset --hard HEAD &&
-	git rebase --skip
-	'
+if tty -s
+then
+	test_expect_success 'rebase --skip with am -3' '
+		git reset --hard HEAD &&
+		git rebase --skip
+		'
+else
+	echo 'stdin is not a terminal, skip test.'
+fi
+
 test_expect_success 'checkout skip-merge' 'git checkout -f skip-merge'
 
 test_expect_failure 'rebase with --merge' 'git rebase --merge master'
@@ -52,8 +58,13 @@ test_expect_success 'rebase --skip with 
 	git rebase --skip
 	'
 
-test_expect_success 'merge and reference trees equal' \
-	'test -z "`git-diff-tree skip-merge skip-reference`"'
+if tty -s
+then
+	test_expect_success 'merge and reference trees equal' \
+		'test -z "`git-diff-tree skip-merge skip-reference`"'
+else
+	echo 'stdin is not a terminal, skip test.'
+fi
 
 test_debug 'gitk --all & sleep 1'
 
-- 
1.4.2.1
