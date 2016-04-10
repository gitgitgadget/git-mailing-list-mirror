From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/6] Add merge testcases for when index doesn't match HEAD
Date: Sat,  9 Apr 2016 23:13:37 -0700
Message-ID: <1460268820-8308-4-git-send-email-newren@gmail.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 08:14:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap8dL-00049x-0h
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 08:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbcDJGNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 02:13:54 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33546 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbcDJGNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 02:13:52 -0400
Received: by mail-pa0-f66.google.com with SMTP id q6so12076380pav.0
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P7LPIs+W95HorWqSRjH+tA+4IQR7Sb1WvduqG7KxTdg=;
        b=eDJY/EOK7wK5O89nTdicE6878FUtWbOvvG0MFQ80kMS//T2rWkMYGkXejh4P7COPBl
         gTLWzz5EGMWwcAY55cCKTukVTiCIHIJTDnB3XOwcQK4ftebJZj2aFseFjPUZxlOKZVLh
         qrbHaGf1rrJag62ro+se4kmgBxkC+AW2uuOQFcRumvIy4/g170WgLAt2rGPn3WHc+vhA
         5589y8vV4PB/Z7TNC91GnxsaYjXZLMDJgA++oPaVfDUuFCmWVrSGDJcRFgmnbcoskdYd
         BKoJVJ8YAXFjPyXY8R8gMmrbTMA2nwGzwsVu+pDpRtF17YyWkj3fxqAOmeVSBXqrIQWy
         ZwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P7LPIs+W95HorWqSRjH+tA+4IQR7Sb1WvduqG7KxTdg=;
        b=ANWB+GYHWscopaUPK/nOYnv0uK0lmiMY7Doyf5R+Hk5bI804WvYFnmjDl6Ght9WQMy
         eBJ9wJelBy1ZYeyB49ULyeSlgb7q50YmIJhMANY9KPCAu0qqNKnoX5M1lIUKY0YipOEd
         ps1Y8JAIdf6Exgez7yj2nYbZrZQHhlveJic4a3SmWI07K1dLZNMtzgSAuyewTK9aDkfp
         bek0hZ4uJIG6J3eBUuB1RlL+0aeCNZIDg/btc3VD5pCO7PIkjtIkjwLRyGVvYurGBG22
         dum2K4POPV3xspK+YDJL5zWAzt3DTlP3o2fEPhM9F/D48dnj5rZwFSY7NSLdzgyZ9xyD
         zR8Q==
X-Gm-Message-State: AD7BkJJ944VNBpMmRU9uTDxZeTDqcJKSB/qmO3ZZ1t2JxgwmKC7eevJsmtyKx5GoLb6ULg==
X-Received: by 10.66.102.70 with SMTP id fm6mr23896237pab.98.1460268831650;
        Sat, 09 Apr 2016 23:13:51 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id p26sm28228711pfi.84.2016.04.09.23.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2016 23:13:51 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g5833b2a
In-Reply-To: <1460268820-8308-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291144>

With one exception, we require the index to exactly match the current HEAD
commit at the time git merge is invoked.  This expectation was even
documented in git-merge.txt until commit ebef7e5 (Documentation: simplify
How Merge Works, 2010-01-23).  Most merge strategies enforced this
requirement, but it turns out not all did.  The current exceptions were
the following two:
  * ff updates
  * octopus merges

ff updates actually will error out if the staged change is to a path
modified between HEAD and the commit being merged.  If the path(s) that
are staged are files unrelated to the changes between these two commits,
though, then an ff update will just keep these staged changes around after
the merge.  This is the one exception we expected to the abort-merge-if-
index-doesn't-match-HEAD rule.

For octopus merges, the rule should be enforced.  Unfortunately, the
current behavior of the code is to ignore the difference and use the
staged changes in place of whatever is in HEAD as it proceeds to perform
the merge.  So if the staged changes can be cleanly merged with all the
other heads, then the staged changes will just be incorported into the
resulting commit.  If the staged changes cannot be cleanly merged with all
the other heads, the merge is not aborted -- merge conflicts are simply
reported as if HEAD had originally contained whatever the index did.

Add testcases that check our expectations.  A subsequent commit will
correct the erroneous octopus merge behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 153 +++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100755 t/t6044-merge-unrelated-index-changes.sh

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
new file mode 100755
index 0000000..eed5d95
--- /dev/null
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+
+test_description="merges with unrelated index changes"
+
+. ./test-lib.sh
+
+# Testcase for some simple merges
+#   A
+#   o-----o B
+#    \
+#     \---o C
+#      \
+#       \-o D
+#        \
+#         o E
+#   Commit A: some file a
+#   Commit B: adds file b, modifies end of a
+#   Commit C: adds file c
+#   Commit D: adds file d, modifies beginning of a
+#   Commit E: renames a->subdir/a, adds subdir/e
+
+test_expect_success 'setup trivial merges' '
+	seq 1 10 >a &&
+	git add a &&
+	test_tick && git commit -m A &&
+
+	git branch A &&
+	git branch B &&
+	git branch C &&
+	git branch D &&
+	git branch E &&
+
+	git checkout B &&
+	echo b >b &&
+	echo 11 >>a &&
+	git add a b &&
+	test_tick && git commit -m B &&
+
+	git checkout C &&
+	echo c >c &&
+	git add c &&
+	test_tick && git commit -m C &&
+
+	git checkout D &&
+	seq 2 10 >a &&
+	echo d >d &&
+	git add a d &&
+	test_tick && git commit -m D &&
+
+	git checkout E &&
+	mkdir subdir &&
+	git mv a subdir/a &&
+	echo e >subdir/e &&
+	git add subdir &&
+	test_tick && git commit -m E
+'
+
+test_expect_success 'ff update' '
+	git reset --hard &&
+	git checkout A^0 &&
+
+	touch random_file && git add random_file &&
+
+	git merge E^0 &&
+
+	test_must_fail git rev-parse HEAD:random_file &&
+	test "$(git diff --name-only --cached E)" = "random_file"
+'
+
+test_expect_success 'ff update, important file modified' '
+	git reset --hard &&
+	git checkout A^0 &&
+
+	mkdir subdir &&
+	touch subdir/e &&
+	git add subdir/e &&
+
+	test_must_fail git merge E^0
+'
+
+test_expect_success 'resolve, trivial' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	touch random_file && git add random_file &&
+
+	test_must_fail git merge -s resolve C^0
+'
+
+test_expect_success 'resolve, non-trivial' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	touch random_file && git add random_file &&
+
+	test_must_fail git merge -s resolve D^0
+'
+
+test_expect_success 'recursive' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	touch random_file && git add random_file &&
+
+	test_must_fail git merge -s recursive C^0
+'
+
+test_expect_failure 'octopus, unrelated file touched' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	touch random_file && git add random_file &&
+
+	test_must_fail git merge C^0 D^0
+'
+
+test_expect_failure 'octopus, related file removed' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git rm b &&
+
+	test_must_fail git merge C^0 D^0
+'
+
+test_expect_failure 'octopus, related file modified' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	echo 12 >>a && git add a &&
+
+	test_must_fail git merge C^0 D^0
+'
+
+test_expect_success 'ours' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	touch random_file && git add random_file &&
+
+	test_must_fail git merge -s ours C^0
+'
+
+test_expect_success 'subtree' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	touch random_file && git add random_file &&
+
+	test_must_fail git merge -s subtree E^0
+'
+
+test_done
-- 
2.8.0.21.g229f62a
