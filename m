From: Christian Thaeter <ct@pipapo.org>
Subject: [PATCH 5/5] Make setup_git_directory reentrant
Date: Mon,  7 Jan 2008 06:47:35 +0100
Message-ID: <1199684855-14246-5-git-send-email-ct@pipapo.org>
References: <1199684855-14246-1-git-send-email-ct@pipapo.org>
 <1199684855-14246-2-git-send-email-ct@pipapo.org>
 <1199684855-14246-3-git-send-email-ct@pipapo.org>
 <1199684855-14246-4-git-send-email-ct@pipapo.org>
Cc: gitster@pobox.com, Christian Thaeter <ct@pipapo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 06:49:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBkr7-0006jE-0l
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 06:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbYAGFru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 00:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbYAGFrt
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 00:47:49 -0500
Received: from pipapo.org ([217.140.77.75]:1102 "EHLO mail.pipapo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755196AbYAGFro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 00:47:44 -0500
Received: from localhost (mercur.pipapo.org [10.20.70.10])
	by mail.pipapo.org (Postfix) with SMTP id 7B10E34F5C01D;
	Mon,  7 Jan 2008 06:47:41 +0100 (CET)
Received: by localhost (sSMTP sendmail emulation); Mon, 07 Jan 2008 06:47:40 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <1199684855-14246-4-git-send-email-ct@pipapo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69766>

Reentrant means here one can call it serveral times for different repos.

The functionality introduced here (based on earlier commits) is sufficent
to call setup_git_directory() for inspecting the refs like generating a
repository list for a browser. For full reset some more works needs
to be done later.

Signed-off-by: Christian Thaeter <ct@pipapo.org>
---
 setup.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index adede16..770dc41 100644
--- a/setup.c
+++ b/setup.c
@@ -200,6 +200,8 @@ static const char *set_work_tree(const char *dir)
 
 	if (!getcwd(buffer, sizeof(buffer)))
 		die ("Could not get the current working directory");
+	if (git_work_tree_cfg)
+		free (git_work_tree_cfg);
 	git_work_tree_cfg = xstrdup(buffer);
 	inside_work_tree = 1;
 
@@ -329,6 +331,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	inside_git_dir = 0;
 	if (!work_tree_env)
 		inside_work_tree = 1;
+	if (git_work_tree_cfg)
+		free (git_work_tree_cfg);
 	git_work_tree_cfg = xstrndup(cwd, offset);
 	if (check_repository_format_gently(nongit_ok))
 		return NULL;
@@ -387,7 +391,14 @@ int check_repository_format(void)
 
 const char *setup_git_directory(void)
 {
-	const char *retval = setup_git_directory_gently(NULL);
+	const char *retval;
+
+	inside_git_dir = -1;
+	inside_work_tree = -1;
+	git_invalidate_cached_refs();
+	reset_packed_git();
+	reset_git_work_tree();
+	retval = setup_git_directory_gently(NULL);
 
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
-- 
1.5.3.7
