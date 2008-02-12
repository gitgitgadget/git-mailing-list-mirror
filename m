From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] diff --relative: output paths as relative to the current
 subdirectory
Date: Tue, 12 Feb 2008 14:26:02 -0800
Message-ID: <7vzlu524n9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 23:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP3bn-0003d7-GJ
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 23:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948AbYBLW05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 17:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756935AbYBLW04
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 17:26:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900AbYBLW0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 17:26:54 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF175572;
	Tue, 12 Feb 2008 17:26:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 4067E5513; Tue, 12 Feb 2008 17:26:07 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73705>

This adds --relative option to diff family.  When you start from
a subdirectory, 

 $ git diff --relative
        
shows only the diff that is inside your current subdirectory,
and without $prefix part.  People who usually live in
subdirectories may like it.

There are a few things I should also mention about the change:

 - This works not just with diff but also works with the log
   family of commands, but the history pruning is not affected.

   In other words, if you go to a subdirectory, you can say:

        $ git log --relative -p

   but it will show the log message even for commits that do not
   touch the current directory.  You can limit it by giving
   pathspec yourself:

        $ git log --relative -p .

   This originally was not a conscious design choice, but we
   have a way to affect diff pathspec and pruning pathspec
   independently.  IOW "git log --full-diff -p ." tells it to
   prune history to commits that affect the current subdirectory
   but show the changes with full context.  I think it makes
   more sense to leave pruning independent from --relative than
   the obvious alternative of always pruning with the current
   subdirectory, which would break the symmetry.

 - Because this works also with the log family, you could
   format-patch a single change, limiting the effect to your
   subdirectory, like so:

        $ cd gitk-git
        $ git format-patch -1 --relative 911f1eb

   But because that is a special purpose usage, this option will
   never become the default, with or without repository or user
   preference configuration.  The risk of producing a partial
   patch and sending it out by mistake is too great if we did
   so.

 - This is inherently incompatible with --no-index, which is a
   bolted-on hack that does not have much to do with git
   itself.  I didn't bother checking and erroring out on the
   combined use of the options, but probably I should.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I've been cooking this privately, but I am sending this out
   now, as I suspect dirstat needs to be adjusted if we decide
   this is a good idea.

 Documentation/git-diff.txt    |    5 ++
 builtin-diff.c                |   11 ++++-
 diff.c                        |  100 ++++++++++++++++++++++++++++++++++-------
 diff.h                        |    3 +
 revision.c                    |    4 ++
 t/t3404-rebase-interactive.sh |   10 +++-
 6 files changed, 113 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 57c2862..012bbdc 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -78,6 +78,11 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
+--relative::
+	When run from a subdirectory of the project, it can be
+	told to exclude changes outside the directory and show
+	pathnames relative to it with this option.
+
 <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
diff --git a/builtin-diff.c b/builtin-diff.c
index 8d7a569..19fa668 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -43,12 +43,17 @@ static void stuff_change(struct diff_options *opt,
 		tmp_u = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_u;
 		tmp_c = old_name; old_name = new_name; new_name = tmp_c;
 	}
+
+	if (opt->prefix &&
+	    (strncmp(old_name, opt->prefix, opt->prefix_length) ||
+	     strncmp(new_name, opt->prefix, opt->prefix_length)))
+		return;
+
 	one = alloc_filespec(old_name);
 	two = alloc_filespec(new_name);
 	fill_filespec(one, old_sha1, old_mode);
 	fill_filespec(two, new_sha1, new_mode);
 
-	/* NEEDSWORK: shouldn't this part of diffopt??? */
 	diff_queue(&diff_queued_diff, one, two);
 }
 
@@ -241,6 +246,10 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		if (diff_setup_done(&rev.diffopt) < 0)
 			die("diff_setup_done failed");
 	}
