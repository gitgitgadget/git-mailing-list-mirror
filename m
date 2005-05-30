From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] Add -O<orderfile> option to diff-* brothers.
Date: Mon, 30 May 2005 00:09:07 -0700
Message-ID: <7vpsv96vho.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
	<7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net>
	<7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 09:08:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DceNm-000148-AL
	for gcvg-git@gmane.org; Mon, 30 May 2005 09:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVE3HKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 03:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVE3HKn
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 03:10:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:50100 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261534AbVE3HJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 03:09:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530070908.CECF1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 03:09:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 23:58:37 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A new diffcore filter diffcore-order is introduced.  This takes
a text file each of whose line is a shell glob pattern.  Patches
that match a glob pattern on an earlier line in the file are
output before patches that match a later line, and patches that
do not match any glob pattern are output last.

A typical orderfile for git project probably should look like
this:

    README
    Makefile
    Documentation
    *.h
    *.c

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-diff-cache.txt |    6 +
 Documentation/git-diff-files.txt |    6 +
 Documentation/git-diff-tree.txt  |    6 +
 Makefile                         |    3 
 diff-cache.c                     |    8 ++
 diff-files.c                     |    6 +
 diff-tree.c                      |    8 ++
 diff.c                           |    5 +
 diff.h                           |    7 +-
 diffcore-order.c                 |  122 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 167 insertions(+), 10 deletions(-)

6575b8d66ea48891aaba3fba3eb8a4fddc596c2c (from 96c0ba825059e65743bfce718e54413c4583ff35)
diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-B] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
+'git-diff-cache' [-p] [-r] [-z] [-m] [-B] [-M] [-R] [-C] [-O<orderfile>] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -52,6 +52,10 @@ OPTIONS
 	changeset, not just the files that contains the change
 	in <string>.
 
+-O<orderfile>::
+	Output the patch in the order specified in the
+	<orderfile>, which has one shell glob pattern per line.
+
 -R::
 	Output diff in reverse.
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the w
 
 SYNOPSIS
 --------
-'git-diff-files' [-p] [-q] [-r] [-z] [-B] [-M] [-C] [-R] [-S<string>] [--pickaxe-all] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-B] [-M] [-C] [-R] [-O<orderfile>] [-S<string>] [--pickaxe-all] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -46,6 +46,10 @@ OPTIONS
 	changeset, not just the files that contains the change
 	in <string>.
 
+-O<orderfile>::
+	Output the patch in the order specified in the
+	<orderfile>, which has one shell glob pattern per line.
+
 -r::
 	This flag does not mean anything.  It is there only to match
 	git-diff-tree.  Unlike git-diff-tree, git-diff-files always looks
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-B] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-B] [-M] [-R] [-C] [-O<orderfile>] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -53,6 +53,10 @@ OPTIONS
 	changeset, not just the files that contains the change
 	in <string>.
 
+-O<orderfile>::
+	Output the patch in the order specified in the
+	<orderfile>, which has one shell glob pattern per line.
+
 -r::
 	recurse
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -48,7 +48,7 @@ LIB_OBJS += strbuf.o
 
 LIB_H += diff.h count-delta.h
 LIB_OBJS += diff.o diffcore-rename.o diffcore-pickaxe.o diffcore-pathspec.o \
-	count-delta.o diffcore-break.o
+	count-delta.o diffcore-break.o diffcore-order.o
 
 LIB_OBJS += gitenv.o
 
@@ -131,6 +131,7 @@ diffcore-rename.o : $(LIB_H) diffcore.h
 diffcore-pathspec.o : $(LIB_H) diffcore.h
 diffcore-pickaxe.o : $(LIB_H) diffcore.h
 diffcore-break.o : $(LIB_H) diffcore.h
+diffcore-order.o : $(LIB_H) diffcore.h
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -10,6 +10,7 @@ static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
+static const char *orderfile = NULL;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
@@ -215,6 +216,10 @@ int main(int argc, const char **argv)
 			pickaxe = arg + 2;
 			continue;
 		}
+		if (!strncmp(arg, "-O", 2)) {
+			orderfile = arg + 2;
+			continue;
+		}
 		if (!strcmp(arg, "--pickaxe-all")) {
 			pickaxe_opts = DIFF_PICKAXE_ALL;
 			continue;
@@ -249,7 +254,8 @@ int main(int argc, const char **argv)
 	diffcore_std(pathspec ? : NULL,
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
-		     diff_break_opt);
+		     diff_break_opt,
+		     orderfile);
 	diff_flush(diff_output_format, 1);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -16,6 +16,7 @@ static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
+static const char *orderfile = NULL;
 static int silent = 0;
 
 static void show_unmerge(const char *path)
@@ -56,6 +57,8 @@ int main(int argc, const char **argv)
 			diff_setup_opt |= DIFF_SETUP_REVERSE;
 		else if (!strncmp(argv[1], "-S", 2))
 			pickaxe = argv[1] + 2;
