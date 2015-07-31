From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 2/2] notes: handle multiple worktrees
Date: Fri, 31 Jul 2015 18:11:09 -0400
Message-ID: <1438380669-11012-2-git-send-email-dturner@twopensource.com>
References: <1438380669-11012-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, johan@herland.net
X-From: git-owner@vger.kernel.org Sat Aug 01 00:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLIWV-00029V-Ar
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 00:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbbGaWLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 18:11:24 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35242 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbbGaWLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 18:11:22 -0400
Received: by qgii95 with SMTP id i95so55414099qgi.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 15:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DU6peK2MRI3tvkrJsRM2mWAiUjCtg2QkpvpZ/QUaTB0=;
        b=Cnyp5HluvkW2MTxGEC6UgnjPQKaDIPHmq8a+mmlOHKq/JbMgzpT2eOsjQ5RVo5e1Sa
         R7oZpm3BOF8bRftCfnMseAeL02NzJqYbr61ReJF/lqzH70n97Jf45Yf/BdhuYp4Xb0aO
         i05IsWcUS6+ilDsQ73PMQST+0P4rzMhKP+BAsVfRsw0FGbAipw2LyXXM4DEm0efm3rri
         dX/k79lRs4A2Km+ybnoWBNUz7VaSVWXDnRTkWPt9J1tm2p+1+9wRWcEwarQHFaLfIU8I
         f5KFRhf34iQKL2cerK1jgpCcGR1Rp9XeiyHbRQcynYlVAmttEYM1R1KjDIIrDEaOjK/x
         Bohg==
X-Gm-Message-State: ALoCoQmNkiAwQ3QFiNzRuopeHDiXl5ZtVoaphr46FVD4P26DOxoT4+ZkZkFtBn6/IBl3Ns7eJjBA
X-Received: by 10.140.195.198 with SMTP id q189mr8863496qha.57.1438380681764;
        Fri, 31 Jul 2015 15:11:21 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id t77sm2903661qge.42.2015.07.31.15.11.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Jul 2015 15:11:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438380669-11012-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275086>

Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
find_shared_symref and die if we find one.  This prevents simultaneous
merges to the same notes branch from different worktrees.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/notes.c                  |  5 +++
 t/t3320-notes-merge-worktrees.sh | 72 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100755 t/t3320-notes-merge-worktrees.sh

diff --git a/builtin/notes.c b/builtin/notes.c
index 63f95fc..e4dda79 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -19,6 +19,7 @@
 #include "string-list.h"
 #include "notes-merge.h"
 #include "notes-utils.h"
+#include "branch.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
@@ -825,10 +826,14 @@ static int merge(int argc, const char **argv, const char *prefix)
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
+			die(_("A notes merge on %s is already in-progress for %s"), default_notes_ref(), existing);
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 			die("Failed to store link to current notes ref (%s)",
 			    default_notes_ref());
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
new file mode 100755
index 0000000..997621f
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
+		grep "A notes merge on refs/notes/y is already in-progress for" err
+	) &&
+	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
+'
+
+test_expect_success 'merge z into x while mid-merge on y succeeds' '
+	(
+		cd worktree2 &&
+		git config core.notesRef refs/notes/x &&
+		test_must_fail git notes merge z 2>&1 >out &&
+		grep "Automatic notes merge failed" out
+		grep -v "A notes merge on refs/notes/x is already in-progress for" out
+	) &&
+	echo "ref: refs/notes/x" > expect &&
+	test_cmp .git/worktrees/worktree2/NOTES_MERGE_REF expect
+'
+
+test_done
-- 
2.0.4.315.gad8727a-twtrsrc
