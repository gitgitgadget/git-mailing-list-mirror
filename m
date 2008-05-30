From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] builtin-fast-export: Remove double spaces in author line
Date: Fri, 30 May 2008 12:31:15 +0200
Message-ID: <1212143475-48255-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 12:32:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K21u8-0000N2-5t
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 12:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYE3KbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 06:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbYE3KbU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 06:31:20 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:3493 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbYE3KbT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 06:31:19 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 62BC87000085;
	Fri, 30 May 2008 12:31:17 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 25E597000082;
	Fri, 30 May 2008 12:31:17 +0200 (CEST)
X-ME-UUID: 20080530103117155.25E597000082@mwinf6109.orange.nl
X-Mailer: git-send-email 1.5.6.rc0.163.g26db5e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83287>

At least the Samba repository has an extra space after the author's email
for some commits. This breaks builtin-fast-export as that format is required
to have only a single space.

This removes double spaces in committer and author lines.
---

This is an ugly hack and obviously not meant for application (which is why
I didn't sign it off). 

The Samba thing can be seen by running:

  git cat-file commit 65968b294351d2612d1bf94236d1fcbf853c494e

It produces 

	"author Samba Release Account <samba-bugs@samba.org>  831196245 +0000"

The git-fast-import syntax says there can only be a single space after the >
sign. This Samba commit breaks bzr-fast-import, for example.

I'm not sure how to properly fix the problem, as I'm not very deep into Git's
code. I included this patch in case anyone else has the same problem and wants
a quick fix. I'm also not sure if it's a fast-export problem, or if the Samba
repository is just invalid :)

- Pieter

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 1dfc01e..8218199 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -144,6 +144,24 @@ static const char *find_encoding(const char *begin, const char *end)
 	return bol;
 }
 
+static void parse_line(char **begin, char **end)
+{
+	char *b = *begin;
+	char *e = *end;
+
+	char *line = xmalloc((e - b) * sizeof(char));
+	*begin = line;
+	char prev = 0;
+
+	for (; b < e; b++) {
+		if (!(prev == ' ' && *b == ' '))
+			*line++ = *b;
+		prev = *b;
+	}
+
+	*end = line;
+}
+
 static void handle_commit(struct commit *commit, struct rev_info *rev)
 {
 	int saved_output_format = rev->diffopt.output_format;
@@ -163,11 +181,14 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	author++;
 	author_end = strchrnul(author, '\n');
 	committer = strstr(author_end, "\ncommitter ");
+	parse_line(&author, &author_end);
+
 	if (!committer)
 		die ("Could not find committer in commit %s",
 		     sha1_to_hex(commit->object.sha1));
 	committer++;
 	committer_end = strchrnul(committer, '\n');
+	parse_line(&committer, &committer_end);
 	message = strstr(committer_end, "\n\n");
 	encoding = find_encoding(committer_end, message);
 	if (message)
@@ -214,6 +235,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 
 	printf("\n");
 
+	free(committer);
+	free(author);
 	show_progress();
 }
 
-- 
1.5.6.rc0.163.g26db5e.dirty
