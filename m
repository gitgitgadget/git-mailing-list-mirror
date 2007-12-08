From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/3] Fix commit-msg hook to allow editing
Date: Sat,  8 Dec 2007 12:38:09 +0100
Message-ID: <1197113889-16243-4-git-send-email-win@wincent.com>
References: <1197113889-16243-1-git-send-email-win@wincent.com>
 <1197113889-16243-2-git-send-email-win@wincent.com>
 <1197113889-16243-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, krh@redhat.com,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 12:39:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0y1m-0002SN-2G
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbXLHLip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbXLHLip
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:38:45 -0500
Received: from wincent.com ([72.3.236.74]:34210 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbXLHLio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 06:38:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB8BcAAC021147;
	Sat, 8 Dec 2007 05:38:15 -0600
X-Mailer: git-send-email 1.5.3.7.1115.gaa595
In-Reply-To: <1197113889-16243-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67545>

The old git-commit.sh script allowed the commit-msg hook to not only
prevent a commit from proceding, but also to edit the commit message
on the fly and allow it to proceed. So here we teach builtin-commit
to do the same.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 builtin-commit.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index df9377e..a6223d2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -787,14 +787,18 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		const char *env[2] = { index, NULL };
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
 		launch_editor(git_path(commit_editmsg), &sb, env);
-	} else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
-		rollback_index_files();
-		die("could not read commit message");
 	}
-	if (!no_verify &&
-	    run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
+	if (!no_verify) {
+		if (run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
+			rollback_index_files();
+			exit(1);
+		}
+		strbuf_setlen(&sb, header_len);
+	}
+	if ((no_edit || !no_verify) &&
+	    strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
-		exit(1);
+		die("could not read commit message");
 	}
 
 	/* Truncate the message just before the diff, if any. */
-- 
1.5.3.7.1115.gaa595
