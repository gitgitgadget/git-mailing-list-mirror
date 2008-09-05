From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Fri,  5 Sep 2008 19:13:05 +0200
Message-ID: <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 19:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbet4-0007EB-JV
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 19:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYIERNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 13:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYIERNL
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 13:13:11 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:45443 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbYIERNK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 13:13:10 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6208.online.nl (SMTP Server) with ESMTP id D4BC61C00086;
	Fri,  5 Sep 2008 19:13:07 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6208.online.nl (SMTP Server) with ESMTP id F19FA1C00082;
	Fri,  5 Sep 2008 19:13:06 +0200 (CEST)
X-ME-UUID: 20080905171306989.F19FA1C00082@mwinf6208.online.nl
X-Mailer: git-send-email 1.6.0.1.346.g880d9.dirty
In-Reply-To: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95024>

This outputs the current branch on which a commit was created, just for
reference. For example:

	Created commit 6d42875 on master: Fix submodule invalid command error

This also reminds the committer when he is on a detached HEAD:

	Created commit 02a7172 on detached HEAD: Also do this for 'git commit --amend'

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 builtin-commit.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 8165bb3..a82483d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -878,10 +878,31 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	return commitable ? 0 : 1;
 }
 
+static char* get_commit_format_string()
+{
+	unsigned char sha[20];
+	const char* head = resolve_ref("HEAD", sha, 0, NULL);
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addstr(&buf, "format:%h");
+
+	/* Are we on a detached HEAD? */
+	if (!strcmp("HEAD", head))
+		strbuf_addstr(&buf, " on detached HEAD");
+	else if (!prefixcmp(head, "refs/heads/")) {
+		strbuf_addstr(&buf, " on ");
+		strbuf_addstr(&buf, head + 11);
+	}
+	strbuf_addstr(&buf, ": %s");
+
+	return buf.buf;
+}
+
 static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
 	struct commit *commit;
+	char* format = get_commit_format_string();
 
 	commit = lookup_commit(sha1);
 	if (!commit)
@@ -899,7 +920,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
-	get_commit_format("format:%h: %s", &rev);
+	get_commit_format(format, &rev);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
@@ -910,10 +931,11 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	if (!log_tree_commit(&rev, commit)) {
 		struct strbuf buf = STRBUF_INIT;
-		format_commit_message(commit, "%h: %s", &buf, DATE_NORMAL);
+		format_commit_message(commit, format + 7, &buf, DATE_NORMAL);
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
 	}
+	free(format);
 }
 
 static int git_commit_config(const char *k, const char *v, void *cb)
-- 
1.6.0.1.346.g880d9.dirty
