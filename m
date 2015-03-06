From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 3/3] commit/status: show the index-worktree diff with -v -v
Date: Fri,  6 Mar 2015 10:43:35 +0100
Message-ID: <8aaef5cee137a213efc90ab6dacff0837cb8d077.1425634616.git.git@drmicha.warpmail.net>
References: <mqqfv9j2nqu.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 10:44:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTonX-000163-71
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 10:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbbCFJny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 04:43:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36273 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932918AbbCFJnn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 04:43:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CF88020C36
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 04:43:40 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 06 Mar 2015 04:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=2L8cfbtKhRep58K5lAah5I3Razc=; b=dJ9nqKY2ggYpUhCBRvSB
	GuQBZ3Z3rillT9XdOqbD+sKKEg3Vc4r+mrGYHfCiSH/LmKd3t39M1jtX5INMYEog
	joYqmrZA/z9+48Y3Wt7t25pyu9/1Knadk5bwFrB146Wq37Zs8TpQhG8dFCFcMQ/n
	zXo3flhJrH9VUJqPjO6B6Kw=
X-Sasl-enc: NxNFwumjX7U3r6UzvtNUK70O4uepNur1h9PWWNGVSj9Q 1425635021
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 88B156800F4;
	Fri,  6 Mar 2015 04:43:41 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <mqqfv9j2nqu.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1425634616.git.git@drmicha.warpmail.net>
References: <cover.1425634616.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264904>

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
part; the latter preceded by 50*"-" to make it stick out more.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-commit.txt |  4 ++++
 t/t7508-status.sh            | 11 +++++++++++
 wt-status.c                  | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+)

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
index e3c9cf9..6b16bcb 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -143,6 +143,17 @@ test_expect_success 'status -v' '
 	test_i18ncmp expect-with-v output
 '
 
+test_expect_success 'status -v -v' '
+	(cat expect &&
+	 echo "Changes to be committed:" &&
+	 git -c diff.mnemonicprefix=true diff --cached &&
+	 echo "--------------------------------------------------" &&
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
index 29666d0..422dc0e 100644
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
@@ -873,7 +875,25 @@ static void wt_status_print_verbose(struct wt_status *s)
 		rev.diffopt.use_color = 0;
 		wt_status_add_cut_line(s->fp);
 	}
+	if (s->verbose > 1 && s->commitable) {
+		/* print_updated() printed a header, so do we */
+		if (s->fp != stdout)
+			wt_status_print_trailer(s);
+		status_printf_ln(s, c, _("Changes to be committed:"));
+		rev.diffopt.a_prefix = "c/";
+		rev.diffopt.b_prefix = "i/";
+	} /* else use prefix as per user config */
 	run_diff_index(&rev, 1);
+	if (s->verbose > 1 &&
+	    wt_status_check_worktree_changes(s, &dirty_submodules)) {
+		status_printf_ln(s, c,
+			"--------------------------------------------------");
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
