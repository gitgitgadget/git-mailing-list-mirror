From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] diffcore-rename: don't consider unmerged path as source
Date: Thu, 17 Mar 2011 21:42:28 -0400
Message-ID: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 02:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0OiK-0004XG-Rp
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 02:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab1CRBmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 21:42:47 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35395 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab1CRBmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 21:42:46 -0400
Received: by vxi39 with SMTP id 39so3184281vxi.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=6tbUd/yXgBpcbeA5WTIB8ZdKfVqmxkxpU8IsdB9Rd80=;
        b=WJ8llxdvWv0sH8hnjiWCygiY7D7Vj6+TzToljaHzKIoJvAEL2zdHRHXJ+RIjU2zeoF
         g+hfXsjYtINC0SdQjngStSeTTY0hipHvSKhabCjQwccBz7Gk/yMzE/eAdhwJZL7nBjgb
         fpse6d0l3F+X4JF9ek+JUv3up8yYDTIK0REKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uOAjjgKxoLhYztVY++v53oLU3okUDTjV73ibGq4eJO5kT65Ecx0kuaEhrYUC27IjqI
         93rf2g3LlE0Zp6HPzghPM70LtAkLqi6fGhaTmF0Yv1O6Q/TfLxPTtxFulI/0C5hx1rTJ
         6msi8g3//DlNmkrSMPxSv4+PG7hArkxiFb5/c=
Received: by 10.220.59.138 with SMTP id l10mr135605vch.138.1300412565524;
        Thu, 17 Mar 2011 18:42:45 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id eo11sm846748vcb.3.2011.03.17.18.42.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 18:42:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169289>

The output from 'git status' and 'git diff-index --cached -M' is
broken when there are unmerged files as well as new files similar to
the unmerged file (in stage 1).

When two copies have been created the output is:

$ git status -s
C  original -> exact-copy
R  original -> modified-copy
 U original

There are several errors here: 1) "original" has invalid status " U",
2) "modified-copy" is listed as a rename, even though its source
("original") still exists, and 3) "exact-copy" is detected as a copy,
even though 'git status' is only supposed to show renames

In the verbose 'git status' output, the unmerged path is completely
missing. 'git diff-index --cached -M' show similar output.

Fix these problems by making diffcore-rename not consider unmerged
paths as source for rename detection. For simplicty, don't consider
the path independent of the type of merge conflict, even if the path
is deleted on at least one side. Still consider unmerged paths as
source for copy detection.

While at it, update the users of diff_options to use
DIFF_DETECT_RENAME instead of directly using the value 1 to enable
rename detection.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

This is the first time I look at the diff code, so please review
carefully. I think the changes make sense, but I really don't know the
code enough to be sure.

Also not sure about the "while at it" stuff...

The test cases assume that the paths will be printed in a certain
order. Can I rely on that?

 builtin/commit.c                    |    2 +-
 diffcore-rename.c                   |    7 +++-
 t/t7510-status-merge-rename-copy.sh |   68 +++++++++++++++++++++++++++++++++++
 wt-status.c                         |    6 ++--
 4 files changed, 77 insertions(+), 6 deletions(-)
 create mode 100755 t/t7510-status-merge-rename-copy.sh

diff --git a/builtin/commit.c b/builtin/commit.c
index 82092e5..1f9f314 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1284,7 +1284,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.show_root_diff = 1;
 	get_commit_format(format.buf, &rev);
 	rev.always_show_header = 0;
-	rev.diffopt.detect_rename = 1;
+	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
 	rev.diffopt.rename_limit = 100;
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0cd4c13..c53ca36 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -464,7 +464,7 @@ void diffcore_rename(struct diff_options *options)
 			else
 				locate_rename_dst(p->two, 1);
 		}
-		else if (!DIFF_FILE_VALID(p->two)) {
+		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
 			/*
 			 * If the source is a broken "delete", and
 			 * they did not really want to get broken,
@@ -575,7 +575,10 @@ void diffcore_rename(struct diff_options *options)
 		struct diff_filepair *p = q->queue[i];
 		struct diff_filepair *pair_to_free = NULL;
 
-		if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
+		if (DIFF_PAIR_UNMERGED(p)) {
+			diff_q(&outq, p);
+		}
+		else if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
 			/*
 			 * Creation
 			 *
diff --git a/t/t7510-status-merge-rename-copy.sh b/t/t7510-status-merge-rename-copy.sh
new file mode 100755
index 0000000..8c7a4d2
--- /dev/null
+++ b/t/t7510-status-merge-rename-copy.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Martin von Zweigbergk
+#
+
+test_description='git status during merge with copies'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo a b c | xargs -n1 >original &&
+	git add original &&
+	git commit -m initial &&
+
+	cp original exact-copy &&
+	cp original modified-copy &&
+	echo x >>original &&
+	echo y >>modified-copy &&
+	git add original exact-copy modified-copy &&
+	git commit -m "create copies and modify original on master" &&
+
+	git checkout -b topic HEAD^ &&
+	echo z >>original &&
+	git add original &&
+	git commit -m "modify original on topic" &&
+	test_must_fail git merge master
+'
+
+cat >expected <<\EOF
+A  exact-copy
+A  modified-copy
+UU original
+EOF
+
+test_expect_success 'git status -s shows 2 added + 1 unmerged' '
+	git status -s -uno >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+A	exact-copy
+A	modified-copy
+U	original
+EOF
+
+test_expect_success 'git diff-index --cached shows 2 added + 1 unmerged' '
+	git diff-index --cached --name-status HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff-index --cached -M shows 2 added + 1 unmerged' '
+	git diff-index --cached --name-status HEAD >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+C	original	exact-copy
+C	original	modified-copy
+U	original
+EOF
+
+test_expect_success 'git diff-index --cached -C shows 2 copies + 1 unmerged' '
+	git diff-index --cached -C --name-status HEAD |
+		sed "s/^C[0-9]*/C/g" >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 4daa8bb..532bbcc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -320,7 +320,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	if (s->ignore_submodule_arg) {
 		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
-    }
+	}
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data = s;
 	init_pathspec(&rev.prune_data, s->pathspec);
@@ -345,7 +345,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data = s;
-	rev.diffopt.detect_rename = 1;
+	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
 	rev.diffopt.rename_limit = 200;
 	rev.diffopt.break_opt = 0;
 	init_pathspec(&rev.prune_data, s->pathspec);
@@ -597,7 +597,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
-	rev.diffopt.detect_rename = 1;
+	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
 	rev.diffopt.file = s->fp;
 	rev.diffopt.close_file = 0;
 	/*
-- 
1.7.4.79.gcbe20
