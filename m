From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] merge: --no-verify to bypass pre-merge hook
Date: Wed,  5 Sep 2012 15:39:10 +0200
Message-ID: <2b6dd795b58f6303e1c1fac242825fe95f150b34.1346851863.git.git@drmicha.warpmail.net>
References: <cover.1346851863.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 15:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9FpF-0008Eq-7W
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 15:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab2IENjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 09:39:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57590 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752743Ab2IENjR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 09:39:17 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 895BC20C39
	for <git@vger.kernel.org>; Wed,  5 Sep 2012 09:39:16 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 05 Sep 2012 09:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=SjGjufYBK7C4Sp8KLA+Ivitup
	VE=; b=Yl20s1Chh7Nuh75PD97Fcl9eIzkLet+nL1piGknugYhT0c5Q0EEZ8uOQd
	W505p28F5oN1I3VK0kS7tzenZ8H3WwxveUOEKl27JUvySuQh6zS+eeGjunGqD8U7
	g0tItt882WxTdzORq96OfOXq+5/jhz0wfJPIQv+uLlv8ZZnHn0=
X-Sasl-enc: VCAZ5yh5JDeQwpfxpfy5hTtprmtMUL9FfCuGsWGPA0Pl 1346852356
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2F9818E03D0;
	Wed,  5 Sep 2012 09:39:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
In-Reply-To: <cover.1346851863.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204827>

Analogous to commit, introduce a '--no-verify' option which bypasses the
pre-merge hook. The shorthand '-n' is taken by the (non-existing)
'--no-stat' already.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-merge.txt     | 2 +-
 Documentation/githooks.txt      | 2 +-
 Documentation/merge-options.txt | 4 ++++
 builtin/merge.c                 | 4 +++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 20f9228..8816865 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>]
+	[--no-verify] [-s <strategy>] [-X <strategy-option>]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3fae643..e20bfe0 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -91,7 +91,7 @@ pre-merge
 
 This hook is invoked by 'git merge' when doing an automatic merge
 commit; it is equivalent to 'pre-commit' for a non-automatic commit
-for a merge.
+for a merge, and can be bypassed with the `\--no-verify` option. 
 
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 0bcbe0a..93e2e61 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -70,6 +70,10 @@ merge.
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
 
+--no-verify::
+	This option bypasses the pre-merge and commit-msg hooks.
+	See also linkgit:githooks[5].
+
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/builtin/merge.c b/builtin/merge.c
index 7c09e0b..4d36a00 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -60,6 +60,7 @@ static const char *branch;
 static char *branch_mergeoptions;
 static int option_renormalize;
 static int verbosity;
+static int no_verify;
 static int allow_rerere_auto;
 static int abort_current_merge;
 static int show_progress = -1;
@@ -198,6 +199,7 @@ static struct option builtin_merge_options[] = {
 		N_("allow fast-forward (default)")),
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
 		N_("abort if fast-forward is not possible")),
+	OPT_BOOLEAN(0, "no-verify", &no_verify, "bypass pre-merge hook"),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
@@ -900,7 +902,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	const char *comment = _(merge_editor_comment);
 	const char *index_file = get_index_file();
 
-	if (run_hook(index_file, "pre-merge", NULL))
+	if (!no_verify && run_hook(index_file, "pre-merge", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge hook could have updated it,
-- 
1.7.12.406.gafd3f81
