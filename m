From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/2] Add builtin "git rm" command
Date: Fri, 19 May 2006 16:19:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605191607580.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605191607010.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat May 20 01:19:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhEG0-000106-79
	for gcvg-git@gmane.org; Sat, 20 May 2006 01:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWESXTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 19:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWESXTl
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 19:19:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964785AbWESXTl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 19:19:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4JNJZtH026966
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 May 2006 16:19:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4JNJY0J009347;
	Fri, 19 May 2006 16:19:35 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605191607010.10823@g5.osdl.org>
X-Spam-Status: No, hits=-5.776 required=5 tests=PATCH_UNIFIED_DIFF_OSDL,REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20365>


This changes semantics very subtly, because it adds a new atomicity 
guarantee.

In particular, if you "git rm" several files, it will now do all or 
nothing. The old shell-script really looped over the removed files one by 
one, and would basically randomly fail in the middle if "-f" was used and 
one of the files didn't exist in the working directory.

This C builtin one will not re-write the index after each remove, but 
instead remove all files at once. However, that means that if "-f" is used 
(to also force removal of the file from the working directory), and some 
files have already been removed from the workspace, it won't stop in the 
middle in some half-way state like the old one did.

So what happens is that if the _first_ file fails to be removed with "-f", 
we abort the whole "git rm". But once we've started removing, we don't 
leave anything half done. If some of the other files don't exist, we'll 
just ignore errors of removal from the working tree.

This is only an issue with "-f", of course.

I think the new behaviour is strictly an improvement, but perhaps more 
importantly, it is _different_. As a special case, the semantics are 
identical for the single-file case (which is the only one our test-suite 
seems to test).

