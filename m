From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] diff: Rename QUIET internal option to QUICK
Date: Sat, 23 May 2009 12:24:50 -0700
Message-ID: <1243106690-6385-3-git-send-email-gitster@pobox.com>
References: <1243106690-6385-1-git-send-email-gitster@pobox.com>
 <1243106690-6385-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wqo-0002Cd-3B
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307AbZEWTZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103AbZEWTY7
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbZEWTYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD811B56BD
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0817EB56BC for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106690-6385-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 66513A76-47CF-11DE-A446-F6BA321C86B1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119795>

The option "QUIET" primarily meant "find if we have _any_ difference as
quick as possible and report", which means we often do not even have to
look at blobs if we know the trees are different by looking at the higher
level (e.g. "diff-tree A B").  As a side effect, because there is no point
showing one change that we happened to have found first, it also enables
NO_OUTPUT and EXIT_WITH_STATUS options, making the end result look quiet.

Rename the internal option to QUICK to reflect this better; it also makes
grepping the source tree much easier, as there are other kinds of QUIET
option everywhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-log.c      |    2 +-
 builtin-rev-list.c |    2 +-
 diff-lib.c         |    4 ++--
 diff.c             |    4 ++--
 diff.h             |    2 +-
 revision.c         |    2 +-
 tree-diff.c        |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..80624f5 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -536,7 +536,7 @@ static int reopen_stdout(struct commit *commit, struct rev_info *rev)
 
 	get_patch_filename(commit, rev->nr, fmt_patch_suffix, &filename);
 
-	if (!DIFF_OPT_TST(&rev->diffopt, QUIET))
+	if (!DIFF_OPT_TST(&rev->diffopt, QUICK))
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
 
 	if (freopen(filename.buf, "w", stdout) == NULL)
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 38a8f23..61d3126 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -315,7 +315,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
 
-	quiet = DIFF_OPT_TST(&revs.diffopt, QUIET);
+	quiet = DIFF_OPT_TST(&revs.diffopt, QUICK);
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/diff-lib.c b/diff-lib.c
index a310fb2..a549ee6 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,7 +73,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 
-		if (DIFF_OPT_TST(&revs->diffopt, QUIET) &&
+		if (DIFF_OPT_TST(&revs->diffopt, QUICK) &&
 			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
 
@@ -520,7 +520,7 @@ int index_differs_from(const char *def, int diff_flags)
 
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, def);
-	DIFF_OPT_SET(&rev.diffopt, QUIET);
+	DIFF_OPT_SET(&rev.diffopt, QUICK);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 	rev.diffopt.flags |= diff_flags;
 	run_diff_index(&rev, 1);
diff --git a/diff.c b/diff.c
index e4ab696..eb3a713 100644
--- a/diff.c
+++ b/diff.c
@@ -2445,7 +2445,7 @@ int diff_setup_done(struct diff_options *options)
 	 * to have found.  It does not make sense not to return with
 	 * exit code in such a case either.
 	 */
-	if (DIFF_OPT_TST(options, QUIET)) {
+	if (DIFF_OPT_TST(options, QUICK)) {
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
@@ -2636,7 +2636,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
-		DIFF_OPT_SET(options, QUIET);
+		DIFF_OPT_SET(options, QUICK);
 	else if (!strcmp(arg, "--ext-diff"))
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--no-ext-diff"))
diff --git a/diff.h b/diff.h
index 538e4f0..a7e7ccb 100644
--- a/diff.h
+++ b/diff.h
@@ -55,7 +55,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_COLOR_DIFF          (1 <<  8)
 #define DIFF_OPT_COLOR_DIFF_WORDS    (1 <<  9)
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
-#define DIFF_OPT_QUIET               (1 << 11)
+#define DIFF_OPT_QUICK               (1 << 11)
 #define DIFF_OPT_NO_INDEX            (1 << 12)
 #define DIFF_OPT_ALLOW_EXTERNAL      (1 << 13)
 #define DIFF_OPT_EXIT_WITH_STATUS    (1 << 14)
diff --git a/revision.c b/revision.c
index 18b7ebb..1c114ab 100644
--- a/revision.c
+++ b/revision.c
@@ -800,7 +800,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
 	DIFF_OPT_SET(&revs->pruning, RECURSIVE);
-	DIFF_OPT_SET(&revs->pruning, QUIET);
+	DIFF_OPT_SET(&revs->pruning, QUICK);
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
 	revs->lifo = 1;
diff --git a/tree-diff.c b/tree-diff.c
index 4b1e3f2..6dec88b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -280,7 +280,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 	int baselen = strlen(base);
 
 	for (;;) {
-		if (DIFF_OPT_TST(opt, QUIET) &&
+		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
 		if (opt->nr_paths) {
-- 
1.6.3.1.145.gb74d77
