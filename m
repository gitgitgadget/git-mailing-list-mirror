From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] mailmap: refactor mailmap parsing for non-file sources
Date: Wed, 12 Dec 2012 05:59:45 -0500
Message-ID: <20121212105945.GA19653@sigill.intra.peff.net>
References: <20121212105822.GA15842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 12:00:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tik2o-0006LT-N7
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab2LLK7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 05:59:50 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42756 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387Ab2LLK7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 05:59:49 -0500
Received: (qmail 22653 invoked by uid 107); 12 Dec 2012 11:00:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 06:00:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 05:59:45 -0500
Content-Disposition: inline
In-Reply-To: <20121212105822.GA15842@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211337>

The read_single_mailmap function opens a mailmap file and
parses each line. In preparation for having non-file
mailmaps, let's pull out the line-parsing logic into its own
function (read_mailmap_line), and rename the file-parsing
function to match (read_mailmap_file).

Signed-off-by: Jeff King <peff@peff.net>
---
Cleanup for the next patch. It's mostly indentation changes, so "diff
-w" is much easier to review.

 mailmap.c | 74 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index ea4b471..89bc318 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -129,44 +129,50 @@ static int read_single_mailmap(struct string_list *map, const char *filename, ch
 	return (*right == '\0' ? NULL : right);
 }
 
-static int read_single_mailmap(struct string_list *map, const char *filename, char **repo_abbrev)
+static void read_mailmap_line(struct string_list *map, char *buffer,
+			      char **repo_abbrev)
+{
+	char *name1 = NULL, *email1 = NULL, *name2 = NULL, *email2 = NULL;
+	if (buffer[0] == '#') {
+		static const char abbrev[] = "# repo-abbrev:";
+		int abblen = sizeof(abbrev) - 1;
+		int len = strlen(buffer);
+
+		if (!repo_abbrev)
+			return;
+
+		if (len && buffer[len - 1] == '\n')
+			buffer[--len] = 0;
+		if (!strncmp(buffer, abbrev, abblen)) {
+			char *cp;
+
+			if (repo_abbrev)
+				free(*repo_abbrev);
+			*repo_abbrev = xmalloc(len);
+
+			for (cp = buffer + abblen; isspace(*cp); cp++)
+				; /* nothing */
+			strcpy(*repo_abbrev, cp);
+		}
+		return;
+	}
+	if ((name2 = parse_name_and_email(buffer, &name1, &email1, 0)) != NULL)
+		parse_name_and_email(name2, &name2, &email2, 1);
+
+	if (email1)
+		add_mapping(map, name1, email1, name2, email2);
+}
+
+static int read_mailmap_file(struct string_list *map, const char *filename,
+			     char **repo_abbrev)
 {
 	char buffer[1024];
 	FILE *f = (filename == NULL ? NULL : fopen(filename, "r"));
 
 	if (f == NULL)
 		return 1;
-	while (fgets(buffer, sizeof(buffer), f) != NULL) {
-		char *name1 = NULL, *email1 = NULL, *name2 = NULL, *email2 = NULL;
-		if (buffer[0] == '#') {
-			static const char abbrev[] = "# repo-abbrev:";
-			int abblen = sizeof(abbrev) - 1;
-			int len = strlen(buffer);
-
-			if (!repo_abbrev)
-				continue;
-
-			if (len && buffer[len - 1] == '\n')
-				buffer[--len] = 0;
-			if (!strncmp(buffer, abbrev, abblen)) {
-				char *cp;
-
-				if (repo_abbrev)
-					free(*repo_abbrev);
-				*repo_abbrev = xmalloc(len);
-
-				for (cp = buffer + abblen; isspace(*cp); cp++)
-					; /* nothing */
-				strcpy(*repo_abbrev, cp);
-			}
-			continue;
-		}
-		if ((name2 = parse_name_and_email(buffer, &name1, &email1, 0)) != NULL)
-			parse_name_and_email(name2, &name2, &email2, 1);
-
-		if (email1)
-			add_mapping(map, name1, email1, name2, email2);
-	}
+	while (fgets(buffer, sizeof(buffer), f) != NULL)
+		read_mailmap_line(map, buffer, repo_abbrev);
 	fclose(f);
 	return 0;
 }
@@ -175,8 +181,8 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 {
 	map->strdup_strings = 1;
 	/* each failure returns 1, so >1 means both calls failed */
-	return read_single_mailmap(map, ".mailmap", repo_abbrev) +
-	       read_single_mailmap(map, git_mailmap_file, repo_abbrev) > 1;
+	return read_mailmap_file(map, ".mailmap", repo_abbrev) +
+	       read_mailmap_file(map, git_mailmap_file, repo_abbrev) > 1;
 }
 
 void clear_mailmap(struct string_list *map)
-- 
1.8.0.2.4.g59402aa
