From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Split external diff command interface to a separate
 file.
Date: Sun, 24 Apr 2005 22:15:34 -0700
Message-ID: <7vvf6bqvwp.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
	<7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 07:11:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPvsN-0004gy-L5
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 07:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVDYFQP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 01:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVDYFQP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 01:16:15 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46039 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262538AbVDYFPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 01:15:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050425051534.KZGH8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Apr 2005 01:15:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 24 Apr 2005 22:12:16 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With this patch, the non-core'ish part of show-diff command that
invokes an external "diff" comand to obtain patches is split
into a separate file.  The next patch will introduce a new
command, diff-tree-helper, which uses this common diff interface
to format diff-tree and diff-cache output into a patch form.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Makefile    |    4 ++
diff.c      |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
diff.h      |   17 +++++++++
show-diff.c |  101 +--------------------------------------------------------
4 files changed, 130 insertions(+), 98 deletions(-)

--- k/Makefile
+++ l/Makefile
@@ -27,6 +27,9 @@ LIB_OBJS=read-cache.o sha1_file.o usage.
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h
 
+LIB_H += diff.h
+LIB_OBJS += diff.o
+
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
@@ -66,6 +69,7 @@ checkout-cache.o: $(LIB_H)
 commit.o: $(LIB_H)
 commit-tree.o: $(LIB_H)
 convert-cache.o: $(LIB_H)
+diff.o: $(LIB_H)
 diff-cache.o: $(LIB_H)
 diff-tree.o: $(LIB_H)
 fsck-cache.o: $(LIB_H)
