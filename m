From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC PATCH] Add support for figuring out where in the git archive
 we are
Date: Tue, 16 Aug 2005 18:06:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508161803250.3553@g5.osdl.org>
References: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
 <7vll315u3w.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508161655460.3553@g5.osdl.org>
 <7vhddp5sfz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 03:07:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5COI-00087t-Hk
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 03:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVHQBGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 21:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVHQBGl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 21:06:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750735AbVHQBGk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 21:06:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7H16ZjA016794
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 18:06:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7H16YS3025598;
	Tue, 16 Aug 2005 18:06:35 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhddp5sfz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Junio C Hamano wrote:
> 
> The developement history would look nicer if you did the latter,
> but I am easy and can go either way.

Here is.

> > I'd do at least the "git-diff-tree" part and the "./" and "../" handling,
> > and convert at least the "git diff" thing to the new world order and away
> > from git-sh-setup-script?
> 
> Sounds like fun.

Mostly done. It actually works from inside subdirectories, but "." at the
top-level is still not done. Small detail. Will fix later. But it would
help if you would apply this, since I'm going to be off for dinner..

The "../" handling was pretty straightforward.

		Linus

----
Make "git diff" work inside relative subdirectories

We always show the diff as an absolute path, but pathnames to diff are
taken relative to the current working directory (and if no pathnames are
given, the default ends up being all of the current working directory).

Note that "../xyz" also works, so you can do

	cd linux/drivers/char
	git diff ../block

and it will generate a diff of the linux/drivers/block changes.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -97,7 +97,7 @@ LIB_H=cache.h object.h blob.h tree.h com
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o path.o \
 	 refs.o csum-file.o pack-check.o pkt-line.o connect.o ident.o \
-	 sha1_name.o
+	 sha1_name.o setup.o
 
 LIB_H += rev-cache.h
 LIB_OBJS += rev-cache.o
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -140,6 +140,9 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern const char **get_pathspec(const char *prefix, char **pathspec);
+extern const char *setup_git_directory(void);
+
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /* Initialize and use the cache information */
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -168,10 +168,11 @@ static const char diff_cache_usage[] =
 "[<common diff options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	const char *tree_name = NULL;
 	unsigned char sha1[20];
+	const char *prefix = setup_git_directory();
 	const char **pathspec = NULL;
 	void *tree;
 	unsigned long size;
@@ -179,15 +180,12 @@ int main(int argc, const char **argv)
 	int allow_options = 1;
 	int i;
 
-	read_cache();
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (!allow_options || *arg != '-') {
-			if (tree_name) {
-				pathspec = argv + i;
+			if (tree_name)
 				break;
-			}
 			tree_name = arg;
 			continue;
 		}
@@ -265,12 +263,16 @@ int main(int argc, const char **argv)
 		usage(diff_cache_usage);
 	}
 
+	pathspec = get_pathspec(prefix, argv + i);
+
 	if (find_copies_harder && detect_rename != DIFF_DETECT_COPY)
 		usage(diff_cache_usage);
 
 	if (!tree_name || get_sha1(tree_name, sha1))
 		usage(diff_cache_usage);
 
+	read_cache();
+
 	/* The rest is for paths restriction. */
 	diff_setup(diff_setup_opt);
 
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -41,12 +41,12 @@ static void show_modified(int oldmode, i
 	diff_change(oldmode, mode, old_sha1, sha1, path, NULL);
 }
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	static const unsigned char null_sha1[20] = { 0, };
 	const char **pathspec;
-	int entries = read_cache();
-	int i;
+	const char *prefix = setup_git_directory();
+	int entries, i;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-p") || !strcmp(argv[1], "-u"))
@@ -95,8 +95,9 @@ int main(int argc, const char **argv)
 		argv++; argc--;
 	}
 
-	/* Do we have a pathspec? */
-	pathspec = (argc > 1) ? argv + 1 : NULL;
+	/* Find the directory, and set up the pathspec */
+	pathspec = get_pathspec(prefix, argv + 1);
+	entries = read_cache();
 
 	if (find_copies_harder && detect_rename != DIFF_DETECT_COPY)
 		usage(diff_files_usage);
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -395,16 +395,25 @@ static int diff_tree_stdin(char *line)
 	return diff_tree_commit(commit, line);
 }
 
+static int count_paths(const char **paths)
+{
+	int i = 0;
+	while (*paths++)
+		i++;
+	return i;
+}
+
 static const char diff_tree_usage[] =
 "git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] "
 "[<common diff options>] <tree-ish> <tree-ish>"
 COMMON_DIFF_OPTIONS_HELP;
 