The other question is what to do with leading directories. The old "git 
rm" script didn't do anything, which is somewhat inconsistent. This one 
will actually clean up directories that have become empty as a result of 
removing the last file, but maybe we want to have a flag to decide the 
behaviour?

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/Makefile b/Makefile
index 5373986..06b31d8 100644
--- a/Makefile
+++ b/Makefile
@@ -120,7 +120,7 @@ SCRIPT_SH = \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-prune.sh git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
-	git-resolve.sh git-revert.sh git-rm.sh git-sh-setup.sh \
+	git-resolve.sh git-revert.sh git-sh-setup.sh \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
@@ -170,7 +170,8 @@ PROGRAMS = \
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
-	git-grep$X git-add$X git-rev-list$X git-check-ref-format$X
+	git-grep$X git-add$X git-rm$X git-rev-list$X \
+	git-check-ref-format$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -218,7 +219,8 @@ LIB_OBJS = \
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
-	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-format.o
+	builtin-grep.o builtin-add.o builtin-rev-list.o builtin-check-ref-format.o \
+	builtin-rm.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-rm.c b/builtin-rm.c
new file mode 100644
index 0000000..67e0f79
--- /dev/null
+++ b/builtin-rm.c
@@ -0,0 +1,150 @@
+/*
+ * "git rm" builtin command
+ *
+ * Copyright (C) Linus Torvalds 2006
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "dir.h"
+
+static const char builtin_rm_usage[] =
+"git-rm [-n] [-v] [-f] <filepattern>...";
+
+static struct {
+	int nr, alloc;
+	const char **name;
+} list;
+
+static void add_list(const char *name)
+{
+	if (list.nr >= list.alloc) {
+		list.alloc = alloc_nr(list.alloc);
+		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
+	}
+	list.name[list.nr++] = name;
+}
+
+static int remove_file(const char *name)
+{
+	int ret;
+	char *slash;
+
+	ret = unlink(name);
+	if (!ret && (slash = strrchr(name, '/'))) {
+		char *n = strdup(name);
+		do {
+			n[slash - name] = 0;
+			name = n;
+		} while (!rmdir(name) && (slash = strrchr(name, '/')));
+	}
+	return ret;
+}
+
+static struct cache_file cache_file;
+
+int cmd_rm(int argc, const char **argv, char **envp)
+{
+	int i, newfd;
+	int verbose = 0, show_only = 0, force = 0;
+	const char *prefix = setup_git_directory();
+	const char **pathspec;
+	char *seen;
+
+	git_config(git_default_config);
+
+	newfd = hold_index_file_for_update(&cache_file, get_index_file());
+	if (newfd < 0)
+		die("unable to create new index file");
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	for (i = 1 ; i < argc ; i++) {
+		const char *arg = argv[i];
+
+		if (*arg != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "-n")) {
+			show_only = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-v")) {
+			verbose = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-f")) {
+			force = 1;
+			continue;
+		}
+		die(builtin_rm_usage);
+	}
+	pathspec = get_pathspec(prefix, argv + i);
+
+	seen = NULL;
+	if (pathspec) {
+		for (i = 0; pathspec[i] ; i++)
+			/* nothing */;
+		seen = xmalloc(i);
+		memset(seen, 0, i);
+	}
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
+			continue;
+		add_list(ce->name);
+	}
+
+	if (pathspec) {
+		const char *match;
+		for (i = 0; (match = pathspec[i]) != NULL ; i++) {
+			if (*match && !seen[i])
+				die("pathspec '%s' did not match any files", match);
+		}
+	}
+
+	/*
+	 * First remove the names from the index: we won't commit
+	 * the index unless all of them succeed
+	 */
+	for (i = 0; i < list.nr; i++) {
+		const char *path = list.name[i];
+		printf("rm '%s'\n", path);
+
+		if (remove_file_from_cache(path))
+			die("git rm: unable to remove %s", path);
+	}
+
+	/*
+	 * Then, if we used "-f", remove the filenames from the
+	 * workspace. If we fail to remove the first one, we
+	 * abort the "git rm" (but once we've successfully removed
+	 * any file at all, we'll go ahead and commit to it all:
+	 * by then we've already committed ourself and can't fail
+	 * in the middle)
+	 */
+	if (force) {
+		int removed = 0;
+		for (i = 0; i < list.nr; i++) {  
+			const char *path = list.name[i];
+			if (!remove_file(path)) {
+				removed = 1;
+				continue;
+			}
+			if (!removed)
+				die("git rm: %s: %s", path, strerror(errno));
+		}
+	}
+
+	if (active_cache_changed) {
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    commit_index_file(&cache_file))
+			die("Unable to write new index file");
+	}
+	
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 78275ea..d150c7c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -25,6 +25,7 @@ extern int cmd_count_objects(int argc, c
 
 extern int cmd_push(int argc, const char **argv, char **envp);
 extern int cmd_grep(int argc, const char **argv, char **envp);
+extern int cmd_rm(int argc, const char **argv, char **envp);
 extern int cmd_add(int argc, const char **argv, char **envp);
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
diff --git a/git-rm.sh b/git-rm.sh
deleted file mode 100755
index fda4541..0000000
--- a/git-rm.sh
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/bin/sh
-
-USAGE='[-f] [-n] [-v] [--] <file>...'
-SUBDIRECTORY_OK='Yes'
-. git-sh-setup
-
-remove_files=
-show_only=
-verbose=
-while : ; do
-  case "$1" in
-    -f)
-	remove_files=true
-	;;
-    -n)
-	show_only=true
-	;;
-    -v)
-	verbose=--verbose
-	;;
-    --)
-	shift; break
-	;;
-    -*)
-	usage
-	;;
-    *)
-	break
-	;;
-  esac
-  shift
-done
-
-# This is typo-proofing. If some paths match and some do not, we want
-# to do nothing.
-case "$#" in
-0)	;;
-*)
-	git-ls-files --error-unmatch -- "$@" >/dev/null || {
-		echo >&2 "Maybe you misspelled it?"
-		exit 1
-	}
-	;;
-esac
-
-if test -f "$GIT_DIR/info/exclude"
-then
-	git-ls-files -z \
-	--exclude-from="$GIT_DIR/info/exclude" \
-	--exclude-per-directory=.gitignore -- "$@"
-else
-	git-ls-files -z \
-	--exclude-per-directory=.gitignore -- "$@"
-fi |
-case "$show_only,$remove_files" in
-true,*)
-	xargs -0 echo
-	;;
-*,true)
-	xargs -0 sh -c "
-		while [ \$# -gt 0 ]; do
-			file=\$1; shift
-			rm -- \"\$file\" && git-update-index --remove $verbose \"\$file\"
-		done
-	" inline
-	;;
-*)
-	git-update-index --force-remove $verbose -z --stdin
-	;;
-esac
diff --git a/git.c b/git.c
index 7db5cc1..63aa311 100644
--- a/git.c
+++ b/git.c
@@ -51,6 +51,7 @@ static void handle_internal_command(int 
 		{ "count-objects", cmd_count_objects },
 		{ "diff", cmd_diff },
 		{ "grep", cmd_grep },
+		{ "rm", cmd_rm },
 		{ "add", cmd_add },
 		{ "rev-list", cmd_rev_list },
 		{ "check-ref-format", cmd_check_ref_format }
