From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] git-merge: Honor pre-merge hook
Date: Wed,  5 Sep 2012 15:39:09 +0200
Message-ID: <dc8ebcd7f7b80ff930c04b5a407361ba8f2f077f.1346851863.git.git@drmicha.warpmail.net>
References: <cover.1346851863.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 15:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9FpE-0008Eq-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 15:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab2IENjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 09:39:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42106 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752469Ab2IENjP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 09:39:15 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1012420D78
	for <git@vger.kernel.org>; Wed,  5 Sep 2012 09:39:15 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 05 Sep 2012 09:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=ZrbrJAOvxC/xRgNgRcFBsU/SC
	ps=; b=YLkqUyF1eBxkiiwW01NeDfn+g7Wa3ehXiSauLVPJSZtwxFHCyXzCJfjhd
	008gfijDrmGFNFj6aNt7SR20q2+htIlrsjtML8cyxopAhokt3drddxlcx780KDW1
	oyTQ5QIRaD8jmgzpCOoXbnPmAq9uRn3l1WiDhnIlhdWxQM0Xsk=
X-Sasl-enc: KUvmRDIiTqjLw1v/X+L4uu76zmMibrATRvqfQ5keb2da 1346852354
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9F5734836EE;
	Wed,  5 Sep 2012 09:39:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
In-Reply-To: <cover.1346851863.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204826>

git-merge does not honor the pre-commit hook when doing automatic merge
commits, and for compatibility reasons this is going to stay.

Introduce a pre-merge hook which is called for an automatic merge commit
just like pre-commit is called for a non-automatic merge commit (or any
other commit).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/githooks.txt        |  7 +++++++
 builtin/merge.c                   | 13 ++++++++++++-
 templates/hooks--pre-merge.sample | 13 +++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 templates/hooks--pre-merge.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..3fae643 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -86,6 +86,13 @@ All the 'git commit' hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
 to modify the commit message.
 
+pre-merge
+~~~~~~~~~
+
+This hook is invoked by 'git merge' when doing an automatic merge
+commit; it is equivalent to 'pre-commit' for a non-automatic commit
+for a merge.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 0ec8f0d..7c09e0b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -898,12 +898,23 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
 	const char *comment = _(merge_editor_comment);
+	const char *index_file = get_index_file();
+
+	if (run_hook(index_file, "pre-merge", NULL))
+		abort_commit(remoteheads, NULL);
+	/*
+	 * Re-read the index as pre-merge hook could have updated it,
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
diff --git a/templates/hooks--pre-merge.sample b/templates/hooks--pre-merge.sample
new file mode 100755
index 0000000..a6313e6
--- /dev/null
+++ b/templates/hooks--pre-merge.sample
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# An example hook script to verify what is about to be committed.
+# Called by "git merge" with no arguments.  The hook should
+# exit with non-zero status after issuing an appropriate message if
+# it wants to stop the commit.
+#
+# To enable this hook, rename this file to "pre-merge".
+
+. git-sh-setup
+test -x "$GIT_DIR/hooks/pre-commit" &&
+        exec "$GIT_DIR/hooks/pre-commit"
+:
-- 
1.7.12.406.gafd3f81
