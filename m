From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 09:30:55 -0800
Message-ID: <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 18:44:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR92J-0006Ap-Eu
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 18:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbZAYRnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 12:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbZAYRnS
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 12:43:18 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:34037 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbZAYRnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 12:43:16 -0500
X-Greylist: delayed 718 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Jan 2009 12:43:13 EST
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n0PHVUwa031874;
	Sun, 25 Jan 2009 09:31:30 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n0PHVUKD031873;
	Sun, 25 Jan 2009 09:31:30 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107072>

Introduce config variable "diff.primer".
Allows user to specify arbitrary options
to pass to diff on every invocation,
including internal invocations from other
programs, e.g. git-gui.
Introduce diff command-line options:
--no-primer, --machine-friendly
Protect git-format-patch, git-apply,
git-am, git-rebase, git-gui and gitk
from inapplicable options.

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
 Documentation/config.txt       |   14 +++++++
 Documentation/diff-options.txt |   13 ++++++
 Makefile                       |    2 +
 builtin-log.c                  |    1 +
 diff.c                         |   83 +++++++++++++++++++++++++++++++++++-----
 diff.h                         |   15 ++++++-
 git-gui/lib/diff.tcl           |    8 +++-
 gitk-git/gitk                  |   16 ++++----
 8 files changed, 129 insertions(+), 23 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 290cb48..dd00f98 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -601,6 +601,20 @@ diff.autorefreshindex::
 	affects only 'git-diff' Porcelain, and not lower level
 	'diff' commands, such as 'git-diff-files'.
 
+diff.primer::
+	Whitespace-separated list of options to pass to 'git-diff'
+	on every invocation, including internal invocations from
+	linkgit:git-gui[1] and linkgit:gitk[1],
+	e.g. `"--color --ignore-space-at-eol --exit-code"`.
+	See linkgit:git-diff[1]. You can override these at run time with the
+	diff option --no-primer.  Supports a subset of
+	'git-diff'\'s many options, at least:
+	`-b --binary --color --color-words --cumulative --dirstat-by-file
+--exit-code --ext-diff --find-copies-harder --follow --full-index
+--ignore-all-space --ignore-space-at-eol --ignore-space-change
+--ignore-submodules --no-color --no-ext-diff --no-textconv -q --quiet -R -r
+--relative -t --text --textconv -w`
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1f8ce97..4d12359 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -240,5 +240,18 @@ endif::git-format-patch[]
 --no-prefix::
 	Do not show any source or destination prefix.
 
+--no-primer::
+	Ignore default options specified in '.git/config', i.e.
+	those that were set using a command like
+	`git config diff.primer "--color --ignore-space-at-eol --exit-code"`
+
+--machine-friendly::
+	Declaratively override and turn off all diff options that alter patch
+	output in a way not suitable for input to a program that expects
+	a canonical patch.  For example, `--color`, and the whitespace ignore
+	options `-w`, `-b` and `--ignore-space-at-eol`.  Important when
+	'git-format-patch' generates output for 'git-apply' or 'git-am', for
+	example in the context of 'git-rebase'.
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/Makefile b/Makefile
index b4d9cb4..195f984 100644
--- a/Makefile
+++ b/Makefile
@@ -1279,6 +1279,8 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+diff.h: xdiff/xdiff.h
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..b385e35 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -784,6 +784,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
+	DIFF_OPT_SET(&rev.diffopt, MACHINE_FRIENDLY);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
 
diff --git a/diff.c b/diff.c
index 82cff97..a8c103f 100644
--- a/diff.c
+++ b/diff.c
@@ -24,6 +24,8 @@ static int diff_rename_limit_default = 200;
 static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
