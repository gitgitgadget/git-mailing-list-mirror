From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Add API access to shortlog
Date: Mon, 25 Feb 2008 18:24:14 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802251822120.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:25:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmh4-0005qy-Kh
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 00:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483AbYBYXYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 18:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756299AbYBYXYR
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 18:24:17 -0500
Received: from iabervon.org ([66.92.72.58]:59582 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756366AbYBYXYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 18:24:15 -0500
Received: (qmail 21592 invoked by uid 1000); 25 Feb 2008 23:24:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 23:24:14 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75089>

Shortlog is gives a pretty simple API for cases where you're already
identifying all of the individual commits. Make this available to
other code instead of requiring them to use the revision API and
command line.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-shortlog.c |  149 ++++++++++++++++++++++++++++------------------------
 shortlog.h         |   26 +++++++++
 2 files changed, 106 insertions(+), 69 deletions(-)
 create mode 100644 shortlog.h

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 0055a57..af31aba 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -6,13 +6,11 @@
 #include "revision.h"
 #include "utf8.h"
 #include "mailmap.h"
+#include "shortlog.h"
 
 static const char shortlog_usage[] =
 "git-shortlog [-n] [-s] [-e] [<commit-id>... ]";
 
-static char *common_repo_prefix;
-static int email;
-
 static int compare_by_number(const void *a1, const void *a2)
 {
 	const struct path_list_item *i1 = a1, *i2 = a2;
@@ -26,13 +24,11 @@ static int compare_by_number(const void *a1, const void *a2)
 		return -1;
 }
 
-static struct path_list mailmap = {NULL, 0, 0, 0};
-
-static void insert_one_record(struct path_list *list,
+static void insert_one_record(struct shortlog *log,
 			      const char *author,
 			      const char *oneline)
 {
-	const char *dot3 = common_repo_prefix;
+	const char *dot3 = log->common_repo_prefix;
 	char *buffer, *p;
 	struct path_list_item *item;
 	struct path_list *onelines;
@@ -47,7 +43,7 @@ static void insert_one_record(struct path_list *list,
 	eoemail = strchr(boemail, '>');
 	if (!eoemail)
 		return;
-	if (!map_email(&mailmap, boemail+1, namebuf, sizeof(namebuf))) {
+	if (!map_email(&log->mailmap, boemail+1, namebuf, sizeof(namebuf))) {
 		while (author < boemail && isspace(*author))
 			author++;
 		for (len = 0;
@@ -61,14 +57,14 @@ static void insert_one_record(struct path_list *list,
 	else
 		len = strlen(namebuf);
 
-	if (email) {
+	if (log->email) {
 		size_t room = sizeof(namebuf) - len - 1;
 		int maillen = eoemail - boemail + 1;
 		snprintf(namebuf + len, room, " %.*s", maillen, boemail);
 	}
 
 	buffer = xstrdup(namebuf);
-	item = path_list_insert(buffer, list);
+	item = path_list_insert(buffer, &log->list);
 	if (item->util == NULL)
 		item->util = xcalloc(1, sizeof(struct path_list));
 	else
@@ -114,7 +110,7 @@ static void insert_one_record(struct path_list *list,
 	onelines->items[onelines->nr++].path = buffer;
 }
 
-static void read_from_stdin(struct path_list *list)
+static void read_from_stdin(struct shortlog *log)
 {
 	char author[1024], oneline[1024];
 
@@ -128,39 +124,43 @@ static void read_from_stdin(struct path_list *list)
 		while (fgets(oneline, sizeof(oneline), stdin) &&
 		       oneline[0] == '\n')
 			; /* discard blanks */
-		insert_one_record(list, author + 8, oneline);
+		insert_one_record(log, author + 8, oneline);
 	}
 }
 
-static void get_from_rev(struct rev_info *rev, struct path_list *list)
+void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
-	struct commit *commit;
-
-	if (prepare_revision_walk(rev))
-		die("revision walk setup failed");
-	while ((commit = get_revision(rev)) != NULL) {
-		const char *author = NULL, *buffer;
+	const char *author = NULL, *buffer;
 
-		buffer = commit->buffer;
-		while (*buffer && *buffer != '\n') {
-			const char *eol = strchr(buffer, '\n');
+	buffer = commit->buffer;
+	while (*buffer && *buffer != '\n') {
+		const char *eol = strchr(buffer, '\n');
 
-			if (eol == NULL)
-				eol = buffer + strlen(buffer);
-			else
-				eol++;
+		if (eol == NULL)
+			eol = buffer + strlen(buffer);
+		else
+			eol++;
 
-			if (!prefixcmp(buffer, "author "))
-				author = buffer + 7;
-			buffer = eol;
-		}
-		if (!author)
-			die("Missing author: %s",
-			    sha1_to_hex(commit->object.sha1));
-		if (*buffer)
-			buffer++;
-		insert_one_record(list, author, !*buffer ? "<none>" : buffer);
+		if (!prefixcmp(buffer, "author "))
+			author = buffer + 7;
+		buffer = eol;
 	}
+	if (!author)
+		die("Missing author: %s",
+		    sha1_to_hex(commit->object.sha1));
+	if (*buffer)
+		buffer++;
+	insert_one_record(log, author, !*buffer ? "<none>" : buffer);
+}
+
+static void get_from_rev(struct rev_info *rev, struct shortlog *log)
+{
+	struct commit *commit;
+
+	if (prepare_revision_walk(rev))
+		die("revision walk setup failed");
+	while ((commit = get_revision(rev)) != NULL)
+		shortlog_add_commit(log, commit);
 }
 
 static int parse_uint(char const **arg, int comma)
@@ -212,29 +212,38 @@ static void parse_wrap_args(const char *arg, int *in1, int *in2, int *wrap)
 		die(wrap_arg_usage);
 }
 
+void shortlog_init(struct shortlog *log)
+{
+	memset(log, 0, sizeof(*log));
+
+	read_mailmap(&log->mailmap, ".mailmap", &log->common_repo_prefix);
+
+	log->list.strdup_paths = 1;
+	log->wrap = DEFAULT_WRAPLEN;
+	log->in1 = DEFAULT_INDENT1;
+	log->in2 = DEFAULT_INDENT2;
+}
+
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
+	struct shortlog log;
 	struct rev_info rev;
-	struct path_list list = { NULL, 0, 0, 1 };
-	int i, j, sort_by_number = 0, summary = 0;
-	int wrap_lines = 0;
-	int wrap = DEFAULT_WRAPLEN;
-	int in1 = DEFAULT_INDENT1;
-	int in2 = DEFAULT_INDENT2;
+
+	shortlog_init(&log);
 
 	/* since -n is a shadowed rev argument, parse our args first */
 	while (argc > 1) {
 		if (!strcmp(argv[1], "-n") || !strcmp(argv[1], "--numbered"))
-			sort_by_number = 1;
+			log.sort_by_number = 1;
 		else if (!strcmp(argv[1], "-s") ||
 				!strcmp(argv[1], "--summary"))
-			summary = 1;
+			log.summary = 1;
 		else if (!strcmp(argv[1], "-e") ||
 			 !strcmp(argv[1], "--email"))
-			email = 1;
+			log.email = 1;
 		else if (!prefixcmp(argv[1], "-w")) {
-			wrap_lines = 1;
-			parse_wrap_args(argv[1], &in1, &in2, &wrap);
+			log.wrap_lines = 1;
+			parse_wrap_args(argv[1], &log.in1, &log.in2, &log.wrap);
 		}
 		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
 			usage(shortlog_usage);
@@ -248,34 +257,38 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
-	read_mailmap(&mailmap, ".mailmap", &common_repo_prefix);
-
 	/* assume HEAD if from a tty */
 	if (!rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr == 0) {
-		read_from_stdin(&list);
+		read_from_stdin(&log);
 	}
 	else
-		get_from_rev(&rev, &list);
+		get_from_rev(&rev, &log);
 
-	if (sort_by_number)
-		qsort(list.items, list.nr, sizeof(struct path_list_item),
-			compare_by_number);
+	shortlog_output(&log);
+	return 0;
+}
 
-	for (i = 0; i < list.nr; i++) {
-		struct path_list *onelines = list.items[i].util;
+void shortlog_output(struct shortlog *log)
+{
+	int i, j;
+	if (log->sort_by_number)
+		qsort(log->list.items, log->list.nr, sizeof(struct path_list_item),
+			compare_by_number);
+	for (i = 0; i < log->list.nr; i++) {
+		struct path_list *onelines = log->list.items[i].util;
 
-		if (summary) {
-			printf("%6d\t%s\n", onelines->nr, list.items[i].path);
+		if (log->summary) {
+			printf("%6d\t%s\n", onelines->nr, log->list.items[i].path);
 		} else {
-			printf("%s (%d):\n", list.items[i].path, onelines->nr);
+			printf("%s (%d):\n", log->list.items[i].path, onelines->nr);
 			for (j = onelines->nr - 1; j >= 0; j--) {
 				const char *msg = onelines->items[j].path;
 
-				if (wrap_lines) {
-					int col = print_wrapped_text(msg, in1, in2, wrap);
-					if (col != wrap)
+				if (log->wrap_lines) {
+					int col = print_wrapped_text(msg, log->in1, log->in2, log->wrap);
+					if (col != log->wrap)
 						putchar('\n');
 				}
 				else
@@ -287,13 +300,11 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		onelines->strdup_paths = 1;
 		path_list_clear(onelines, 1);
 		free(onelines);
-		list.items[i].util = NULL;
+		log->list.items[i].util = NULL;
 	}
 
-	list.strdup_paths = 1;
-	path_list_clear(&list, 1);
-	mailmap.strdup_paths = 1;
-	path_list_clear(&mailmap, 1);
-
-	return 0;
+	log->list.strdup_paths = 1;
+	path_list_clear(&log->list, 1);
+	log->mailmap.strdup_paths = 1;
+	path_list_clear(&log->mailmap, 1);
 }
diff --git a/shortlog.h b/shortlog.h
new file mode 100644
index 0000000..31ff491
--- /dev/null
+++ b/shortlog.h
@@ -0,0 +1,26 @@
+#ifndef SHORTLOG_H
+#define SHORTLOG_H
+
+#include "path-list.h"
+
+struct shortlog {
+	struct path_list list;
+	int summary;
+	int wrap_lines;
+	int sort_by_number;
+	int wrap;
+	int in1;
+	int in2;
+
+	char *common_repo_prefix;
+	int email;
+	struct path_list mailmap;
+};
+
+void shortlog_init(struct shortlog *log);
+
+void shortlog_add_commit(struct shortlog *log, struct commit *commit);
+
+void shortlog_output(struct shortlog *log);
+
+#endif
-- 
1.5.4.3.330.g53ab.dirty