+	if (rev.diffopt.prefix && nongit) {
+		rev.diffopt.prefix = NULL;
+		rev.diffopt.prefix_length = 0;
+	}
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
diff --git a/diff.c b/diff.c
index 5b8afdc..db4bd55 100644
--- a/diff.c
+++ b/diff.c
@@ -1397,6 +1397,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 }
 
 static void builtin_checkdiff(const char *name_a, const char *name_b,
+			      const char *attr_path,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two, struct diff_options *o)
 {
@@ -1411,7 +1412,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.filename = name_b ? name_b : name_a;
 	data.lineno = 0;
 	data.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
-	data.ws_rule = whitespace_rule(data.filename);
+	data.ws_rule = whitespace_rule(attr_path);
 
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
@@ -1831,6 +1832,9 @@ static const char *external_diff_attr(const char *name)
 {
 	struct git_attr_check attr_diff_check;
 
+	if (!name)
+		return NULL;
+
 	setup_diff_attr_check(&attr_diff_check);
 	if (!git_checkattr(name, 1, &attr_diff_check)) {
 		const char *value = attr_diff_check.value;
@@ -1850,6 +1854,7 @@ static const char *external_diff_attr(const char *name)
 static void run_diff_cmd(const char *pgm,
 			 const char *name,
 			 const char *other,
+			 const char *attr_path,
 			 struct diff_filespec *one,
 			 struct diff_filespec *two,
 			 const char *xfrm_msg,
@@ -1859,7 +1864,7 @@ static void run_diff_cmd(const char *pgm,
 	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
 		pgm = NULL;
 	else {
-		const char *cmd = external_diff_attr(name);
+		const char *cmd = external_diff_attr(attr_path);
 		if (cmd)
 			pgm = cmd;
 	}
@@ -1900,6 +1905,15 @@ static int similarity_index(struct diff_filepair *p)
 	return p->score * 100 / MAX_SCORE;
 }
 
+static void strip_prefix(int prefix_length, const char **namep, const char **otherp)
+{
+	/* Strip the prefix but do not molest /dev/null and absolute paths */
+	if (*namep && **namep != '/')
+		*namep += prefix_length;
+	if (*otherp && **otherp != '/')
+		*otherp += prefix_length;
+}
+
 static void run_diff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *pgm = external_diff();
@@ -1909,16 +1923,21 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	struct diff_filespec *two = p->two;
 	const char *name;
 	const char *other;
+	const char *attr_path;
 	int complete_rewrite = 0;
 
+	name  = p->one->path;
+	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	attr_path = name;
+	if (o->prefix_length)
+		strip_prefix(o->prefix_length, &name, &other);
 
 	if (DIFF_PAIR_UNMERGED(p)) {
-		run_diff_cmd(pgm, p->one->path, NULL, NULL, NULL, NULL, o, 0);
+		run_diff_cmd(pgm, name, NULL, attr_path,
+			     NULL, NULL, NULL, o, 0);
 		return;
 	}
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 	diff_fill_sha1_info(one);
 	diff_fill_sha1_info(two);
 
@@ -1981,15 +2000,17 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		 * needs to be split into deletion and creation.
 		 */
 		struct diff_filespec *null = alloc_filespec(two->path);
-		run_diff_cmd(NULL, name, other, one, null, xfrm_msg, o, 0);
+		run_diff_cmd(NULL, name, other, attr_path,
+			     one, null, xfrm_msg, o, 0);
 		free(null);
 		null = alloc_filespec(one->path);
-		run_diff_cmd(NULL, name, other, null, two, xfrm_msg, o, 0);
+		run_diff_cmd(NULL, name, other, attr_path,
+			     null, two, xfrm_msg, o, 0);
 		free(null);
 	}
 	else
-		run_diff_cmd(pgm, name, other, one, two, xfrm_msg, o,
-			     complete_rewrite);
+		run_diff_cmd(pgm, name, other, attr_path,
+			     one, two, xfrm_msg, o, complete_rewrite);
 
 	strbuf_release(&msg);
 }
@@ -2010,6 +2031,9 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	name = p->one->path;
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 
+	if (o->prefix_length)
+		strip_prefix(o->prefix_length, &name, &other);
+
 	diff_fill_sha1_info(p->one);
 	diff_fill_sha1_info(p->two);
 
@@ -2022,6 +2046,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *name;
 	const char *other;
+	const char *attr_path;
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
@@ -2030,11 +2055,15 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 
 	name = p->one->path;
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	attr_path = other ? other : name;
+
+	if (o->prefix_length)
+		strip_prefix(o->prefix_length, &name, &other);
 
 	diff_fill_sha1_info(p->one);
 	diff_fill_sha1_info(p->two);
 
-	builtin_checkdiff(name, other, p->one, p->two, o);
+	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
 void diff_setup(struct diff_options *options)
@@ -2076,6 +2105,13 @@ int diff_setup_done(struct diff_options *options)
 	if (DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		options->detect_rename = DIFF_DETECT_COPY;
 
+	if (!DIFF_OPT_TST(options, RELATIVE_NAME))
+		options->prefix = NULL;
+	if (options->prefix)
+		options->prefix_length = strlen(options->prefix);
+	else
+		options->prefix_length = 0;
+
 	if (options->output_format & (DIFF_FORMAT_NAME |
 				      DIFF_FORMAT_NAME_STATUS |
 				      DIFF_FORMAT_CHECKDIFF |
@@ -2264,6 +2300,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
+	else if (!strcmp(arg, "--relative"))
+		DIFF_OPT_SET(options, RELATIVE_NAME);
 
 	/* xdiff options */
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
@@ -2475,12 +2513,20 @@ static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)
 		printf("%c%c", p->status, inter_name_termination);
 	}
 
-	if (p->status == DIFF_STATUS_COPIED || p->status == DIFF_STATUS_RENAMED) {
-		write_name_quoted(p->one->path, stdout, inter_name_termination);
-		write_name_quoted(p->two->path, stdout, line_termination);
+	if (p->status == DIFF_STATUS_COPIED ||
+	    p->status == DIFF_STATUS_RENAMED) {
+		const char *name_a, *name_b;
+		name_a = p->one->path;
+		name_b = p->two->path;
+		strip_prefix(opt->prefix_length, &name_a, &name_b);
+		write_name_quoted(name_a, stdout, inter_name_termination);
+		write_name_quoted(name_b, stdout, line_termination);
 	} else {
-		const char *path = p->one->mode ? p->one->path : p->two->path;
-		write_name_quoted(path, stdout, line_termination);
+		const char *name_a, *name_b;
+		name_a = p->one->mode ? p->one->path : p->two->path;
+		name_b = NULL;
+		strip_prefix(opt->prefix_length, &name_a, &name_b);
+		write_name_quoted(name_a, stdout, line_termination);
 	}
 }
 
@@ -2677,8 +2723,13 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 		diff_flush_checkdiff(p, opt);
 	else if (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))
 		diff_flush_raw(p, opt);
-	else if (fmt & DIFF_FORMAT_NAME)
-		write_name_quoted(p->two->path, stdout, opt->line_termination);
+	else if (fmt & DIFF_FORMAT_NAME) {
+		const char *name_a, *name_b;
+		name_a = p->two->path;
+		name_b = NULL;
+		strip_prefix(opt->prefix_length, &name_a, &name_b);
+		write_name_quoted(name_a, stdout, opt->line_termination);
+	}
 }
 
 static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
@@ -3164,6 +3215,11 @@ void diff_addremove(struct diff_options *options,
 
 	if (!path) path = "";
 	sprintf(concatpath, "%s%s", base, path);
+
+	if (options->prefix &&
+	    strncmp(concatpath, options->prefix, options->prefix_length))
+		return;
+
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
 
@@ -3193,6 +3249,11 @@ void diff_change(struct diff_options *options,
 	}
 	if (!path) path = "";
 	sprintf(concatpath, "%s%s", base, path);
+
+	if (options->prefix &&
+	    strncmp(concatpath, options->prefix, options->prefix_length))
+		return;
+
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
 	fill_filespec(one, old_sha1, old_mode);
@@ -3207,6 +3268,11 @@ void diff_unmerge(struct diff_options *options,
 		  unsigned mode, const unsigned char *sha1)
 {
 	struct diff_filespec *one, *two;
+
+	if (options->prefix &&
+	    strncmp(path, options->prefix, options->prefix_length))
+		return;
+
 	one = alloc_filespec(path);
 	two = alloc_filespec(path);
 	fill_filespec(one, sha1, mode);
diff --git a/diff.h b/diff.h
index 073d5cb..fcd9653 100644
--- a/diff.h
+++ b/diff.h
@@ -60,6 +60,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_EXIT_WITH_STATUS    (1 << 14)
 #define DIFF_OPT_REVERSE_DIFF        (1 << 15)
 #define DIFF_OPT_CHECK_FAILED        (1 << 16)
+#define DIFF_OPT_RELATIVE_NAME       (1 << 17)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
@@ -82,6 +83,8 @@ struct diff_options {
 	int rename_limit;
 	int setup;
 	int abbrev;
+	const char *prefix;
+	int prefix_length;
 	const char *msg_sep;
 	const char *stat_sep;
 	long xdl_opts;
diff --git a/revision.c b/revision.c
index 6e85aaa..6d9188b 100644
--- a/revision.c
+++ b/revision.c
@@ -720,6 +720,10 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
 	diff_setup(&revs->diffopt);
+	if (prefix) {
+		revs->diffopt.prefix = prefix;
+		revs->diffopt.prefix_length = strlen(prefix);
+	}
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e33ea4e..bc46c37 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -328,8 +328,14 @@ test_expect_success 'rebase a commit violating pre-commit' '
 
 	mkdir -p .git/hooks &&
 	PRE_COMMIT=.git/hooks/pre-commit &&
-	echo "#!/bin/sh" > $PRE_COMMIT &&
-	echo "test -z \"\$(git diff --cached --check)\"" >> $PRE_COMMIT &&
+	(
+		echo "#!/bin/sh"
+		echo "z=\$(git diff --cached --check)"
+		echo "test -z \"\$z\" || {"
+		echo "    echo >&2 \"*** \$z ***\""
+		echo "    false"
+		echo "}"
+	) > $PRE_COMMIT &&
 	chmod a+x $PRE_COMMIT &&
 	echo "monde! " >> file1 &&
 	test_tick &&
-- 
1.5.4.1.1278.gc75be
