From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add --diff-filter= output restriction to diff-* family.
Date: Sat, 11 Jun 2005 20:57:13 -0700
Message-ID: <7vr7f8p6qu.fsf@assigned-by-dhcp.cox.net>
References: <7vfyvpxlqi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 05:53:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhJXN-0008Vd-Dh
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 05:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFLD55 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 23:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFLD54
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 23:57:56 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7608 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261318AbVFLD5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 23:57:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050612035713.EIZT16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 23:57:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfyvpxlqi.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 11 Jun 2005 02:53:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a halfway between debugging aid and a helper to write an
ultra-smart merge scripts.  The new option takes a string that
consists of a list of "status" letters, and limits the diff
output to only those classes of changes, with two exceptions:

 - A broken pair (aka "complete rewrite"), does not match D
   (deleted) or N (created).  Use B to look for them.

 - The letter "A" in the diff-filter string does not match
   anything itself, but causes the entire diff that contains
   selected patches to be output (this behaviour is similar to
   that of --pickaxe-all for the -S option).

For example,

    $ git-rev-list HEAD |
      git-diff-tree --stdin -s -v -B -C --diff-filter=BCR

shows a list of commits that have complete rewrite, copy, or
rename.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff.h        |    8 +++++--
 diff-cache.c  |    9 ++++++-
 diff-files.c  |    7 ++++--
 diff-helper.c |   15 +++++++-----
 diff-stages.c |    8 +++++--
 diff-tree.c   |   12 +++++++---
 diff.c        |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 7 files changed, 108 insertions(+), 21 deletions(-)

diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -47,7 +47,11 @@ extern void diffcore_std(const char **pa
 			 int detect_rename, int rename_score,
 			 const char *pickaxe, int pickaxe_opts,
 			 int break_opt,
-			 const char *orderfile);
+			 const char *orderfile, const char *filter);
+
+extern void diffcore_std_no_resolve(const char **paths,
+				    const char *pickaxe, int pickaxe_opts,
+				    const char *orderfile, const char *filter);
 
 extern int diff_queue_is_empty(void);
 
@@ -56,6 +60,6 @@ extern int diff_queue_is_empty(void);
 #define DIFF_FORMAT_PATCH	2
 #define DIFF_FORMAT_NO_OUTPUT	3
 
-extern void diff_flush(int output_style, int resolve_rename_copy);
+extern void diff_flush(int output_style);
 
 #endif /* DIFF_H */
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -11,6 +11,7 @@ static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
 static const char *orderfile = NULL;
+static const char *diff_filter = NULL;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
@@ -224,6 +225,10 @@ int main(int argc, const char **argv)
 			pickaxe = arg + 2;
 			continue;
 		}
+		if (!strncmp(arg, "--diff-filter=", 14)) {
+			diff_filter = arg + 14;
+			continue;
+		}
 		if (!strncmp(arg, "-O", 2)) {
 			orderfile = arg + 2;
 			continue;
@@ -263,7 +268,7 @@ int main(int argc, const char **argv)
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
 		     diff_break_opt,
-		     orderfile);
-	diff_flush(diff_output_format, 1);
+		     orderfile, diff_filter);
+	diff_flush(diff_output_format);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -17,6 +17,7 @@ static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
 static const char *orderfile = NULL;
+static const char *diff_filter = NULL;
 static int silent = 0;
 
 static void show_unmerge(const char *path)
@@ -59,6 +60,8 @@ int main(int argc, const char **argv)
 			pickaxe = argv[1] + 2;
 		else if (!strncmp(argv[1], "-O", 2))
 			orderfile = argv[1] + 2;
+		else if (!strncmp(argv[1], "--diff-filter=", 14))
+			diff_filter = argv[1] + 14;
 		else if (!strcmp(argv[1], "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
 		else if (!strncmp(argv[1], "-B", 2)) {
@@ -131,7 +134,7 @@ int main(int argc, const char **argv)
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
 		     diff_break_opt,
-		     orderfile);
-	diff_flush(diff_output_format, 1);
+		     orderfile, diff_filter);
+	diff_flush(diff_output_format);
 	return 0;
 }
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -8,17 +8,16 @@
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
 static const char *orderfile = NULL;
+static const char *diff_filter = NULL;
 static int line_termination = '\n';
 static int inter_name_termination = '\t';
 
 static void flush_them(int ac, const char **av)
 {
-	diffcore_std(av + 1,
-		     0, 0, /* no renames */
-		     pickaxe, pickaxe_opts,
-		     -1, /* no breaks */
-		     orderfile);
-	diff_flush(DIFF_FORMAT_PATCH, 0);
+	diffcore_std_no_resolve(av + 1,
+				pickaxe, pickaxe_opts,
+				orderfile, diff_filter);
+	diff_flush(DIFF_FORMAT_PATCH);
 }
 
 static const char *diff_helper_usage =
