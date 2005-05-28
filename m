From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add -O<orderfile> option to diff-* brothers.
Date: Sat, 28 May 2005 02:54:39 -0700
Message-ID: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 11:54:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dby1J-0002fF-Rt
	for gcvg-git@gmane.org; Sat, 28 May 2005 11:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVE1J4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 05:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVE1J4Y
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 05:56:24 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56295 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262676AbVE1Jyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 05:54:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528095440.MFXA12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 05:54:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A new diffcore filter diffcore-order is introduced.  This takes
a text file each of whose line is a shell glob pattern.  Patches
matching the glob pattern on an earlier line in the file are
output before patches matching the glob pattern on a later line,
and patches not matching any glob pattern is output last.

A typical orderfile for git project would probably look like
this:

    README
    Documentation
    Makefile
    *.h
    *.c

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-cache.txt |    6 +
Documentation/git-diff-files.txt |    6 +
Documentation/git-diff-tree.txt  |    6 +
Makefile                         |    3 
diff-cache.c                     |    7 ++
diff-files.c                     |    5 +
diff-tree.c                      |    7 ++
diff.h                           |    2 
diffcore-order.c                 |  121 +++++++++++++++++++++++++++++++++++++++
9 files changed, 159 insertions(+), 4 deletions(-)
new file (100644): diffcore-order.c

diff --git a/Documentation/git-diff-cache.txt b/Documentation/git-diff-cache.txt
--- a/Documentation/git-diff-cache.txt
+++ b/Documentation/git-diff-cache.txt
@@ -9,7 +9,7 @@ git-diff-cache - Compares content and mo
 
 SYNOPSIS
 --------
-'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
+'git-diff-cache' [-p] [-r] [-z] [-m] [-M] [-R] [-C] [-O<orderfile>] [-S<string>] [--pickaxe-all] [--cached] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -49,6 +49,10 @@ OPTIONS
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
-'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-S<string>] [--pickaxe-all] [<pattern>...]
+'git-diff-files' [-p] [-q] [-r] [-z] [-M] [-C] [-R] [-O<orderfile>] [-S<string>] [--pickaxe-all] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -43,6 +43,10 @@ OPTIONS
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
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-O<orderfile>] [-S<string>] [--pickaxe-all] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -50,6 +50,10 @@ OPTIONS
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
-	count-delta.o
+	count-delta.o diffcore-order.o
 
 LIB_OBJS += gitenv.o
 
@@ -130,6 +130,7 @@ diff.o: $(LIB_H) diffcore.h
 diffcore-rename.o : $(LIB_H) diffcore.h
 diffcore-pathspec.o : $(LIB_H) diffcore.h
 diffcore-pickaxe.o : $(LIB_H) diffcore.h
+diffcore-order.o : $(LIB_H) diffcore.h
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -9,6 +9,7 @@ static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static const char *orderfile = NULL;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
@@ -210,6 +211,10 @@ int main(int argc, const char **argv)
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
@@ -246,6 +251,8 @@ int main(int argc, const char **argv)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	if (orderfile)
+		diffcore_order(orderfile);
 	diff_flush(diff_output_format, 1);
 	return ret;
 }
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -15,6 +15,7 @@ static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static const char *orderfile = NULL;
 static int silent = 0;
 
 static void show_unmerge(const char *path)
@@ -55,6 +56,8 @@ int main(int argc, const char **argv)
 			diff_setup_opt |= DIFF_SETUP_REVERSE;
 		else if (!strncmp(argv[1], "-S", 2))
 			pickaxe = argv[1] + 2;
+		else if (!strncmp(argv[1], "-O", 2))
+			orderfile = argv[1] + 2;
 		else if (!strcmp(argv[1], "--pickaxe-all"))
 			pickaxe_opts = DIFF_PICKAXE_ALL;
 		else if (!strncmp(argv[1], "-M", 2)) {
@@ -122,6 +125,8 @@ int main(int argc, const char **argv)
 		diffcore_rename(detect_rename, diff_score_opt);
 	if (pickaxe)
 		diffcore_pickaxe(pickaxe, pickaxe_opts);
+	if (orderfile)
+		diffcore_order(orderfile);
 	diff_flush(diff_output_format, 1);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -14,6 +14,7 @@ static int diff_setup_opt = 0;
 static int diff_score_opt = 0;
 static const char *pickaxe = NULL;
 static int pickaxe_opts = 0;
+static const char *orderfile = NULL;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
@@ -269,6 +270,8 @@ static int call_diff_flush(void)
 		diff_flush(DIFF_FORMAT_NO_OUTPUT, 0);
 		return 0;
 	}
+	if (orderfile)
+		diffcore_order(orderfile);
 	if (header) {
 		const char *fmt = "%s";
 		if (diff_output_format == DIFF_FORMAT_MACHINE)
@@ -510,6 +513,10 @@ int main(int argc, const char **argv)
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
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -43,6 +43,8 @@ extern void diffcore_pickaxe(const char 
 
 extern void diffcore_pathspec(const char **pathspec);
 
+extern void diffcore_order(const char *orderfile);
+
 extern int diff_queue_is_empty(void);
 
 #define DIFF_FORMAT_HUMAN	0
diff --git a/diffcore-order.c b/diffcore-order.c
new file mode 100644
--- /dev/null
+++ b/diffcore-order.c
@@ -0,0 +1,121 @@
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
+	return;
+}
------------------------------------------------

