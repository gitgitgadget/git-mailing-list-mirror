From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Mon,  2 Feb 2009 10:20:54 -0800
Message-ID: <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU3hr-0002xk-3S
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 19:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbZBBSiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 13:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZBBSiI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 13:38:08 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:34165 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719AbZBBSiG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 13:38:06 -0500
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n12Ic0Mj001179;
	Mon, 2 Feb 2009 10:38:00 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n12Ic0Kb001178;
	Mon, 2 Feb 2009 10:38:00 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108104>

Introduce config variable "diff.primer".
Improve porcelain diff's accommodation of user preference by allowing
some settings to (a) persist over all invocations and (b) stay consistent
over multiple tools (e.g. command-line and gui).  The approach taken here
is good because it delivers the consistency a user expects without breaking
any plumbing.  It works by allowing the user, via git-config, to specify
arbitrary options to pass to porcelain diff on every invocation, including
internal invocations from other programs, e.g. git-gui.  Introduce diff
command-line options --primer and --no-primer.  Affect only porcelain diff:
we suppress primer options for plumbing diff-{files,index,tree},
format-patch, and all other commands unless explicitly requested using
--primer (opt-in).  Teach gitk to use --primer, but protect it from
inapplicable options like --color.

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
 Documentation/config.txt       |   14 +++++++
 Documentation/diff-options.txt |   10 +++++
 builtin-diff.c                 |    2 +
 diff.c                         |   77 +++++++++++++++++++++++++++++++++++-----
 diff.h                         |   14 ++++++--
 gitk-git/gitk                  |   16 ++++----
 6 files changed, 113 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e2b8775..bd85c4a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -601,6 +601,20 @@ diff.autorefreshindex::
 	affects only 'git-diff' Porcelain, and not lower level
 	'diff' commands, such as 'git-diff-files'.
 
+diff.primer::
+	Whitespace-separated list of options to pass to 'git-diff'
+	on every invocation, including internal invocations from
+	linkgit:git-gui[1] and linkgit:gitk[1],
+	e.g. `"--patience --color --ignore-space-at-eol --exit-code"`.
+	See linkgit:git-diff[1]. You can suppress these at run time with
+	option `--no-primer`.  Supports a subset of
+	'git-diff'\'s many options, at least:
+	`-b --binary --color --color-words --cumulative --dirstat-by-file
+--exit-code --ext-diff --find-copies-harder --follow --full-index
+--ignore-all-space --ignore-space-at-eol --ignore-space-change
+--ignore-submodules --no-color --no-ext-diff --no-textconv --patience -q
+--quiet -R -r --relative -t --text --textconv -w`
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 813a7b1..f422055 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -254,5 +254,15 @@ override configuration settings.
 --no-prefix::
 	Do not show any source or destination prefix.
 
+--no-primer::
+	Ignore default options specified in '.git/config', i.e.
+	those that were set using a command like
+	`git config diff.primer "--patience --color --ignore-space-at-eol --exit-code"`
+
+--primer::
+	Opt-in for default options specified in '.git/config'.  This option is
+	most often used with the three plumbing commands diff-{files,index,tree}.
+	These commands normally suppress default options.
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/builtin-diff.c b/builtin-diff.c
index d75d69b..b3c3e87 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -284,6 +284,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 
+	DIFF_OPT_SET(&rev.diffopt, PRIMER);
+
 	/* If this is a no-index diff, just run it and exit there. */
 	diff_no_index(&rev, argc, argv, nongit, prefix);
 
