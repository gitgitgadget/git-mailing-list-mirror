From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6] notes: handle multiple worktrees
Date: Mon, 10 Aug 2015 13:43:50 -0400
Message-ID: <1439228630-25146-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:44:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOr7N-0005wV-EK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbbHJRoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 13:44:10 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34818 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbbHJRoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:44:07 -0400
Received: by iodd187 with SMTP id d187so176923668iod.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 10:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tU+9skM0Ydr+y8rsChWAYdn5qMqLXpX9Hy0LACVGVC0=;
        b=A46aUPwyEusk7NUCzlnWBFAWONkdeTDizJCrQu0vpVPqNv17iwDfurUi7mEZJp/Icn
         FjwWvrcYqYzM913pd96yZWGa1ewsxaOpgPKfDeXiPZI4/TBKTkp/4v9/KDeaxeb9/nr9
         5zxl2ZVCiLk8k5BfNuLJ41Nw6D5HVMhbug2wRdIzOE2zTo58sMQK1CVim3L1VYRD/OU0
         /Bt3Q8DwdvPiO0wH+XYu4CrlC71aME8ua5bycubf39Qb8wrAxfBdftV8CKpK/aoNnS1d
         dFAlm3EiNRhkeoEcVitTC10APso9/GJYyHUvL7Z+TrY7xcsS/nn+f0BfrZ0cEasA5SF4
         sZWA==
X-Gm-Message-State: ALoCoQmDdEzpcwAlvchdZmpapPoT4VVaIo/0PT+IeCbyB36Ky1aM30YDVrCa4XT5PXc3JjKF0s2h
X-Received: by 10.107.7.11 with SMTP id 11mr21564088ioh.81.1439228646424;
        Mon, 10 Aug 2015 10:44:06 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id k19sm13603642iok.20.2015.08.10.10.44.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Aug 2015 10:44:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275640>

Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
find_shared_symref and die if we find one.  This prevents simultaneous
merges to the same notes branch from different worktrees.

Signed-off-by: David Turner <dturner@twopensource.com>
---

This reroll addresses Eric Sunshine's comments on v5.

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
