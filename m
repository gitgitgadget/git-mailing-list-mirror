From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 2/2 v3]  Make git log --follow find copies among unmodified files.
Date: Thu, 22 Apr 2010 22:05:42 +0800
Message-ID: <1271945142-27015-3-git-send-email-struggleyb.nku@gmail.com>
References: <1271945142-27015-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 16:06:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4x2o-0003YL-V1
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058Ab0DVOGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 10:06:01 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43586 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974Ab0DVOF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:05:59 -0400
Received: by pvh1 with SMTP id 1so366706pvh.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+mjdiGJEGElbemBTHuYX+xN8x5E5EUYSQzSl6yJo7q8=;
        b=ZSQmmjlhzpenr52mMLbzQKmg1uuME1HtWl2QYbJIPF6v00AXinvMWG3Ua4o8fsZWE5
         eM7Ir5gK9V9wZIXk8tWIG2TaUreUOkpSumwND3UGf2YXMYcWVIegAfK9YE2elTMgCDwz
         3rL+uRiAuYhtNcmj8Q4YBwxnDwM+hOHxcBRgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BEayx1VRlSjtPEa3xWQ53PR5+HRpDrHY+C1dO6OuGc3bHvi/bmDnmbD0oKJIM3gC27
         IKW8o97VnwJC0jy3E8VLF5TOT/D5Uj00UKfCDrHaN5JqQglKJAGBXBvnOfifW/hZOt7q
         FsdNJBTGtidDS7tQMarB9zc3KGMj54icntz7M=
Received: by 10.114.237.20 with SMTP id k20mr4743602wah.185.1271945157966;
        Thu, 22 Apr 2010 07:05:57 -0700 (PDT)
Received: from localhost.localdomain ([222.35.130.216])
        by mx.google.com with ESMTPS id b17sm4487756wam.22.2010.04.22.07.05.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 07:05:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
In-Reply-To: <1271945142-27015-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145532>

'git log --follow <path>' don't track copies from unmodified
files, and this patch fix it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/git-log.txt           |    2 +-
 t/t4205-log-follow-harder-copies.sh |   56 +++++++++++++++++++++++++++++++++++
 tree-diff.c                         |    2 +-
 3 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100755 t/t4205-log-follow-harder-copies.sh

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index fb184ba..0727818 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -56,7 +56,7 @@ include::diff-options.txt[]
 	commits, and doesn't limit diff for those commits.
 
 --follow::
-	Continue listing the history of a file beyond renames.
+	Continue listing the history of a file beyond renames/copies.
 
 --log-size::
 	Before the log message print out its size in bytes. Intended
diff --git a/t/t4205-log-follow-harder-copies.sh b/t/t4205-log-follow-harder-copies.sh
new file mode 100755
index 0000000..ad29e65
--- /dev/null
+++ b/t/t4205-log-follow-harder-copies.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test --follow should always find copies hard in git log.
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+echo >path0 'Line 1
+Line 2
+Line 3
+'
+
+test_expect_success \
+    'add a file path0 and commit.' \
+    'git add path0 &&
+     git commit -m "Add path0"'
+
+echo >path0 'New line 1
+New line 2
+New line 3
+'
+test_expect_success \
+    'Change path0.' \
+    'git add path0 &&
+     git commit -m "Change path0"'
+
+cat <path0 >path1
+test_expect_success \
+    'copy path0 to path1.' \
+    'git add path1 &&
+     git commit -m "Copy path1 from path0"'
+
+test_expect_success \
+    'find the copy path0 -> path1 harder' \
+    'git log --follow --name-status --pretty="format:%s"  path1 > current'
+
+cat >expected <<\EOF
+Copy path1 from path0
+C100	path0	path1
+
+Change path0
+M	path0
+
+Add path0
+A	path0
+EOF
+
+test_expect_success \
+    'validate the output.' \
+    'compare_diff_patch current expected'
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index fe9f52c..1fb3e94 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -346,7 +346,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 
 	diff_setup(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
-	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
 	diff_opts.break_opt = opt->break_opt;
-- 
1.7.0.2.273.gc2413.dirty
