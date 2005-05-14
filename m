From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] Rename git-diff-tree-helper to git-diff-helper.
Date: Fri, 13 May 2005 18:40:54 -0700
Message-ID: <7vekca60ux.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 03:43:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWlg9-0000uS-Qt
	for gcvg-git@gmane.org; Sat, 14 May 2005 03:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVENBmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 21:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVENBmt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 21:42:49 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20954 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262671AbVENBlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 21:41:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514014056.JJEK7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 21:40:56 -0400
To: pasky@ucw.cz, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It used to be that diff-tree needed helper support to parse its
raw output to generate diffs, but these days git-diff-* family
produces the same output and the helper is not tied to diff-tree
anymore.  Drop "tree" from its name.

This commit is done separately to record just the rename and no
file content changes.  Makefiles and documentation needs to be
adjusted, which is done in the next commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-diff-helper.txt      |   49 +++++++++++
Documentation/git-diff-tree-helper.txt |   49 -----------
diff-helper.c                          |  143 +++++++++++++++++++++++++++++++++
diff-tree-helper.c                     |  143 ---------------------------------
4 files changed, 192 insertions(+), 192 deletions(-)
Documentation/git-diff-helper.txt (. --> 100644)
Documentation/git-diff-tree-helper.txt (100644 --> .)
diff-helper.c (. --> 100644)
diff-tree-helper.c (100644 --> .)

