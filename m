From: Linus Torvalds <torvalds@osdl.org>
Subject: Do "git add" as a builtin
Date: Wed, 17 May 2006 09:33:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 17 18:33:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgOxv-00016k-UY
	for gcvg-git@gmane.org; Wed, 17 May 2006 18:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWEQQdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 12:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWEQQdh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 12:33:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750789AbWEQQdg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 12:33:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HGXXtH030276
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 09:33:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HGXWot018774;
	Wed, 17 May 2006 09:33:32 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20212>


First try. Let's see how well this works.

In many ways, the hard parts of "git commit" are not so different from
this, and a builtin commit would share a lot of the code, I think.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

It passes the tests for me. I dropped the strange "--error-unmatch" test, 
because it was really ugly and I didn't see the point. It seems to do all 
the right things, but hey, a mistake here is obviously a bad thing.

I suspect that if I get around to "git commit", we'd be getting to the 
point where most of the core/easy/often-used/whatever commands would be 
all built-in.

diff --git a/Makefile b/Makefile
index f43ac63..e6f7794 100644
--- a/Makefile
+++ b/Makefile
@@ -218,7 +218,7 @@ LIB_OBJS = \
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
-	builtin-grep.o
+	builtin-grep.o builtin-add.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-add.c b/builtin-add.c
new file mode 100644
index 0000000..e815b3d
--- /dev/null
+++ b/builtin-add.c
@@ -0,0 +1,228 @@
+/*
+ * "git add" builtin command
+ *
+ * Copyright (C) 2006 Linus Torvalds
+ */
+#include <fnmatch.h>
+
+#include "cache.h"
+#include "builtin.h"
+#include "dir.h"
+
+static const char builtin_add_usage[] =
+"git-add [-n] [-v] <filepattern>...";
+
+static int common_prefix(const char **pathspec)
+{
+	const char *path, *slash, *next;
+	int prefix;
+
+	if (!pathspec)
+		return 0;
+
+	path = *pathspec;
+	slash = strrchr(path, '/');
+	if (!slash)
+		return 0;
+
+	prefix = slash - path + 1;
+	while ((next = *++pathspec) != NULL) {
+		int len = strlen(next);
+		if (len >= prefix && !memcmp(path, next, len))
+			continue;
+		for (;;) {
+			if (!len)
+				return 0;
+			if (next[--len] != '/') 
+				continue;
+			if (memcmp(path, next, len+1))
+				continue;
+			prefix = len + 1;
+			break;
+		}
+	}
+	return prefix;
+}
+
+static int match(const char **pathspec, const char *name, int namelen, int prefix)
+{
+	const char *match;
+
+	name += prefix;
+	namelen -= prefix;
+
+	while ((match = *pathspec++) != NULL) {
+		int matchlen;
+
+		match += prefix;
+		matchlen = strlen(match);
+		if (!matchlen)
+			return 1;
+		if (!strncmp(match, name, matchlen)) {
+			if (match[matchlen-1] == '/')
+				return 1;
+			switch (name[matchlen]) {
+			case '/': case '\0':
+				return 1;
+			}
+		}
+		if (!fnmatch(match, name, 0))
+			return 1;
+	}
+	return 0;
+}
+
+static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
+{
+	int i;
+	struct dir_entry **src, **dst;
+
+	src = dst = dir->entries;
+	i = dir->nr;
+	while (--i >= 0) {
+		struct dir_entry *entry = *src++;
+		if (!match(pathspec, entry->name, entry->len, prefix)) {
+			free(entry);
+			continue;
+		}
+		*dst++ = entry;
+	}
+	dir->nr = dst - dir->entries;
+}
+
+static void fill_directory(struct dir_struct *dir, const char **pathspec)
+{
+	const char *path, *base;
+	int baselen;
+
+	/* Set up the default git porcelain excludes */
+	memset(dir, 0, sizeof(*dir));
+	dir->exclude_per_dir = ".gitignore";
+	path = git_path("info/exclude");
+	if (!access(path, R_OK))
+		add_excludes_from_file(dir, path);
+
+	/*
+	 * Calculate common prefix for the pathspec, and
+	 * use that to optimize the directory walk
+	 */
+	baselen = common_prefix(pathspec);
+	path = ".";
+	base = "";
+	if (baselen) {
+		char *common = xmalloc(baselen + 1);
+		common = xmalloc(baselen + 1);
+		memcpy(common, *pathspec, baselen);
+		common[baselen] = 0;
+		path = base = common;
+	}
+
+	/* Read the directory and prune it */
+	read_directory(dir, path, base, baselen);
+	if (pathspec)
+		prune_directory(dir, pathspec, baselen);
+}
+
+static int add_file_to_index(const char *path, int verbose)
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
+	return 0;
+}
+
+static struct cache_file cache_file;
+
+int cmd_add(int argc, const char **argv, char **envp)
+{
+	int i, newfd;
+	int verbose = 0, show_only = 0;
+	const char *prefix = setup_git_directory();
+	const char **pathspec;
+	struct dir_struct dir;
+
+	git_config(git_default_config);
+
+	newfd = hold_index_file_for_update(&cache_file, get_index_file());
+	if (newfd < 0)
+		die("unable to create new cachefile");
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
+		if (!strcmp(arg, "-v")) {
+			verbose = 1;
+			continue;
+		}
+		die(builtin_add_usage);
+	}
+	git_config(git_default_config);
+	pathspec = get_pathspec(prefix, argv + i);
+
+	fill_directory(&dir, pathspec);
+
+	if (show_only) {
+		const char *sep = "", *eof = "";
+		for (i = 0; i < dir.nr; i++) {
+			printf("%s%s", sep, dir.entries[i]->name);
+			sep = " ";
+			eof = "\n";
+		}
+		fputs(eof, stdout);
+		return 0;
+	}
+
+	for (i = 0; i < dir.nr; i++)
+		add_file_to_index(dir.entries[i]->name, verbose);
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
index 7744f7d..1b77f4b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -24,5 +24,6 @@ extern int cmd_count_objects(int argc, c
 
 extern int cmd_push(int argc, const char **argv, char **envp);
 extern int cmd_grep(int argc, const char **argv, char **envp);
+extern int cmd_add(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index a94d9ee..fac46af 100644
--- a/git.c
+++ b/git.c
@@ -50,6 +50,7 @@ static void handle_internal_command(int 
 		{ "count-objects", cmd_count_objects },
 		{ "diff", cmd_diff },
 		{ "grep", cmd_grep },
+		{ "add", cmd_add },
 	};
 	int i;
 