-int main(int argc, const char **argv)
+int main(int argc, char **argv)
 {
 	int nr_sha1;
 	char line[1000];
 	unsigned char sha1[2][20];
+	const char *prefix = setup_git_directory();
 
 	nr_sha1 = 0;
 	for (;;) {
@@ -523,11 +532,11 @@ int main(int argc, const char **argv)
 	if (find_copies_harder && detect_rename != DIFF_DETECT_COPY)
 		usage(diff_tree_usage);
 
-	if (argc > 0) {
+	paths = get_pathspec(prefix, argv);
+	if (paths) {
 		int i;
 
-		paths = argv;
-		nr_paths = argc;
+		nr_paths = count_paths(paths);
 		pathlens = xmalloc(nr_paths * sizeof(int));
 		for (i=0; i<nr_paths; i++)
 			pathlens[i] = strlen(paths[i]);
diff --git a/git-diff-script b/git-diff-script
--- a/git-diff-script
+++ b/git-diff-script
@@ -1,7 +1,5 @@
 #!/bin/sh
-. git-sh-setup-script || die "Not a git archive"
-
-rev=($(git-rev-parse --revs-only "$@"))
+rev=($(git-rev-parse --revs-only "$@")) || exit
 flags=($(git-rev-parse --no-revs --flags "$@"))
 files=($(git-rev-parse --no-revs --no-flags "$@"))
 case "${#rev[*]}" in
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -134,7 +134,8 @@ int main(int argc, char **argv)
 {
 	int i, as_is = 0;
 	unsigned char sha1[20];
-
+	const char *prefix = setup_git_directory();
+	
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 		char *dotdot;
@@ -189,6 +190,10 @@ int main(int argc, char **argv)
 				for_each_ref(show_reference);
 				continue;
 			}
+			if (!strcmp(arg, "--show-prefix")) {
+				puts(prefix);
+				continue;
+			}
 			show_arg(arg);
 			continue;
 		}
diff --git a/setup.c b/setup.c
new file mode 100644
--- /dev/null
+++ b/setup.c
@@ -0,0 +1,110 @@
+#include "cache.h"
+
+const char **get_pathspec(const char *prefix, char **pathspec)
+{
+	char *entry = *pathspec;
+	char **p;
+	int prefixlen;
+
+	if (!prefix) {
+		char **p;
+		if (!entry)
+			return NULL;
+		p = pathspec;
+		do {
+			if (*entry != '.')
+				continue;
+			/* fixup ? */
+		} while ((entry = *++p) != NULL);
+		return (const char **) pathspec;
+	}
+
+	if (!entry) {
+		static const char *spec[2];
+		spec[0] = prefix;
+		spec[1] = NULL;
+		return spec;
+	}
+
+	/* Otherwise we have to re-write the entries.. */
+	prefixlen = strlen(prefix);
+	p = pathspec;
+	do {
+		int speclen, len = prefixlen;
+		char *n;
+
+		for (;;) {
+			if (!strcmp(entry, ".")) {
+				entry++;
+				break;
+			}
+			if (!strncmp(entry, "./", 2)) {
+				entry += 2;
+				continue;
+			}
+			if (!strncmp(entry, "../", 3)) {
+				do {
+					if (!len)
+						die("'%s' is outside repository", *p);
+					len--;
+				} while (len && prefix[len-1] != '/');
+				entry += 3;
+				continue;
+			}
+			break;
+		}
+		speclen = strlen(entry);
+		n = xmalloc(speclen + len + 1);
+		
+		memcpy(n, prefix, len);
+		memcpy(n + len, entry, speclen+1);
+		*p = n;
+	} while ((entry = *++p) != NULL);
+	return (const char **) pathspec;
+}
+
+const char *setup_git_directory(void)
+{
+	static char cwd[PATH_MAX+1];
+	int len, offset;
+
+	/*
+	 * If GIT_DIR is set explicitly, we're not going
+	 * to do any discovery
+	 */
+	if (gitenv(GIT_DIR_ENVIRONMENT))
+		return NULL;
+
+	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+		die("Unable to read current working directory");
+
+	offset = len = strlen(cwd);
+	for (;;) {
+		/*
+		 * We always want to see a .git/HEAD and a .git/refs/
+		 * subdirectory
+		 */
+		if (!access(".git/HEAD", R_OK) && !access(".git/refs/", X_OK)) {
+			/*
+			 * Then we need either a GIT_OBJECT_DIRECTORY define
+			 * or a .git/objects/ directory
+			 */
+			if (gitenv(DB_ENVIRONMENT) || !access(".git/objects/", X_OK))
+				break;
+		}
+		chdir("..");
+		do {
+			if (!offset)
+				die("Not a git repository");
+		} while (cwd[--offset] != '/');
+	}
+
+	if (offset == len)
+		return NULL;
+
+	/* Make "offset" point to past the '/', and add a '/' at the end */
+	offset++;
+	cwd[len++] = '/';
+	cwd[len] = 0;
+	return cwd + offset;
+}