--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -0,0 +1,49 @@
+git-diff-tree-helper(1)
+=======================
+v0.1, May 2005
+
+NAME
+----
+git-diff-tree-helper - Generates patch format output for git-diff-*
+
+
+SYNOPSIS
+--------
+'git-diff-tree-helper' [-z] [-R]
+
+DESCRIPTION
+-----------
+Reads output from "git-diff-cache", "git-diff-tree" and "git-diff-files" and
+generates patch format output.
+
+OPTIONS
+-------
+-z::
+	\0 line termination on input
+
+-R::
+	Output diff in reverse.  This is useful for displaying output from
+	"git-diff-cache" which always compares tree with cache or working
+	file.  E.g.
+
+		git-diff-cache <tree> | git-diff-tree-helper -R file.c
++
+would show a diff to bring the working file back to what is in the <tree>.
+
+See Also
+--------
+The section on generating patches in link:git-diff-cache.html[git-diff-cache]
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
--- a/Documentation/git-diff-tree-helper.txt
+++ b/Documentation/git-diff-tree-helper.txt
@@ -1,49 +0,0 @@
-git-diff-tree-helper(1)
-=======================
-v0.1, May 2005
-
-NAME
-----
-git-diff-tree-helper - Generates patch format output for git-diff-*
-
-
-SYNOPSIS
---------
-'git-diff-tree-helper' [-z] [-R]
-
-DESCRIPTION
------------
-Reads output from "git-diff-cache", "git-diff-tree" and "git-diff-files" and
-generates patch format output.
-
-OPTIONS
--------
--z::
-	\0 line termination on input
-
--R::
-	Output diff in reverse.  This is useful for displaying output from
-	"git-diff-cache" which always compares tree with cache or working
-	file.  E.g.
-
-		git-diff-cache <tree> | git-diff-tree-helper -R file.c
-+
-would show a diff to bring the working file back to what is in the <tree>.
-
-See Also
---------
-The section on generating patches in link:git-diff-cache.html[git-diff-cache]
-
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org>
-
-Documentation
---------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the link:git.html[git] suite
-
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2005 Junio C Hamano
+ */
+#include <limits.h>
+#include "cache.h"
+#include "strbuf.h"
+#include "diff.h"
+
+static int matches_pathspec(const char *name, const char **spec, int cnt)
+{
+	int i;
+	int namelen = strlen(name);
+	for (i = 0; i < cnt; i++) {
+		int speclen = strlen(spec[i]);
+		if (! strncmp(spec[i], name, speclen) &&
+		    speclen <= namelen &&
+		    (name[speclen] == 0 ||
+		     name[speclen] == '/'))
+			return 1;
+	}
+	return 0;
+}
+
+static int parse_oneside_change(const char *cp, struct diff_spec *one,
+				char *path)
+{
+	int ch;
+
+	one->file_valid = one->sha1_valid = 1;
+	one->mode = 0;
+	while ((ch = *cp) && '0' <= ch && ch <= '7') {
+		one->mode = (one->mode << 3) | (ch - '0');
+		cp++;
+	}
+
+	if (strncmp(cp, "\tblob\t", 6))
+		return -1;
+	cp += 6;
+	if (get_sha1_hex(cp, one->blob_sha1))
+		return -1;
+	cp += 40;
+	if (*cp++ != '\t')
+		return -1;
+	strcpy(path, cp);
+	return 0;
+}
+
+static int parse_diff_tree_output(const char *buf,
+				  const char **spec, int cnt, int reverse)
+{
+	struct diff_spec old, new;
+	char path[PATH_MAX];
+	const char *cp = buf;
+	int ch;
+
+	switch (*cp++) {
+	case 'U':
+		if (!cnt || matches_pathspec(cp + 1, spec, cnt))
+			diff_unmerge(cp + 1);
+		return 0;
+	case '+':
+		old.file_valid = 0;
+		parse_oneside_change(cp, &new, path);
+		break;
+	case '-':
+		new.file_valid = 0;
+		parse_oneside_change(cp, &old, path);
+		break;
+	case '*':
+		old.file_valid = old.sha1_valid =
+			new.file_valid = new.sha1_valid = 1;
+		old.mode = new.mode = 0;
+		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+			old.mode = (old.mode << 3) | (ch - '0');
+			cp++;
+		}
+		if (strncmp(cp, "->", 2))
+			return -1;
+		cp += 2;
+		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+			new.mode = (new.mode << 3) | (ch - '0');
+			cp++;
+		}
+		if (strncmp(cp, "\tblob\t", 6))
+			return -1;
+		cp += 6;
+		if (get_sha1_hex(cp, old.blob_sha1))
+			return -1;
+		cp += 40;
+		if (strncmp(cp, "->", 2))
+			return -1;
+		cp += 2;
+		if (get_sha1_hex(cp, new.blob_sha1))
+			return -1;
+		cp += 40;
+		if (*cp++ != '\t')
+			return -1;
+		strcpy(path, cp);
+		break;
+	default:
+		return -1;
+	}
+	if (!cnt || matches_pathspec(path, spec, cnt)) {
+		if (reverse)
+			run_external_diff(path, &new, &old);
+		else
+			run_external_diff(path, &old, &new);
+	}
+	return 0;
+}
+
+static const char *diff_tree_helper_usage =
+"diff-tree-helper [-R] [-z] paths...";
+
+int main(int ac, const char **av) {
+	struct strbuf sb;
+	int reverse = 0;
+	int line_termination = '\n';
+
+	strbuf_init(&sb);
+
+	while (1 < ac && av[1][0] == '-') {
+		if (av[1][1] == 'R')
+			reverse = 1;
+		else if (av[1][1] == 'z')
+			line_termination = 0;
+		else
+			usage(diff_tree_helper_usage);
+		ac--; av++;
+	}
+	/* the remaining parameters are paths patterns */
+
+	while (1) {
+		int status;
+		read_line(&sb, stdin, line_termination);
+		if (sb.eof)
+			break;
+		status = parse_diff_tree_output(sb.buf, av+1, ac-1, reverse);
+		if (status)
+			fprintf(stderr, "cannot parse %s\n", sb.buf);
+	}
+	return 0;
+}
--- a/diff-tree-helper.c
+++ b/diff-tree-helper.c
@@ -1,143 +0,0 @@
-/*
- * Copyright (C) 2005 Junio C Hamano
- */
-#include <limits.h>
-#include "cache.h"
-#include "strbuf.h"
-#include "diff.h"
-
-static int matches_pathspec(const char *name, const char **spec, int cnt)
-{
-	int i;
-	int namelen = strlen(name);
-	for (i = 0; i < cnt; i++) {
-		int speclen = strlen(spec[i]);
-		if (! strncmp(spec[i], name, speclen) &&
-		    speclen <= namelen &&
-		    (name[speclen] == 0 ||
-		     name[speclen] == '/'))
-			return 1;
-	}
-	return 0;
-}
-
-static int parse_oneside_change(const char *cp, struct diff_spec *one,
-				char *path)
-{
-	int ch;
-
-	one->file_valid = one->sha1_valid = 1;
-	one->mode = 0;
-	while ((ch = *cp) && '0' <= ch && ch <= '7') {
-		one->mode = (one->mode << 3) | (ch - '0');
-		cp++;
-	}
-
-	if (strncmp(cp, "\tblob\t", 6))
-		return -1;
-	cp += 6;
-	if (get_sha1_hex(cp, one->blob_sha1))
-		return -1;
-	cp += 40;
-	if (*cp++ != '\t')
-		return -1;
-	strcpy(path, cp);
-	return 0;
-}
-
-static int parse_diff_tree_output(const char *buf,
-				  const char **spec, int cnt, int reverse)
-{
-	struct diff_spec old, new;
-	char path[PATH_MAX];
-	const char *cp = buf;
-	int ch;
-
-	switch (*cp++) {
-	case 'U':
-		if (!cnt || matches_pathspec(cp + 1, spec, cnt))
-			diff_unmerge(cp + 1);
-		return 0;
-	case '+':
-		old.file_valid = 0;
-		parse_oneside_change(cp, &new, path);
-		break;
-	case '-':
-		new.file_valid = 0;
-		parse_oneside_change(cp, &old, path);
-		break;
-	case '*':
-		old.file_valid = old.sha1_valid =
-			new.file_valid = new.sha1_valid = 1;
-		old.mode = new.mode = 0;
-		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-			old.mode = (old.mode << 3) | (ch - '0');
-			cp++;
-		}
-		if (strncmp(cp, "->", 2))
-			return -1;
-		cp += 2;
-		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-			new.mode = (new.mode << 3) | (ch - '0');
-			cp++;
-		}
-		if (strncmp(cp, "\tblob\t", 6))
-			return -1;
-		cp += 6;
-		if (get_sha1_hex(cp, old.blob_sha1))
-			return -1;
-		cp += 40;
-		if (strncmp(cp, "->", 2))
-			return -1;
-		cp += 2;
-		if (get_sha1_hex(cp, new.blob_sha1))
-			return -1;
-		cp += 40;
-		if (*cp++ != '\t')
-			return -1;
-		strcpy(path, cp);
-		break;
-	default:
-		return -1;
-	}
-	if (!cnt || matches_pathspec(path, spec, cnt)) {
-		if (reverse)
-			run_external_diff(path, &new, &old);
-		else
-			run_external_diff(path, &old, &new);
-	}
-	return 0;
-}
-
-static const char *diff_tree_helper_usage =
-"diff-tree-helper [-R] [-z] paths...";
-
-int main(int ac, const char **av) {
-	struct strbuf sb;
-	int reverse = 0;
-	int line_termination = '\n';
-
-	strbuf_init(&sb);
-
-	while (1 < ac && av[1][0] == '-') {
-		if (av[1][1] == 'R')
-			reverse = 1;
-		else if (av[1][1] == 'z')
-			line_termination = 0;
-		else
-			usage(diff_tree_helper_usage);
-		ac--; av++;
-	}
-	/* the remaining parameters are paths patterns */
-
-	while (1) {
-		int status;
-		read_line(&sb, stdin, line_termination);
-		if (sb.eof)
-			break;
-		status = parse_diff_tree_output(sb.buf, av+1, ac-1, reverse);
-		if (status)
-			fprintf(stderr, "cannot parse %s\n", sb.buf);
-	}
-	return 0;
-}

