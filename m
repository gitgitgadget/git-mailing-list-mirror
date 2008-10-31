From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 01:09:13 -0400
Message-ID: <1225429753-70109-1-git-send-email-benji@silverinsanity.com>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com>
Cc: Shawn O Pearce <spearce@spearce.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 06:10:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvmHT-0007AV-QJ
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 06:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbYJaFJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 01:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbYJaFJS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 01:09:18 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35756 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbYJaFJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 01:09:17 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E97751FFC18A; Fri, 31 Oct 2008 05:09:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO,RCVD_IN_PBL,RCVD_IN_SORBS_DUL autolearn=no 
	version=3.1.7-deb
Received: from localhost.localdomain (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	by silverinsanity.com (Postfix) with ESMTP id D67271FFC186;
	Fri, 31 Oct 2008 05:09:02 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.3.757.g1e5a4
In-Reply-To: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99551>

Not all /bin/sh have a builtin echo that recognizes -n.  Using printf
is far more portable.

Discovered on OS X 10.5.5 in t4030-diff-textconv.sh and changed in all
the test scripts.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 t/t2005-checkout-index-symlinks.sh |    2 +-
 t/t2102-update-index-symlinks.sh   |    4 ++--
 t/t4030-diff-textconv.sh           |    2 +-
 t/t6025-merge-symlinks.sh          |    4 ++--
 t/t9400-git-cvsserver-server.sh    |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index ed12c4d..9fa5610 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -13,7 +13,7 @@ file if core.symlinks is false.'
 test_expect_success \
 'preparation' '
 git config core.symlinks false &&
-l=$(echo -n file | git hash-object -t blob -w --stdin) &&
+l=$(printf file | git hash-object -t blob -w --stdin) &&
 echo "120000 $l	symlink" | git update-index --index-info'
 
 test_expect_success \
diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-symlinks.sh
index f195aef..1ed44ee 100755
--- a/t/t2102-update-index-symlinks.sh
+++ b/t/t2102-update-index-symlinks.sh
@@ -13,12 +13,12 @@ even if a plain file is in the working tree if core.symlinks is false.'
 test_expect_success \
 'preparation' '
 git config core.symlinks false &&
-l=$(echo -n file | git hash-object -t blob -w --stdin) &&
+l=$(printf file | git hash-object -t blob -w --stdin) &&
 echo "120000 $l	symlink" | git update-index --index-info'
 
 test_expect_success \
 'modify the symbolic link' '
-echo -n new-file > symlink &&
+printf new-file > symlink &&
 git update-index symlink'
 
 test_expect_success \
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 3945731..a235955 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -105,7 +105,7 @@ index ad8b3d2..67be421
 EOF
 # make a symlink the hard way that works on symlink-challenged file systems
 test_expect_success 'textconv does not act on symlinks' '
-	echo -n frotz > file &&
+	printf frotz > file &&
 	git add file &&
 	git ls-files -s | sed -e s/100644/120000/ |
 		git update-index --index-info &&
diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 53892a5..433c4de 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -18,11 +18,11 @@ git add file &&
 git commit -m initial &&
 git branch b-symlink &&
 git branch b-file &&
-l=$(echo -n file | git hash-object -t blob -w --stdin) &&
+l=$(printf file | git hash-object -t blob -w --stdin) &&
 echo "120000 $l	symlink" | git update-index --index-info &&
 git commit -m master &&
 git checkout b-symlink &&
-l=$(echo -n file-different | git hash-object -t blob -w --stdin) &&
+l=$(printf file-different | git hash-object -t blob -w --stdin) &&
 echo "120000 $l	symlink" | git update-index --index-info &&
 git commit -m b-symlink &&
 git checkout b-file &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index c1850d2..f6a2dbd 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -424,7 +424,7 @@ cd "$WORKDIR"
 test_expect_success 'cvs update (-p)' '
     touch really-empty &&
     echo Line 1 > no-lf &&
-    echo -n Line 2 >> no-lf &&
+    printf Line 2 >> no-lf &&
     git add really-empty no-lf &&
     git commit -q -m "Update -p test" &&
     git push gitcvs.git >/dev/null &&
-- 
1.6.0.3.757.g1e5a4
