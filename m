From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] builtin-commit: fix author date with --amend --author=<author>
Date: Thu, 8 Nov 2007 12:16:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081215540.4362@racer.site>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 08 13:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6JE-0007wj-Gq
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758986AbXKHMQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758954AbXKHMQN
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:16:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:53239 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758931AbXKHMQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:16:13 -0500
Received: (qmail invoked by alias); 08 Nov 2007 12:16:11 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp027) with SMTP; 08 Nov 2007 13:16:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AOPYZptkA/PR3xd7zYkqCv687trnJ2aUPN/GXnH
	MDJiD+SR4LUkd3
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711081213580.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64007>


When amending a commit with a new author, the author date is taken
from the original commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index bba9b82..03f0b9d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -278,7 +278,6 @@ static void determine_author_info(struct strbuf *sb)
 			die("malformed --author parameter\n");
 		name = xstrndup(force_author, eoname - force_author);
 		email = xstrndup(eoname + 2, eomail - eoname - 2);
-		/* REVIEW: drops author date from amended commit on --amend --author=<author> */
 		strbuf_addf(sb, "author %s\n",
 			    fmt_ident(name, email,
 				      getenv("GIT_AUTHOR_DATE"), 1));
@@ -525,6 +524,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	} else if (amend) {
 		struct commit_list *c;
 		struct commit *commit;
+		const char *author;
 
 		reflog_msg = "commit (amend)";
 		commit = lookup_commit(head_sha1);
@@ -534,6 +534,21 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
1.5.3.5.1634.g0fa78
