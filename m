From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/4] git-merge: Honor pre-commit hook based on config
Date: Thu,  6 Sep 2012 16:25:56 +0200
Message-ID: <882ac21b36f2498492f6ca2be2df6c446b3a290b.1346939542.git.git@drmicha.warpmail.net>
References: <50487F8A.4050803@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 16:26:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9d25-0001zj-Bc
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab2IFO0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:26:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54078 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756046Ab2IFO0D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 10:26:03 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4C82A20CA8;
	Thu,  6 Sep 2012 10:26:03 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 06 Sep 2012 10:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=E+
	HwStRfN1GATkA84nN26ISmxv4=; b=Ky05Gigwv9mhFcllvWt/A9EuYs5aZWtjqd
	SS4Ak2Nte1FtyJUlN6i3Rp7+ugN5qkvHiEo+QGfznhzwyWpb+ol0ycSdXHD3p/ak
	dLya7Q8Xq510H/dI5ygtujf22NIo/CmgpSx7h5ZX7sB20cnFGye7lCwBs36K2b/T
	DYFgYU89o=
X-Sasl-enc: +NR+lfjhgoo9DvUou9WGxCadRRRA2K0Z9rYKhyixs4Iu 1346941562
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B573B8E00A2;
	Thu,  6 Sep 2012 10:26:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
In-Reply-To: <50487F8A.4050803@alum.mit.edu>
In-Reply-To: <cover.1346939542.git.git@drmicha.warpmail.net>
References: <cover.1346939542.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204887>

git-merge does not honor the pre-commit hook when doing automatic merge
commits, and for compatibility reasons this is going to stay.

Introduce a merge.usePreCommitHook which controls whether an automatic
merge commit invokes pre-commit.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-merge.txt    |  2 +-
 Documentation/githooks.txt     |  3 +++
 Documentation/merge-config.txt |  5 +++++
 builtin/merge.c                | 17 ++++++++++++++++-
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b3ba8a8..3501ae2 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -310,7 +310,7 @@ branch.<name>.mergeoptions::
 
 HOOKS
 -----
-This command can run the `prepare-commit-msg` hook.
+This command can run the `prepare-commit-msg` and `pre-commit` hooks.
 See linkgit:githooks[5] for more information.
 
 SEE ALSO
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b32134c..d62e02d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -86,6 +86,9 @@ All the 'git commit' hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
 to modify the commit message.
 
+If the configuration option `merge.usePreCommitHook` is set to `true`
+then 'git merge' invokes this hook whenever it creates a new commit.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 861bd6f..727caad 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -59,6 +59,11 @@ merge.tool::
 	and "xxdiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
+merge.usePreCommitHook::
+	Controls whether the pre-commit hook is invoked when 'git merge'
+	creates a new commit (true merge without conflicts).  False by
+	default.
+
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
 	strategy.  Level 0 outputs nothing except a final error
diff --git a/builtin/merge.c b/builtin/merge.c
index 0ec8f0d..a2590a9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -64,6 +64,7 @@ static int allow_rerere_auto;
 static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream;
+static int use_pre_commit_hook;
 static const char *sign_commit;
 
 static struct strategy all_strategy[] = {
@@ -575,6 +576,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
+	} else if (!strcmp(k, "merge.useprecommithook")) {
+		use_pre_commit_hook = git_config_bool(k, v);
+		return 0;
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
@@ -898,12 +902,23 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *comment = _(merge_editor_comment);
+	const char *index_file = get_index_file();
+
+	if (use_pre_commit_hook && run_hook(index_file, "pre-commit", NULL))
+		abort_commit(remoteheads, NULL);
+	/*
+	 * Re-read the index as pre-commit hook could have updated it,
+	 * and write it out as a tree.  We must do this before we invoke
+	 * the editor and after we invoke run_status above.
+	 */
+	discard_cache();
+	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
 	if (0 < option_edit)
 		strbuf_add_lines(&msg, "# ", comment, strlen(comment));
 	write_merge_msg(&msg);
-	run_hook(get_index_file(), "prepare-commit-msg",
+	run_hook(index_file, "prepare-commit-msg",
 		 git_path("MERGE_MSG"), "merge", NULL, NULL);
 	if (0 < option_edit) {
 		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
-- 
1.7.12.406.gafd3f81
