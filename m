From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH 2/2] builtin-commit: show on which branch a commit was added
Date: Mon,  8 Sep 2008 01:05:41 +0200
Message-ID: <1220828741-91050-2-git-send-email-pdebie@ai.rug.nl>
References: <7vd4jgpkce.fsf@gitster.siamese.dyndns.org>
 <1220828741-91050-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:07:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcTLg-0002pm-3l
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbYIGXF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbYIGXF5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:05:57 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:24540 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbYIGXFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:05:55 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6107.online.nl (SMTP Server) with ESMTP id 40A137000083;
	Mon,  8 Sep 2008 01:05:52 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6107.online.nl (SMTP Server) with ESMTP id A2E1A7000081;
	Mon,  8 Sep 2008 01:05:51 +0200 (CEST)
X-ME-UUID: 20080907230551667.A2E1A7000081@mwinf6107.online.nl
X-Mailer: git-send-email 1.6.0.1.346.g880d9.dirty
In-Reply-To: <1220828741-91050-1-git-send-email-pdebie@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95188>

This outputs the current branch on which a commit was created, just for
reference. For example:

	Created commit 6d42875 on master: Fix submodule invalid command error

This also reminds the committer when he is on a detached HEAD:

	Created commit 02a7172 on detached HEAD: Also do this for 'git commit --amend'

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 builtin-commit.c |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 8165bb3..47b76e6 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -878,10 +878,37 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	return commitable ? 0 : 1;
 }
 
+static char *get_commit_format_string(void)
+{
+	unsigned char sha[20];
+	const char *head = resolve_ref("HEAD", sha, 0, NULL);
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addstr(&buf, "format:%h");
+
+	/* Are we on a detached HEAD? */
+	if (!strcmp("HEAD", head))
+		strbuf_addstr(&buf, " on detached HEAD");
+	else if (!prefixcmp(head, "refs/heads/")) {
+		const char *cp;
+		strbuf_addstr(&buf, " on ");
+		for (cp = head + 11; *cp; cp++) {
+			if (*cp == '%')
+				strbuf_addstr(&buf, "%%");
+			else
+				strbuf_addch(&buf, *cp);
+		}
+	}
+	strbuf_addstr(&buf, ": %s");
+
+	return strbuf_detach(&buf, NULL);
+}
+
 static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
 	struct commit *commit;
+	char *format = get_commit_format_string();
 
 	commit = lookup_commit(sha1);
 	if (!commit)
@@ -899,7 +926,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
-	get_commit_format("format:%h: %s", &rev);
+	get_commit_format(format, &rev);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
@@ -910,10 +937,11 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
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