diff --git a/diff.c b/diff.c
index a5a540f..32455c3 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,8 @@ static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
+static const char *diff_primer;
+static struct diff_options *primer;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 
@@ -106,6 +108,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		diff_rename_limit_default = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.primer"))
+		return git_config_string(&diff_primer, var, value);
 
 	switch (userdiff_config(var, value)) {
 		case 0: break;
@@ -2316,6 +2320,45 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
+static const char blank[] = " \t\r\n";
+
+void parse_diff_primer(struct diff_options *options)
+{
+	char *str1, *token, *saveptr;
+	int len;
+
+	if ((! diff_primer) || ((len = (strlen(diff_primer)+1)) < 3))
+		return;
+
+	token = str1 = strncpy((char*) malloc(len), diff_primer, len);
+	if ((saveptr = strpbrk(token += strspn(token, blank), blank)))
+		*(saveptr++) = '\0';
+	while (token) {
+		if (*token == '-')
+			diff_opt_parse(options, (const char **) &token, -1);
+		if ((token = saveptr))
+			if ((saveptr = strpbrk(token += strspn(token, blank), blank)))
+				*(saveptr++) = '\0';
+	}
+
+	free( str1 );
+}
+
+struct diff_options* flatten_diff_options(struct diff_options *master, struct diff_options *slave)
+{
+	unsigned x0 = master->flags, x1 = master->mask, x2 = slave->flags, x3 = slave->mask;
+	long w = master->xdl_opts, x = master->xdl_mask, y = slave->xdl_opts, z = slave->xdl_mask;
+
+	//minimized by Quine-McCluskey
+	master->flags = (~x1&x2&x3)|(x0&~x3)|(x0&x1);
+	master->mask = x1|x3;
+
+	master->xdl_opts = (~x&y&z)|(w&~z)|(w&x);
+	master->xdl_mask = x|z;
+
+	return master;
+}
+
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
@@ -2326,14 +2369,15 @@ void diff_setup(struct diff_options *options)
 	options->break_opt = -1;
 	options->rename_limit = -1;
 	options->dirstat_percent = 3;
-	DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
+	if (DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE))
+		DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
 	options->context = 3;
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
 	if (diff_use_color_default > 0)
 		DIFF_OPT_SET(options, COLOR_DIFF);
-	else
+	else if (DIFF_OPT_TST(options, COLOR_DIFF))
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	options->detect_rename = diff_detect_rename_default;
 
@@ -2423,6 +2467,14 @@ int diff_setup_done(struct diff_options *options)
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
 
+	if (DIFF_OPT_TST(options, PRIMER)) {
+		if (! primer) {
+			diff_setup(primer = (struct diff_options *) malloc(sizeof(struct diff_options)));
+			parse_diff_primer(primer);
+		}
+		flatten_diff_options(options, primer);
+	}
+
 	return 0;
 }
 
@@ -2570,13 +2622,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 
 	/* xdiff options */
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
+		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
+		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
-		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
+		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--patience"))
-		options->xdl_opts |= XDF_PATIENCE_DIFF;
+		DIFF_XDL_SET(options, PATIENCE_DIFF);
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
@@ -2597,10 +2649,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--no-color"))
 		DIFF_OPT_CLR(options, COLOR_DIFF);
-	else if (!strcmp(arg, "--color-words"))
-		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+	else if (!strcmp(arg, "--color-words")) {
+		DIFF_OPT_SET(options, COLOR_DIFF);
+		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
+	}
 	else if (!prefixcmp(arg, "--color-words=")) {
-		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+		DIFF_OPT_SET(options, COLOR_DIFF);
+		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
 		options->word_regex = arg + 14;
 	}
 	else if (!strcmp(arg, "--exit-code"))
@@ -2617,6 +2672,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules"))
 		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
