From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make git-mv a builtin
Date: Wed, 26 Jul 2006 03:52:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607260348130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 03:53:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Ya3-0006Mu-OY
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 03:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWGZBwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 21:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWGZBwk
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 21:52:40 -0400
Received: from mail.gmx.net ([213.165.64.21]:59060 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030351AbWGZBwj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 21:52:39 -0400
Received: (qmail invoked by alias); 26 Jul 2006 01:52:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 26 Jul 2006 03:52:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24196>


This also moves add_file_to_index() to read-cache.c. Oh, and while
touching builtin-add.c, it also removes a duplicate git_config() call.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	There is no test for it, and I am quite certain the old script
	doesn't do it either: git-mv some_tracked_dir/ there/ will
	not work. t7001-mv passes, though.

	I cannot test, because the script still fails to work here.

 Makefile      |    7 +-
 builtin-add.c |   40 ---------
 builtin-mv.c  |  221 +++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h     |    1 
 cache.h       |    1 
 git-mv.perl   |  246 ---------------------------------------------------------
 git.c         |    1 
 read-cache.c  |   39 +++++++++
 8 files changed, 267 insertions(+), 289 deletions(-)

diff --git a/Makefile b/Makefile
index 1069810..baed711 100644
--- a/Makefile
+++ b/Makefile
@@ -165,7 +165,7 @@ SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-shortlog.perl git-rerere.perl \
 	git-annotate.perl git-cvsserver.perl \
-	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl \
+	git-svnimport.perl git-cvsexportcommit.perl \
 	git-send-email.perl git-svn.perl
 
 SCRIPT_PYTHON = \
@@ -207,7 +207,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-read-tree$X git-commit-tree$X git-write-tree$X \
 	git-apply$X git-show-branch$X git-diff-files$X git-update-index$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
-	git-fmt-merge-msg$X git-prune$X
+	git-fmt-merge-msg$X git-prune$X git-mv$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -263,7 +263,8 @@ BUILTIN_OBJS = \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
-	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o
+	builtin-update-ref.o builtin-fmt-merge-msg.o builtin-prune.o \
+	builtin-mv.o path-list.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS = -lz
diff --git a/builtin-add.c b/builtin-add.c
index 2d25698..111d8f5 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -83,45 +83,6 @@ static void fill_directory(struct dir_st
 		prune_directory(dir, pathspec, baselen);
 }
 
-static int add_file_to_index(const char *path, int verbose)
-{
-	int size, namelen;
-	struct stat st;
-	struct cache_entry *ce;
-
-	if (lstat(path, &st))
-		die("%s: unable to stat (%s)", path, strerror(errno));
-
-	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode))
-		die("%s: can only add regular files or symbolic links", path);
-
-	namelen = strlen(path);
-	size = cache_entry_size(namelen);
-	ce = xcalloc(1, size);
-	memcpy(ce->name, path, namelen);
-	ce->ce_flags = htons(namelen);
-	fill_stat_cache_info(ce, &st);
-
-	ce->ce_mode = create_ce_mode(st.st_mode);
-	if (!trust_executable_bit) {
-		/* If there is an existing entry, pick the mode bits
-		 * from it.
-		 */
-		int pos = cache_name_pos(path, namelen);
-		if (pos >= 0)
-			ce->ce_mode = active_cache[pos]->ce_mode;
-	}
-
-	if (index_path(ce->sha1, path, &st, 1))
-		die("unable to index file %s", path);
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD))
-		die("unable to add %s to index",path);
-	if (verbose)
-		printf("add '%s'\n", path);
-	cache_tree_invalidate_path(active_cache_tree, path);
-	return 0;
-}
-
 static struct lock_file lock_file;
 
 int cmd_add(int argc, const char **argv, char **envp)
@@ -160,7 +121,6 @@ int cmd_add(int argc, const char **argv,
 		}
 		die(builtin_add_usage);
 	}
-	git_config(git_default_config);
 	pathspec = get_pathspec(prefix, argv + i);
 
 	fill_directory(&dir, pathspec);
