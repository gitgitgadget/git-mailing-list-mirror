From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] mergetool: demonstrate directory / file conflict breakage
Date: Tue, 24 Feb 2009 23:01:06 +0000
Message-ID: <1235516466-3930-1-git-send-email-charles@hashpling.org>
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 00:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc6Ih-0003Eo-0Q
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 00:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759508AbZBXXBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 18:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757237AbZBXXBN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 18:01:13 -0500
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:9398 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754525AbZBXXBM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 18:01:12 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAHQLpEnUnw6R/2dsb2JhbADYM4QRBg
Received: from ptb-relay01.plus.net ([212.159.14.145])
  by relay.pcl-ipout02.plus.net with ESMTP; 24 Feb 2009 23:01:08 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1Lc6Gy-0002ta-2Y; Tue, 24 Feb 2009 23:01:08 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n1ON17Gg003984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Feb 2009 23:01:07 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n1ON16RA003983;
	Tue, 24 Feb 2009 23:01:06 GMT
X-Mailer: git-send-email 1.6.2.rc1.258.g314b8b
X-Plusnet-Relay: 746b2e8a2ae4eb8cdbba44a03f0a2b50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111357>

---

This appears to demonstrate one of the corner cases that trips mergetool
up. I also appear to have fixed it in my work-in-progress refactoring of
mergetool, but I haven't yet completed it or tested it thoroughly enough
so it's not ready for human consumption.

 t/t7610-mergetool.sh |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index e768c3e..df57b83 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -34,6 +34,8 @@ test_expect_success 'setup' '
     git add file1 file2 subdir/file3 &&
     git commit -m "master updates" &&
 
+    git branch empty $(echo empty | git commit-tree $(printf "" | git mktree)) &&
+
     git config merge.tool mytool &&
     git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
     git config mergetool.mytool.trustExitCode true
@@ -67,13 +69,56 @@ test_expect_success 'mergetool crlf' '
 '
 
 test_expect_success 'mergetool in subdir' '
-    git checkout -b test3 branch1
-    cd subdir && (
+    git checkout -b test3 branch1 &&
+    ( cd subdir &&
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
     test "$(cat file3)" = "master new sub" )
 '
 
+# Choosing the 'remote' symlink should work
+test_expect_success 'mergetool symlink change' '
+    git clean -f &&
+    git checkout -f -b symlink-test empty &&
+    echo file >file1 &&
+    echo file >linktofile1 &&
+    git add file1 linktofile1 &&
+    git commit -m base &&
+    rm linktofile1 &&
+    ln -s file1 linktofile1 &&
+    git commit -a -m "change file to link" &&
+    git checkout -b symlink-test-2 HEAD^ &&
+    rm linktofile1 &&
+    printf file1 >linktofile1 &&
+    git commit -a -m "file change" &&
+    test_must_fail git merge symlink-test >/dev/null 2>&1 &&
+    ( yes "r" | git mergetool linktofile1 >/dev/null 2>&1 ) &&
+    test -L linktofile1 &&
+    git commit -m "symlink resolve"
+'
+
+# Aborting a conflicted dir -> file merge shouldn't remove the offending
+# parth altogether
+test_expect_failure 'abort mergetool directory change' '
+    git clean -f &&
+    git checkout -f -b dir-test empty &&
+    echo file >dir1 &&
+    git add dir1 &&
+    git commit -m base &&
+    rm dir1 &&
+    mkdir dir1 &&
+    echo file >dir1/file &&
+    git add dir1
+    git commit -a -m "change file to dir" &&
+    git checkout -b dir-test-2 HEAD^ &&
+    echo not a dir >dir1 &&
+    git commit -a -m "file change" &&
+    test_must_fail git merge -s resolve dir-test &&
+    test -e dir1 &&
+    ( yes "a" | test_must_fail git mergetool dir1 >/dev/null 2>&1 ) &&
+    test -e dir1
+'
+
 # We can't merge files from parent directories when running mergetool
 # from a subdir. Is this a bug?
 #
-- 
1.6.2.rc1.258.g314b8b
