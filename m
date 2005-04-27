From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] diff-files: in the spirit of diff-cache and diff-tree
Date: Wed, 27 Apr 2005 00:24:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504270010210.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 06:19:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQe1I-0008T3-Ir
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 06:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVD0EYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 00:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVD0EYq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 00:24:46 -0400
Received: from [24.201.245.36] ([24.201.245.36]:60965 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261907AbVD0EYX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 00:24:23 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFL00FOE885GY@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Apr 2005 00:24:05 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Here's a diff-files implementation to go along with diff-cache and 
diff-tree.  It is based on pieces taken from show-diff and show-files.  
The difference with show-diff is that it can handle files which are not 
(yet) in the cache.  And since the show-diff arguments are a bit awkward 
I decided it would be better to leave it alone and create a new tool.  
IMHO show-diff could simply be removed once all its users have been 
switched over to diff-files.

Signed-off-by: Nicolas Pitre <nico@cam.org>

--- k/Makefile
+++ l/Makefile
@@ -18,7 +18,7 @@ PROG=   update-cache show-diff init-db w
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
 	check-files ls-tree merge-base merge-cache unpack-file git-export \
 	diff-cache convert-cache http-pull rpush rpull rev-list git-mktag \
-	diff-tree-helper
+	diff-tree-helper diff-files
 
 all: $(PROG)
 
--- k/diff-files.c
+++ l/diff-files.c
@@ -0,0 +1,246 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+
+#include <dirent.h>
+#include "cache.h"
+
+static const char *diff_files_usage = "diff-files [-d] [-o] [-z] [paths...]";
+
+/* What paths are we interested in? */
+static int nr_paths = 0;
+static char **paths = NULL;
+static int *pathlens = NULL;
+
+/*
+ * see if name matches our specified paths.
+ * return value:
+ *	-1 if no match
+ *	0 if partial match (name is a directory component)
+ *	1 = exact match
+ *	2 = name is within a specified directory path
+ */
+static int path_match(const char *name, int namelen)
+{
+	int i;
+	if (!nr_paths)
+		return 2;
+	for (i = 0; i < nr_paths; i++) {
+		int pathlen = pathlens[i];
+		if (pathlen == namelen &&
+		    strncmp(paths[i], name, pathlen) == 0) {
+			return 1;
+		} else if (pathlen > namelen && 
+			   strncmp(paths[i], name, namelen) == 0 &&
+			   paths[i][namelen] == '/') {
+				   return 0;
+		} else if (pathlen < namelen &&
+			   strncmp(paths[i], name, pathlen) == 0 &&
+			   name[pathlen] == '/') {
+			return 2;
+		}
+	}
+	return -1;
+}
+
+static const char **dir;
+static int nr_dir;
+static int dir_alloc;
+
+static void add_name(const char *pathname, int len)
+{
+	char *name;
+
+	if (cache_name_pos(pathname, len) >= 0)
+		return;
+
+	if (nr_dir == dir_alloc) {
+		dir_alloc = alloc_nr(dir_alloc);
+		dir = realloc(dir, dir_alloc*sizeof(char *));
+	}
+	name = malloc(len + 1);
+	memcpy(name, pathname, len + 1);
+	dir[nr_dir++] = name;
+}
+
+/*
+ * Read a directory tree. We currently ignore anything but
+ * directories and regular files. That's because git doesn't
+ * handle them at all yet. Maybe that will change some day.
+ *
+ * Also, we currently ignore all names starting with a dot.
+ * That likely will not change.
+ */
+static void read_directory(const char *path, const char *base, int baselen, int match)
+{
+	DIR *dir = opendir(path);
+
+	if (dir) {
+		struct dirent *de;
+		char fullname[MAXPATHLEN + 1];
+		memcpy(fullname, base, baselen);
+
+		while ((de = readdir(dir)) != NULL) {
+			int len;
+
+			if (de->d_name[0] == '.')
+				continue;
+			len = strlen(de->d_name);
+			memcpy(fullname + baselen, de->d_name, len+1);
+			if (match < 2)
+				match = path_match(fullname, baselen+len);
+			if (match < 0)
+				continue;
+
+			switch (de->d_type) {
+			struct stat st;
+			default:
+				continue;
+			case DT_UNKNOWN:
+				if (lstat(fullname, &st))
+					continue;
+				if (S_ISREG(st.st_mode))
+					break;
+				if (!S_ISDIR(st.st_mode))
+					continue;
+				/* fallthrough */
+			case DT_DIR:
+				memcpy(fullname + baselen + len, "/", 2);
+				read_directory(fullname, fullname,
+					       baselen + len + 1,
+					       match == 1 ? 2 : 0);
+				continue;
+			case DT_REG:
+				break;
+			}
+			if (match > 0)
+				add_name(fullname, baselen + len);
+		}
+		closedir(dir);
+	}
+}
+
+static int cmp_name(const void *p1, const void *p2)
+{
+	const char *n1 = *(const char **)p1;
+	const char *n2 = *(const char **)p2;
+	int l1 = strlen(n1), l2 = strlen(n2);
+
+	return cache_name_compare(n1, l1, n2, l2);
+}
+
+static int show_deleted = 0;
+static int show_others = 0;
+static int line_terminator = '\n';
+
+static const char null_sha1_hex[] = "0000000000000000000000000000000000000000";
+
+static void show_file(const char *prefix, unsigned int mode,
+		      const char *sha1, const char *name)
+{
+	printf("%s%o\t%s\t%s\t%s%c", prefix, mode, "blob",
+	       sha1, name, line_terminator);
+}
+
+int main(int argc, char **argv)
+{
+	int i, entries;
+
+	for (i = 1; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (*arg != '-')
+			break;
+
+		if (!strcmp(arg, "-z")) {
+			line_terminator = 0;
+			continue;
+		}
+		if (!strcmp(arg, "-d")) {
+			show_deleted = 1;
+			continue;
+		}
+		if (!strcmp(arg, "-o")) {
+			show_others = 1;
+			continue;
+		}
+
+		usage(diff_files_usage);
+	}
+
+	if (i < argc) {
+		paths = &argv[i];
+		nr_paths = argc - i;
+		pathlens = malloc(nr_paths * sizeof(int));
+		for (i=0; i<nr_paths; i++) {
+			pathlens[i] = strlen(paths[i]);
+			if (paths[i][pathlens[i] - 1] == '@')
+				pathlens[i]--;
+		}
+	}
+
+	entries = read_cache();
+	if (entries < 0) {
+		perror("read_cache");
+		exit(1);
+	}
+
+	if (show_others) {
+		read_directory(".", "", 0, 0);
+		qsort(dir, nr_dir, sizeof(char *), cmp_name);
+		for (i = 0; i < nr_dir; i++) {
+			struct stat st;
+			unsigned int mode;
+			if (stat(dir[i], &st) < 0) {
+				perror(dir[i]);
+			} else {
+				mode = S_IFREG | ce_permissions(st.st_mode);
+				show_file("+", mode, null_sha1_hex, dir[i]);
+			}
+		}
+	}
+
+	for (i = 0; i < entries; i++) {
+		struct stat st;
+		unsigned int ce_mode, mode;
+		struct cache_entry *ce = active_cache[i];
+		int changed;
+
+		if (path_match(ce->name, ce_namelen(ce)) < 1)
+			continue;
+
+		if (ce_stage(ce)) {
+			printf("U %s%c", ce->name, line_terminator);
+			do {
+				i++;
+			} while (i < entries &&
+				 !strcmp(ce->name, active_cache[i]->name));
+			continue;
+		}
+
+		ce_mode = ntohl(ce->ce_mode);
+		if (stat(ce->name, &st) < 0) {
+			if (errno != ENOENT) {
+				perror(ce->name);
+			} else if (show_deleted) {
+				show_file("-", ce_mode,
+					  sha1_to_hex(ce->sha1), ce->name);
+			}
+			continue;
+		}
+
+		changed = cache_match_stat(ce, &st);
+		if (!changed)
+			continue;
+
+		mode = S_IFREG | ce_permissions(st.st_mode);
+		printf("*%o->%o\t%s\t%s->%s\t%s%c",
+		       ce_mode, mode, "blob",
+		       sha1_to_hex(ce->sha1), null_sha1_hex,
+		       ce->name, line_terminator);
+	}
+
+	return 0;
+}

