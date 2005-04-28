From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add a diff-files command (revised)
Date: Wed, 27 Apr 2005 22:06:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504272141560.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyNm-00007m-Jr
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVD1CJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVD1CJX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:09:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32806 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261540AbVD1CGs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 22:06:48 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFM00C06WITR4@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Apr 2005 22:06:29 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

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
Binary files k/diff-tree and l/diff-tree differ
Binary files k/diff-tree-helper and l/diff-tree-helper differ
Binary files k/diff.o and l/diff.o differ
Binary files k/fsck-cache and l/fsck-cache differ
Binary files k/git-export and l/git-export differ
Binary files k/git-mktag and l/git-mktag differ
Binary files k/http-pull and l/http-pull differ
Binary files k/init-db and l/init-db differ
Binary files k/init-db.o and l/init-db.o differ
Binary files k/libgit.a and l/libgit.a differ
Binary files k/ls-tree and l/ls-tree differ
Binary files k/merge-base and l/merge-base differ
Binary files k/merge-cache and l/merge-cache differ
Binary files k/object.o and l/object.o differ
Binary files k/read-cache.o and l/read-cache.o differ
Binary files k/read-tree and l/read-tree differ
Binary files k/rev-list and l/rev-list differ
Binary files k/rev-tree and l/rev-tree differ
Binary files k/rpull and l/rpull differ
Binary files k/rpush and l/rpush differ
Binary files k/sha1_file.o and l/sha1_file.o differ
Binary files k/show-diff and l/show-diff differ
Binary files k/show-files and l/show-files differ
Binary files k/strbuf.o and l/strbuf.o differ
Binary files k/tree.o and l/tree.o differ
Binary files k/unpack-file and l/unpack-file differ
Binary files k/update-cache and l/update-cache differ
--- k/update-cache.c
+++ l/update-cache.c
@@ -0,0 +1,373 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+#include <signal.h>
+#include "cache.h"
+
+/*
+ * Default to not allowing changes to the list of files. The
+ * tool doesn't actually care, but this makes it harder to add
+ * files to the revision control by mistake by doing something
+ * like "update-cache *" and suddenly having all the object
+ * files be revision controlled.
+ */
+static int allow_add = 0, allow_remove = 0, not_new = 0;
+
+/* Three functions to allow overloaded pointer return; see linux/err.h */
+static inline void *ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
+static inline long PTR_ERR(const void *ptr)
+{
+	return (long) ptr;
+}
+
+static inline long IS_ERR(const void *ptr)
+{
+	return (unsigned long)ptr > (unsigned long)-1000L;
+}
+
+static int index_fd(unsigned char *sha1, int fd, struct stat *st)
+{
+	z_stream stream;
+	unsigned long size = st->st_size;
+	int max_out_bytes = size + 200;
+	void *out = xmalloc(max_out_bytes);
+	void *metadata = xmalloc(200);
+	int metadata_size;
+	void *in;
+	SHA_CTX c;
+
+	in = "";
+	if (size)
+		in = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (!out || (int)(long)in == -1)
+		return -1;
+
+	metadata_size = 1+sprintf(metadata, "blob %lu", size);
+
+	SHA1_Init(&c);
+	SHA1_Update(&c, metadata, metadata_size);
+	SHA1_Update(&c, in, size);
+	SHA1_Final(sha1, &c);
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, Z_BEST_COMPRESSION);
+
+	/*
+	 * ASCII size + nul byte
+	 */	
+	stream.next_in = metadata;
+	stream.avail_in = metadata_size;
+	stream.next_out = out;
+	stream.avail_out = max_out_bytes;
+	while (deflate(&stream, 0) == Z_OK)
+		/* nothing */;
+
+	/*
+	 * File content
+	 */
+	stream.next_in = in;
+	stream.avail_in = size;
+	while (deflate(&stream, Z_FINISH) == Z_OK)
+		/*nothing */;
+
+	deflateEnd(&stream);
+	
+	return write_sha1_buffer(sha1, out, stream.total_out);
+}
+
+/*
+ * This only updates the "non-critical" parts of the directory
+ * cache, ie the parts that aren't tracked by GIT, and only used
+ * to validate the cache.
+ */
+static void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
+{
+	ce->ce_ctime.sec = htonl(st->st_ctime);
+	ce->ce_mtime.sec = htonl(st->st_mtime);
+#ifdef NSEC
+	ce->ce_ctime.nsec = htonl(st->st_ctim.tv_nsec);
+	ce->ce_mtime.nsec = htonl(st->st_mtim.tv_nsec);
+#endif
+	ce->ce_dev = htonl(st->st_dev);
+	ce->ce_ino = htonl(st->st_ino);
+	ce->ce_uid = htonl(st->st_uid);
+	ce->ce_gid = htonl(st->st_gid);
+	ce->ce_size = htonl(st->st_size);
+}
+
+static int add_file_to_cache(char *path)
+{
+	int size, namelen;
+	struct cache_entry *ce;
+	struct stat st;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT) {
+			if (allow_remove)
+				return remove_file_from_cache(path);
+		}
+		return -1;
+	}
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		return -1;
+	}
+	namelen = strlen(path);
+	size = cache_entry_size(namelen);
+	ce = xmalloc(size);
+	memset(ce, 0, size);
+	memcpy(ce->name, path, namelen);
+	fill_stat_cache_info(ce, &st);
+	ce->ce_mode = create_ce_mode(st.st_mode);
+	ce->ce_flags = htons(namelen);
+
+	if (index_fd(ce->sha1, fd, &st) < 0)
+		return -1;
+
+	return add_cache_entry(ce, allow_add);
+}
+
+static int match_data(int fd, void *buffer, unsigned long size)
+{
+	while (size) {
+		char compare[1024];
+		int ret = read(fd, compare, sizeof(compare));
+
+		if (ret <= 0 || ret > size || memcmp(buffer, compare, ret))
+			return -1;
+		size -= ret;
+		buffer += ret;
+	}
+	return 0;
+}
+
+static int compare_data(struct cache_entry *ce, unsigned long expected_size)
+{
+	int match = -1;
+	int fd = open(ce->name, O_RDONLY);
+
+	if (fd >= 0) {
+		void *buffer;
+		unsigned long size;
+		char type[10];
+
+		buffer = read_sha1_file(ce->sha1, type, &size);
+		if (buffer) {
+			if (size == expected_size && !strcmp(type, "blob"))
+				match = match_data(fd, buffer, size);
+			free(buffer);
+		}
+		close(fd);
+	}
+	return match;
+}
+
+/*
+ * "refresh" does not calculate a new sha1 file or bring the
+ * cache up-to-date for mode/content changes. But what it
+ * _does_ do is to "re-match" the stat information of a file
+ * with the cache, so that you can refresh the cache for a
+ * file that hasn't been changed but where the stat entry is
+ * out of date.
+ *
+ * For example, you'd want to do this after doing a "read-tree",
+ * to link up the stat cache details with the proper files.
+ */
+static struct cache_entry *refresh_entry(struct cache_entry *ce)
+{
+	struct stat st;
+	struct cache_entry *updated;
+	int changed, size;
+
+	if (stat(ce->name, &st) < 0)
+		return ERR_PTR(-errno);
+
+	changed = cache_match_stat(ce, &st);
+	if (!changed)
+		return ce;
+
+	/*
+	 * If the mode has changed, there's no point in trying
+	 * to refresh the entry - it's not going to match
+	 */
+	if (changed & MODE_CHANGED)
+		return ERR_PTR(-EINVAL);
+
+	if (compare_data(ce, st.st_size))
+		return ERR_PTR(-EINVAL);
+
+	size = ce_size(ce);
+	updated = xmalloc(size);
+	memcpy(updated, ce, size);
+	fill_stat_cache_info(updated, &st);
+	return updated;
+}
+
+static void refresh_cache(void)
+{
+	int i;
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce, *new;
+		ce = active_cache[i];
+		if (ce_stage(ce)) {
+			printf("%s: needs merge\n", ce->name);
+			while ((i < active_nr) &&
+			       ! strcmp(active_cache[i]->name, ce->name))
+				i++;
+			i--;
+			continue;
+		}
+
+		new = refresh_entry(ce);
+		if (IS_ERR(new)) {
+			if (!(not_new && PTR_ERR(new) == -ENOENT))
+				printf("%s: needs update\n", ce->name);
+			continue;
+		}
+		active_cache[i] = new;
+	}
+}
+
+/*
+ * We fundamentally don't like some paths: we don't want
+ * dot or dot-dot anywhere, and in fact, we don't even want
+ * any other dot-files (.git or anything else). They
+ * are hidden, for chist sake.
+ *
+ * Also, we don't want double slashes or slashes at the
+ * end that can make pathnames ambiguous.
+ */
+static int verify_path(char *path)
+{
+	char c;
+
+	goto inside;
+	for (;;) {
+		if (!c)
+			return 1;
+		if (c == '/') {
+inside:
+			c = *path++;
+			if (c != '/' && c != '.' && c != '\0')
+				continue;
+			return 0;
+		}
+		c = *path++;
+	}
+}
+
+static int add_cacheinfo(char *arg1, char *arg2, char *arg3)
+{
+	int size, len;
+	unsigned int mode;
+	unsigned char sha1[20];
+	struct cache_entry *ce;
+
+	if (sscanf(arg1, "%o", &mode) != 1)
+		return -1;
+	if (get_sha1_hex(arg2, sha1))
+		return -1;
+	if (!verify_path(arg3))
+		return -1;
+
+	len = strlen(arg3);
+	size = cache_entry_size(len);
+	ce = xmalloc(size);
+	memset(ce, 0, size);
+
+	memcpy(ce->sha1, sha1, 20);
+	memcpy(ce->name, arg3, len);
+	ce->ce_flags = htons(len);
+	ce->ce_mode = create_ce_mode(mode);
+	return add_cache_entry(ce, allow_add);
+}
+
+static const char *lockfile_name = NULL;
+
+static void remove_lock_file(void)
+{
+	if (lockfile_name)
+		unlink(lockfile_name);
+}
+
+static void remove_lock_file_on_signal(int signo)
+{
+	remove_lock_file();
+}
+
+int main(int argc, char **argv)
+{
+	int i, newfd, entries;
+	int allow_options = 1;
+	static char lockfile[MAXPATHLEN+1];
+	const char *indexfile = get_index_file();
+
+	snprintf(lockfile, sizeof(lockfile), "%s.lock", indexfile);
+
+	newfd = open(lockfile, O_RDWR | O_CREAT | O_EXCL, 0600);
+	if (newfd < 0)
+		die("unable to create new cachefile");
+
+	signal(SIGINT, remove_lock_file_on_signal);
+	atexit(remove_lock_file);
+	lockfile_name = lockfile;
+
+	entries = read_cache();
+	if (entries < 0)
+		die("cache corrupted");
+
+	for (i = 1 ; i < argc; i++) {
+		char *path = argv[i];
+
+		if (allow_options && *path == '-') {
+			if (!strcmp(path, "--")) {
+				allow_options = 0;
+				continue;
+			}
+			if (!strcmp(path, "--add")) {
+				allow_add = 1;
+				continue;
+			}
+			if (!strcmp(path, "--remove")) {
+				allow_remove = 1;
+				continue;
+			}
+			if (!strcmp(path, "--refresh")) {
+				refresh_cache();
+				continue;
+			}
+			if (!strcmp(path, "--cacheinfo")) {
+				if (i+3 >= argc || add_cacheinfo(argv[i+1], argv[i+2], argv[i+3]))
+					die("update-cache: --cacheinfo <mode> <sha1> <path>");
+				i += 3;
+				continue;
+			}
+			if (!strcmp(path, "--ignore-missing")) {
+				not_new = 1;
+				continue;
+			}
+			die("unknown option %s", path);
+		}
+		if (!verify_path(path)) {
+			fprintf(stderr, "Ignoring path %s\n", argv[i]);
+			continue;
+		}
+		if (add_file_to_cache(path))
+			die("Unable to add %s to database", path);
+	}
+	if (write_cache(newfd, active_cache, active_nr) || rename(lockfile, indexfile))
+		die("Unable to write new cachefile");
+
+	lockfile_name = NULL;
+	return 0;
+}
