From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix several places where diff.renames in config can be problematic
Date: Sat, 08 Jul 2006 01:05:16 -0700
Message-ID: <7vsllcr077.fsf@assigned-by-dhcp.cox.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net>
	<11522670473116-git-send-email-normalperson@yhbt.net>
	<7v7j2p3eac.fsf@assigned-by-dhcp.cox.net>
	<20060707110123.GA23400@soma>
	<7vpsghzmr1.fsf@assigned-by-dhcp.cox.net>
	<7v64i9zk0j.fsf@assigned-by-dhcp.cox.net>
	<20060708015844.GA13769@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 10:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz7og-0007P6-Qg
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 10:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWGHIFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 04:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWGHIFT
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 04:05:19 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61620 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751264AbWGHIFR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 04:05:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060708080517.NVHB12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Jul 2006 04:05:17 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060708015844.GA13769@soma> (Eric Wong's message of "Fri, 7 Jul
	2006 18:58:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23482>

Eric Wong <normalperson@yhbt.net> writes:

> -my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
> +my @files = safe_pipe_capture('git-diff-tree','--no-renames','-r',
> +				$parent, $commit);

I changed my mind.

-- >8 --
diff: do not use configuration magic at the core-level

The Porcelainish has become so much usable as the UI that there
is not much reason people should be using the core programs by
hand anymore.  At this point we are better off making the
behaviour of the core programs predictable by keeping them
unaffected by the configuration variables.  Otherwise they will
become very hard to use as reliable building blocks.

For example, "git-commit -a" internally uses git-diff-files to
figure out the set of paths that need to be updated in the
index, and we should never allow diff.renames that happens to be
in the configuration to interfere (or slow down the process).

The UI level configuration such as showing renamed diff and
coloring are still honored by the Porcelainish ("git log" family
and "git diff"), but not by the core anymore.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-diff-files.c  |    2 +-
 builtin-diff-index.c  |    2 +-
 builtin-diff-stages.c |    2 +-
 builtin-diff-tree.c   |    2 +-
 builtin-diff.c        |    2 +-
 builtin-log.c         |    8 ++++----
 diff.c                |    8 +++++++-
 diff.h                |    2 +-
 8 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index a655eea..81ac2fe 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -18,7 +18,7 @@ int cmd_diff_files(int argc, const char 
 	struct rev_info rev;
 	int silent = 0;
 
-	git_config(git_diff_config);
+	git_config(git_default_config); /* no "diff" UI options */
 	init_revisions(&rev);
 	rev.abbrev = 0;
 
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index b37c9e8..a1fa1b8 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -15,7 +15,7 @@ int cmd_diff_index(int argc, const char 
 	int cached = 0;
 	int i;
 
-	git_config(git_diff_config);
+	git_config(git_default_config); /* no "diff" UI options */
 	init_revisions(&rev);
 	rev.abbrev = 0;
 
diff --git a/builtin-diff-stages.c b/builtin-diff-stages.c
index 30931fe..9c62702 100644
--- a/builtin-diff-stages.c
+++ b/builtin-diff-stages.c
@@ -61,7 +61,7 @@ int cmd_diff_stages(int ac, const char *
 	const char *prefix = setup_git_directory();
 	const char **pathspec = NULL;
 
-	git_config(git_diff_config);
+	git_config(git_default_config); /* no "diff" UI options */
 	read_cache();
 	diff_setup(&diff_options);
 	while (1 < ac && av[1][0] == '-') {
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index ae1cde9..b610668 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -67,7 +67,7 @@ int cmd_diff_tree(int argc, const char *
 	static struct rev_info *opt = &log_tree_opt;
 	int read_stdin = 0;
 
-	git_config(git_diff_config);
+	git_config(git_default_config); /* no "diff" UI options */
 	nr_sha1 = 0;
 	init_revisions(opt);
 	opt->abbrev = 0;
diff --git a/builtin-diff.c b/builtin-diff.c
index d520c7c..1df531b 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -250,7 +250,7 @@ int cmd_diff(int argc, const char **argv
 	 * Other cases are errors.
 	 */
 
-	git_config(git_diff_config);
+	git_config(git_diff_ui_config);
 	init_revisions(&rev);
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/builtin-log.c b/builtin-log.c
index 698b71e..dd5a5a2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -47,7 +47,7 @@ int cmd_whatchanged(int argc, const char
 {
 	struct rev_info rev;
 
-	git_config(git_diff_config);
+	git_config(git_diff_ui_config);
 	init_revisions(&rev);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
@@ -62,7 +62,7 @@ int cmd_show(int argc, const char **argv
 {
 	struct rev_info rev;
 
-	git_config(git_diff_config);
+	git_config(git_diff_ui_config);
 	init_revisions(&rev);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
@@ -79,7 +79,7 @@ int cmd_log(int argc, const char **argv,
 {
 	struct rev_info rev;
 
-	git_config(git_diff_config);
+	git_config(git_diff_ui_config);
 	init_revisions(&rev);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, envp, &rev);
@@ -105,7 +105,7 @@ static int git_format_config(const char 
 		strcat(extra_headers, value);
 		return 0;
 	}
-	return git_diff_config(var, value);
+	return git_diff_ui_config(var, value);
 }
 
 
diff --git a/diff.c b/diff.c
index 1bf1ed0..493650c 100644
--- a/diff.c
+++ b/diff.c
@@ -102,7 +102,13 @@ static const char *parse_diff_color_valu
 	die("bad config value '%s' for variable '%s'", value, var);
 }
 
-int git_diff_config(const char *var, const char *value)
+/*
+ * These are to give UI layer defaults.
+ * The core-level commands such as git-diff-files should
+ * never be affected by the setting of diff.renames
+ * the user happens to have in the configuration file.
+ */
+int git_diff_ui_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "diff.renamelimit")) {
 		diff_rename_limit_default = git_config_int(var, value);
diff --git a/diff.h b/diff.h
index 8ab0448..a06f959 100644
--- a/diff.h
+++ b/diff.h
@@ -123,7 +123,7 @@ #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-extern int git_diff_config(const char *var, const char *value);
+extern int git_diff_ui_config(const char *var, const char *value);
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
 extern int diff_setup_done(struct diff_options *);
