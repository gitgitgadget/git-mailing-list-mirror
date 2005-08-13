From: Brad Roberts <braddr@puremagic.com>
Subject: [PATCH] fix null TZ problems on os/x
Date: Sat, 13 Aug 2005 03:22:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0508130308190.2136-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Aug 13 12:23:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3tAH-0001nC-MN
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 12:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVHMKWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 06:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVHMKWw
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 06:22:52 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:42217 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S1751317AbVHMKWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 06:22:51 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.4/8.13.4/Debian-3) with ESMTP id j7DAMl0F027580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 03:22:47 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.4/8.13.4/Submit) with ESMTP id j7DAMk2A027576
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 03:22:46 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Fix TZ handling in tests, "" isn't a valid timezone at least on os/x

It seems that the localtime() libc routine doesn't care for finding a TZ
that's empty.  It's ok with TZ not being set.  Setting the TZ to GMT allowed
these tests to pass.

$ uname -v
Darwin Kernel Version 7.9.0: Wed Mar 30 20:11:17 PST 2005; root:xnu/xnu-517.12.7.obj~1/RELEASE_PPC

Signed-off-by: Brad Roberts <braddr@puremagic.com>

---
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -32,7 +32,7 @@ test_expect_success \
      GIT_COMMITTER_NAME="Committer Name" \
      GIT_COMMITTER_EMAIL="committer@email" \
      GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     TZ= git-commit-tree `cat treeid` >commitid 2>/dev/null'
+     TZ=GMT git-commit-tree `cat treeid` >commitid 2>/dev/null'

 test_expect_success \
     'read commit' \
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -41,7 +41,7 @@ test_expect_success \
      find a -type l | xargs git-update-cache --add &&
      treeid=`git-write-tree` &&
      echo $treeid >treeid &&
-     TZ= GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
+     TZ=GMT GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
      git-commit-tree $treeid </dev/null >.git/HEAD'

 test_expect_success \
@@ -50,7 +50,7 @@ test_expect_success \

 test_expect_success \
     'validate file modification time' \
-    'TZ= tar tvf b.tar a/a |
+    'TZ=GMT tar tvf b.tar a/a |
      awk \{print\ \$4,\ \(length\(\$5\)\<7\)\ ?\ \$5\":00\"\ :\ \$5\} \
      >b.mtime &&
      echo "2005-05-27 22:00:00" >expected.mtime &&