+		else if (!strncmp(argv[1], "-O", 2))
+			orderfile = argv[1] + 2;
 		else if (!strcmp(argv[1], "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
 		else if (!strncmp(argv[1], "-B", 2))
@@ -122,7 +125,8 @@ int main(int argc, const char **argv)
 	diffcore_std((1 < argc) ? argv + 1 : NULL,
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
-		     diff_break_opt);
+		     diff_break_opt,
+		     orderfile);
 	diff_flush(diff_output_format, 1);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -15,6 +15,7 @@ static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
+static const char *orderfile = NULL;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
@@ -265,7 +266,8 @@ static int call_diff_flush(void)
 	diffcore_std(0,
 		     detect_rename, diff_score_opt,
 		     pickaxe, pickaxe_opts,
-		     diff_break_opt);
+		     diff_break_opt,
+		     orderfile);
 	if (diff_queue_is_empty()) {
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
@@ -511,6 +513,10 @@ int main(int argc, const char **argv)
 			pickaxe = arg + 2;
 			continue;
 		}
+		if (!strncmp(arg, "-O", 2)) {
+			orderfile = arg + 2;
+			continue;
+		}
 		if (!strcmp(arg, "--pickaxe-all")) {
 			pickaxe_opts = DIFF_PICKAXE_ALL;
 			continue;
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -888,7 +888,8 @@ void diff_flush(int diff_output_style, i
 void diffcore_std(const char **paths,
 		  int detect_rename, int rename_score,
 		  const char *pickaxe, int pickaxe_opts,
-		  int break_opt)
+		  int break_opt,
+		  const char *orderfile)
 {
 	if (paths && paths[0])
 		diffcore_pathspec(paths);
@@ -898,6 +899,8 @@ void diffcore_std(const char **paths,
 		diffcore_rename(detect_rename, rename_score);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	if (orderfile)
+		diffcore_order(orderfile);
 }
 
 void diff_addremove(int addremove, unsigned mode,
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -43,12 +43,15 @@ extern void diffcore_pickaxe(const char 
 
 extern void diffcore_pathspec(const char **pathspec);
 
-extern void diffcore_break(int);
+extern void diffcore_order(const char *orderfile);
+
+extern void diffcore_break(int max_score);
 
 extern void diffcore_std(const char **paths,
 			 int detect_rename, int rename_score,
 			 const char *pickaxe, int pickaxe_opts,
-			 int break_opt);
+			 int break_opt,
+			 const char *orderfile);
 
 extern int diff_queue_is_empty(void);
 
diff --git a/diffcore-order.c b/diffcore-order.c
new file mode 100644
--- /dev/null
+++ b/diffcore-order.c
@@ -0,0 +1,122 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+#include <fnmatch.h>
+
+static char **order;
+static int order_cnt;
+
+static void prepare_order(const char *orderfile)
+{
+	int fd, cnt, pass;
+	void *map;
+	char *cp, *endp;
+	struct stat st;
+
+	if (order)
+		return;
+
+	fd = open(orderfile, O_RDONLY);
+	if (fd < 0)
+		return;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return;
+	}
+	map = mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (-1 == (int)(long)map)
+		return;
+	endp = map + st.st_size;
+	for (pass = 0; pass < 2; pass++) {
+		cnt = 0;
+		cp = map;
+		while (cp < endp) {
+			char *ep;
+			for (ep = cp; ep < endp && *ep != '\n'; ep++)
+				;
+			/* cp to ep has one line */
+			if (*cp == '\n' || *cp == '#')
+				; /* comment */
+			else if (pass == 0)
+				cnt++;
+			else {
+				if (*ep == '\n') {
+					*ep = 0;
+					order[cnt] = cp;
+				}
+				else {
+					order[cnt] = xmalloc(ep-cp+1);
+					memcpy(order[cnt], cp, ep-cp);
+					order[cnt][ep-cp] = 0;
+				}
+				cnt++;
+			}
+			if (ep < endp)
+				ep++;
+			cp = ep;
+		}
+		if (pass == 0) {
+			order_cnt = cnt;
+			order = xmalloc(sizeof(*order) * cnt);
+		}
+	}
+}
+
+struct pair_order {
+	struct diff_filepair *pair;
+	int orig_order;
+	int order;
+};
+
+static int match_order(const char *path)
+{
+	int i;
+	char p[PATH_MAX];
+
+	for (i = 0; i < order_cnt; i++) {
+		strcpy(p, path);
+		while (p[0]) {
+			char *cp;
+			if (!fnmatch(order[i], p, 0))
+				return i;
+			cp = strrchr(p, '/');
+			if (!cp)
+				break;
+			*cp = 0;
+		}
+	}
+	return order_cnt;
+}
+
+static int compare_pair_order(const void *a_, const void *b_)
+{
+	struct pair_order const *a, *b;
+	a = (struct pair_order const *)a_;
+	b = (struct pair_order const *)b_;
+	if (a->order != b->order)
+		return a->order - b->order;
+	return a->orig_order - b->orig_order;
+}
+
+void diffcore_order(const char *orderfile)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct pair_order *o = xmalloc(sizeof(*o) * q->nr);
+	int i;
+
+	prepare_order(orderfile);
+	for (i = 0; i < q->nr; i++) {
+		o[i].pair = q->queue[i];
+		o[i].orig_order = i;
+		o[i].order = match_order(o[i].pair->two->path);
+	}
+	qsort(o, q->nr, sizeof(*o), compare_pair_order);
+	for (i = 0; i < q->nr; i++)
+		q->queue[i] = o[i].pair;
+	free(o);
+	return;
+}