@@ -38,6 +37,10 @@ int main(int ac, const char **av) {
 		}
 		else if (!strcmp(av[1], "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
+		else if (!strncmp(av[1], "--diff-filter=", 14))
+			diff_filter = av[1] + 14;
+		else if (!strncmp(av[1], "-O", 2))
+			orderfile = av[1] + 2;
 		else
 			usage(diff_helper_usage);
 		ac--; av++;
diff --git a/diff-stages.c b/diff-stages.c
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -13,6 +13,7 @@ static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
 static const char *orderfile = NULL;
+static const char *diff_filter = NULL;
 
 static char *diff_stages_usage =
 "git-diff-stages [-p] [-r] [-z] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] <stage1> <stage2> [<path>...]";
@@ -88,6 +89,8 @@ int main(int ac, const char **av)
 			pickaxe = arg + 2;
 		else if (!strncmp(arg, "-O", 2))
 			orderfile = arg + 2;
+		else if (!strncmp(arg, "--diff-filter=", 14))
+			diff_filter = arg + 14;
 		else if (!strcmp(arg, "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
 		else
@@ -111,7 +114,8 @@ int main(int ac, const char **av)
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
 		     diff_break_opt,
-		     orderfile);
-	diff_flush(diff_output_format, 1);
+		     orderfile,
+		     diff_filter);
+	diff_flush(diff_output_format);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -18,6 +18,7 @@ static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
 static const char *orderfile = NULL;
+static const char *diff_filter = NULL;
 static const char *header = NULL;
 static const char *header_prefix = "";
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
@@ -272,9 +273,10 @@ static int call_diff_flush(void)
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
 		     diff_break_opt,
-		     orderfile);
+		     orderfile,
+		     diff_filter);
 	if (diff_queue_is_empty()) {
-		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
+		diff_flush(DIFF_FORMAT_NO_OUTPUT);
 		return 0;
 	}
 	if (header) {
@@ -285,7 +287,7 @@ static int call_diff_flush(void)
 		printf(fmt, header, 0);
 		header = NULL;
 	}
-	diff_flush(diff_output_format, 1);
+	diff_flush(diff_output_format);
 	return 1;
 }
 
@@ -455,6 +457,10 @@ int main(int argc, const char **argv)
 			orderfile = arg + 2;
 			continue;
 		}
+		if (!strncmp(arg, "--diff-filter=", 14)) {
+			diff_filter = arg + 14;
+			continue;
+		}
 		if (!strcmp(arg, "--pickaxe-all")) {
 			pickaxe_opts = DIFF_PICKAXE_ALL;
 			continue;
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -920,7 +920,7 @@ static void diff_resolve_rename_copy(voi
 	diff_debug_queue("resolve-rename-copy done", q);
 }
 
-void diff_flush(int diff_output_style, int resolve_rename_copy)
+void diff_flush(int diff_output_style)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -929,8 +929,6 @@ void diff_flush(int diff_output_style, i
 
 	if (diff_output_style == DIFF_FORMAT_MACHINE)
 		line_termination = inter_name_termination = 0;
-	if (resolve_rename_copy)
-		diff_resolve_rename_copy();
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
@@ -957,11 +955,58 @@ void diff_flush(int diff_output_style, i
 	q->nr = q->alloc = 0;
 }
 
+static void diffcore_apply_filter(const char *filter)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq;
+	outq.queue = NULL;
+	outq.nr = outq.alloc = 0;
+
+	if (!filter)
+		return;
+
+	if (strchr(filter, 'A')) {
+		/* All-or-none */
+		int found;
+		for (i = found = 0; !found && i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if ((p->broken_pair && strchr(filter, 'B')) ||
+			    (!p->broken_pair && strchr(filter, p->status)))
+				found++;
+		}
+		if (found)
+			return;
+
+		/* otherwise we will clear the whole queue
+		 * by copying the empty outq at the end of this
+		 * function, but first clear the current entries
+		 * in the queue.
+		 */
+		for (i = 0; i < q->nr; i++)
+			diff_free_filepair(q->queue[i]);
+	}
+	else {
+		/* Only the matching ones */
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if ((p->broken_pair && strchr(filter, 'B')) ||
+			    (!p->broken_pair && strchr(filter, p->status)))
+				diff_q(&outq, p);
+			else
+				diff_free_filepair(p);
+		}
+	}
+	free(q->queue);
+	*q = outq;
+}
+
 void diffcore_std(const char **paths,
 		  int detect_rename, int rename_score,
 		  const char *pickaxe, int pickaxe_opts,
 		  int break_opt,
-		  const char *orderfile)
+		  const char *orderfile,
+		  const char *filter)
 {
 	if (paths && paths[0])
 		diffcore_pathspec(paths);
@@ -975,6 +1020,23 @@ void diffcore_std(const char **paths,
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
 	if (orderfile)
 		diffcore_order(orderfile);
+	diff_resolve_rename_copy();
+	diffcore_apply_filter(filter);
+}
+
+
+void diffcore_std_no_resolve(const char **paths,
+			     const char *pickaxe, int pickaxe_opts,
+			     const char *orderfile,
+			     const char *filter)
+{
+	if (paths && paths[0])
+		diffcore_pathspec(paths);
+	if (pickaxe)
+		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	if (orderfile)
+		diffcore_order(orderfile);
+	diffcore_apply_filter(filter);
 }
 
 void diff_addremove(int addremove, unsigned mode,
------------

