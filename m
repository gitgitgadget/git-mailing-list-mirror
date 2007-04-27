From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Split out mailmap handling out of shortlog
Date: Fri, 27 Apr 2007 00:54:16 -0700
Message-ID: <11776604582482-git-send-email-junkio@cox.net>
References: <11776604573799-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 09:54:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhLHb-0008Ae-Vg
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 09:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbXD0HyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 03:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbXD0HyV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 03:54:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64004 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461AbXD0HyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 03:54:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427075417.CTUN22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Fri, 27 Apr 2007 03:54:17 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id s7uJ1W0011kojtg0000100; Fri, 27 Apr 2007 03:54:18 -0400
X-Mailer: git-send-email 1.5.2.rc0.765.g34a89
In-Reply-To: <11776604573799-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45697>

This splits out a few functions to deal with mailmap from
shortlog and makes it a bit more usable from other programs.
Most notably, it does not clobber input e-mail address anymore.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile           |    4 +-
 builtin-shortlog.c |   84 ++-----------------------------------------------
 mailmap.c          |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mailmap.h          |    7 ++++
 4 files changed, 101 insertions(+), 82 deletions(-)
 create mode 100644 mailmap.c
 create mode 100644 mailmap.h

diff --git a/Makefile b/Makefile
index 60c41fd..85c0a75 100644
--- a/Makefile
+++ b/Makefile
@@ -288,7 +288,7 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h
+	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h mailmap.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -310,7 +310,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o
+	convert.o attr.o decorate.o progress.o mailmap.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 3f93498..b57a88a 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -5,6 +5,7 @@
 #include "path-list.h"
 #include "revision.h"
 #include "utf8.h"
+#include "mailmap.h"
 
 static const char shortlog_usage[] =
 "git-shortlog [-n] [-s] [<commit-id>... ]";
@@ -26,83 +27,6 @@ static int compare_by_number(const void *a1, const void *a2)
 
 static struct path_list mailmap = {NULL, 0, 0, 0};
 
-static int read_mailmap(const char *filename)
-{
-	char buffer[1024];
-	FILE *f = fopen(filename, "r");
-
-	if (f == NULL)
-		return 1;
-	while (fgets(buffer, sizeof(buffer), f) != NULL) {
-		char *end_of_name, *left_bracket, *right_bracket;
-		char *name, *email;
-		int i;
-		if (buffer[0] == '#') {
-			static const char abbrev[] = "# repo-abbrev:";
-			int abblen = sizeof(abbrev) - 1;
-			int len = strlen(buffer);
-
-			if (len && buffer[len - 1] == '\n')
-				buffer[--len] = 0;
-			if (!strncmp(buffer, abbrev, abblen)) {
-				char *cp;
-
-				if (common_repo_prefix)
-					free(common_repo_prefix);
-				common_repo_prefix = xmalloc(len);
-
-				for (cp = buffer + abblen; isspace(*cp); cp++)
-					; /* nothing */
-				strcpy(common_repo_prefix, cp);
-			}
-			continue;
-		}
-		if ((left_bracket = strchr(buffer, '<')) == NULL)
-			continue;
-		if ((right_bracket = strchr(left_bracket + 1, '>')) == NULL)
-			continue;
-		if (right_bracket == left_bracket + 1)
-			continue;
-		for (end_of_name = left_bracket; end_of_name != buffer
-				&& isspace(end_of_name[-1]); end_of_name--)
-			/* keep on looking */
-		if (end_of_name == buffer)
-			continue;
-		name = xmalloc(end_of_name - buffer + 1);
-		strlcpy(name, buffer, end_of_name - buffer + 1);
-		email = xmalloc(right_bracket - left_bracket);
-		for (i = 0; i < right_bracket - left_bracket - 1; i++)
-			email[i] = tolower(left_bracket[i + 1]);
-		email[right_bracket - left_bracket - 1] = '\0';
-		path_list_insert(email, &mailmap)->util = name;
-	}
-	fclose(f);
-	return 0;
-}
-
-static int map_email(char *email, char *name, int maxlen)
-{
-	char *p;
-	struct path_list_item *item;
-
-	/* autocomplete common developers */
-	p = strchr(email, '>');
-	if (!p)
-		return 0;
-
-	*p = '\0';
-	/* downcase the email address */
-	for (p = email; *p; p++)
-		*p = tolower(*p);
-	item = path_list_lookup(email, &mailmap);
-	if (item != NULL) {
-		const char *realname = (const char *)item->util;
-		strncpy(name, realname, maxlen);
-		return 1;
-	}
-	return 0;
-}
-
 static void insert_author_oneline(struct path_list *list,
 		const char *author, int authorlen,
 		const char *oneline, int onelinelen)
