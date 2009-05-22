From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff: must --exit-code work with --ignore* options?
Date: Fri, 22 May 2009 13:40:49 -0700
Message-ID: <7v7i087twu.fsf@alter.siamese.dyndns.org>
References: <87k549dyne.fsf@meyering.net>
	<7vvdnt869j.fsf@alter.siamese.dyndns.org>
	<87eiuhdnw9.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri May 22 22:40:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7bY1-0008Ic-Pb
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905AbZEVUku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756951AbZEVUkt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 16:40:49 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:49979 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbZEVUks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 16:40:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090522204049.RFZA20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 May 2009 16:40:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ukgp1b00J4aMwMQ04kgpgw; Fri, 22 May 2009 16:40:50 -0400
X-Authority-Analysis: v=1.0 c=1 a=tgU2TYdJe80A:10 a=Tph-e6BAsvEA:10
 a=O0v0mdFJAAAA:8 a=ybZZDoGAAAAA:8 a=CVpe0-tgmyvmM_ZXCf4A:9
 a=UrsNiARlCFQk6Ui31tMA:7 a=w5L1IbqkTmqRYWsjEbx7NyBdyooA:4 a=VvQ7Xpx9qTgA:10
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <87eiuhdnw9.fsf@meyering.net> (Jim Meyering's message of "Fri\, 22 May 2009 19\:54\:14 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119751>

Jim Meyering <jim@meyering.net> writes:

> Junio C Hamano wrote:
>> Jim Meyering <jim@meyering.net> writes:
>>>
>>>     # do this in an empty directory
>>>     $ git init -q; echo>k; git add .; git commit -q -m. .; echo \ >k
>>>     $ git diff --ignore-space-at-eol --quiet || echo bad
>>>     bad
>>
>> I am slightly torn about this, in that I can picture myself saying that
>> this is unintuitive on some different days, but not today ;-)
>
> Thanks for the quick reply.  Here's why I noticed:
> ...

It seems that today is already "some different day" ;-) We could do
something like this patch.

While in the longer term I think it may make the world a better place by
being more consistent with what users expect, I am not sure at what
revision boundary we should introduce such a semantic change.

We could always declare this a bug and apply the "fix" at any time.  It's
all perception ;-).

-- >8 --
Subject: [PATCH] diff --quiet: special case "ignore whitespace" options

The option "QUIET" primarily meant "find if we have _any_ difference as
quick as possible and report", which means we often do not even have to
look at blobs if we know the trees are different by looking at the higher
level (e.g. "diff-tree A B").  As a side effect, because there is no point
showing one change that we happened to have found first, it also enables
NO_OUTPUT and EXIT_WITH_STATUS options, making the end result look quiet.

Traditionally, the --ignore-whitespace* options have merely meant to tell
the diff output routine that some class of differences are not worth
showing in the textual diff output, so that the end user has easier time
to review the remaining (presumably more meaningful) changes.  These
options never affected the outcome of the command, given as the exit
status when the --exit-code option was in effect (either directly or
indirectly).

These two classes of options are incompatible.  When you have only
whitespace changes, you would expect:

	git diff -b --quiet

to report that there is _no_ change.  This is unfortunately not the case,
however, if there are differences to be reported if the command was run
without --quiet; there _is_ a change, and the command still exits with
non-zero status.

And that is wrong.

Change the semantics of --ignore-whitespace* options to mean more than
"omit showing the difference in text".  When these options are used, the
internal "quick" optimization is turned off, and the status reported with
the --exit-code option will now match if any the textual diff output is
actually produced.

Also rename the internal option "QUIET" to "QUICK" to better reflect what
its true purpose is.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-log.c      |    2 +-
 builtin-rev-list.c |    2 +-
 diff-lib.c         |    4 ++--
 diff.c             |   39 ++++++++++++++++++++++++++++++++++++---
 diff.h             |    3 ++-
 revision.c         |    2 +-
 tree-diff.c        |    2 +-
 7 files changed, 44 insertions(+), 10 deletions(-)

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
index f06876b..f2ed2ac 100644
--- a/diff.c
+++ b/diff.c
@@ -2370,6 +2370,21 @@ int diff_setup_done(struct diff_options *options)
 	if (count > 1)
 		die("--name-only, --name-status, --check and -s are mutually exclusive");
 
+	/*
+	 * Most of the time we can say "there are changes"
+	 * only by checking if there are changed paths, but
+	 * --ignore-whitespace* options force us to look
+	 * inside contets.
+	 */
+
+	if ((XDF_IGNORE_WHITESPACE|
+	     XDF_IGNORE_WHITESPACE_CHANGE|
+	     XDF_IGNORE_WHITESPACE_AT_EOL) & options->xdl_opts) {
+		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
+	} else {
+		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
+	}
+
 	if (DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		options->detect_rename = DIFF_DETECT_COPY;
 
@@ -2430,9 +2445,19 @@ int diff_setup_done(struct diff_options *options)
 	 * to have found.  It does not make sense not to return with
 	 * exit code in such a case either.
 	 */
-	if (DIFF_OPT_TST(options, QUIET)) {
+	if (DIFF_OPT_TST(options, QUICK)) {
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
+
+		/*
+		 * QUICK means "if we find any difference return early
+		 * and say 'there is a difference'", and we often do
+		 * not even look at the blobs.  Some options would not
+		 * be compatible with this optimization, so we turn it
+		 * off, make it into "no output but exit with status".
+		 */
+		if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
+			DIFF_OPT_CLR(options, QUICK);
 	}
 
 	return 0;
@@ -2621,7 +2646,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
-		DIFF_OPT_SET(options, QUIET);
+		/* see postprocessing in diff_setup_done() */
+		DIFF_OPT_SET(options, QUICK);
 	else if (!strcmp(arg, "--ext-diff"))
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--no-ext-diff"))
@@ -3322,6 +3348,13 @@ free_queue:
 	q->nr = q->alloc = 0;
 	if (options->close_file)
 		fclose(options->file);
+
+	if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
+		if (options->found_changes)
+			DIFF_OPT_SET(options, HAS_CHANGES);
+		else
+			DIFF_OPT_CLR(options, HAS_CHANGES);
+	}
 }
 
 static void diffcore_apply_filter(const char *filter)
@@ -3458,7 +3491,7 @@ void diffcore_std(struct diff_options *options)
 	diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
 
-	if (diff_queued_diff.nr)
+	if (diff_queued_diff.nr && !DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
 		DIFF_OPT_SET(options, HAS_CHANGES);
 	else
 		DIFF_OPT_CLR(options, HAS_CHANGES);
diff --git a/diff.h b/diff.h
index 6616877..a7e7ccb 100644
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
@@ -66,6 +66,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
+#define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
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
index edd8394..ac85a55 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -280,7 +280,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 	int baselen = strlen(base);
 
 	for (;;) {
-		if (DIFF_OPT_TST(opt, QUIET) && DIFF_OPT_TST(opt, HAS_CHANGES))
+		if (DIFF_OPT_TST(opt, QUICK) && DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
 		if (opt->nr_paths) {
 			skip_uninteresting(t1, base, baselen, opt);
-- 
1.6.3.1.70.ga80aa
