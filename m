From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/7] rev-list: implement "--bisect-skip" option
Date: Thu, 12 Mar 2009 08:51:26 +0100
Message-ID: <20090312085126.823c1bc2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:54:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhfkl-0007QV-5T
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbZCLHwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 03:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZCLHwY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:52:24 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:46816 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbZCLHwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:52:23 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 2CFF6940159;
	Thu, 12 Mar 2009 08:52:13 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id C2F5994012E;
	Thu, 12 Mar 2009 08:52:10 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113015>

When bisecting, skipped revisions used to be filtered by the
"filter_skipped" function in "git-bisect.sh". This was not very
efficient and error prone, and it made it difficult to implement
new behaviors when skipping commits.

This patch moves the logic from the "filter_skipped" shell function
into a new "bisect-skip.c" file. And a new "--bisect-skip" option is
implemented in "builtin-rev-list.c" to use this logic.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile           |    1 +
 bisect-skip.c      |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 bisect.h           |    5 +++
 builtin-rev-list.c |   40 +++++++++++++++++++++--
 4 files changed, 132 insertions(+), 4 deletions(-)
 create mode 100644 bisect-skip.c

	I know that there is no documentation along with this, but I am
	working on it and hope to send it soon.

diff --git a/Makefile b/Makefile
index 9500c5e..126a06d 100644
--- a/Makefile
+++ b/Makefile
@@ -415,6 +415,7 @@ LIB_OBJS += archive-zip.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
+LIB_OBJS += bisect-skip.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
 LIB_OBJS += bundle.o
diff --git a/bisect-skip.c b/bisect-skip.c
new file mode 100644
index 0000000..9228465
--- /dev/null
+++ b/bisect-skip.c
@@ -0,0 +1,90 @@
+#include "cache.h"
+#include "commit.h"
+#include "strbuf.h"
+#include "bisect.h"
+
+static unsigned char (*skipped_sha1)[20];
+static int skipped_sha1_nr;
+static int skipped_sha1_alloc;
+
+void register_skipped(const char *skipped)
+{
+	struct strbuf sb, **list, **it, *cur;
+	int len = strlen(skipped);
+
+	strbuf_init(&sb, len);
+	strbuf_add(&sb, skipped, len);
+
+	list = strbuf_split(&sb, ',', 0);
+
+	for (it = list; (cur = *it); it++) {
+		ALLOC_GROW(skipped_sha1, skipped_sha1_nr + 1,
+			   skipped_sha1_alloc);
+		if (get_sha1(cur->buf, skipped_sha1[skipped_sha1_nr++]))
+			die("Bad bisect skip ref: %s", cur->buf);
+	}
+
+	strbuf_list_free(list);
+	strbuf_release(&sb);
+}
+
+static int skipcmp(const void *a, const void *b)
+{
+	return hashcmp(a, b);
+}
+
+static void prepare_skipped(void)
+{
+	qsort(skipped_sha1, skipped_sha1_nr, sizeof(*skipped_sha1), skipcmp);
+}
+
+static int lookup_skipped(unsigned char *sha1)
+{
+	int lo, hi;
+	lo = 0;
+	hi = skipped_sha1_nr;
+	while (lo < hi) {
+		int mi = (lo + hi) / 2;
+		int cmp = hashcmp(sha1, skipped_sha1[mi]);
+		if (!cmp)
+			return mi;
+		if (cmp < 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	return -lo - 1;
+}
+
+struct commit_list *filter_skipped(struct commit_list *list,
+				   struct commit_list **tried,
+				   int show_all)
+{
+	struct commit_list *filtered = NULL, **f = &filtered;
+
+	*tried = NULL;
+
+	if (!skipped_sha1_nr)
+		return list;
+
+	prepare_skipped();
+
+	while (list) {
+		struct commit_list *next = list->next;
+		list->next = NULL;
+		if (0 <= lookup_skipped(list->item->object.sha1)) {
+			/* Move current to tried list */
+			*tried = list;
+			tried = &list->next;
+		} else {
+			if (!show_all)
+				return list;
+			/* Move current to filtered list */
+			*f = list;
+			f = &list->next;
+		}
+		list = next;
+	}
+
+	return filtered;
+}
diff --git a/bisect.h b/bisect.h
index cce268d..c5f9fe1 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,6 +1,11 @@
 #ifndef BISECT_H
 #define BISECT_H
 
+void register_skipped(const char *skipped);
+struct commit_list *filter_skipped(struct commit_list *list,
+				   struct commit_list **tried,
+				   int show_all);
+
 struct commit_list *find_bisection(struct commit_list *list,
 				   int *reaches, int *all,
 				   int find_all);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index b1e8200..b50d304 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -39,7 +39,8 @@ static const char rev_list_usage[] =
 "  special purpose:\n"
 "    --bisect\n"
 "    --bisect-vars\n"
-"    --bisect-all"
+"    --bisect-all\n"
+"    --bisect-skip"
 ;
 
 static struct rev_info revs;
@@ -226,6 +227,16 @@ static int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
+static void show_tried(struct commit_list *tried)
+{
+	printf("bisect_tried='");
+	for (;tried; tried = tried->next) {
+		char *format = tried->next ? "%s|" : "%s";
+		printf(format, sha1_to_hex(tried->item->object.sha1));
+	}
+	printf("'\n");
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
@@ -234,6 +245,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
+	int bisect_show_all = 0;
+	int bisect_skip = 0;
 	int quiet = 0;
 
 	git_config(git_default_config, NULL);
@@ -261,6 +274,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--bisect-all")) {
 			bisect_list = 1;
 			bisect_find_all = 1;
+			bisect_show_all = 1;
 			revs.show_decorations = 1;
 			continue;
 		}
@@ -269,6 +283,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			bisect_show_vars = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--bisect-skip=")) {
+			bisect_list = 1;
+			bisect_show_vars = 1;
+			bisect_find_all = 1;
+			bisect_skip = 1;
+			register_skipped(arg + 14);
+			continue;
+		}
 		if (!strcmp(arg, "--stdin")) {
 			if (read_from_stdin++)
 				die("--stdin given twice?");
@@ -310,13 +332,18 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (bisect_list) {
 		int reaches = reaches, all = all;
+		struct commit_list *tried;
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
+
+		revs.commits = filter_skipped(revs.commits, &tried,
+					      bisect_show_all);
+
 		if (bisect_show_vars) {
 			int cnt;
 			char hex[41];
-			if (!revs.commits)
+			if (!revs.commits && !bisect_skip)
 				return 1;
 			/*
 			 * revs.commits can reach "reaches" commits among
@@ -330,13 +357,18 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			cnt = all - reaches;
 			if (cnt < reaches)
 				cnt = reaches;
-			strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
+			if (revs.commits)
+				strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
+			else
+				hex[0] = '\0';
 
-			if (bisect_find_all) {
+			if (bisect_show_all) {
 				traverse_commit_list(&revs, show_commit, show_object);
 				printf("------\n");
 			}
 
+			if (bisect_skip)
+				show_tried(tried);
 			printf("bisect_rev=%s\n"
 			       "bisect_nr=%d\n"
 			       "bisect_good=%d\n"
-- 
1.6.2.83.g012a16.dirty
