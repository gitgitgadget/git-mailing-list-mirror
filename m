From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] notes: handle multiple worktrees
Date: Fri, 31 Jul 2015 13:44:57 -0400
Message-ID: <1438364697-6647-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Jul 31 19:45:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLEMu-0005di-2V
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 19:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbbGaRpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 13:45:08 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33496 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbbGaRpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 13:45:07 -0400
Received: by qged69 with SMTP id d69so50765784qge.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 10:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XBeDHlmhgROVvMNKGZBxo7rlZ12XLUubDMK6hWb2uI4=;
        b=jhKNE9gp8cHJuYj/yOFi9WSrIeVGDyKpGbYlME+5OuD5D3Xm00CNVFaM/72LSd88i3
         RtsGZFY3fz0xGmTxoCV928YwPQbknjhqqe06Yh1kJZbAFng4QQQgckGOP9rp0kHSDmSF
         7qSXrYtwehqUYWYLgo+eC9GQWsdseApWv4+7UVqGAxSXr0Mvf22uYqGdYAzPEyASHW2U
         2qYrYaLDoJCIOOd9/X0NefFRiDT4eZj68CpajMqQhPleMGhqQCIsk3smvuyoM3QcFUOX
         RDa9LZ8cE5KYsN0y3cgHbH31TH3cIf39EEDjZhRVlOQLnLJ6RENHiaoPCfbnbaTCngMf
         /+lw==
X-Gm-Message-State: ALoCoQmd5zG6zBY2JOlIbbwFXDXHhafwxS6ry9uziQBehrsg86+lyNmXl9ZNU7pNOpKYw5KiwuiV
X-Received: by 10.140.43.100 with SMTP id d91mr6342725qga.77.1438364706666;
        Fri, 31 Jul 2015 10:45:06 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 47sm2560472qgt.15.2015.07.31.10.45.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Jul 2015 10:45:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275059>

Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
die_if_shared_symref.  This prevents simultaneous merges to the same
notes branch from different worktrees.

Signed-off-by: David Turner <dturner@twopensource.com>
---

This version addresses Eric Sunshine's critiques of v1.  It breaks out
the symref-checking functionality into die_if_shared_symref, leaving
die_if_checked_out to handle HEAD.

---
 builtin/notes.c                  |  2 ++
 t/t3320-notes-merge-worktrees.sh | 71 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100755 t/t3320-notes-merge-worktrees.sh

diff --git a/builtin/notes.c b/builtin/notes.c
index 63f95fc..78a264e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -19,6 +19,7 @@
 #include "string-list.h"
 #include "notes-merge.h"
 #include "notes-utils.h"
+#include "branch.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
@@ -829,6 +830,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 		update_ref(msg.buf, "NOTES_MERGE_PARTIAL", result_sha1, NULL,
 			   0, UPDATE_REFS_DIE_ON_ERR);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
+		die_if_shared_symref("NOTES_MERGE_REF", default_notes_ref());
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die("Failed to store link to current notes ref (%s)",
 			    default_notes_ref());
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
new file mode 100755
index 0000000..b102c23
--- /dev/null
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -0,0 +1,71 @@
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
+		grep "is already checked out" err
+	) &&
+	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
+'
+
+test_expect_success 'merge z into x while mid-merge on y succeeds' '
+	(
+		cd worktree2 &&
+		git config core.notesRef refs/notes/x &&
+		test_must_fail git notes merge z 2>&1 >out &&
+		grep -v "is already checked out" out
+	) &&
+	echo "ref: refs/notes/x" > expect &&
+	test_cmp .git/worktrees/worktree2/NOTES_MERGE_REF expect
+'
+
+test_done
-- 
2.0.4.315.gad8727a-twtrsrc
