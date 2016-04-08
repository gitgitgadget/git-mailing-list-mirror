From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 03/18] Document weird bug in octopus merges via testcases
Date: Thu,  7 Apr 2016 23:58:31 -0700
Message-ID: <1460098726-5958-4-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 08:59:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQO7-0002VL-0B
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbcDHG7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:08 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35971 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932606AbcDHG7C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id q129so8827946pfb.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFv7sABcuzDRf4dw1S6PNRlN1EamDjo2E/MQDuTrwGA=;
        b=GetKLtof4lVQEWKCBjXAO+r/rsTYEgBRxhW+XfWUkhsicEbijeswVbHNZPQUDwytQA
         0Amfc+NO5o0M7RMbgHTlm++j8CsOPqeEft2RXjsgry58iJ6Ia3Bu9HDIa7PsB+DwLCrp
         UueuqEhQlfFDaY2uqzMvBDPIKHb5/88TO4V6V9RC5Sp99NQ26Pt0lNkVE1ETehw5Flcx
         KLAtpRHWHBB/cnoybpm6ZKTdJ2DyWXPAKN+x4cH7Qh+Lt4v3A7toehqBOkL4Cl8m3AD9
         cp+ZnXkE6tBJdc5RJeo3YdtkN2QGLb8YElNYkjeHJ3UntHTaAIkK7Dicm/1MQan4SXXQ
         mW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFv7sABcuzDRf4dw1S6PNRlN1EamDjo2E/MQDuTrwGA=;
        b=TRsotIq/JH4fjdEyMlBrapuh5fNWbW701NjNECgpVLiLS2JqiyyTuaj48kKuG0Nj8l
         vx4+6U1VwQTqdTznRN6lsW3oW0wq0OzP9KSzWB3LunQXS2QgCH893nibFGqhsrthsgVA
         5tZyP1gNFwJLWH/dygiYe5eu3dWODQ1IM4gq0sg0OxZWL2zvsWQ3dGx6Vs62KsS9yvj6
         1lnZFpxuL0fz2bhK4EmdOxuPDbNnaejxJXH5iB2TM6t1Q2+fVuXA0xDEi4CuB3Zu/iuB
         vRT6hqVDHjHgrnf7DuPRV6MYjR+YvG7RpcOLdHZIq+n9a1JJcnVC63Tn7A0Shl0FJT+0
         /MFg==
X-Gm-Message-State: AD7BkJKPWHnFP092m05AzxqliLL5URpF4xaWa3KvYY4T0p9KwS4/b2CBP0UcZqpr/vKRkw==
X-Received: by 10.98.76.216 with SMTP id e85mr10469433pfj.121.1460098741411;
        Thu, 07 Apr 2016 23:59:01 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:00 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291001>

...and check all other merge strategies with testcases while we're at it.

When the index has a staged change before running git merge, most the time
git merge will error out telling the user that the merge operation would
toss their merged changes unless they commit them first.  There are two
exceptions:
  * ff updates
  * octopus merges

ff updates actually will error out if the staged change is to a path
modified between HEAD and the commit being merged.  If the path(s) that
are staged are files unrelated to the changes between these two commits,
though, then an ff update will just keep these staged changes around after
the merge.

For octopus merges, the staged changes seem to take the place of HEAD just
before the merge is performed.  So if the staged changes can be cleanly
merged with all the other heads, then the staged changes will just be
incorported into the resulting commit.  If the staged changes cannot be
cleanly merged with all the other heads, the merge is not aborted -- merge
conflicts are simply reported as if HEAD had originally contained whatever
the index did.

Somewhat amusingly, though, an octopus merge will abort if the changes are
not staged.  So, for example, if you do a 'git rm --cached somefile' right
before attempting an octopus merge then you'll get an error, but if you do
a 'git rm somefile' right before attempting an octopus merge git will
happily proceed.  Similarly if you just modify a tracked file without
adding it.

...makes me wonder if I should add a testcase for unstaged and untracked
changes for each merge strategy while I'm at it.  Hmmm...

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 165 +++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100755 t/t6044-merge-unrelated-index-changes.sh

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
new file mode 100755
index 0000000..726c898
--- /dev/null
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -0,0 +1,165 @@
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
+	echo "I think the next line should fail, but maybe it was intended..." &&
+	test_might_fail git merge C^0 D^0 &&
+
+	echo "No matter what, random_file should NOT be part of HEAD" &&
+	test_must_fail git rev-parse HEAD:random_file
+'
+
+test_expect_failure 'octopus, related file removed' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git rm b &&
+
+	echo "I think the next line should fail, but maybe it was intended..." &&
+	test_might_fail git merge C^0 D^0 &&
+
+	echo "No matter what, b should still be in HEAD" &&
+	git cat-file -p HEAD:b | grep b$
+'
+
+test_expect_failure 'octopus, related file modified' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	echo 12 >>a && git add a &&
+
+	echo "I think the next line should fail, but maybe it was intended..." &&
+	test_might_fail git merge C^0 D^0 &&
+
+	echo "No matter what, 12 should NOT be in the copy of a from HEAD" &&
+	git cat-file -p HEAD:a | test_must_fail grep 12
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
2.8.0.18.gc685494
