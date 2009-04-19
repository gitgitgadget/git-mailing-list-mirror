From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/5] bisect--helper: add "--next-exit" to output bisect
 results
Date: Sun, 19 Apr 2009 11:56:07 +0200
Message-ID: <20090419115607.c7089503.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 11:58:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvTnc-0002MA-JB
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 11:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755AbZDSJ5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 05:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755692AbZDSJ5Y
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 05:57:24 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:60042 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120AbZDSJ5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 05:57:22 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 458BF4B011A;
	Sun, 19 Apr 2009 11:57:15 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 44FDF4B003B;
	Sun, 19 Apr 2009 11:57:13 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116889>

The goal of this patch is to port more shell code from the "bisect_next"
function in "git-bisect.sh" to C code in "builtin-bisect--helper.c".

So we port the code that interprets the bisection result and stops or
continues (by checking out the next revision) the bisection process.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c                 |  105 ++++++++++++++++++++++++++++++++++++++++++++++
 bisect.h                 |    1 +
 builtin-bisect--helper.c |   12 ++++-
 3 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 0448eae..f6e1378 100644
--- a/bisect.c
+++ b/bisect.c
@@ -6,6 +6,7 @@
 #include "list-objects.h"
 #include "quote.h"
 #include "sha1-lookup.h"
+#include "run-command.h"
 #include "bisect.h"
 
 static unsigned char (*skipped_sha1)[20];
@@ -16,6 +17,12 @@ static const char **rev_argv;
 static int rev_argv_nr;
 static int rev_argv_alloc;
 
+static const unsigned char *current_bad_sha1;
+
+static const char *argv_diff_tree[] = {"diff-tree", "--pretty", NULL, NULL};
+static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
+static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+
 /* bits #0-15 in revision.h */
 
 #define COUNTED		(1u<<16)
@@ -403,6 +410,7 @@ static int register_ref(const char *refname, const unsigned char *sha1,
 {
 	if (!strcmp(refname, "bad")) {
 		ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
+		current_bad_sha1 = sha1;
 		rev_argv[rev_argv_nr++] = xstrdup(sha1_to_hex(sha1));
 	} else if (!prefixcmp(refname, "good-")) {
 		const char *hex = sha1_to_hex(sha1);
@@ -560,3 +568,100 @@ int bisect_next_vars(const char *prefix)
 
 	return show_bisect_vars(&info, reaches, all);
 }
+
+static void exit_if_skipped_commits(struct commit_list *tried,
+				    const unsigned char *bad)
+{
+	if (!tried)
+		return;
+
+	printf("There are only 'skip'ped commit left to test.\n"
+	       "The first bad commit could be any of:\n");
+	print_commit_list(tried, "%s\n", "%s\n");
+	if (bad)
+		printf("%s\n", sha1_to_hex(bad));
+	printf("We cannot bisect more!\n");
+	exit(2);
+}
+
+static void mark_expected_rev(char *bisect_rev_hex)
+{
+	int len = strlen(bisect_rev_hex);
+	const char *filename = git_path("BISECT_EXPECTED_REV");
+	int fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+
+	if (fd < 0)
+		die("could not create file '%s': %s",
+		    filename, strerror(errno));
+
+	bisect_rev_hex[len] = '\n';
+	write_or_die(fd, bisect_rev_hex, len + 1);
+	bisect_rev_hex[len] = '\0';
+
+	if (close(fd) < 0)
+		die("closing file %s: %s", filename, strerror(errno));
+}
+
+static int bisect_checkout(char *bisect_rev_hex)
+{
+	int res;
+
+	mark_expected_rev(bisect_rev_hex);
+
+	argv_checkout[2] = bisect_rev_hex;
+	res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
+	if (res)
+		exit(res);
+
+	argv_show_branch[1] = bisect_rev_hex;
+	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
+}
+
+/*
+ * We use the convention that exiting with an exit code 10 means that
+ * the bisection process finished successfully.
+ * In this case the calling shell script should exit 0.
+ */
+int bisect_next_exit(const char *prefix)
+{
+	struct rev_info revs;
+	struct commit_list *tried;
+	int reaches = 0, all = 0, nr;
+	const unsigned char *bisect_rev;
+	char bisect_rev_hex[41];
+
+	bisect_common(&revs, prefix, &reaches, &all);
+
+	revs.commits = filter_skipped(revs.commits, &tried, 0);
+
+	if (!revs.commits) {
+		/*
+		 * We should exit here only if the "bad"
+		 * commit is also a "skip" commit.
+		 */
+		exit_if_skipped_commits(tried, NULL);
+
+		printf("%s was both good and bad\n",
+		       sha1_to_hex(current_bad_sha1));
+		exit(1);
+	}
+
+	bisect_rev = revs.commits->item->object.sha1;
+	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), 41);
+
+	if (!hashcmp(bisect_rev, current_bad_sha1)) {
+		exit_if_skipped_commits(tried, current_bad_sha1);
+		printf("%s is first bad commit\n", bisect_rev_hex);
+		argv_diff_tree[2] = bisect_rev_hex;
+		run_command_v_opt(argv_diff_tree, RUN_GIT_CMD);
+		/* This means the bisection process succeeded. */
+		exit(10);
+	}
+
+	nr = all - reaches - 1;
+	printf("Bisecting: %d revisions left to test after this "
+	       "(roughly %d steps)\n", nr, estimate_bisect_steps(all));
+
+	return bisect_checkout(bisect_rev_hex);
+}
+
diff --git a/bisect.h b/bisect.h
index 89aa6cb..028eb85 100644
--- a/bisect.h
+++ b/bisect.h
@@ -29,6 +29,7 @@ struct rev_list_info {
 extern int show_bisect_vars(struct rev_list_info *info, int reaches, int all);
 
 extern int bisect_next_vars(const char *prefix);
+extern int bisect_next_exit(const char *prefix);
 
 extern int estimate_bisect_steps(int all);
 
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
index 8fe7787..cb86a9a 100644
--- a/builtin-bisect--helper.c
+++ b/builtin-bisect--helper.c
@@ -5,23 +5,29 @@
 
 static const char * const git_bisect_helper_usage[] = {
 	"git bisect--helper --next-vars",
+	"git bisect--helper --next-exit",
 	NULL
 };
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_vars = 0;
+	int next_exit = 0;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "next-vars", &next_vars,
 			    "output next bisect step variables"),
+		OPT_BOOLEAN(0, "next-exit", &next_exit,
+			    "output bisect result and exit instuctions"),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, options, git_bisect_helper_usage, 0);
 
-	if (!next_vars)
+	if ((next_vars && next_exit) || (!next_vars && !next_exit))
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-vars */
-	return bisect_next_vars(prefix);
+	if (next_vars)
+		return bisect_next_vars(prefix);
+	else /* next-exit */
+		return bisect_next_exit(prefix);
 }
-- 
1.6.2.2.537.g3b83b
