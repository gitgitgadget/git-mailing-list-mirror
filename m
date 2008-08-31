From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] git wrapper: DWIM mistyped commands
Date: Sun, 31 Aug 2008 15:50:23 +0200
Message-ID: <20080831135023.GA6616@blimp.local>
References: <20080828171533.GA6024@blimp.local> <20080828212722.GF6439@steel.home> <7vsksm1pmd.fsf@gitster.siamese.dyndns.org> <81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com> <20080830171331.GA26932@steel.home> <7vprnqifd2.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 15:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZnLl-0006aJ-M0
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 15:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040AbYHaNu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 09:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbYHaNu2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 09:50:28 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:30366 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937AbYHaNu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 09:50:27 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f4EPXSQ==
Received: from tigra.home (Faf6f.f.strato-dslnet.de [195.4.175.111])
	by post.webmailer.de (klopstock mo24) (RZmta 16.47)
	with ESMTP id v073bfk7V7ekOq ; Sun, 31 Aug 2008 15:50:23 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 571E3277AE;
	Sun, 31 Aug 2008 15:50:23 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 2D4C336D1D; Sun, 31 Aug 2008 15:50:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vprnqifd2.fsf@gitster.siamese.dyndns.org> <237967ef0808300333t2cd4e354xd461f7bfead40f4c@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94480>

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

Junio C Hamano, Sat, Aug 30, 2008 19:26:17 +0200:
> I think you do not need the file-scope static levenshtein_cmd anymore with
> this change, if you make similarity() take two command names.  No?

Yes :)

> Please reroll the whole f66dd34 (git wrapper: DWIM mistyped commands,
> 2008-08-28), as it is not part of any solid integration branch yet.

I think I better reroll (now) both

> You might also want to update the commit log message to talk about the
> "len" reuse hack, but you already have in-code comment which might be
> sufficient.

I believe it is (and I added one against the member in the
declaration)

Mikael, this also might fix the crash you're seeing: the heap was
corrupted by clean_cmdnames(&other_cmds) names members of which were
moved to main_cmds.

 Makefile      |    2 +
 builtin.h     |    2 +-
 git.c         |    4 ++-
 help.c        |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 help.h        |    2 +-
 levenshtein.c |   47 +++++++++++++++++++++++++++++++++++++
 levenshtein.h |    8 ++++++
 7 files changed, 133 insertions(+), 4 deletions(-)
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
index b278257..aaba809 100644
--- a/help.c
+++ b/help.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "levenshtein.h"
 #include "help.h"
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
@@ -37,6 +38,16 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 	cmds->names[cmds->cnt++] = ent;
 }
 
+static void clean_cmdnames(struct cmdnames *cmds)
+{
+	int i;
+	for (i = 0; i < cmds->cnt; ++i)
+		free(cmds->names[i]);
+	free(cmds->names);
+	cmds->cnt = 0;
+	cmds->alloc = 0;
+}
+
 static int cmdname_compare(const void *a_, const void *b_)
 {
 	struct cmdname *a = *(struct cmdname **)a_;
@@ -250,9 +261,68 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
-void help_unknown_cmd(const char *cmd)
+static int levenshtein_compare(const void *p1, const void *p2)
+{
+	const struct cmdname *const *c1 = p1, *const *c2 = p2;
+	const char *s1 = (*c1)->name, *s2 = (*c2)->name;
+	int l1 = (*c1)->len;
+	int l2 = (*c2)->len;
+	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
+}
+
+const char *help_unknown_cmd(const char *cmd)
 {
+	int i, n, best_similarity = 0;
+	struct cmdnames main_cmds, other_cmds;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(main_cmds));
+
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	ALLOC_GROW(main_cmds.names, main_cmds.cnt + other_cmds.cnt,
+		   main_cmds.alloc);
+	memcpy(main_cmds.names + main_cmds.cnt, other_cmds.names,
+	       other_cmds.cnt * sizeof(other_cmds.names[0]));
+	main_cmds.cnt += other_cmds.cnt;
+	free(other_cmds.names);
+
+	/* This reuses cmdname->len for similarity index */
+	for (i = 0; i < main_cmds.cnt; ++i)
+		main_cmds.names[i]->len =
+			levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
+
+	qsort(main_cmds.names, main_cmds.cnt,
+	      sizeof(*main_cmds.names), levenshtein_compare);
+
+	if (!main_cmds.cnt)
+		die ("Uh oh. Your system reports no Git commands at all.");
+
+	best_similarity = main_cmds.names[0]->len;
+	n = 1;
+	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
+		++n;
+	if (n == 1) {
+		const char *assumed = main_cmds.names[0]->name;
+		main_cmds.names[0] = NULL;
+		clean_cmdnames(&main_cmds);
+		fprintf(stderr, "WARNING: You called a Git program named '%s', "
+			"which does not exist.\n"
+			"Continuing under the assumption that you meant '%s'\n",
+			cmd, assumed);
+		return assumed;
+	}
+
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
+
+	if (best_similarity < 6) {
+		fprintf(stderr, "\nDid you mean %s?\n",
+			n < 2 ? "this": "one of these");
+
+		for (i = 0; i < n; i++)
+			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+	}
+
 	exit(1);
 }
 
diff --git a/help.h b/help.h
index 2733433..56bc154 100644
--- a/help.h
+++ b/help.h
@@ -5,7 +5,7 @@ struct cmdnames {
 	int alloc;
 	int cnt;
 	struct cmdname {
-		size_t len;
+		size_t len; /* also used for similarity index in help.c */
 		char name[FLEX_ARRAY];
 	} **names;
 };
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
1.6.0.1.168.gdf6f0
