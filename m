From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 2/2] notes: handle multiple worktrees
Date: Mon,  3 Aug 2015 14:48:26 -0400
Message-ID: <1438627706-6743-2-git-send-email-dturner@twopensource.com>
References: <1438627706-6743-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, johan@herland.net,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Aug 03 20:48:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMKmq-0002zG-4D
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 20:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbbHCSsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 14:48:33 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33810 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbbHCSsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 14:48:32 -0400
Received: by qkfc129 with SMTP id c129so54245617qkf.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 11:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tDZUFxSWilkHXu69KNKPA0DVM+MSfDN481W/yLHDMXI=;
        b=c7M/WhXUYFF5PQGfeGYdAyUm7r6bCZbJ/l9F3pMdHT94ZgyNwgAx39oo/6+pxfodHt
         lRb7rwnsyhoDIjcKnp+yOEwmFsSk/MuzG3t78kj9FG2sdI059jF/TvSQV2ZcwG4dVYY4
         RybVhF+ACd28FZl4w2WE/06e1fpwx5GEUqlbgCxSmAPNCJZu567AENhGOB3C4M2S79Dg
         +oydCHCMFGwmySySosG0bywOlvYoB50bFSsC/h/fY7a61wUO4DRO4SLkgvljew/Gl5G9
         APP01tVs1ZVbFVys+uIKwOz6igp/9B0eBurtCBfwIYwuOpp5FFlKiilHPGT36sJrkkvG
         3r1A==
X-Gm-Message-State: ALoCoQktAAwmZ+Hosoc+TY102XYIVcjL3C8R5pdsOiggwf8OJo5kItXyh5ctMTfIfQjawBlk9LvU
X-Received: by 10.55.25.150 with SMTP id 22mr27145362qkz.4.1438627711347;
        Mon, 03 Aug 2015 11:48:31 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id z18sm7321515qkz.3.2015.08.03.11.48.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Aug 2015 11:48:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438627706-6743-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275188>

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
