From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/10] bisect--helper: implement "git bisect--helper"
Date: Thu, 26 Mar 2009 05:55:54 +0100
Message-ID: <20090326055554.e91bf6ba.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmhfp-0003rO-NB
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbZCZE46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZCZE46
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:56:58 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:39792 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbZCZE45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:56:57 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 3786D94004D;
	Thu, 26 Mar 2009 05:56:46 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 6C3A29400A4;
	Thu, 26 Mar 2009 05:56:43 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114732>

This patch implements a new "git bisect--helper" builtin plumbing
command that will be used to migrate "git-bisect.sh" to C.

We start by implementing only the "--next-vars" option that will
read bisect refs from "refs/bisect/", and then compute the next
bisect step, and output shell variables ready to be eval'ed by
the shell.

At this step, "git bisect--helper" ignores the paths that may
have been put in "$GIT_DIR/BISECT_NAMES". This will be fixed in a
later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile                 |    1 +
 bisect.c                 |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 bisect.h                 |    7 +++++
 builtin-bisect--helper.c |   27 ++++++++++++++++++
 builtin.h                |    1 +
 git.c                    |    1 +
 6 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100644 builtin-bisect--helper.c

diff --git a/Makefile b/Makefile
index 9fa2928..006c27b 100644
--- a/Makefile
+++ b/Makefile
@@ -521,6 +521,7 @@ BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
 BUILTIN_OBJS += builtin-apply.o
 BUILTIN_OBJS += builtin-archive.o
+BUILTIN_OBJS += builtin-bisect--helper.o
 BUILTIN_OBJS += builtin-blame.o
 BUILTIN_OBJS += builtin-branch.o
 BUILTIN_OBJS += builtin-bundle.o
diff --git a/bisect.c b/bisect.c
index 39189f2..ce62696 100644
--- a/bisect.c
+++ b/bisect.c
@@ -2,6 +2,8 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "refs.h"
+#include "list-objects.h"
 #include "bisect.h"
 
 
@@ -9,6 +11,10 @@ static unsigned char (*skipped_sha1)[20];
 static int skipped_sha1_nr;
 static int skipped_sha1_alloc;
 
+static const char **rev_argv;
+static int rev_argv_nr;
+static int rev_argv_alloc;
+
 /* bits #0-15 in revision.h */
 
 #define COUNTED		(1u<<16)
@@ -391,6 +397,33 @@ struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
+static int register_ref(const char *refname, const unsigned char *sha1,
+			int flags, void *cb_data)
+{
+	if (!strcmp(refname, "bad")) {
+		ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
+		rev_argv[rev_argv_nr++] = xstrdup(sha1_to_hex(sha1));
+	} else if (!prefixcmp(refname, "good-")) {
+		const char *hex = sha1_to_hex(sha1);
+		char *good = xmalloc(strlen(hex) + 2);
+		*good = '^';
+		memcpy(good + 1, hex, strlen(hex) + 1);
+		ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
+		rev_argv[rev_argv_nr++] = good;
+	} else if (!prefixcmp(refname, "skip-")) {
+		ALLOC_GROW(skipped_sha1, skipped_sha1_nr + 1,
+			   skipped_sha1_alloc);
+		hashcpy(skipped_sha1[skipped_sha1_nr++], sha1);
+	}
+
+	return 0;
+}
+
+static int read_bisect_refs(void)
+{
+	return for_each_bisect_ref(register_ref, NULL);
+}
+
 static int skipcmp(const void *a, const void *b)
 {
 	return hashcmp(a, b);
@@ -451,3 +484,37 @@ struct commit_list *filter_skipped(struct commit_list *list,
 
 	return filtered;
 }
+
+int bisect_next_vars(const char *prefix)
+{
+	struct rev_info revs;
+	int reaches = 0, all = 0;
+
+	init_revisions(&revs, prefix);
+	revs.abbrev = 0;
+	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+
+	/* argv[0] will be ignored by setup_revisions */
+	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
+	rev_argv[rev_argv_nr++] = xstrdup("bisect_rev_setup");
+
+	if (read_bisect_refs())
+		die("reading bisect refs failed");
+
+	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
+	rev_argv[rev_argv_nr++] = xstrdup("--");
+
+	setup_revisions(rev_argv_nr, rev_argv, &revs, NULL);
+
+	revs.limited = 1;
+
+	if (prepare_revision_walk(&revs))
+		die("revision walk setup failed");
+	if (revs.tree_objects)
+		mark_edges_uninteresting(revs.commits, &revs, NULL);
+
+	revs.commits = find_bisection(revs.commits, &reaches, &all,
+				      !!skipped_sha1_nr);
+
+	return show_bisect_vars(&revs, reaches, all, 0, 1);
+}
diff --git a/bisect.h b/bisect.h
index 2489630..05eea17 100644
--- a/bisect.h
+++ b/bisect.h
@@ -9,7 +9,14 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
 					  int show_all);
 
+/*
+ * The "show_all" parameter should be 0 if this function is called
+ * from outside "builtin-rev-list.c" as otherwise it would use
+ * static "revs" from this file.
+ */
 extern int show_bisect_vars(struct rev_info *revs, int reaches, int all,
 			    int show_all, int show_tried);
 
+extern int bisect_next_vars(const char *prefix);
+
 #endif
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
new file mode 100644
index 0000000..8fe7787
--- /dev/null
+++ b/builtin-bisect--helper.c
@@ -0,0 +1,27 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "bisect.h"
+
+static const char * const git_bisect_helper_usage[] = {
+	"git bisect--helper --next-vars",
+	NULL
+};
+
+int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
+{
+	int next_vars = 0;
+	struct option options[] = {
+		OPT_BOOLEAN(0, "next-vars", &next_vars,
+			    "output next bisect step variables"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, git_bisect_helper_usage, 0);
+
+	if (!next_vars)
+		usage_with_options(git_bisect_helper_usage, options);
+
+	/* next-vars */
+	return bisect_next_vars(prefix);
+}
diff --git a/builtin.h b/builtin.h
index 1495cf6..425ff8e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -25,6 +25,7 @@ extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
 extern int cmd_archive(int argc, const char **argv, const char *prefix);
+extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index c2b181e..a553926 100644
--- a/git.c
+++ b/git.c
@@ -271,6 +271,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
+		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
-- 
1.6.2.1.317.g3d804
