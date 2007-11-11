From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/6] builtin-commit: fix author date with --amend --author=<author>
Date: Sun, 11 Nov 2007 17:35:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111735100.4362@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGiq-0005rO-Iy
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbXKKRfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437AbXKKRfa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:35:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:32839 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755160AbXKKRfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:35:30 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:35:28 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp041) with SMTP; 11 Nov 2007 18:35:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Fwox3vwwFipaLftcYOFelCAto6Zz+xmNETvu/Bh
	ZTreiOe1PxP4CO
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711111730580.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64479>


When amending a commit with a new author, the author date is taken
from the original commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index a84a729..6be6def 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -527,6 +527,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	} else if (amend) {
 		struct commit_list *c;
 		struct commit *commit;
+		const char *author;
 
 		reflog_msg = "commit (amend)";
 		commit = lookup_commit(head_sha1);
@@ -536,6 +537,21 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		for (c = commit->parents; c; c = c->next)
 			strbuf_addf(&sb, "parent %s\n",
 				      sha1_to_hex(c->item->object.sha1));
+
+		/* determine author date */
+		author = strstr(commit->buffer, "\nauthor");
+		if (author && !memmem(commit->buffer,
+					author + 1 - commit->buffer,
+					"\n\n", 2)) {
+			const char *email_end = strchr(author + 1, '>');
+			const char *line_end = strchr(author + 1, '\n');
+			if (email_end && line_end && email_end < line_end) {
+				char *date = xstrndup(email_end + 1,
+					line_end - email_end - 1);
+				setenv("GIT_AUTHOR_DATE", date, 1);
+				free(date);
+			}
+		}
 	} else if (in_merge) {
 		struct strbuf m;
 		FILE *fp;
-- 
1.5.3.5.1693.g26ed