+	else if (!strcmp(arg, "--primer"))
+		DIFF_OPT_SET(options, PRIMER);
+	else if (!strcmp(arg, "--no-primer"))
+		DIFF_OPT_CLR(options, PRIMER);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index 23cd90c..7f11b12 100644
--- a/diff.h
+++ b/diff.h
@@ -66,9 +66,15 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
-#define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
-#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
-#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
+#define DIFF_OPT_PRIMER              (1 << 22)
+#define DIFF_OPT_TST(opts, flag)    ((opts)->flags &   DIFF_OPT_##flag)
+#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |=  DIFF_OPT_##flag), ((opts)->mask |= DIFF_OPT_##flag)
+#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag), ((opts)->mask |= DIFF_OPT_##flag)
+#define DIFF_OPT_DRT(opts, flag)    ((opts)->mask  &   DIFF_OPT_##flag)
+#define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts &   XDF_##flag)
+#define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |=  XDF_##flag), ((opts)->xdl_mask |= XDF_##flag)
+#define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag), ((opts)->xdl_mask |= XDF_##flag)
+#define DIFF_XDL_DRT(opts, flag)    ((opts)->xdl_mask &   XDF_##flag)
 
 struct diff_options {
 	const char *filter;
@@ -77,6 +83,7 @@ struct diff_options {
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
+	unsigned mask;
 	int context;
 	int interhunkcontext;
 	int break_opt;
@@ -95,6 +102,7 @@ struct diff_options {
 	int prefix_length;
 	const char *stat_sep;
 	long xdl_opts;
+	long xdl_mask;
 
 	int stat_width;
 	int stat_name_width;
diff --git a/gitk-git/gitk b/gitk-git/gitk
index dc2a439..b67bbaa 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4259,7 +4259,7 @@ proc do_file_hl {serial} {
 	# must be "containing:", i.e. we're searching commit info
 	return
     }
-    set cmd [concat | git diff-tree -r -s --stdin $gdtargs]
+    set cmd [concat | git diff-tree --primer --no-color -r -s --stdin $gdtargs]
     set filehighlight [open $cmd r+]
     fconfigure $filehighlight -blocking 0
     filerun $filehighlight readfhighlight
@@ -4753,7 +4753,7 @@ proc dodiffindex {} {
 
     if {!$showlocalchanges || !$isworktree} return
     incr lserial
-    set cmd "|git diff-index --cached HEAD"
+    set cmd "|git diff-index --primer --no-color --cached HEAD"
     if {$vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -4782,7 +4782,7 @@ proc readdiffindex {fd serial inst} {
     }
 
     # now see if there are any local changes not checked in to the index
-    set cmd "|git diff-files"
+    set cmd "|git diff-files --primer --no-color"
     if {$vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -7068,7 +7068,7 @@ proc diffcmd {ids flags} {
     if {$i >= 0} {
 	if {[llength $ids] > 1 && $j < 0} {
 	    # comparing working directory with some specific revision
-	    set cmd [concat | git diff-index $flags]
+	    set cmd [concat | git diff-index --primer --no-color $flags]
 	    if {$i == 0} {
 		lappend cmd -R [lindex $ids 1]
 	    } else {
@@ -7076,13 +7076,13 @@ proc diffcmd {ids flags} {
 	    }
 	} else {
 	    # comparing working directory with index
-	    set cmd [concat | git diff-files $flags]
+	    set cmd [concat | git diff-files --primer --no-color $flags]
 	    if {$j == 1} {
 		lappend cmd -R
 	    }
 	}
     } elseif {$j >= 0} {
-	set cmd [concat | git diff-index --cached $flags]
+	set cmd [concat | git diff-index --primer --no-color --cached $flags]
 	if {[llength $ids] > 1} {
 	    # comparing index with specific revision
 	    if {$i == 0} {
@@ -7095,7 +7095,7 @@ proc diffcmd {ids flags} {
 	    lappend cmd HEAD
 	}
     } else {
-	set cmd [concat | git diff-tree -r $flags $ids]
+	set cmd [concat | git diff-tree --primer --no-color -r $flags $ids]
     }
     return $cmd
 }
@@ -10657,7 +10657,7 @@ if {[catch {package require Tk 8.4} err]} {
 }
 
 # defaults...
-set wrcomcmd "git diff-tree --stdin -p --pretty"
+set wrcomcmd "git diff-tree --primer --no-color --stdin -p --pretty"
 
 set gitencoding {}
 catch {
-- 
1.6.1
