From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH] Make git log --follow support --find-copies-harder.
Date: Wed, 21 Apr 2010 22:37:21 +0800
Message-ID: <1271860641-29305-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 16:37:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4b3q-0001tB-K4
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 16:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0DUOht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 10:37:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40517 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab0DUOhs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 10:37:48 -0400
Received: by pvg13 with SMTP id 13so811047pvg.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jaDxP8Jhx7hHY2bvS9Vq4n15Rl9Gih0nJKAXGqsKvuk=;
        b=ai7YlHQCe8x04VUcRWxEYgCz0/ClnchYs0wxdiTY//5D1l3lfJpaMGWOtL/slaUjmw
         cQmPccXu36CA+cUMjrILjOYy1QArgQVec2QfkcPDoGK53B0TlYvF3vExcIKc4eCvQBd1
         RlWNNU9G9LrtMlIWcajb1fD4lZ8waZ7zfgMgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=STVA3D2O9iIfNeR0LfT+KncrePlwkBLorsZkscsv9ACegUHEr3aF9aYk+zp9Jfg9To
         75nvHea8roPdsx3y6WCzmguygrLSNfKRIkG6d5VwBKR+W2Sd8Eq8SP987dOO3pBx/1GB
         VmDOs3fm9RkDBcLvNCFmch5lqe+3sJAm7bwiw=
Received: by 10.140.58.18 with SMTP id g18mr1435460rva.46.1271860666257;
        Wed, 21 Apr 2010 07:37:46 -0700 (PDT)
Received: from localhost.localdomain ([122.70.43.135])
        by mx.google.com with ESMTPS id k17sm9755990rvh.16.2010.04.21.07.37.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 07:37:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145433>

'git log --follow --find-copies-harder <path>' don't track copies
from unmodified files, and this patch fix it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 t/t4205-log-follow-harder-copies.sh |   56 +++++++++++++++++++++++++++++++++++
 tree-diff.c                         |    2 +
 2 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100755 t/t4205-log-follow-harder-copies.sh

diff --git a/t/t4205-log-follow-harder-copies.sh b/t/t4205-log-follow-harder-copies.sh
new file mode 100755
index 0000000..11e85f4
--- /dev/null
+++ b/t/t4205-log-follow-harder-copies.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test --follow with --find-copies-harder in git log.
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
+    'git log --follow --find-copies-harder --name-status --pretty="format:%s"  path1 > current'
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
index fe9f52c..0dea53e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -346,6 +346,8 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 
 	diff_setup(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER))
+		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
-- 
1.7.0.2.273.gc2413.dirty
