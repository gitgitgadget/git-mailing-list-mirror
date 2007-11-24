From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/3] Add "--patch" option to git-add--interactive
Date: Sat, 24 Nov 2007 13:55:22 +0100
Message-ID: <1195908922-88023-4-git-send-email-win@wincent.com>
References: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
 <1195908922-88023-1-git-send-email-win@wincent.com>
 <1195908922-88023-2-git-send-email-win@wincent.com>
 <1195908922-88023-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 13:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvuYe-0000yr-Nx
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 13:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbXKXMz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 07:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbXKXMz4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 07:55:56 -0500
Received: from wincent.com ([72.3.236.74]:34073 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbXKXMzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 07:55:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAOCtOor008418;
	Sat, 24 Nov 2007 06:55:33 -0600
X-Mailer: git-send-email 1.5.3.6.1994.g315c0c
In-Reply-To: <1195908922-88023-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65948>

When the "--patch" option is supplied, the patch_update_file function is
called, once for each supplied pathspec argument, and then we exit.

Seeing as builtin-add is the only caller of git-add--interactive we can
impose a strict requirement on the format of the arguments to avoid
possible ambiguity: an "--" argument must be used whenever any pathspecs
are passed, both with the "--patch" option and without it.

This commit adds an early return mechanism to the patch_update_pathspec
function to prevent spurious line feeds from being echoed when the user
passes in pathspecs which match unchanged files.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

I am sure that someone who actually knows Perl will be able to come up
with a more compact implementation of the process_args() function.
This works, but it's written by a Perl amateur.

 Documentation/git-add.txt |    9 ++++++++-
 builtin-add.c             |   17 ++++++++++-------
 git-add--interactive.perl |   35 ++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 63829d9..ce22de8 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -61,7 +61,14 @@ OPTIONS
 
 -i, \--interactive::
 	Add modified contents in the working tree interactively to
-	the index.
+	the index. Optional path arguments may be supplied to limit
+	operation to a subset of the working tree. See ``Interactive
+	mode'' for details.
+
+-p, \--patch:
+	Similar to Interactive mode but the initial command loop is
+	bypassed and the 'patch' subcommand is invoked using each of
+	the specified filepatterns before exiting.
 
 -u::
 	Update only files that git already knows about. This is similar
diff --git a/builtin-add.c b/builtin-add.c
index 06212c3..e69bc13 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -19,7 +19,7 @@ static const char * const builtin_add_usage[] = {
 	"git-add [options] [--] <filepattern>...",
 	NULL
 };
-
+static int patch_interactive = 0, add_interactive = 0;
 static int take_worktree_changes;
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
@@ -159,7 +159,7 @@ static int validate_pathspec(const char *prefix, const char **pattern)
 
 int interactive_add(const char *prefix, int argc, const char **argv)
 {
-	int i, status;
+	int i, status, pre_argc;
 	const char **args;
 	if (read_cache() < 0)
 		die("index file corrupt");
@@ -168,10 +168,13 @@ int interactive_add(const char *prefix, int argc, const char **argv)
 			return 1;
 	}
 
-	args = xmalloc(sizeof(const char *) * (argc + 2));
+	pre_argc = patch_interactive ? 3 : 2;
+	args = xmalloc(sizeof(const char *) * (argc + pre_argc + 1));
 	args[0] = "add--interactive";
-	memcpy((void *)args + sizeof(const char *), argv, sizeof(const char *) * argc);
-	args[argc + 1] = NULL;
+	args[1]	= patch_interactive ? "--patch" : "--";
+	args[2] = "--";
+	memcpy((void *)args + sizeof(const char *) * pre_argc, argv, sizeof(const char *) * argc);
+	args[argc + pre_argc] = NULL;
 
 	status = run_command_v_opt(args, RUN_GIT_CMD);
 	free(args);
@@ -184,13 +187,13 @@ static const char ignore_error[] =
 "The following paths are ignored by one of your .gitignore files:\n";
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int add_interactive = 0;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
 	OPT__VERBOSE(&verbose),
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
+	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
 	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
@@ -205,7 +208,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
-	if (add_interactive)
+	if (add_interactive || patch_interactive)
 		exit(interactive_add(prefix, argc, argv));
 
 	git_config(git_default_config);
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 381bcbe..7d62ceb 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,9 @@
 
 use strict;
 
+# command line options
+my $patch;
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -335,7 +338,8 @@ sub add_untracked_cmd {
 
 sub parse_diff {
 	my ($path) = @_;
-	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);
+	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path)
+	    or return undef;
 	my (@hunk) = { TEXT => [] };
 
 	for (@diff) {
@@ -571,6 +575,7 @@ sub patch_update_pathspec {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
+	return unless $head;
 	for (@{$head->{TEXT}}) {
 		print;
 	}
@@ -775,6 +780,20 @@ add untracked - add contents of untracked files to the staged set of changes
 EOF
 }
 
+sub process_args {
+	return unless @ARGV;
+	my $arg = shift @ARGV;
+	if ($arg eq "--patch") {
+		$patch = 1;
+		$arg = shift @ARGV or die "missing --";
+		die "invalid argument $arg, expecting --"
+		    unless $arg eq "--";
+	}
+	elsif ($arg ne "--") {
+		die "invalid argument $arg, expecting --";
+	}
+}
+
 sub main_loop {
 	my @cmd = ([ 'status', \&status_cmd, ],
 		   [ 'update', \&update_cmd, ],
@@ -803,6 +822,16 @@ sub main_loop {
 	}
 }
 
+process_args();
 refresh();
-status_cmd();
-main_loop();
+if ($patch) {
+	print "No filepattern specified: what did you want to patch?\n"
+	    unless @ARGV;
+	foreach my $pathspec (@ARGV) {
+		patch_update_pathspec($pathspec);
+	}
+}
+else {
+	status_cmd();
+	main_loop();
+}
-- 
1.5.3.6.1992.gd646-dirty