diff --git a/builtin-mv.c b/builtin-mv.c
new file mode 100644
index 0000000..973bb29
--- /dev/null
+++ b/builtin-mv.c
@@ -0,0 +1,221 @@
+/*
+ * "git mv" builtin command
+ *
+ * Copyright (C) 2006 Johannes Schindelin
+ */
+#include <fnmatch.h>
+
+#include "cache.h"
+#include "builtin.h"
+#include "dir.h"
+#include "cache-tree.h"
+#include "path-list.h"
+
+static const char builtin_mv_usage[] =
+"git-mv [-n] [-f] { <source> <destination> | [-k] <source>... <destination> }";
+
+static const char **copy_pathspec(const char *prefix, const char **pathspec,
+		int count, int base_name)
+{
+	const char **result = xmalloc((count + 1) * sizeof(const char *));
+	memcpy(result, pathspec, count * sizeof(const char *));
+	result[count] = NULL;
+	if (base_name) {
+		int i;
+		for (i = 0; i < count; i++) {
+			const char *last_slash = strrchr(result[i], '/');
+			if (last_slash)
+				result[i] = last_slash + 1;
+		}
+	}
+	return get_pathspec(prefix, result);
+}
+
+static void show_list(const char *label, struct path_list *list)
+{
+	if (list->nr > 0) {
+		int i;
+		printf("%s", label);
+		for (i = 0; i < list->nr; i++)
+			printf("%s%s", i > 0 ? ", " : "", list->items[i].path);
+		putchar('\n');
+	}
+}
+
+static struct lock_file lock_file;
+
+int cmd_mv(int argc, const char **argv, char **envp)
+{
+	int i, newfd, count;
+	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
+	const char *prefix = setup_git_directory();
+	const char **source, **destination, **dest_path;
+	struct stat st;
+	struct path_list overwritten = {NULL, 0, 0, 0};
+	struct path_list src_for_dst = {NULL, 0, 0, 0};
+	struct path_list added = {NULL, 0, 0, 0};
+	struct path_list deleted = {NULL, 0, 0, 0};
+	struct path_list changed = {NULL, 0, 0, 0};
+
+	git_config(git_default_config);
+
+	newfd = hold_lock_file_for_update(&lock_file, get_index_file());
+	if (newfd < 0)
+		die("unable to create new index file");
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (arg[0] != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "-n")) {
+			show_only = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-f")) {
+			force = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-k")) {
+			ignore_errors = 1;
+			continue;
+		}
+		die(builtin_mv_usage);
+	}
+	count = argc - i - 1;
+	if (count < 1)
+		usage(builtin_mv_usage);
+
+	source = copy_pathspec(prefix, argv + i, count, 0);
+	dest_path = copy_pathspec(prefix, argv + argc - 1, 1, 0);
+
+	if (lstat(dest_path[0], &st) == 0 &&
+			S_ISDIR(st.st_mode))
+		destination = copy_pathspec(dest_path[0], argv + i, count, 1);
+	else {
+		if (count != 1)
+			usage(builtin_mv_usage);
+		destination = dest_path;
+	}
+
+	/* Checking */
+	for (i = 0; i < count; i++) {
+		const char *bad = NULL;
+
+		if (show_only)
+			printf("Checking rename of '%s' to '%s'\n",
+				source[i], destination[i]);
+
+		if (lstat(source[i], &st) < 0)
+			bad = "bad source";
+		else if (lstat(destination[i], &st) == 0) {
+			bad = "destination exists";
+			if (force) {
+				/*
+				 * only files can overwrite each other:
+				 * check both source and destination
+				 */
+				if (S_ISREG(st.st_mode)) {
+					fprintf(stderr, "Warning: %s;"
+							" will overwrite!\n",
+							bad);
+					bad = NULL;
+					path_list_insert(destination[i],
+							&overwritten);
+				} else
+					bad = "Cannot overwrite";
+			}
+		}
+
+		if (!bad && !strncmp(destination[i], source[i],
+					strlen(source[i])))
+			bad = "can not move directory into itself";
+
+		if (!bad && cache_name_pos(source[i], strlen(source[i])) < 0)
+			bad = "not under version control";
+
+		if (!bad) {
+			if (path_list_has_path(&src_for_dst, destination[i]))
+				bad = "multiple sources for the same target";
+			else
+				path_list_insert(destination[i], &src_for_dst);
+		}
+
+		if (bad) {
+			if (ignore_errors) {
+				if (--count > 0) {
+					memmove(source + i, source + i + 1,
+						(count - i) * sizeof(char *));
+					memmove(destination + i,
+							destination + i + 1,
+							(count - i) * sizeof(char *));
+				}
+			} else
+				die ("Error: %s, source=%s, destination=%s",
+						bad, source[i], destination[i]);
+		}
+	}
+
+	for (i = 0; i < count; i++) {
+		if (show_only || verbose)
+			printf("Renaming %s to %s\n",
+					source[i], destination[i]);
+		if (!show_only && rename(source[i], destination[i]) < 0
+				&& !ignore_errors)
+			die ("renaming %s failed: %s",
+					source[i], strerror(errno));
+
+		if (cache_name_pos(source[i], strlen(source[i])) >= 0) {
+			path_list_insert(source[i], &deleted);
+
+			/* destination can be a directory with 1 file inside */
+			if (path_list_has_path(&overwritten, destination[i]))
+				path_list_insert(destination[i], &changed);
+			else
+				path_list_insert(destination[i], &added);
+		} else
+			path_list_insert(destination[i], &added);
+	}
+
+        if (show_only) {
+		show_list("Changed  : ", &changed);
+		show_list("Adding   : ", &added);
+		show_list("Deleting : ", &deleted);
+	} else {
+		for (i = 0; i < changed.nr; i++) {
+			const char *path = changed.items[i].path;
+			int i = cache_name_pos(path, strlen(path));
+			struct cache_entry *ce = active_cache[i];
+
+			if (i < 0)
+				die ("Huh? Cache entry for %s unknown?", path);
+			refresh_cache_entry(ce, 0);
+		}
+
+		for (i = 0; i < added.nr; i++) {
+			const char *path = added.items[i].path;
+			add_file_to_index(path, verbose);
+		}
+
+		for (i = 0; i < deleted.nr; i++) {
+			const char *path = deleted.items[i].path;
+			remove_file_from_cache(path);
+		}
+
+		if (active_cache_changed) {
+			if (write_cache(newfd, active_cache, active_nr) ||
+					close(newfd) ||
+					commit_lock_file(&lock_file))
+				die("Unable to write new index file");
+		}
+	}
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 5339d86..6f3a439 100755
--- a/builtin.h
+++ b/builtin.h
@@ -52,6 +52,7 @@ extern int cmd_rev_parse(int argc, const
 extern int cmd_update_index(int argc, const char **argv, char **envp);
 extern int cmd_update_ref(int argc, const char **argv, char **envp);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, char **envp);
