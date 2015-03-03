From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] commit/status: show the index-worktree diff with -v -v
Date: Tue,  3 Mar 2015 15:16:22 +0100
Message-ID: <33591b47a7ea8cfa23a3bee05fbf8c0ce4a00b3d.1425390756.git.git@drmicha.warpmail.net>
References: <54B8C82E.8000707@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 15:16:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSncd-0007Wf-FO
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 15:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbbCCOQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 09:16:29 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40929 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756510AbbCCOQ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 09:16:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D708220BFF
	for <git@vger.kernel.org>; Tue,  3 Mar 2015 09:16:25 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 03 Mar 2015 09:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=5iYn0F7S+VBNCxSY1oLjC/UE2EI=; b=cM72S54nWplcC4GsgiUV
	QdWwVEMM4vg4STB1crTKySDQce19hQDxMM1QkM3s9uY5m3doxQgFvvLQEanRf/iE
	f4qxr5+4unRsVyKD/kv8FZVt0oIoedUqHrD9P6jAEhblP/tqRA0Xeq+VHvavjcXM
	Jm3lQmX9UPglHrJgf8YFZoo=
X-Sasl-enc: SY3PL+oUmlorQwcUjW0zU/r2++mbhgyg69534UcE667n 1425392186
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8D087C0029D;
	Tue,  3 Mar 2015 09:16:26 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <54B8C82E.8000707@drmicha.warpmail.net>
In-Reply-To: <cover.1425390756.git.git@drmicha.warpmail.net>
References: <cover.1425390756.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264658>

git commit and git status in long format show the diff between HEAD
and the index when given -v. This allows previewing a commit to be made.

They also list tracked files with unstaged changes, but without a diff.

Introduce '-v -v' which shows the diff between the index and the
worktree in addition to the HEAD index diff. This allows a review of unstaged
changes which might be missing from the commit.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-commit.txt |  4 ++++
 t/t7508-status.sh            | 43 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 10 ++++++++++
 3 files changed, 57 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1e74b75..f14d2ec 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -284,6 +284,10 @@ configuration variable documented in linkgit:git-config[1].
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
 	lines prefixed with '#'.
++
+If specified twice, show in addition the unified diff between
+what would be committed and the worktree files, i.e. the unstaged
+changes to tracked files.
 
 -q::
 --quiet::
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 4989e98..6779195 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -139,6 +139,49 @@ test_expect_success 'status -v' '
 	test_cmp expect output
 '
 
+cat >expect <<\EOF
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+	new file:   dir2/added
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working directory)
+
+	modified:   dir1/modified
+
+Untracked files:
+  (use "git add <file>..." to include in what will be committed)
+
+	dir1/untracked
+	dir2/modified
+	dir2/untracked
+	expect
+	output
+	untracked
+
+diff --git HEAD=base-commit/dir2/added INDEX=staged-for-commit/dir2/added
+new file mode 100644
+index 0000000..00750ed
+--- /dev/null
++++ INDEX=staged-for-commit/dir2/added
+@@ -0,0 +1 @@
++3
+diff --git INDEX=staged-for-commit/dir1/modified WORKTREE=not-staged-for-commit/dir1/modified
+index e69de29..d00491f 100644
+--- INDEX=staged-for-commit/dir1/modified
++++ WORKTREE=not-staged-for-commit/dir1/modified
+@@ -0,0 +1 @@
++1
+EOF
+
+test_expect_success 'status -v -v' '
+	git status -v -v >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'setup fake editor' '
 	cat >.git/editor <<-\EOF &&
 	#! /bin/sh
diff --git a/wt-status.c b/wt-status.c
index 29666d0..b6e9837 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -873,7 +873,17 @@ static void wt_status_print_verbose(struct wt_status *s)
 		rev.diffopt.use_color = 0;
 		wt_status_add_cut_line(s->fp);
 	}
+	if (s->verbose > 1) {
+		rev.diffopt.a_prefix = "HEAD=base-commit/";
+		rev.diffopt.b_prefix = "INDEX=staged-for-commit/";
+	} /* else use prefix as per user config */
 	run_diff_index(&rev, 1);
+	if (s->verbose > 1) {
+		setup_work_tree();
+		rev.diffopt.a_prefix = "INDEX=staged-for-commit/";
+		rev.diffopt.b_prefix = "WORKTREE=not-staged-for-commit/";
+		run_diff_files(&rev, 0);
+	}
 }
 
 static void wt_status_print_tracking(struct wt_status *s)
-- 
2.3.1.303.g5174db1
