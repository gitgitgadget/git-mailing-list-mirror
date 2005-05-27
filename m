From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 09/12] Add --pickaxe-all to diff-* brothers.
Date: Fri, 27 May 2005 15:55:28 -0700
Message-ID: <7vy8a02s9r.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:54:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbniI-0002Iz-Kr
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVE0Wz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVE0Wz6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:55:58 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:61149 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262637AbVE0Wza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:55:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225530.OUWJ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:55:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When --pickaxe-all is given in addition to -S, pickaxe shows the
entire diffs contained in the changeset, not just the diffs for
the filepair that touched the sought-after string.  This is
useful to see the changes in context.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c       |    7 ++++
diff-files.c       |    5 ++-
diff-helper.c      |    7 +++-
diff-tree.c        |    7 ++++
diff.h             |    4 ++
diffcore-pickaxe.c |   77 +++++++++++++++++++++++++++++++++++++++--------------
6 files changed, 81 insertions(+), 26 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -8,6 +8,7 @@ static int detect_rename = 0;
 static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
@@ -209,6 +210,10 @@ int main(int argc, const char **argv)
 			pickaxe = arg + 2;
 			continue;
 		}
+		if (!strcmp(arg, "--pickaxe-all")) {
+			pickaxe_opts = DIFF_PICKAXE_ALL;
+			continue;
+		}
 		if (!strcmp(arg, "-m")) {
 			match_nonexisting = 1;
 			continue;
@@ -238,7 +243,7 @@ int main(int argc, const char **argv)
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diffcore_pickaxe(pickaxe);
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (pathspec)
 		diffcore_pathspec(pathspec);
 	diff_flush(diff_output_format, 1);
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -14,6 +14,7 @@ static int detect_rename = 0;
 static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
 static int silent = 0;
 
 static void show_unmerge(const char *path)
@@ -54,6 +55,8 @@ int main(int argc, const char **argv)
 			diff_setup_opt |= DIFF_SETUP_REVERSE;
 		else if (!strcmp(argv[1], "-S"))
 			pickaxe = argv[1] + 2;
+		else if (!strcmp(argv[1], "--pickaxe-all"))
+			pickaxe_opts = DIFF_PICKAXE_ALL;
 		else if (!strncmp(argv[1], "-M", 2)) {
 			diff_score_opt = diff_scoreopt_parse(argv[1]);
 			detect_rename = DIFF_DETECT_RENAME;
@@ -116,7 +119,7 @@ int main(int argc, const char **argv)
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diffcore_pickaxe(pickaxe);
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (1 < argc)
 		diffcore_pathspec(argv + 1);
 	diff_flush(diff_output_format, 1);
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 
 static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
 static int line_termination = '\n';
 static int inter_name_termination = '\t';
 
@@ -23,6 +24,8 @@ int main(int ac, const char **av) {
 		else if (av[1][1] == 'S') {
 			pickaxe = av[1] + 2;
 		}
+		else if (!strcmp(av[1], "--pickaxe-all"))
+			pickaxe_opts = DIFF_PICKAXE_ALL;
 		else
 			usage(diff_helper_usage);
 		ac--; av++;
@@ -127,14 +130,14 @@ int main(int ac, const char **av) {
 			continue;
 		}
 		if (pickaxe)
-			diffcore_pickaxe(pickaxe);
+			diffcore_pickaxe(pickaxe, pickaxe_opts);
 		if (1 < ac)
 			diffcore_pathspec(av + 1);
 		diff_flush(DIFF_FORMAT_PATCH, 0);
 		printf("%s\n", sb.buf);
 	}
 	if (pickaxe)
-		diffcore_pickaxe(pickaxe);
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (1 < ac)
 		diffcore_pathspec(av + 1);
 	diff_flush(DIFF_FORMAT_PATCH, 0);
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -13,6 +13,7 @@ static int detect_rename = 0;
 static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
+static int pickaxe_opts = 0;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
@@ -263,7 +264,7 @@ static int call_diff_flush(void)
 	if (detect_rename)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
-		diffcore_pickaxe(pickaxe);
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (diff_queue_is_empty()) {
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
@@ -509,6 +510,10 @@ int main(int argc, const char **argv)
 			pickaxe = arg + 2;
 			continue;
 		}
+		if (!strcmp(arg, "--pickaxe-all")) {
+			pickaxe_opts = DIFF_PICKAXE_ALL;
+			continue;
+		}
 		if (!strncmp(arg, "-M", 2)) {
 			detect_rename = DIFF_DETECT_RENAME;
 			diff_score_opt = diff_scoreopt_parse(arg);
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -36,7 +36,9 @@ extern void diff_setup(int flags);
 
 extern void diffcore_rename(int rename_copy, int minimum_score);
 
-extern void diffcore_pickaxe(const char *needle);
+#define DIFF_PICKAXE_ALL	1
+extern void diffcore_pickaxe(const char *needle, int opts);
+
 extern void diffcore_pathspec(const char **pathspec);
 
 extern int diff_queue_is_empty(void);
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -21,36 +21,73 @@ static int contains(struct diff_filespec
 	return 0;
 }
 
-void diffcore_pickaxe(const char *needle)
+void diffcore_pickaxe(const char *needle, int opts)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
-	int i;
+	int i, has_changes;
 	struct diff_queue_struct outq;
 	outq.queue = NULL;
 	outq.nr = outq.alloc = 0;
 
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		int onum = outq.nr;
-		if (!DIFF_FILE_VALID(p->one)) {
-			if (!DIFF_FILE_VALID(p->two))
-				continue; /* ignore nonsense */
-			/* created */
-			if (contains(p->two, needle, len))
-				diff_q(&outq, p);
+	if (opts & DIFF_PICKAXE_ALL) {
+		/* Showing the whole changeset if needle exists */
+		for (i = has_changes = 0; !has_changes && i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (!DIFF_FILE_VALID(p->one)) {
+				if (!DIFF_FILE_VALID(p->two))
+					continue; /* ignore unmerged */
+				/* created */
+				if (contains(p->two, needle, len))
+					has_changes++;
+			}
+			else if (!DIFF_FILE_VALID(p->two)) {
+				if (contains(p->one, needle, len))
+					has_changes++;
+			}
+			else if (!diff_unmodified_pair(p) &&
+				 contains(p->one, needle, len) !=
+				 contains(p->two, needle, len))
+				has_changes++;
 		}
-		else if (!DIFF_FILE_VALID(p->two)) {
-			if (contains(p->one, needle, len))
+		if (has_changes)
+			return; /* not munge the queue */
+
+		/* otherwise we will clear the whole queue
+		 * by copying the empty outq at the end of this
+		 * function, but first clear the current entries
+		 * in the queue.
+		 */
+		for (i = 0; i < q->nr; i++)
+			diff_free_filepair(q->queue[i]);
+	}
+	else 
+		/* Showing only the filepairs that has the needle */
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			has_changes = 0;
+			if (!DIFF_FILE_VALID(p->one)) {
+				if (!DIFF_FILE_VALID(p->two))
+					; /* ignore unmerged */
+				/* created */
+				else if (contains(p->two, needle, len))
+					has_changes = 1;
+			}
+			else if (!DIFF_FILE_VALID(p->two)) {
+				if (contains(p->one, needle, len))
+					has_changes = 1;
+			}
+			else if (!diff_unmodified_pair(p) &&
+				 contains(p->one, needle, len) !=
+				 contains(p->two, needle, len))
+				has_changes = 1;
+
+			if (has_changes)
 				diff_q(&outq, p);
+			else
+				diff_free_filepair(p);
 		}
-		else if (!diff_unmodified_pair(p) &&
-			 contains(p->one, needle, len) !=
-			 contains(p->two, needle, len))
-			diff_q(&outq, p);
-		if (onum == outq.nr)
-			diff_free_filepair(p);
-	}
+
 	free(q->queue);
 	*q = outq;
 	return;
------------------------------------------------