@@ -184,7 +108,7 @@ static void read_from_stdin(struct path_list *list)
 				(bob = strchr(buffer + 7, '<')) != NULL) {
 			char buffer2[1024], offset = 0;
 
-			if (map_email(bob + 1, buffer, sizeof(buffer)))
+			if (map_email(&mailmap, bob + 1, buffer, sizeof(buffer)))
 				bob = buffer + strlen(buffer);
 			else {
 				offset = 8;
@@ -238,7 +162,7 @@ static void get_from_rev(struct rev_info *rev, struct path_list *list)
 					die("Invalid commit buffer: %s",
 					    sha1_to_hex(commit->object.sha1));
 
-				if (map_email(bracket + 1, scratch,
+				if (map_email(&mailmap, bracket + 1, scratch,
 							sizeof(scratch))) {
 					author = scratch;
 					authorlen = strlen(scratch);
@@ -360,7 +284,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		die ("unrecognized argument: %s", argv[1]);
 
 	if (!access(".mailmap", R_OK))
-		read_mailmap(".mailmap");
+		read_mailmap(&mailmap, ".mailmap", &common_repo_prefix);
 
 	if (rev.pending.nr == 0) {
 		if (isatty(0))
diff --git a/mailmap.c b/mailmap.c
new file mode 100644
index 0000000..af187a3
--- /dev/null
+++ b/mailmap.c
@@ -0,0 +1,88 @@
+#include "cache.h"
+#include "path-list.h"
+
+int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev)
+{
+	char buffer[1024];
+	FILE *f = fopen(filename, "r");
+
+	if (f == NULL)
+		return 1;
+	while (fgets(buffer, sizeof(buffer), f) != NULL) {
+		char *end_of_name, *left_bracket, *right_bracket;
+		char *name, *email;
+		int i;
+		if (buffer[0] == '#') {
+			static const char abbrev[] = "# repo-abbrev:";
+			int abblen = sizeof(abbrev) - 1;
+			int len = strlen(buffer);
+
+			if (len && buffer[len - 1] == '\n')
+				buffer[--len] = 0;
+			if (!strncmp(buffer, abbrev, abblen)) {
+				char *cp;
+
+				if (repo_abbrev)
+					free(*repo_abbrev);
+				*repo_abbrev = xmalloc(len);
+
+				for (cp = buffer + abblen; isspace(*cp); cp++)
+					; /* nothing */
+				strcpy(*repo_abbrev, cp);
+			}
+			continue;
+		}
+		if ((left_bracket = strchr(buffer, '<')) == NULL)
+			continue;
+		if ((right_bracket = strchr(left_bracket + 1, '>')) == NULL)
+			continue;
+		if (right_bracket == left_bracket + 1)
+			continue;
+		for (end_of_name = left_bracket; end_of_name != buffer
+				&& isspace(end_of_name[-1]); end_of_name--)
+			/* keep on looking */
+		if (end_of_name == buffer)
+			continue;
+		name = xmalloc(end_of_name - buffer + 1);
+		strlcpy(name, buffer, end_of_name - buffer + 1);
+		email = xmalloc(right_bracket - left_bracket);
+		for (i = 0; i < right_bracket - left_bracket - 1; i++)
+			email[i] = tolower(left_bracket[i + 1]);
+		email[right_bracket - left_bracket - 1] = '\0';
+		path_list_insert(email, map)->util = name;
+	}
+	fclose(f);
+	return 0;
+}
+
+int map_email(struct path_list *map, const char *email, char *name, int maxlen)
+{
+	char *p;
+	struct path_list_item *item;
+	char buf[1024], *mailbuf;
+	int i;
+
+	/* autocomplete common developers */
+	p = strchr(email, '>');
+	if (!p)
+		return 0;
+	if (p - email + 1 < sizeof(buf))
+		mailbuf = buf;
+	else
+		mailbuf = xmalloc(p - email + 1);
+
+	/* downcase the email address */
+	for (i = 0; i < p - email; i++)
+		mailbuf[i] = tolower(email[i]);
+	mailbuf[i] = 0;
+	item = path_list_lookup(mailbuf, map);
+	if (mailbuf != buf)
+		free(mailbuf);
+	if (item != NULL) {
+		const char *realname = (const char *)item->util;
+		strncpy(name, realname, maxlen);
+		return 1;
+	}
+	return 0;
+}
+
diff --git a/mailmap.h b/mailmap.h
new file mode 100644
index 0000000..3503fd2
--- /dev/null
+++ b/mailmap.h
@@ -0,0 +1,7 @@
+#ifndef MAILMAP_H
+#define MAILMAP_H
+
+int read_mailmap(struct path_list *map, const char *filename, char **repo_abbrev);
+int map_email(struct path_list *mailmap, const char *email, char *name, int maxlen);
+
+#endif
-- 
1.5.2.rc0.746.gcf51
