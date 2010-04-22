From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2] Make git log --follow find copies among unmodified files.
Date: Thu, 22 Apr 2010 11:50:44 +0800
Message-ID: <1271908244-18910-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 05:51:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4nRX-0001Ji-UI
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 05:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab0DVDvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 23:51:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53621 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab0DVDvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 23:51:05 -0400
Received: by pvh1 with SMTP id 1so71928pvh.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=IuXOyUg6wuw4U8JY0WSQoj5K4JNZGaUZwjDgWcETipo=;
        b=AaEiEU6G7ObRr0nYsqLsk5FlVQR1nDEky0V0BP1ZC+NFSohLq3JJfwkGy0QGDIeUtl
         HeGWMOCcVESVqRqQi50Q6fMp2i4Etm4mwIRA6YPlQPRUa+oivFm8vrfLxGund8Z+4L8k
         LBUyt7FBLn/d6GnvyJPnaNJ0cvIHGt7LyR8Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rBxvCJ2Z9cLye797FqDQd+5dXToP3BaExxFR2g9onn+rTYiNeqShudIf10UtoNl+ue
         8iaxs1EViET8XmQdg3x4XdiMfGjMC454/DmyM31NDM4PrnNaDjCyiEDwnq93YO+FDI5+
         5YjnL+kJKaSQFsPHhB33hUX6Sh4W1kXfctgqk=
Received: by 10.115.39.40 with SMTP id r40mr891002waj.183.1271908263364;
        Wed, 21 Apr 2010 20:51:03 -0700 (PDT)
Received: from localhost.localdomain ([122.70.43.135])
        by mx.google.com with ESMTPS id 33sm2364012wad.17.2010.04.21.20.50.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 20:51:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145501>

'git log --follow <path>' don't track copies from unmodified
files, and this patch fix it.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/git-log.txt           |    5 ++-
 diff.c                              |    3 ++
 t/t4205-log-follow-harder-copies.sh |   56 +++++++++++++++++++++++++++++++++++
 tree-diff.c                         |    2 +
 4 files changed, 65 insertions(+), 1 deletions(-)
 create mode 100755 t/t4205-log-follow-harder-copies.sh

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index fb184ba..682a85a 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -56,7 +56,10 @@ include::diff-options.txt[]
 	commits, and doesn't limit diff for those commits.
 
 --follow::
-	Continue listing the history of a file beyond renames.
+	Continue listing the history of a file beyond renames/copies.
+	With this, all files in a commit will be searched for
+	renames/copies, and it is equal to specify '--follow' with
+	'--follow -M -C -C'.
 
 --log-size::
 	Before the log message print out its size in bytes. Intended
diff --git a/diff.c b/diff.c
index d0ecbc3..6982f79 100644
--- a/diff.c
+++ b/diff.c
@@ -2594,6 +2594,9 @@ int diff_setup_done(struct diff_options *options)
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
 
+	if (DIFF_OPT_TST(options, FOLLOW_RENAMES))
+		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
+
 	if (DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		options->detect_rename = DIFF_DETECT_COPY;
 
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
