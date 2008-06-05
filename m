From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [TOY PATCH] git wrapper: show similar command names for an unknown
 command
Date: Thu, 5 Jun 2008 07:48:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050747000.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 05 08:51:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K49JU-0000k5-Tl
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 08:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbYFEGuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 02:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbYFEGuI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 02:50:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:39210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753838AbYFEGuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 02:50:04 -0400
Received: (qmail invoked by alias); 05 Jun 2008 06:50:02 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp005) with SMTP; 05 Jun 2008 08:50:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18N9JRGwagN9FQG+hsmGxYBwwvIS2yIRU1ltylgBf
	tfuvo/yAm0D8a9
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83867>


This patch introduces a modified Damerau-Levenshtein algorithm into
Git's code base, and uses it with the following penalties to show some
similar commands when an unknown command was encountered:

	swap = 0, insertion = 1, substitution = 2, deletion = 4

A typical output would now look like this:

	$ git reabse
	git: 'reabse' is not a git-command. See 'git --help'.

	Did you mean one of these?
		rebase
		merge-base
		rev-parse
		remote
		rerere

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is just a toy, but might be useful to other people.

 Makefile      |    2 ++
 help.c        |   43 +++++++++++++++++++++++++++++++++++++++++++
 levenshtein.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 levenshtein.h |    8 ++++++++
 4 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 levenshtein.c
 create mode 100644 levenshtein.h

diff --git a/Makefile b/Makefile
index cce5a6e..df48af2 100644
--- a/Makefile
+++ b/Makefile
@@ -376,6 +376,7 @@ LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += utf8.h
 LIB_H += wt-status.h
+LIB_H += levenshtein.h
 
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
@@ -471,6 +472,7 @@ LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
+LIB_OBJS += levenshtein.o
 
 BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
diff --git a/help.c b/help.c
index d89d437..ac29225 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "levenshtein.h"
 
 static struct man_viewer_list {
 	struct man_viewer_list *next;
@@ -623,9 +624,51 @@ static void show_html_page(const char *git_cmd)
 	execl_git_cmd("web--browse", "-c", "help.browser", page_path.buf, NULL);
 }
 
+static const char *levenshtein_cmd;
+static int similarity(const char *cmd) {
+	return levenshtein(levenshtein_cmd, cmd, 0, 2, 1, 4);
+}
+
+static int levenshtein_compare(const void *p1, const void *p2)
+{
+	const struct cmdname *const *c1 = p1, *const *c2 = p2;
+	const char *s1 = (*c1)->name, *s2 = (*c2)->name;
+	int l1 = similarity(s1);
+	int l2 = similarity(s2);
+	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
+}
+
 void help_unknown_cmd(const char *cmd)
 {
+	int i, header_shown = 0;
+
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
+
+	load_command_list();
+	ALLOC_GROW(main_cmds.names, main_cmds.cnt + other_cmds.cnt,
+			main_cmds.alloc);
+	memcpy(main_cmds.names + main_cmds.cnt, other_cmds.names,
+		other_cmds.cnt * sizeof(other_cmds.names[0]));
+	main_cmds.cnt += other_cmds.cnt;
+
+	levenshtein_cmd = cmd;
+	qsort(main_cmds.names, main_cmds.cnt,
+	      sizeof(*main_cmds.names), levenshtein_compare);
+
+	for (i = 0; i < main_cmds.cnt; i++) {
+		int s = similarity(main_cmds.names[i]->name);
+		if (s > 6)
+			break;
+		if (!i) {
+			fprintf(stderr, "\nDid you mean %s?\n",
+				main_cmds.cnt < 2 ||
+				similarity(main_cmds.names[1]->name) > 6 ?
+				"this" : "one of these");
+			header_shown = 1;
+		}
+		fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+	}
+
 	exit(1);
 }
 
diff --git a/levenshtein.c b/levenshtein.c
new file mode 100644
index 0000000..db52f2c
--- /dev/null
+++ b/levenshtein.c
@@ -0,0 +1,47 @@
+#include "cache.h"
+#include "levenshtein.h"
+
+int levenshtein(const char *string1, const char *string2,
+		int w, int s, int a, int d)
+{
+	int len1 = strlen(string1), len2 = strlen(string2);
+	int *row0 = xmalloc(sizeof(int) * (len2 + 1));
+	int *row1 = xmalloc(sizeof(int) * (len2 + 1));
+	int *row2 = xmalloc(sizeof(int) * (len2 + 1));
+	int i, j;
+
+	for (j = 0; j <= len2; j++)
+		row1[j] = j * a;
+	for (i = 0; i < len1; i++) {
+		int *dummy;
+
+		row2[0] = (i + 1) * d;
+		for (j = 0; j < len2; j++) {
+			/* substitution */
+			row2[j + 1] = row1[j] + s * (string1[i] != string2[j]);
+			/* swap */
+			if (i > 0 && j > 0 && string1[i - 1] == string2[j] &&
+					string1[i] == string2[j - 1] &&
+					row2[j + 1] > row0[j - 1] + w)
+				row2[j + 1] = row0[j - 1] + w;
+			/* deletion */
+			if (j + 1 < len2 && row2[j + 1] > row1[j + 1] + d)
+				row2[j + 1] = row1[j + 1] + d;
+			/* insertion */
+			if (row2[j + 1] > row2[j] + a)
+				row2[j + 1] = row2[j] + a;
+		}
+
+		dummy = row0;
+		row0 = row1;
+		row1 = row2;
+		row2 = dummy;
+	}
+
+	i = row1[len2];
+	free(row0);
+	free(row1);
+	free(row2);
+
+	return i;
+}
diff --git a/levenshtein.h b/levenshtein.h
new file mode 100644
index 0000000..0173abe
--- /dev/null
+++ b/levenshtein.h
@@ -0,0 +1,8 @@
+#ifndef LEVENSHTEIN_H
+#define LEVENSHTEIN_H
+
+int levenshtein(const char *string1, const char *string2,
+	int swap_penalty, int substition_penalty,
+	int insertion_penalty, int deletion_penalty);
+
+#endif
-- 
1.5.6.rc1.167.gce972
