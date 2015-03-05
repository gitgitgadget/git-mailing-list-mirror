From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 3/3] commit/status: show the index-worktree diff with -v -v
Date: Thu,  5 Mar 2015 15:13:04 +0100
Message-ID: <cae757b238bdd71bf8d03f9040a08466194c3440.1425564336.git.git@drmicha.warpmail.net>
References: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 15:13:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTWWq-0008Py-6K
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 15:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbbCEONR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 09:13:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46165 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755984AbbCEONL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 09:13:11 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 41BD72085C
	for <git@vger.kernel.org>; Thu,  5 Mar 2015 09:13:09 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 05 Mar 2015 09:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=NVN4HUJ9BP8YMZ+oJUwxhHYqgUc=; b=XMuKjO02G0xeBHzJC81A
	taIAnH1/h8GWaoNF/eOJ1fuf85CbWQ1KYvIj6kEXyLzABBjxX467jFEd55tcrTOI
	hx7aF0e5Clgxy38Q+4B5mgLTJWmoY2P4bspVmPyJHEDIXD90UYYVBzpwyfQWxB1g
	Z5dzzMa/dCfZrsoKY7zv604=
X-Sasl-enc: 71nkeLguzOlEGCx6/S5OnqyWq9aqjDohRbZGDU5Raz8q 1425564790
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F2CE3C002A6;
	Thu,  5 Mar 2015 09:13:09 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1425564336.git.git@drmicha.warpmail.net>
References: <cover.1425564336.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264839>

git commit and git status in long format show the diff between HEAD
and the index when given -v. This allows previewing a commit to be made.

They also list tracked files with unstaged changes, but without a diff.

Introduce '-v -v' which shows the diff between the index and the
worktree in addition to the HEAD index diff. This allows a review of unstaged
changes which might be missing from the commit.

In the case of '-v -v', additonal header lines

Changes to be committed:

and

Changes not staged for commit:

are inserted before the diffs, which are equal to those in the status
part.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-commit.txt |  4 ++++
 t/t7508-status.sh            | 10 ++++++++++
 wt-status.c                  | 16 ++++++++++++++++
 3 files changed, 30 insertions(+)

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
index e3c9cf9..b392376 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -143,6 +143,16 @@ test_expect_success 'status -v' '
 	test_i18ncmp expect-with-v output
 '
 
+test_expect_success 'status -v -v' '
+	(cat expect &&
+	 echo "Changes to be committed:" &&
+	 git -c diff.mnemonicprefix=true diff --cached &&
+	 echo "Changes not staged for commit:" &&
+	 git -c diff.mnemonicprefix=true diff) >expect-with-v &&
+	git status -v -v >output &&
+	test_i18ncmp expect-with-v output
+'
+
 test_expect_success 'setup fake editor' '
 	cat >.git/editor <<-\EOF &&
 	#! /bin/sh
diff --git a/wt-status.c b/wt-status.c
index 29666d0..3cdb356 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -849,6 +849,8 @@ static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	int dirty_submodules;
+	const char *c = color(WT_STATUS_HEADER, s);
 
 	init_revisions(&rev, NULL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
@@ -873,7 +875,21 @@ static void wt_status_print_verbose(struct wt_status *s)
 		rev.diffopt.use_color = 0;
 		wt_status_add_cut_line(s->fp);
 	}
+	if (s->verbose > 1 && s->commitable) {
+		/* print_updated() printed header */
+		status_printf_ln(s, c, _("Changes to be committed:"));
+		rev.diffopt.a_prefix = "c/";
+		rev.diffopt.b_prefix = "i/";
+	} /* else use prefix as per user config */
 	run_diff_index(&rev, 1);
+	if (s->verbose > 1 &&
+	    wt_status_check_worktree_changes(s, &dirty_submodules)) {
+		status_printf_ln(s, c, _("Changes not staged for commit:"));
+		setup_work_tree();
+		rev.diffopt.a_prefix = "i/";
+		rev.diffopt.b_prefix = "w/";
+		run_diff_files(&rev, 0);
+	}
 }
 
 static void wt_status_print_tracking(struct wt_status *s)
-- 
2.3.1.303.g5174db1
