From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH updated] git wrapper: DWIM mistyped commands
Date: Thu, 28 Aug 2008 23:27:22 +0200
Message-ID: <20080828212722.GF6439@steel.home>
References: <20080828171533.GA6024@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 23:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYp2d-0003Kk-3e
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYH1V10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbYH1V10
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:27:26 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:21784 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbYH1V1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:27:25 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4kO7
Received: from tigra.home (Faa1f.f.strato-dslnet.de [195.4.170.31])
	by post.webmailer.de (klopstock mo44) (RZmta 16.47)
	with ESMTP id j00acak7SLB7bf ; Thu, 28 Aug 2008 23:27:23 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2296C277AE;
	Thu, 28 Aug 2008 23:27:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E9AA456D2A; Thu, 28 Aug 2008 23:27:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080828171533.GA6024@blimp.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94179>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This patch introduces a modified Damerau-Levenshtein algorithm into
Git's code base, and uses it with the following penalties to show some
similar commands when an unknown command was encountered:

	swap = 0, insertion = 1, substitution = 2, deletion = 4

A typical output would now look like this:

	$ git sm
	git: 'sm' is not a git-command. See 'git --help'.

	Did you mean one of these?
		am
		rm

The cut-off is at similarity rating 6, which was empirically determined
to give sensible results.

As a convenience, if there is only one candidate, Git continues under
the assumption that the user mistyped it.  Example:

	$ git reabse
	WARNING: You called a Git program named 'reabse', which does
	not exist.
	Continuing under the assumption that you meant 'rebase'
	[...]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Thu, Aug 28, 2008 19:15:33 +0200:
> 
> BTW, the Johannesses typo-guesser conflicts heavily in recent master.
> Pity. I'm going to rebase it and send out the rebased version.
> 

As promised. Johannes, I remember you talking about some problem with
that code (it should be the latest we talked about on the list), but I
am not sure I have updated the algorithm accordingly. Could you please
check?

 Makefile      |    2 +
 builtin.h     |    2 +-
 git.c         |    4 ++-
 help.c        |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 levenshtein.c |   47 +++++++++++++++++++++++++++++++++++++++++
 levenshtein.h |    8 +++++++
 6 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 levenshtein.c
 create mode 100644 levenshtein.h

diff --git a/Makefile b/Makefile
index bf400e6..3daa6dc 100644
--- a/Makefile
+++ b/Makefile
@@ -358,6 +358,7 @@ LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
 LIB_H += help.h
+LIB_H += levenshtein.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
@@ -433,6 +434,7 @@ LIB_OBJS += hash.o
 LIB_OBJS += help.o
 LIB_OBJS += ident.o
 LIB_OBJS += interpolate.o
+LIB_OBJS += levenshtein.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
diff --git a/builtin.h b/builtin.h
index f3502d3..e67cb20 100644
--- a/builtin.h
+++ b/builtin.h
@@ -11,7 +11,7 @@ extern const char git_usage_string[];
 extern const char git_more_info_string[];
 
 extern void list_common_cmds_help(void);
-extern void help_unknown_cmd(const char *cmd);
+extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
 extern int read_line_with_nul(char *buf, int size, FILE *file);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
diff --git a/git.c b/git.c
index 37b1d76..54c5bfa 100644
--- a/git.c
+++ b/git.c
@@ -499,7 +499,9 @@ int main(int argc, const char **argv)
 				cmd, argv[0]);
 			exit(1);
 		}
-		help_unknown_cmd(cmd);
+		argv[0] = help_unknown_cmd(cmd);
+		handle_internal_command(argc, argv);
+		execv_dashed_external(argv);
 	}
 
 	fprintf(stderr, "Failed to run command '%s': %s\n",
diff --git a/help.c b/help.c
index 1afbac0..981fb02 100644
--- a/help.c
+++ b/help.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "levenshtein.h"
 #include "help.h"
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
@@ -257,9 +258,70 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
-void help_unknown_cmd(const char *cmd)
+static const char *levenshtein_cmd;
+static int similarity(const char *cmd) {
+	return levenshtein(levenshtein_cmd, cmd, 0, 2, 1, 4);
+}
+
+static int levenshtein_compare(const void *p1, const void *p2)
 {
+	const struct cmdname *const *c1 = p1, *const *c2 = p2;
+	const char *s1 = (*c1)->name, *s2 = (*c2)->name;
+	int l1 = similarity(s1);
+	int l2 = similarity(s2);
+	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
+}
+
+const char *help_unknown_cmd(const char *cmd)
+{
+	int i, best_similarity = 0;
+	char cwd[PATH_MAX];
+	static struct cmdnames main_cmds, other_cmds;
+
+	if (!getcwd(cwd, sizeof(cwd))) {
+		error("Could not get current working directory");
+		cwd[0] = '\0';
+	}
+
+	if (!main_cmds.cnt && !other_cmds.cnt)
+		load_command_list("git-", &main_cmds, &other_cmds);
+
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
+	if (!main_cmds.cnt)
+		die ("Uh oh.  Your system reports no Git commands at all.");
+	best_similarity = similarity(main_cmds.names[0]->name);
+	if (main_cmds.cnt < 2 ||
+	    best_similarity < similarity(main_cmds.names[1]->name)) {
+		if (!*cwd)
+			exit(1);
+		if (chdir(cwd))
+			die ("Could not change directory back to '%s'", cwd);
+		fprintf(stderr, "WARNING: You called a Git program named '%s', "
+			"which does not exist.\n"
+			"Continuing under the assumption that you meant '%s'\n",
+			cmd, main_cmds.names[0]->name);
+		return main_cmds.names[0]->name;
+	}
+
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
+
+	if (best_similarity < 6) {
+		fprintf(stderr, "\nDid you mean one of these?\n");
+
+		for (i = 0; i < main_cmds.cnt && best_similarity ==
+				similarity(main_cmds.names[i]->name); i++)
+			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
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
1.6.0.106.g97c8
