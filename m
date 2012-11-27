From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH v2 2/3] Allow for MERGE_MODE to specify more then one mode
Date: Wed, 28 Nov 2012 00:00:16 +0100
Message-ID: <1354057217-65886-3-git-send-email-draenog@pld-linux.org>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Kacper Kornet <draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:18:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUPp-00006C-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328Ab2K0XRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:17:37 -0500
Received: from carme.pld-linux.org ([193.239.45.140]:13590 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab2K0XRf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:17:35 -0500
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1TdU8X-000H9T-ER; Wed, 28 Nov 2012 00:00:17 +0100
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210623>

Presently only one merge mode exists: non-fast-forward. But in future
the second one (transpose-parents) will be added, so the need to read
all lines of MERGE_MODE.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 builtin/commit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 273332f..ee0e884 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1427,7 +1427,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
-	struct stat statbuf;
 	int allow_fast_forward = 1;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
@@ -1481,11 +1480,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
-		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-				die_errno(_("could not read MERGE_MODE"));
-			if (!strcmp(sb.buf, "no-ff"))
-				allow_fast_forward = 0;
+		if((fp = fopen(git_path("MERGE_MODE"), "r"))) {
+			while (strbuf_getline(&m, fp, '\n') != EOF) {
+				if (!strcmp(m.buf, "no-ff"))
+					allow_fast_forward = 0;
+			}
+			fclose(fp);
 		}
 		pptr = &commit_list_insert(current_head, pptr)->next;
 		fp = fopen(git_path("MERGE_HEAD"), "r");
-- 
1.8.0.1