+static const char     *diff_primer;
+static struct diff_options *primer;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 
@@ -102,6 +104,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		diff_rename_limit_default = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.primer"))
+		return git_config_string(& diff_primer, var, value);
 
 	switch (userdiff_config(var, value)) {
 		case 0: break;
@@ -2215,6 +2219,46 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
+static const char blank[] = " \t\r\n";
+
+void set_diff_primer(struct diff_options *options)
+{
+	char  *str1, *token, *saveptr;
+	int    len;
+
+	if((DIFF_OPT_TST(options, SUPPRESS_PRIMER)) ||
+	   (!              diff_primer            ) ||
+	   ((len = (strlen(diff_primer)+1)) < 3   )){ return; }
+
+	token = str1 = strncpy( (char*) malloc(len), diff_primer, len );
+	if( (           saveptr = strpbrk( token += strspn( token, blank ), blank )) ){ *(saveptr++) = '\0'; }
+	while( token ){
+	  if( *token == '-'      ){
+	    diff_opt_parse( options, (const char **) &token, -1 );
+	  }
+	  if( (token  = saveptr) ){
+	    if( (       saveptr = strpbrk( token += strspn( token, blank ), blank )) ){ *(saveptr++) = '\0'; }
+	  }
+	}
+
+	free( str1 );
+}
+
+struct diff_options* flatten_diff_options( struct diff_options *master, struct diff_options *slave )
+{
+	unsigned   x0 = master->flags   , x1 = master->mask    , x2 = slave->flags   , x3 = slave->mask;
+	long       w  = master->xdl_opts, x  = master->xdl_mask, y  = slave->xdl_opts, z  = slave->xdl_mask;
+
+	//minimized by Quine-McClusk
+	master->flags    = (~x1&x2&x3)|(x0&~x3)|(x0&x1);
+	master->mask     = x1 | x3;
+
+	master->xdl_opts = (~x &y &z )|(w &~z )|(w &x );
+	master->xdl_mask = x  | z ;
+
+	return master;
+}
+
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
@@ -2225,15 +2269,16 @@ void diff_setup(struct diff_options *options)
 	options->break_opt = -1;
 	options->rename_limit = -1;
 	options->dirstat_percent = 3;
-	DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
+	if( DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE))
+	    DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
 	options->context = 3;
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
 	if (diff_use_color_default > 0)
-		DIFF_OPT_SET(options, COLOR_DIFF);
-	else
-		DIFF_OPT_CLR(options, COLOR_DIFF);
+		 DIFF_OPT_SET(options, COLOR_DIFF);
+	else if( DIFF_OPT_TST(options, COLOR_DIFF))
+		 DIFF_OPT_CLR(options, COLOR_DIFF);
 	options->detect_rename = diff_detect_rename_default;
 
 	if (!diff_mnemonic_prefix) {
@@ -2322,6 +2367,18 @@ int diff_setup_done(struct diff_options *options)
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
 
+	if( ! DIFF_OPT_TST(      options, SUPPRESS_PRIMER ) ){
+	  if( !                           primer ){
+	    diff_setup(                   primer = (struct diff_options *) malloc( sizeof(struct diff_options) ) );
+	    set_diff_primer(              primer );
+	  }
+	  flatten_diff_options(  options, primer );
+	}
+
+	if(   DIFF_OPT_TST(      options, MACHINE_FRIENDLY ) ){
+	  DIFF_MACHINE_FRIENDLY( options );
+	}
+
 	return 0;
 }
 
@@ -2469,13 +2526,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 
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
@@ -2496,8 +2553,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--no-color"))
 		DIFF_OPT_CLR(options, COLOR_DIFF);
