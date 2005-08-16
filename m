From: Linus Torvalds <torvalds@osdl.org>
Subject: [RFC PATCH] Add support for figuring out where in the git archive
 we are
Date: Tue, 16 Aug 2005 15:45:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 17 00:46:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ABk-0004Eu-6y
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 00:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVHPWpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 18:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVHPWpl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 18:45:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750715AbVHPWpk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 18:45:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7GMjajA005023
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 15:45:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7GMjZ0a018161;
	Tue, 16 Aug 2005 15:45:35 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

    
This does only "git-diff-cache" and "git-diff-files", but the concept
should work for any command that uses the working tree.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
This is really partly a serious patch, but also just a query whether 
people would want git to work in subdirectories, not just the top-level 
directory.

So you can be in linux/drivers, and if you do a

	git-diff-files -p char

then it will automatically be turned into the full pathname, and do the
right thing (ie do a diff of drivers/char only).

I didn't want to do it originally, but that was largely a complexity
issue, and an issue of there being many more things up in the air at that
time. Now, things have calmed down a bit, the interfaces are fairly
stable, and it turns out to be not that difficult to just walk up the
chain of directories until we hit the one that has the ".git" directory in
it.

I only converted "git-diff-files" and "git-diff-cache" to do this, because
so far it's a technology demo. And the "git-diff-script" file (and the
git-sh-setup-script in particular) does _not_ accept this "automatically 
figure out where we are" thing, so it's really only the native git diff 
commands that do it.

But if people think it's a good idea, I can pretty trivially convert the 
rest. It's done in a way that makes it very easy to convert programs to 
take advantage of the auto-git-directory-finding thing.

If you use the GIT_DIR environment variable approach, it assumes that all
filenames you give it are absolute and acts the way it always did before.

Comments? Like? Dislike?

		Linus

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
@@ -140,6 +140,8 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern char **setup_git_directory(char **pathspec);
+
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /* Initialize and use the cache information */
diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -179,15 +179,12 @@ int main(int argc, const char **argv)
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
@@ -265,12 +262,16 @@ int main(int argc, const char **argv)
 		usage(diff_cache_usage);
 	}
 
+	pathspec = setup_git_directory(argv + i);
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
@@ -45,8 +45,7 @@ int main(int argc, const char **argv)
 {
 	static const unsigned char null_sha1[20] = { 0, };
 	const char **pathspec;
-	int entries = read_cache();
-	int i;
+	int entries, i;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-p") || !strcmp(argv[1], "-u"))
@@ -95,8 +94,9 @@ int main(int argc, const char **argv)
 		argv++; argc--;
 	}
 
-	/* Do we have a pathspec? */
-	pathspec = (argc > 1) ? argv + 1 : NULL;
+	/* Find the directory, and set up the pathspec */
+	pathspec = setup_git_directory(argv + 1);
+	entries = read_cache();
 
 	if (find_copies_harder && detect_rename != DIFF_DETECT_COPY)
 		usage(diff_files_usage);
diff --git a/setup.c b/setup.c
new file mode 100644
--- /dev/null
+++ b/setup.c
@@ -0,0 +1,66 @@
+#include "cache.h"
+
+char **setup_git_directory(char **pathspec)
+{
+	static char *spec[2], **p;
+	static char cwd[PATH_MAX+1];
+	int len, offset;
+
+	/*
+	 * If GIT_DIR is set explicitly, we're not going
+	 * to do any discovery
+	 */
+	if (gitenv(GIT_DIR_ENVIRONMENT))
+		return *pathspec ? pathspec : NULL;
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
+		return *pathspec ? pathspec : NULL;
+
+	/* Make "offset" point to past the '/', and add a '/' at the end */
+	offset++;
+	cwd[len++] = '/';
+	cwd[len] = 0;
+
+	/* An empty pathspec gets turned into the directory we were in */
+	if (!*pathspec) {
+		spec[0] = cwd + offset;
+		spec[1] = NULL;
+		return spec;
+	}
+
+	/* Otherwise we have to re-write the entries.. */
+	p = pathspec;
+	do {
+		int speclen = strlen(*p);
+		char *n = xmalloc(speclen + len - offset + 1);
+		memcpy(n, cwd + offset, len - offset);
+		memcpy(n + len - offset, *p, speclen+1);
+		*p = n;
+	} while (*++p);
+	return pathspec;
+}
+