+extern int cmd_mv(int argc, const char **argv, char **envp);
 
 extern int cmd_write_tree(int argc, const char **argv, char **envp);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
diff --git a/cache.h b/cache.h
index 457d1d0..3288b11 100644
--- a/cache.h
+++ b/cache.h
@@ -158,6 +158,7 @@ extern int add_cache_entry(struct cache_
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_cache_entry_at(int pos);
 extern int remove_file_from_cache(const char *path);
+extern int add_file_to_index(const char *path, int verbose);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int ce_match_stat(struct cache_entry *ce, struct stat *st, int);
 extern int ce_modified(struct cache_entry *ce, struct stat *st, int);
diff --git a/git-mv.perl b/git-mv.perl
deleted file mode 100755
index 322b9fd..0000000
--- a/git-mv.perl
+++ /dev/null
@@ -1,246 +0,0 @@
-#!/usr/bin/perl
-#
-# Copyright 2005, Ryan Anderson <ryan@michonline.com>
-#                 Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
-#
-# This file is licensed under the GPL v2, or a later version
-# at the discretion of Linus Torvalds.
-
-use warnings;
-use strict;
-use Getopt::Std;
-use Git;
-
-sub usage() {
-	print <<EOT;
-$0 [-f] [-n] <source> <destination>
-$0 [-f] [-n] [-k] <source> ... <destination directory>
-EOT
-	exit(1);
-}
-
-our ($opt_n, $opt_f, $opt_h, $opt_k, $opt_v);
-getopts("hnfkv") || usage;
-usage() if $opt_h;
-@ARGV >= 1 or usage;
-
-my $repo = Git->repository();
-
-my (@srcArgs, @dstArgs, @srcs, @dsts);
-my ($src, $dst, $base, $dstDir);
-
-# remove any trailing slash in arguments
-for (@ARGV) { s/\/*$//; }
-
-my $argCount = scalar @ARGV;
-if (-d $ARGV[$argCount-1]) {
-	$dstDir = $ARGV[$argCount-1];
-	@srcArgs = @ARGV[0..$argCount-2];
-
-	foreach $src (@srcArgs) {
-		$base = $src;
-		$base =~ s/^.*\///;
-		$dst = "$dstDir/". $base;
-		push @dstArgs, $dst;
-	}
-}
-else {
-    if ($argCount < 2) {
-	print "Error: need at least two arguments\n";
-	exit(1);
-    }
-    if ($argCount > 2) {
-	print "Error: moving to directory '"
-	    . $ARGV[$argCount-1]
-	    . "' not possible; not existing\n";
-	exit(1);
-    }
-    @srcArgs = ($ARGV[0]);
-    @dstArgs = ($ARGV[1]);
-    $dstDir = "";
-}
-
-my $subdir_prefix = $repo->wc_subdir();
-
-# run in git base directory, so that git-ls-files lists all revisioned files
-chdir $repo->wc_path();
-$repo->wc_chdir('');
-
-# normalize paths, needed to compare against versioned files and update-index
-# also, this is nicer to end-users by doing ".//a/./b/.//./c" ==> "a/b/c"
-for (@srcArgs, @dstArgs) {
-    # prepend git prefix as we run from base directory
-    $_ = $subdir_prefix.$_;
-    s|^\./||;
-    s|/\./|/| while (m|/\./|);
-    s|//+|/|g;
-    # Also "a/b/../c" ==> "a/c"
-    1 while (s,(^|/)[^/]+/\.\./,$1,);
-}
-
-my (@allfiles,@srcfiles,@dstfiles);
-my $safesrc;
-my (%overwritten, %srcForDst);
-
-{
-	local $/ = "\0";
-	@allfiles = $repo->command('ls-files', '-z');
-}
-
-
-my ($i, $bad);
-while(scalar @srcArgs > 0) {
-    $src = shift @srcArgs;
-    $dst = shift @dstArgs;
-    $bad = "";
-
-    for ($src, $dst) {
-	# Be nicer to end-users by doing ".//a/./b/.//./c" ==> "a/b/c"
-	s|^\./||;
-	s|/\./|/| while (m|/\./|);
-	s|//+|/|g;
-	# Also "a/b/../c" ==> "a/c"
-	1 while (s,(^|/)[^/]+/\.\./,$1,);
-    }
-
-    if ($opt_v) {
-	print "Checking rename of '$src' to '$dst'\n";
-    }
-
-    unless (-f $src || -l $src || -d $src) {
-	$bad = "bad source '$src'";
-    }
-
-    $safesrc = quotemeta($src);
-    @srcfiles = grep /^$safesrc(\/|$)/, @allfiles;
-
-    $overwritten{$dst} = 0;
-    if (($bad eq "") && -e $dst) {
-	$bad = "destination '$dst' already exists";
-	if ($opt_f) {
-	    # only files can overwrite each other: check both source and destination
-	    if (-f $dst && (scalar @srcfiles == 1)) {
-		print "Warning: $bad; will overwrite!\n";
-		$bad = "";
-		$overwritten{$dst} = 1;
-	    }
-	    else {
-		$bad = "Can not overwrite '$src' with '$dst'";
-	    }
-	}
-    }
-    
-    if (($bad eq "") && ($dst =~ /^$safesrc\//)) {
-	$bad = "can not move directory '$src' into itself";
-    }
-
-    if ($bad eq "") {
-        if (scalar @srcfiles == 0) {
-	    $bad = "'$src' not under version control";
-	}
-    }
-
-    if ($bad eq "") {
-       if (defined $srcForDst{$dst}) {
-           $bad = "can not move '$src' to '$dst'; already target of ";
-           $bad .= "'".$srcForDst{$dst}."'";
-       }
-       else {
-           $srcForDst{$dst} = $src;
-       }
-    }
-
-    if ($bad ne "") {
-	if ($opt_k) {
-	    print "Warning: $bad; skipping\n";
-	    next;
-	}
-	print "Error: $bad\n";
-	exit(1);
-    }
-    push @srcs, $src;
-    push @dsts, $dst;
-}
-
-# Final pass: rename/move
-my (@deletedfiles,@addedfiles,@changedfiles);
-$bad = "";
-while(scalar @srcs > 0) {
-    $src = shift @srcs;
-    $dst = shift @dsts;
-
-    if ($opt_n || $opt_v) { print "Renaming $src to $dst\n"; }
-    if (!$opt_n) {
-	if (!rename($src,$dst)) {
-	    $bad = "renaming '$src' failed: $!";
-	    if ($opt_k) {
-		print "Warning: skipped: $bad\n";
-		$bad = "";
-		next;
-	    }
-	    last;
-	}
-    }
-
-    $safesrc = quotemeta($src);
-    @srcfiles = grep /^$safesrc(\/|$)/, @allfiles;
-    @dstfiles = @srcfiles;
-    s/^$safesrc(\/|$)/$dst$1/ for @dstfiles;
-
-    push @deletedfiles, @srcfiles;
-    if (scalar @srcfiles == 1) {
-	# $dst can be a directory with 1 file inside
-	if ($overwritten{$dst} ==1) {
-	    push @changedfiles, $dstfiles[0];
-
-	} else {
-	    push @addedfiles, $dstfiles[0];
-	}
-    }
-    else {
-	push @addedfiles, @dstfiles;
-    }
-}
-
-if ($opt_n) {
-    if (@changedfiles) {
-	print "Changed  : ". join(", ", @changedfiles) ."\n";
-    }
-    if (@addedfiles) {
-	print "Adding   : ". join(", ", @addedfiles) ."\n";
-    }
-    if (@deletedfiles) {
-	print "Deleting : ". join(", ", @deletedfiles) ."\n";
-    }
-}
-else {
-    if (@changedfiles) {
-	my ($fd, $ctx) = $repo->command_input_pipe('update-index', '-z', '--stdin');
-	foreach my $fileName (@changedfiles) {
-		print $fd "$fileName\0";
-	}
-	git_cmd_try { $repo->command_close_pipe($fd, $ctx); }
-		'git-update-index failed to update changed files with code %d';
-    }
-    if (@addedfiles) {
-	my ($fd, $ctx) = $repo->command_input_pipe('update-index', '--add', '-z', '--stdin');
-	foreach my $fileName (@addedfiles) {
-		print $fd "$fileName\0";
-	}
-	git_cmd_try { $repo->command_close_pipe($fd, $ctx); }
-		'git-update-index failed to add new files with code %d';
-    }
-    if (@deletedfiles) {
-	my ($fd, $ctx) = $repo->command_input_pipe('update-index', '--remove', '-z', '--stdin');
-	foreach my $fileName (@deletedfiles) {
-		print $fd "$fileName\0";
-	}
-	git_cmd_try { $repo->command_close_pipe($fd, $ctx); }
-		'git-update-index failed to remove old files with code %d';
-    }
-}
-
-if ($bad ne "") {
-    print "Error: $bad\n";
-    exit(1);
-}
diff --git a/git.c b/git.c
index e4b2174..bd58885 100644
--- a/git.c
+++ b/git.c
@@ -261,6 +261,7 @@ static void handle_internal_command(int 
 		{ "update-ref", cmd_update_ref },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg },
 		{ "prune", cmd_prune },
+		{ "mv", cmd_mv },
 	};
 	int i;
 
diff --git a/read-cache.c b/read-cache.c
index 9c0a9fc..c375e91 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -319,6 +319,45 @@ int remove_file_from_cache(const char *p
 	return 0;
 }
 
+int add_file_to_index(const char *path, int verbose)
+{
+	int size, namelen;
+	struct stat st;
+	struct cache_entry *ce;
+
+	if (lstat(path, &st))
+		die("%s: unable to stat (%s)", path, strerror(errno));
+
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode))
+		die("%s: can only add regular files or symbolic links", path);
+
+	namelen = strlen(path);
+	size = cache_entry_size(namelen);
+	ce = xcalloc(1, size);
+	memcpy(ce->name, path, namelen);
+	ce->ce_flags = htons(namelen);
+	fill_stat_cache_info(ce, &st);
+
+	ce->ce_mode = create_ce_mode(st.st_mode);
+	if (!trust_executable_bit) {
+		/* If there is an existing entry, pick the mode bits
+		 * from it.
+		 */
+		int pos = cache_name_pos(path, namelen);
+		if (pos >= 0)
+			ce->ce_mode = active_cache[pos]->ce_mode;
+	}
+
+	if (index_path(ce->sha1, path, &st, 1))
+		die("unable to index file %s", path);
+	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD))
+		die("unable to add %s to index",path);
+	if (verbose)
+		printf("add '%s'\n", path);
+	cache_tree_invalidate_path(active_cache_tree, path);
+	return 0;
+}
+
 int ce_same_name(struct cache_entry *a, struct cache_entry *b)
 {
 	int len = ce_namelen(a);
-- 
1.4.2.rc2.g39be8
