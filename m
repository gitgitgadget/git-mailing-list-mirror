From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH] Make --follow support --find-copies-harder.
Date: Tue, 20 Apr 2010 19:27:55 +0800
Message-ID: <1271762875-16548-1-git-send-email-struggleyb.nku@gmail.com>
Cc: torvalds@linux-foundation.org, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 13:28:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Bcm-0002oJ-KI
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 13:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab0DTL2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 07:28:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47150 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab0DTL2H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 07:28:07 -0400
Received: by pwj9 with SMTP id 9so4079807pwj.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iWDD4bg4y7bAbCVPf0xJGw/Gz7I5wiQ6fDgeVpyehFw=;
        b=QKsf8quGIPmFtmOXOlAFhEM6ysRcJplfnAVlBkK+yrAIu9a8IinpkQidhDrctj2TCb
         6Kjey+f2jhw5QfBTN3z3tmKUq6IReztK/uT7a27yonuGiGDgwCkLJBZKX0AI/Fd+XwLd
         fXWMaa3tq2PvO00+239aFpduR9HCxaZd//f80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Jv3ck0cQ39lKi7MzczGIpvoI6tqDvlg2a44BAjF3ZfFh6Dn1iUfCpZ3XkB6Xpp3SeG
         jIlzi25V3Fjd1e9u/P8xOe/VAndvo02gpHV3Q6XSz5Z1mrQd7oAk2zrZpAd2QV3+KOkz
         3m8c685Os+RkN8zk65B1078jxm+kh2idBZhos=
Received: by 10.142.121.1 with SMTP id t1mr2647145wfc.100.1271762886924;
        Tue, 20 Apr 2010 04:28:06 -0700 (PDT)
Received: from localhost.localdomain ([222.35.68.136])
        by mx.google.com with ESMTPS id 22sm6372649pzk.13.2010.04.20.04.28.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Apr 2010 04:28:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145363>

'git diff --follow <commit1> <commit2> <path>' give users
the content difference of <path> between the two commits.
It will detect file copies/moves of <path> if there is any.
But with '--find-copies-harder', it does not take the
unmodified files as copy/move source. And this patch fix
this bug.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 t/t4042-find-copies-harder.sh |   45 +++++++++++++++++++++++++++++++++++++++++
 tree-diff.c                   |    2 +
 2 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t4042-find-copies-harder.sh

diff --git a/t/t4042-find-copies-harder.sh b/t/t4042-find-copies-harder.sh
new file mode 100755
index 0000000..40d2122
--- /dev/null
+++ b/t/t4042-find-copies-harder.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test copy detection with --find-copies-harder in diff engine.
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+echo >path0 'Line 1
+Line 2
+Line 3
+Line 4
+Line 5
+Line 6
+'
+
+test_expect_success \
+    'add a file path0 and commit.' \
+    'git add path0 &&
+     git commit -m "Add path0"'
+
+cat <path0 >path1
+test_expect_success \
+    'copy path0 to path1.' \
+    'git add path1 &&
+     git commit -m "Copy path1 from path0"'
+
+test_expect_success \
+    'find the copy path0 -> path1 harder' \
+    'git diff --follow --find-copies-harder HEAD^ HEAD path1 > current'
+cat >expected <<\EOF
+diff --git a/path0 b/path1
+similarity index 100%
+copy from path0
+copy to path1
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
