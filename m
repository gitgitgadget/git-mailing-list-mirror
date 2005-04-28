From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add a diff-files command (revised and cleaned up)
Date: Wed, 27 Apr 2005 22:43:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504272239420.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:40:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQywp-0003BG-Qs
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVD1Cpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVD1Cpg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:45:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60525 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261784AbVD1CoO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 22:44:14 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFM00GBUY9AWY@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Apr 2005 22:43:58 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[ sorry for the resent
  still experiencing glitches with cogito
  please ignore previous patch ]

In the same spirit as diff-tree and diff-cache, here is a diff-files 
command that processes differences between the index cache and the 
working directory content.  It produces lists of files that are either 
changed, deleted and/or unknown with regards to the current cache, 
content. The -p option can also be used to generate a patch describing 
the differences in patch form.

It also has the ability to accept exclude patterns for files and the 
ability to read those exclude patterns from a file.

Typical usage looks like:

    diff-files --others --exclude=\*.o arch/arm/ include/asm-arm/

which lists all files the git cache doesn't know about in arch/arm/ and 
include/asm-arm/ but ignoring any object files.  Or:

    diff-files --all -p --exclude-from=dontdiff.list

which produces a patch of all changes currently in the work tree while 
excluding all files matching any of the patterns listed in 
dontdiff.list (useful when one doesn't want to run 'make distclean').

(revised after comments from Junio C Hamano)
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
@@ -0,0 +1,347 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+
+#include <dirent.h>
+#include <fnmatch.h>
+#include "cache.h"
+#include "diff.h"
+
+static const char *diff_files_usage =
+	"diff-files [--all] [--changed] [--deleted] [--others] [-p | -z] "
+	"[--exclude=<pattern>] [--exclude-from=<file>] [paths...]";
+
+/* What paths are we interested in? */
+static int nr_paths = 0;
+static char **paths = NULL;
+static int *pathlens = NULL;
+
+static int nr_excludes;
+static const char **excludes;
+static int excludes_alloc;
+
+static void add_exclude(const char *string)
+{
+	if (nr_excludes == excludes_alloc) {
+		excludes_alloc = alloc_nr(excludes_alloc);
+		excludes = realloc(excludes, excludes_alloc*sizeof(char *));
+	}
+	excludes[nr_excludes++] = string;
+}
+
+static void add_excludes_from_file(const char *fname)
+{
+	int fd, i;
+	long size;
+	char *buf, *entry;
+
+	fd = open(fname, O_RDONLY);
+	if (fd < 0)
+		goto err;
+	size = lseek(fd, 0, SEEK_END);
+	if (size < 0)
+		goto err;
+	lseek(fd, 0, SEEK_SET);
+	if (size == 0) {
+		close(fd);
+		return;
+	}
+	buf = malloc(size);
+	if (!buf) {
+		errno = ENOMEM;
+		goto err;
+	}
+	if (read(fd, buf, size) != size)
+		goto err;
+	close(fd);
+
+	entry = buf;
+	for (i = 0; i < size; i++) {
+		if (buf[i] == '\n') {
+			if (entry != buf + i) {
+				buf[i] = 0;
+				add_exclude(entry);
+			}
+			entry = buf + i + 1;
+		}
+	}
+	return;
+
+err:	perror(fname);
+	exit(1);
+}
+
+/*
+ * See if name matches our specified paths and is not excluded.
+ * return value:
+ *	-1 if no match
+ *	0 if partial match (name is a directory component)
+ *	1 = exact match
+ *	2 = name is under a specified directory path with no excludes
+ */
+static int path_match(const char *name, int namelen)
+{
+	int i, ret;
+
+	/* fast case: no path list and no exclude list */
+	if (!nr_paths && !nr_excludes)
+		return 2;
+
+	ret = (nr_paths) ? -1 : 1;
+	for (i = 0; i < nr_paths; i++) {
+		int pathlen = pathlens[i];
+		if (pathlen == namelen &&
+		    strncmp(paths[i], name, pathlen) == 0) {
+			ret = 1;
+			break;
+		} else if (pathlen > namelen && 
+			   strncmp(paths[i], name, namelen) == 0 &&
+			   paths[i][namelen] == '/') {
+			ret = 0;
+			break;
+		} else if (pathlen < namelen &&
+			   strncmp(paths[i], name, pathlen) == 0 &&
+			   name[pathlen] == '/') {
+			ret = (nr_excludes) ? 1 : 2;
+			break;
+		}
+	}
+
+	if (ret >= 0 && nr_excludes) {
+		const char *basename = strrchr(name, '/');
+		basename = (basename) ? basename+1 : name;
+		for (i = 0; i < nr_excludes; i++) {
+			if (fnmatch(excludes[i], basename, 0) == 0) {
+				ret = -1;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static const char **others;
+static int nr_others;
+static int others_alloc;
+
+static void add_name(const char *pathname, int len)
+{
+	char *name;
+
+	if (cache_name_pos(pathname, len) >= 0)
+		return;
+
+	if (nr_others == others_alloc) {
+		others_alloc = alloc_nr(others_alloc);
+		others = realloc(others, others_alloc*sizeof(char *));
+	}
+	name = malloc(len + 1);
+	memcpy(name, pathname, len + 1);
+	others[nr_others++] = name;
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
+					       baselen + len + 1, match);
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
+static int show_changed = 0;
+static int show_deleted = 0;
+static int show_others = 0;
+static int generate_patch = 0;
+static int line_terminator = '\n';
+
+static const char null_sha1[20];
+static const char null_sha1_hex[] = "0000000000000000000000000000000000000000";
+
+static void show_file(int prefix, unsigned int mode,
+		      const char *sha1, const char *name)
+{
+	if (generate_patch)
+		diff_addremove(prefix, mode, sha1, name, NULL);
+	else
+		printf("%c%o\t%s\t%s\t%s%c", prefix, mode, "blob",
+		       sha1_to_hex(sha1), name, line_terminator);
+}
+
+int main(int argc, char **argv)
+{
+	int i, entries;
+
+	for (i = 1; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (*arg != '-') {
+			break;
+		} else if (!strcmp(arg, "-z")) {
+			line_terminator = 0;
+		} else if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
+			show_changed = show_deleted = show_others = 1;
+		} else if (!strcmp(arg, "-c") || !strcmp(arg, "--changed")) {
+			show_changed = 1;
+		} else if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
+			show_deleted = 1;
+		} else if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
+			show_others = 1;
+		} else if (!strcmp(arg, "-p")) {
+			generate_patch = 1;
+		} else if (!strcmp(arg, "-x") && i+1 < argc) {
+			add_exclude(argv[++i]);
+		} else if (!strncmp(arg, "--exclude=", 10)) {
+			add_exclude(arg+10);
+		} else if (!strcmp(arg, "-X") && i+1 < argc) {
+			add_excludes_from_file(argv[++i]);
+		} else if (!strncmp(arg, "--exclude-from=", 15)) {
+			add_excludes_from_file(arg+15);
+		} else if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		} else
+			usage(diff_files_usage);
+	}
+
+	/* default to -c if none of -c, -d nor -o have been specified */
+	if (!show_changed && !show_deleted && !show_others)
+		show_changed = 1;
+
+	if (i < argc) {
+		paths = &argv[i];
+		nr_paths = argc - i;
+		pathlens = malloc(nr_paths * sizeof(int));
+		for (i=0; i<nr_paths; i++) {
+			pathlens[i] = strlen(paths[i]);
+			if (paths[i][pathlens[i] - 1] == '/')
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
+		qsort(others, nr_others, sizeof(char *), cmp_name);
+		for (i = 0; i < nr_others; i++) {
+			struct stat st;
+			unsigned int mode;
+			if (stat(others[i], &st) < 0) {
+				perror(others[i]);
+			} else {
+				mode = S_IFREG | ce_permissions(st.st_mode);
+				show_file('+', mode, null_sha1, others[i]);
+			}
+		}
+	}
+
+	for (i = 0; i < entries; i++) {
+		struct stat st;
+		unsigned int ce_mode, mode;
+		struct cache_entry *ce = active_cache[i];
+
+		if (path_match(ce->name, ce_namelen(ce)) < 1)
+			continue;
+
+		if (show_changed && ce_stage(ce)) {
+			if (generate_patch)
+				diff_unmerge(ce->name);
+			else
+				printf("U %s%c", ce->name, line_terminator);
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
+				show_file('-', ce_mode, ce->sha1, ce->name);
+			}
+			continue;
+		}
+
+		if (!show_changed || !cache_match_stat(ce, &st))
+			continue;
+
+		mode = S_IFREG | ce_permissions(st.st_mode);
+		if (generate_patch)
+			diff_change(ce_mode, mode, ce->sha1,
+				    null_sha1, ce->name, NULL);
+		else
+			printf("*%o->%o\t%s\t%s->%s\t%s%c",
+			       ce_mode, mode, "blob",
+			       sha1_to_hex(ce->sha1), null_sha1_hex,
+			       ce->name, line_terminator);
+	}
+
+	return 0;
+}