--- k/diff.c
+++ l/diff.c
@@ -0,0 +1,106 @@
+#include "cache.h"
+#include "diff.h"
+
+static char *diff_cmd = "diff -L 'k/%s' -L 'l/%s' ";
+static char *diff_opts = "-p -u";
+static char *diff_arg_forward  = " - '%s'";
+static char *diff_arg_reverse  = " '%s' -";
+
+void prepare_diff_cmd(void)
+{
+	/*
+	 * Default values above are meant to match the
+	 * Linux kernel development style.  Examples of
+	 * alternative styles you can specify via environment
+	 * variables are:
+	 *
+	 * GIT_DIFF_CMD="diff -L '%s' -L '%s'"
+	 * GIT_DIFF_OPTS="-c";
+	 */
+	diff_cmd = getenv("GIT_DIFF_CMD") ? : diff_cmd;
+	diff_opts = getenv("GIT_DIFF_OPTS") ? : diff_opts;
+}
+
+/* Help to copy the thing properly quoted for the shell safety.
+ * any single quote is replaced with '\'', and the caller is
+ * expected to enclose the result within a single quote pair.
+ *
+ * E.g.
+ *  original     sq_expand     result
+ *  name     ==> name      ==> 'name'
+ *  a b      ==> a b       ==> 'a b'
+ *  a'b      ==> a'\''b    ==> 'a'\''b'
+ */
+static char *sq_expand(const char *src)
+{
+	static char *buf = NULL;
+	int cnt, c;
+	const char *cp;
+	char *bp;
+
+	/* count bytes needed to store the quoted string. */ 
+	for (cnt = 1, cp = src; *cp; cnt++, cp++)
+		if (*cp == '\'')
+			cnt += 3;
+
+	if (! (buf = malloc(cnt)))
+	    return buf;
+	bp = buf;
+	while ((c = *src++)) {
+		if (c != '\'')
+			*bp++ = c;
+		else {
+			bp = strcpy(bp, "'\\''");
+			bp += 4;
+		}
+	}
+	*bp = 0;
+	return buf;
+}
+
+void show_differences(const char *name, /* filename on the filesystem */
+		      const char *label, /* diff label to use */
+		      void *old_contents, /* contents in core */
+		      unsigned long long old_size, /* size in core */
+		      int reverse /* 0: diff core file
+				     1: diff file core */)
+{
+	FILE *f;
+	char *name_sq = sq_expand(name);
+	const char *label_sq = (name != label) ? sq_expand(label) : name_sq;
+	char *diff_arg = reverse ? diff_arg_reverse : diff_arg_forward;
+	int cmd_size = strlen(name_sq) + strlen(label_sq) * 2 +
+		strlen(diff_cmd) + strlen(diff_opts) + strlen(diff_arg);
+	char *cmd = malloc(cmd_size);
+	int next_at;
+
+	fflush(stdout);
+	next_at = snprintf(cmd, cmd_size, diff_cmd, label_sq, label_sq);
+	next_at += snprintf(cmd+next_at, cmd_size-next_at, "%s", diff_opts);
+	next_at += snprintf(cmd+next_at, cmd_size-next_at, diff_arg, name_sq);
+	f = popen(cmd, "w");
+	if (old_size)
+		fwrite(old_contents, old_size, 1, f);
+	pclose(f);
+	if (label_sq != name_sq)
+		free((void*)label_sq); /* constness */
+	free(name_sq);
+	free(cmd);
+}
+
+void show_diff_empty(const unsigned char *sha1,
+		     const char *name,
+		     int reverse)
+{
+	char *old;
+	unsigned long int size;
+	unsigned char type[20];
+
+	old = read_sha1_file(sha1, type, &size);
+	if (! old) {
+		error("unable to read blob object for %s (%s)", name,
+		      sha1_to_hex(sha1));
+		return;
+	}
+	show_differences("/dev/null", name, old, size, reverse);
+}
--- k/diff.h
+++ l/diff.h
@@ -0,0 +1,17 @@
+#ifndef DIFF_H
+#define DIFF_H
+
+extern void prepare_diff_cmd(void);
+
+extern void show_differences(const char *name, /* filename on the filesystem */
+			     const char *label, /* diff label to use */
+			     void *old_contents, /* contents in core */
+			     unsigned long long old_size, /* size in core */
+			     int reverse /* 0: diff core file
+					    1: diff file core */);
+
+extern void show_diff_empty(const unsigned char *sha1,
+			    const char *name,
+			    int reverse);
+
+#endif /* DIFF_H */
--- k/show-diff.c
+++ l/show-diff.c
@@ -4,103 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
-
-static char *diff_cmd = "diff -L 'a/%s' -L 'b/%s' ";
-static char *diff_opts = "-p -u";
-static char *diff_arg_forward  = " - '%s'";
-static char *diff_arg_reverse  = " '%s' -";
-
-static void prepare_diff_cmd(void)
-{
-	/*
-	 * Default values above are meant to match the
-	 * Linux kernel development style.  Examples of
-	 * alternative styles you can specify via environment
-	 * variables are:
-	 *
-	 * GIT_DIFF_CMD="diff -L '%s' -L '%s'"
-	 * GIT_DIFF_OPTS="-c";
-	 */
-	diff_cmd = getenv("GIT_DIFF_CMD") ? : diff_cmd;
-	diff_opts = getenv("GIT_DIFF_OPTS") ? : diff_opts;
-}
-
-/* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', and the caller is
- * expected to enclose the result within a single quote pair.
- *
- * E.g.
- *  original     sq_expand     result
- *  name     ==> name      ==> 'name'
- *  a b      ==> a b       ==> 'a b'
- *  a'b      ==> a'\''b    ==> 'a'\''b'
- */
-static char *sq_expand(char *src)
-{
-	static char *buf = NULL;
-	int cnt, c;
-	char *cp;
-
-	/* count bytes needed to store the quoted string. */ 
-	for (cnt = 1, cp = src; *cp; cnt++, cp++)
-		if (*cp == '\'')
-			cnt += 3;
-
-	if (! (buf = malloc(cnt)))
-	    return buf;
-	cp = buf;
-	while ((c = *src++)) {
-		if (c != '\'')
-			*cp++ = c;
-		else {
-			cp = strcpy(cp, "'\\''");
-			cp += 4;
-		}
-	}
-	*cp = 0;
-	return buf;
-}
-
-static void show_differences(char *name, char *label, void *old_contents,
-			     unsigned long long old_size, int reverse)
-{
-	FILE *f;
-	char *name_sq = sq_expand(name);
-	char *label_sq = (name != label) ? sq_expand(label) : name_sq;
-	char *diff_arg = reverse ? diff_arg_reverse : diff_arg_forward;
-	int cmd_size = strlen(name_sq) + strlen(label_sq) * 2 +
-		strlen(diff_cmd) + strlen(diff_opts) + strlen(diff_arg);
-	char *cmd = malloc(cmd_size);
-	int next_at;
-
-	fflush(stdout);
-	next_at = snprintf(cmd, cmd_size, diff_cmd, label_sq, label_sq);
-	next_at += snprintf(cmd+next_at, cmd_size-next_at, "%s", diff_opts);
-	next_at += snprintf(cmd+next_at, cmd_size-next_at, diff_arg, name_sq);
-	f = popen(cmd, "w");
-	if (old_size)
-		fwrite(old_contents, old_size, 1, f);
-	pclose(f);
-	if (label_sq != name_sq)
-		free(label_sq);
-	free(name_sq);
-	free(cmd);
-}
-
-static void show_diff_empty(struct cache_entry *ce, int reverse)
-{
-	char *old;
-	unsigned long int size;
-	unsigned char type[20];
-
-	old = read_sha1_file(ce->sha1, type, &size);
-	if (! old) {
-		error("unable to read blob object for %s (%s)", ce->name,
-		      sha1_to_hex(ce->sha1));
-		return;
-	}
-	show_differences("/dev/null", ce->name, old, size, reverse);
-}
+#include "diff.h"
 
 static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";
 
@@ -183,7 +87,8 @@ int main(int argc, char **argv)
 			else {
 				printf("%s: %s\n", ce->name, strerror(errno));
 				if (errno == ENOENT)
-					show_diff_empty(ce, reverse);
+					show_diff_empty(ce->sha1, ce->name,
+							reverse);
 			}
 			continue;
 		}

