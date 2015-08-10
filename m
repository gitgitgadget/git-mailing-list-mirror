From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 2/2] notes: handle multiple worktrees
Date: Mon, 10 Aug 2015 13:52:45 -0400
Message-ID: <1439229165-25773-2-git-send-email-dturner@twopensource.com>
References: <1439229165-25773-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, johan@herland.net,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Aug 10 19:53:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOrG0-00015Z-Em
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbbHJRxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:53:01 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35053 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932452AbbHJRw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:52:59 -0400
Received: by igbjg10 with SMTP id jg10so5941950igb.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 10:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tDZUFxSWilkHXu69KNKPA0DVM+MSfDN481W/yLHDMXI=;
        b=dTwbrpZryMJPNksf3VNNzCgcUfWCSJbsCsR4bZjM0RMCmkSxM7fUmdsTwdWiGZrL9O
         5Y6MFmVDuH8Kmn/HPjHY/TZLSIPgopffr/6xYaAbuulELgsHTiRqVqXsd6HWoTx7k5ET
         dPYVT8JLgC0X95vzntEcD2cCjl6R2eAVZFuZGRROcrNrD/HbWIXtMCdba95PXmoa8gpA
         j6DtKl8B2NN685zHqGAal0hXkOJ6SWdbO6b6vphEpPb6Z84dUS0jmF1FF/Fk2vW49GkO
         18epTRL1pYwJluXLt/4JqIcVCy04UMO4+58YkdVvXvIqjYF80nIo6+MmOlu4Qlkm6rSa
         ZOsw==
X-Gm-Message-State: ALoCoQkfSAVQFd/4gGUwAAiXHAG7l5Cd3Zb9nAD8WjK/GKdHxb82zrD4l09pVNYLTnW/3Z9pDgbi
X-Received: by 10.50.147.4 with SMTP id tg4mr13314919igb.53.1439229178864;
        Mon, 10 Aug 2015 10:52:58 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id v18sm6296551igr.3.2015.08.10.10.52.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 10:52:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1439229165-25773-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275644>

Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
find_shared_symref and die if we find one.  This prevents simultaneous
merges to the same notes branch from different worktrees.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/notes.c                  |  6 ++++
 t/t3320-notes-merge-worktrees.sh | 72 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 t/t3320-notes-merge-worktrees.sh

diff --git a/builtin/notes.c b/builtin/notes.c
index 63f95fc..0423480 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -19,6 +19,7 @@
 #include "string-list.h"
 #include "notes-merge.h"
 #include "notes-utils.h"
+#include "branch.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
@@ -825,10 +826,15 @@ static int merge(int argc, const char **argv, const char *prefix)
 		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 	else { /* Merge has unresolved conflicts */
+		char *existing;
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
 		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
+		existing = find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
+		if (existing)
+			die(_("A notes merge into %s is already in-progress at %s"),
+			    default_notes_ref(), existing);
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die("Failed to store link to current notes ref (%s)",
 			    default_notes_ref());
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
new file mode 100755
index 0000000..a7beef2
--- /dev/null
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Twitter, Inc
+#
+
+test_description='Test merging of notes trees in multiple worktrees'
+
+. ./test-lib.sh
+
+test_expect_success 'setup commit' '
+	test_commit tantrum
+'
+
+commit_tantrum=$(git rev-parse tantrum^{commit})
+
+test_expect_success 'setup notes ref (x)' '
+	git config core.notesRef refs/notes/x &&
+	git notes add -m "x notes on tantrum" tantrum
+'
+
+test_expect_success 'setup local branch (y)' '
+	git update-ref refs/notes/y refs/notes/x &&
+	git config core.notesRef refs/notes/y &&
+	git notes remove tantrum
+'
+
+test_expect_success 'setup remote branch (z)' '
+	git update-ref refs/notes/z refs/notes/x &&
+	git config core.notesRef refs/notes/z &&
+	git notes add -f -m "conflicting notes on tantrum" tantrum
+'
+
+test_expect_success 'modify notes ref ourselves (x)' '
+	git config core.notesRef refs/notes/x &&
+	git notes add -f -m "more conflicting notes on tantrum" tantrum
+'
+
+test_expect_success 'create some new worktrees' '
+	git worktree add -b newbranch worktree master &&
+	git worktree add -b newbranch2 worktree2 master
+'
+
+test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
+	git config core.notesRef refs/notes/y &&
+	test_must_fail git notes merge z &&
+	echo "ref: refs/notes/y" > expect &&
+	test_cmp .git/NOTES_MERGE_REF expect
+'
+
+test_expect_success 'merge z into y while mid-merge in another workdir fails' '
+	(
+		cd worktree &&
+		git config core.notesRef refs/notes/y &&
+		test_must_fail git notes merge z 2>err &&
+		grep "A notes merge into refs/notes/y is already in-progress at" err
+	) &&
+	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
+'
+
+test_expect_success 'merge z into x while mid-merge on y succeeds' '
+	(
+		cd worktree2 &&
+		git config core.notesRef refs/notes/x &&
+		test_must_fail git notes merge z 2>&1 >out &&
+		grep "Automatic notes merge failed" out &&
+		grep -v "A notes merge into refs/notes/x is already in-progress in" out
+	) &&
+	echo "ref: refs/notes/x" > expect &&
+	test_cmp .git/worktrees/worktree2/NOTES_MERGE_REF expect
+'
+
+test_done
-- 
2.0.4.315.gad8727a-twtrsrc