-	else if (!strcmp(arg, "--color-words"))
-		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+	else if (!strcmp(arg, "--color-words")){
+		DIFF_OPT_SET(options, COLOR_DIFF);
+		DIFF_OPT_SET(options, COLOR_DIFF_WORDS);
+	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
@@ -2512,6 +2571,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules"))
 		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
+	else if (!strcmp(arg, "--no-primer"))
+		DIFF_OPT_SET(options, SUPPRESS_PRIMER);
+	else if (!strcmp(arg, "--machine-friendly"))
+		DIFF_OPT_SET(options, MACHINE_FRIENDLY);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index 4d5a327..e98c23a 100644
--- a/diff.h
+++ b/diff.h
@@ -5,6 +5,7 @@
 #define DIFF_H
 
 #include "tree-walk.h"
+#include "xdiff/xdiff.h"
 
 struct rev_info;
 struct diff_options;
@@ -66,9 +67,15 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
-#define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
-#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
-#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
+#define DIFF_OPT_SUPPRESS_PRIMER     (1 << 22)
+#define DIFF_OPT_MACHINE_FRIENDLY    (1 << 23)
+#define DIFF_OPT_TST(opts, flag)    ((opts)->flags &   DIFF_OPT_##flag)
+#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |=  DIFF_OPT_##flag), ((opts)->mask |= DIFF_OPT_##flag)
+#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag), ((opts)->mask |= DIFF_OPT_##flag)
+#define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts &   XDF_##flag)
+#define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |=  XDF_##flag), ((opts)->xdl_mask |= XDF_##flag)
+#define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag), ((opts)->xdl_mask |= XDF_##flag)
+#define DIFF_MACHINE_FRIENDLY(opts) ((opts)->flags &= ~(DIFF_OPT_COLOR_DIFF)), ((opts)->xdl_opts &= ~(XDF_WHITESPACE_FLAGS))
 
 struct diff_options {
 	const char *filter;
@@ -77,6 +84,7 @@ struct diff_options {
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
+	unsigned  mask;
 	int context;
 	int interhunkcontext;
 	int break_opt;
@@ -95,6 +103,7 @@ struct diff_options {
 	int prefix_length;
 	const char *stat_sep;
 	long xdl_opts;
+	long xdl_mask;
 
 	int stat_width;
 	int stat_name_width;
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index bbbf15c..94faf95 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -276,6 +276,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	lappend cmd -p
+	lappend cmd --exit-code
 	lappend cmd --no-color
 	if {$repo_config(gui.diffcontext) >= 1} {
 		lappend cmd "-U$repo_config(gui.diffcontext)"
@@ -310,6 +311,7 @@ proc read_diff {fd cont_info} {
 	global ui_diff diff_active
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
+	global errorCode
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
@@ -397,7 +399,9 @@ proc read_diff {fd cont_info} {
 	$ui_diff conf -state disabled
 
 	if {[eof $fd]} {
-		close $fd
+		fconfigure $fd -blocking 1
+		catch { close $fd } err
+		set diff_exit_status $errorCode
 
 		if {$current_diff_queue ne {}} {
 			advance_diff_queue $cont_info
@@ -413,7 +417,7 @@ proc read_diff {fd cont_info} {
 		}
 		ui_ready
 
-		if {[$ui_diff index end] eq {2.0}} {
+		if {$diff_exit_status eq "NONE"} {
 			handle_empty_diff
 		}
 		set callback [lindex $cont_info 1]
diff --git a/gitk-git/gitk b/gitk-git/gitk
index dc2a439..49e5cb7 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4259,7 +4259,7 @@ proc do_file_hl {serial} {
 	# must be "containing:", i.e. we're searching commit info
 	return
     }
-    set cmd [concat | git diff-tree -r -s --stdin $gdtargs]
+    set cmd [concat | git diff-tree --no-color -r -s --stdin $gdtargs]
     set filehighlight [open $cmd r+]
     fconfigure $filehighlight -blocking 0
     filerun $filehighlight readfhighlight
@@ -4753,7 +4753,7 @@ proc dodiffindex {} {
 
     if {!$showlocalchanges || !$isworktree} return
     incr lserial
-    set cmd "|git diff-index --cached HEAD"
+    set cmd "|git diff-index --no-color --cached HEAD"
     if {$vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -4782,7 +4782,7 @@ proc readdiffindex {fd serial inst} {
     }
 
     # now see if there are any local changes not checked in to the index
-    set cmd "|git diff-files"
+    set cmd "|git diff-files --no-color"
     if {$vfilelimit($curview) ne {}} {
 	set cmd [concat $cmd -- $vfilelimit($curview)]
     }
@@ -7068,7 +7068,7 @@ proc diffcmd {ids flags} {
     if {$i >= 0} {
 	if {[llength $ids] > 1 && $j < 0} {
 	    # comparing working directory with some specific revision
-	    set cmd [concat | git diff-index $flags]
+	    set cmd [concat | git diff-index --no-color $flags]
 	    if {$i == 0} {
 		lappend cmd -R [lindex $ids 1]
 	    } else {
@@ -7076,13 +7076,13 @@ proc diffcmd {ids flags} {
 	    }
 	} else {
 	    # comparing working directory with index
-	    set cmd [concat | git diff-files $flags]
+	    set cmd [concat | git diff-files --no-color $flags]
 	    if {$j == 1} {
 		lappend cmd -R
 	    }
 	}
     } elseif {$j >= 0} {
-	set cmd [concat | git diff-index --cached $flags]
+	set cmd [concat | git diff-index --no-color --cached $flags]
 	if {[llength $ids] > 1} {
 	    # comparing index with specific revision
 	    if {$i == 0} {
@@ -7095,7 +7095,7 @@ proc diffcmd {ids flags} {
 	    lappend cmd HEAD
 	}
     } else {
-	set cmd [concat | git diff-tree -r $flags $ids]
+	set cmd [concat | git diff-tree --no-color -r $flags $ids]
     }
     return $cmd
 }
@@ -10657,7 +10657,7 @@ if {[catch {package require Tk 8.4} err]} {
 }
 
 # defaults...
-set wrcomcmd "git diff-tree --stdin -p --pretty"
+set wrcomcmd "git diff-tree --no-color --stdin -p --pretty"
 
 set gitencoding {}
 catch {
-- 
1.6.1
