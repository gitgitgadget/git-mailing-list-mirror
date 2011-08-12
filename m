From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 01/56] t6042: Add a testcase where git deletes an untracked file
Date: Thu, 11 Aug 2011 23:19:34 -0600
Message-ID: <1313126429-17368-2-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:20:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkAl-0004Sk-7s
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab1HLFUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:37 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1HLFUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:35 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+CFYkC9y9OE44T4RsAMzvjgxwRuRNJoYnTcF1TQ5QNQ=;
        b=RQJ0RZgbELO0TZV8iRyFCRylSWuqsoaLqDSb61Egi4eSx5CLjdKiUGbz5hIhHeRRls
         RY1lsRaaMniLhUchgOV+8Ijho3impXcLwU50AKy2s25BqUmwGLsbfFfL7Pv/id7MPR14
         D/eppLwkNEPv20i2IcptO15It1MYVydQs1ZhQ=
Received: by 10.231.55.201 with SMTP id v9mr1167089ibg.16.1313126435137;
        Thu, 11 Aug 2011 22:20:35 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.33
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179164>

Current git will nuke an untracked file during a rename/delete conflict if
(a) there is an untracked file whose name matches the source of a rename
and (b) the merge is done in a certain direction.  Add a simple testcase
demonstrating this bug.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 t/t6036-recursive-corner-cases.sh    |    2 +-
 t/t6042-merge-rename-corner-cases.sh |   36 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletions(-)
 create mode 100755 t/t6042-merge-rename-corner-cases.sh

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 871577d..319b6fa 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='recursive merge corner cases'
+test_description='recursive merge corner cases involving criss-cross merges'
 
 . ./test-lib.sh
 
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
new file mode 100755
index 0000000..5054459
--- /dev/null
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description="recursive merge corner cases w/ renames but not criss-crosses"
+# t6036 has corner cases that involve both criss-cross merges and renames
+
+. ./test-lib.sh
+
+test_expect_success 'setup rename/delete + untracked file' '
+	echo "A pretty inscription" >ring &&
+	git add ring &&
+	test_tick &&
+	git commit -m beginning &&
+
+	git branch people &&
+	git checkout -b rename-the-ring &&
+	git mv ring one-ring-to-rule-them-all &&
+	test_tick &&
+	git commit -m fullname &&
+
+	git checkout people &&
+	git rm ring &&
+	echo gollum >owner &&
+	git add owner &&
+	test_tick &&
+	git commit -m track-people-instead-of-objects &&
+	echo "Myyy PRECIOUSSS" >ring
+'
+
+test_expect_failure "Does git preserve Gollum's precious artifact?" '
+	test_must_fail git merge -s recursive rename-the-ring &&
+
+	# Make sure git did not delete an untracked file
+	test -f ring
+'
+
+test_done
-- 
1.7.6.100.gac5c1
