From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 3/3 v4]  Make git log --follow find copies among unmodified files.
Date: Thu,  6 May 2010 21:52:29 -0700
Message-ID: <1273207949-18500-4-git-send-email-struggleyb.nku@gmail.com>
References: <1273207949-18500-1-git-send-email-struggleyb.nku@gmail.com>
 <1273207949-18500-2-git-send-email-struggleyb.nku@gmail.com>
 <1273207949-18500-3-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 06:52:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAFYW-00005k-E7
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 06:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab0EGEwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 00:52:47 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:35038 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab0EGEwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 00:52:44 -0400
Received: by yxe29 with SMTP id 29so422895yxe.4
        for <git@vger.kernel.org>; Thu, 06 May 2010 21:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PJd3gW+duZax36rNVai+EljQ9RU2iSYn1fmqfA74MJU=;
        b=MUjdSeG2FM4v0afPlb6VCaDP+GYZexxKy5Xjr340uSeIYN8la8k2p6dYQM+TCyyJbn
         Xt2jSojKflHUSQ/NP93Jw8yadnNFr5IR+PPRcXlpqbAfStQtCn1H9p56FMLLoXV3P370
         PfB9rrvFHmv/QfbZsdc/Dj1F1IpAhOeZkdmcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Dx1Pzu19haCSzwf5gLi3BXHX5MKCRl1LZpNd7wLPIHYf1l7efWVezJe6qSNTCYw410
         rurupEgEogZZ/vM0JWYW3zUxBvqsYuhQrmz6dL3bgMHAXmecfUgJsb58i/FFZ0gxEB2o
         Th4VSZcOSbXxLfDm+RY+Meu3hbk606w8IUYiE=
Received: by 10.101.192.33 with SMTP id u33mr9909618anp.237.1273207963124;
        Thu, 06 May 2010 21:52:43 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n2sm16458856ann.12.2010.05.06.21.52.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 21:52:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273207949-18500-3-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146523>

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
1.6.0.4
