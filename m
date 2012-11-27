From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH v2 1/3] Process MERGE_MODE before MERGE_HEAD
Date: Wed, 28 Nov 2012 00:00:15 +0100
Message-ID: <1354057217-65886-2-git-send-email-draenog@pld-linux.org>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Kacper Kornet <draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:18:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUPq-00006C-Ud
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab2K0XRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:17:41 -0500
Received: from carme.pld-linux.org ([193.239.45.140]:13592 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab2K0XRi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:17:38 -0500
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1TdU8X-000H9P-9T; Wed, 28 Nov 2012 00:00:17 +0100
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210624>

It is in preparation to introduce --transpose-parents option to
git-merge, when the content of MERGE_MODE will dictate how the
MERGE_HEAD is interpreted.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 builtin/commit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1dd2ec5..273332f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1481,6 +1481,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
+		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
+				die_errno(_("could not read MERGE_MODE"));
+			if (!strcmp(sb.buf, "no-ff"))
+				allow_fast_forward = 0;
+		}
 		pptr = &commit_list_insert(current_head, pptr)->next;
 		fp = fopen(git_path("MERGE_HEAD"), "r");
 		if (fp == NULL)
@@ -1496,12 +1502,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		}
 		fclose(fp);
 		strbuf_release(&m);
-		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-				die_errno(_("could not read MERGE_MODE"));
-			if (!strcmp(sb.buf, "no-ff"))
-				allow_fast_forward = 0;
-		}
 		if (allow_fast_forward)
 			parents = reduce_heads(parents);
 	} else {
-- 
1.8.0.1
