From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] GIT: Create tar archives of tree on the fly, take two
Date: Thu, 28 Apr 2005 19:40:38 +0200
Message-ID: <20050428174038.GA24352@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Joshua T. Corbin" <jcorbin@node1.wunjo.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:39:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRCxm-0007kB-AN
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 19:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVD1Rnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVD1Rnb
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 13:43:31 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:54936 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262191AbVD1Rkk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 13:40:40 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 2BFE635F; Thu, 28 Apr 2005 19:40:38 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Linus,

here's an improved version of tar-tree, a streaming archive creator for
GIT.  The major added feature is blocking; all write(2) calls now have a
size of 10240, just as GNU tar (and tape drives) likes them.  The
buffering overhead does not seem to degrade performance because most
files in the repositories I tested this with are smaller than 10KB, so
we need fewer system calls.

File names are still restricted to 500 bytes and the archive format
currently only allows for files up to 8GB.  Both restrictions can be
lifted if need be with more pax extended headers.

The archive format used is the pax interchange format, i.e. POSIX tar
format.  It can be read by (and created with) GNU tar.  If I read the
specs correctly tar-tree should now be standards compliant (modulo
bugs).

Because it streams the archive (think ls-tree merged with cat-file),
tar-tree doesn't need to create any temporary files.  That makes it
quite fast.

It accepts tree IDs and commit IDs as first parameter.  In the latter
case tar-tree tries to get the commit date out of the committer line.
Else all files in the archive are time-stamped with the current time.

An optional second parameter is used as a path prefix for all files in
the archive.  Example:

   $ tar-tree a2755a80f40e5794ddc20e00f781af9d6320fafb \
   linux-2.6.12-rc3 | bzip9 -9 > linux-2.6.12-rc3.tar.bz2

I think it fits nicely into the core toolset of git.  What do you think?

Thanks,
Rene


Index: Makefile
===================================================================
--- a5d7e40207ee2bd713a15d5bc839168139055f5e/Makefile  (mode:100644 sha1:378d5ee9a24a9fb7690bfdf79fd3fde2b9563fad)
+++ 0fa216c80d3ecf45d3de1552c03d95a21f8c2a11/Makefile  (mode:100644 sha1:0b330dc3fd05253b8fd20ca4f9e98e411074868f)
@@ -18,7 +18,7 @@
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
 	check-files ls-tree merge-base merge-cache unpack-file git-export \
 	diff-cache convert-cache http-pull rpush rpull rev-list git-mktag \
-	diff-tree-helper
+	diff-tree-helper tar-tree
 
 all: $(PROG)
 
Index: tar-tree.c
===================================================================
--- /dev/null  (tree:a5d7e40207ee2bd713a15d5bc839168139055f5e)
+++ 0fa216c80d3ecf45d3de1552c03d95a21f8c2a11/tar-tree.c  (mode:100644 sha1:d078cb5a8d4ab5bc2c774b889b602d179bde39b1)
@@ -0,0 +1,363 @@
+#include <time.h>
+#include "cache.h"
+
+#define RECORDSIZE	(512)
+#define BLOCKSIZE	(RECORDSIZE * 20)
+
+static const char *tar_tree_usage = "tar-tree <key> [basedir]";
+
+static char block[BLOCKSIZE];
+static unsigned long offset;
+
+static const char *basedir;
+static time_t archive_time;
+
+struct path_prefix {
+	struct path_prefix *prev;
+	const char *name;
+};
+
+/* tries hard to write, either succeeds or dies in the attempt */
+static void reliable_write(void *buf, unsigned long size)
+{
+	while (size > 0) {
+		long ret = write(1, buf, size);
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				continue;
+			if (errno == EPIPE)
+				exit(0);
+			die("tar-tree: %s", strerror(errno));
+		} else if (!ret) {
+			die("tar-tree: disk full?");
+		}
+		size -= ret;
+		buf += ret;
+	}
+}
+
+/* writes out the whole block, but only if it is full */
+static void write_if_needed(void)
+{
+	if (offset == BLOCKSIZE) {
+		reliable_write(block, BLOCKSIZE);
+		offset = 0;
+	}
+}
+
+/*
+ * The end of tar archives is marked by 1024 nul bytes and after that
+ * follows the rest of the block (if any).
+ */
+static void write_trailer(void)
+{
+	memset(block + offset, 0, RECORDSIZE);
+	offset += RECORDSIZE;
+	write_if_needed();
+	memset(block + offset, 0, RECORDSIZE);
+	offset += RECORDSIZE;
+	write_if_needed();
+	if (offset) {
+		memset(block + offset, 0, BLOCKSIZE - offset);
+		reliable_write(block, BLOCKSIZE);
+		offset = 0;
+	}
+}
+
+/*
+ * queues up writes, so that all our write(2) calls write exactly one
+ * full block; pads writes to RECORDSIZE
+ */
+static void write_blocked(void *buf, unsigned long size)
+{
+	unsigned long tail;
+
+	if (offset) {
+		unsigned long chunk = BLOCKSIZE - offset;
+		if (size < chunk)
+			chunk = size;
+		memcpy(block + offset, buf, chunk);
+		size -= chunk;
+		offset += chunk;
+		buf += chunk;
+		write_if_needed();
+	}
+	while (size >= BLOCKSIZE) {
+		reliable_write(buf, BLOCKSIZE);
+		size -= BLOCKSIZE;
+		buf += BLOCKSIZE;
+	}
+	if (size) {
+		memcpy(block + offset, buf, size);
+		buf += size;
+		offset += size;
+	}
+	tail = offset % RECORDSIZE;
+	if (tail)  {
+		memset(block + offset, 0, RECORDSIZE - tail);
+		offset += RECORDSIZE - tail;
+	}
+	write_if_needed();
+}
+
+static void append_string(char **p, const char *s)
+{
+	unsigned int len = strlen(s);
+	memcpy(*p, s, len);
+	*p += len;
+}
+
+static void append_char(char **p, char c)
+{
+	**p = c;
+	*p += 1;
+}
+
+static void append_long(char **p, long n)
+{
+	int len = sprintf(*p, "%ld", n);
+	*p += len;
+}
+
+static void append_path_prefix(char **buffer, struct path_prefix *prefix)
+{
+	if (!prefix)
+		return;
+	append_path_prefix(buffer, prefix->prev);
+	append_string(buffer, prefix->name);
+	append_char(buffer, '/');
+}
+
+static unsigned int path_prefix_len(struct path_prefix *prefix)
+{
+	if (!prefix)
+		return 0;
+	return path_prefix_len(prefix->prev) + strlen(prefix->name) + 1;
+}
+
+static void append_path(char **p, int is_dir, const char *basepath,
+                        struct path_prefix *prefix, const char *path)
+{
+	if (basepath) {
+		append_string(p, basepath);
+		append_char(p, '/');
+	}
+	append_path_prefix(p, prefix);
+	append_string(p, path);
+	if (is_dir)
+		append_char(p, '/');
+}
+
+static unsigned int path_len(int is_dir, const char *basepath,
+                             struct path_prefix *prefix, const char *path)
+{
+	unsigned int len = 0;
+	if (basepath)
+		len += strlen(basepath) + 1;
+	len += path_prefix_len(prefix) + strlen(path);
+	if (is_dir)
+		len++;
+	return len;
+}
+
+static void write_header(const char *, const char *, struct path_prefix *,
+                         const char *, unsigned int, unsigned long);
+
+/* stores a pax extended header directly in the block buffer */
+static void write_extended_header(const char *headerfilename, int is_dir,
+                                  const char *basepath,
+                                  struct path_prefix *prefix,
+                                  const char *path, unsigned int namelen)
+{
+	char *records, *p;
+	unsigned int size = 1 + 6 + namelen + 1;
+	if (size > 9)
+		size++;
+	if (size > 99)
+		size++;
+	if (size > RECORDSIZE)
+		die("tar-tree: extended header too big, wtf?");
+	write_header(NULL, NULL, NULL, headerfilename, 0100600, size);
+
+	records = block + offset;
+	memset(records, 0, RECORDSIZE);
+	offset += RECORDSIZE;
+	p = records;
+	append_long(&p, size);
+	append_string(&p, " path=");
+	append_path(&p, is_dir, basepath, prefix, path);
+	append_char(&p, '\n');
+	write_if_needed();
+}
+
+/* stores a ustar header directly in the block buffer */
+static void write_header(const char *sha1, const char *basepath,
+                         struct path_prefix *prefix, const char *path,
+                         unsigned int mode, unsigned long size)
+{
+	unsigned int namelen; 
+	char *p, *header = NULL;
+	unsigned int checksum = 0;
+	int i;
+
+	namelen = path_len(S_ISDIR(mode), basepath, prefix, path);
+	if (namelen > 500) {
+		die("tar-tree: name too log of object %s\n", sha1_to_hex(sha1));
+	} else if (namelen > 100) {
+		char *sha1_hex = sha1_to_hex(sha1);
+		char headerfilename[51];
+		sprintf(headerfilename, "%s.paxheader", sha1_hex);
+		/* the extended header must be written before the normal one */
+		write_extended_header(headerfilename, S_ISDIR(mode), basepath,
+				      prefix, path, namelen);
+
+		header = block + offset;
+		memset(header, 0, RECORDSIZE);
+		offset += RECORDSIZE;
+		sprintf(header, "%s.data", sha1_hex);
+	} else {
+		header = block + offset;
+		memset(header, 0, RECORDSIZE);
+		offset += RECORDSIZE;
+		p = header;
+		append_path(&p, S_ISDIR(mode), basepath, prefix, path);
+	}
+
+	if (S_ISDIR(mode))
+		mode |= 0755;	/* GIT doesn't store permissions of dirs */
+	sprintf(&header[100], "%07o", mode & 07777);
+
+	/* XXX: should we provide more meaningful info here? */
+	sprintf(&header[108], "%07o", 0);	/* uid */
+	sprintf(&header[116], "%07o", 0);	/* gid */
+	strncpy(&header[265], "git", 31);	/* uname */
+	strncpy(&header[297], "git", 31);	/* gname */
+
+	sprintf(&header[124], "%011lo", S_ISDIR(mode) ? 0 : size);
+	sprintf(&header[136], "%011lo", archive_time);
+
+	/* typeflag */
+	if (!sha1)
+		header[156] = 'x';	/* extended header */
+	else
+		header[156] = S_ISDIR(mode) ? '5' : '0';
+
+	memcpy(&header[257], "ustar", 6);
+	memcpy(&header[263], "00", 2);
+
+	printf(&header[329], "%07o", 0);	/* devmajor */
+	printf(&header[337], "%07o", 0);	/* devminor */
+
+	memset(&header[148], ' ', 8);
+	for (i = 0; i < RECORDSIZE; i++)
+		checksum += header[i];
+	sprintf(&header[148], "%07o", checksum & 0x1fffff);
+
+	write_if_needed();
+}
+
+static void traverse_tree(void *buffer, unsigned long size,
+			  struct path_prefix *prefix)
+{
+	struct path_prefix this_prefix;
+	this_prefix.prev = prefix;
+
+	while (size) {
+		int namelen = strlen(buffer)+1;
+		void *eltbuf;
+		char elttype[20];
+		unsigned long eltsize;
+		unsigned char *sha1 = buffer + namelen;
+		char *path = strchr(buffer, ' ') + 1;
+		unsigned int mode;
+
+		if (size < namelen + 20 || sscanf(buffer, "%o", &mode) != 1)
+			die("corrupt 'tree' file");
+		buffer = sha1 + 20;
+		size -= namelen + 20;
+
+		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
+		if (!eltbuf)
+			die("cannot read %s", sha1_to_hex(sha1));
+		write_header(sha1, basedir, prefix, path, mode, eltsize);
+		if (!strcmp(elttype, "tree")) {
+			this_prefix.name = path;
+			traverse_tree(eltbuf, eltsize, &this_prefix);
+		} else if (!strcmp(elttype, "blob")) {
+			write_blocked(eltbuf, eltsize);
+		}
+		free(eltbuf);
+	}
+}
+
+/* get commit time from committer line of commit object */
+time_t commit_time(const unsigned char *sha1)
+{
+        char type[20];
+        void *buffer;
+        unsigned long size;
+	time_t result = 0;
+
+        buffer = read_sha1_file(sha1, type, &size);
+	if (buffer) {
+		char *p = buffer;
+		while (size > 0) {
+			char *endp = memchr(p, '\n', size);
+			if (!endp || endp == p)
+				break;
+			*endp = '\0';
+			if (endp - p > 10 && !memcmp(p, "committer ", 10)) {
+				char *nump = strrchr(p, '>');
+				if (!nump)
+					break;
+				nump++;
+				result = strtoul(nump, &endp, 10);
+				if (*endp != ' ')
+					result = 0;
+				break;
+			}
+			size -= endp - p - 1;
+			p = endp + 1;
+		}
+		free(buffer);
+	}
+	return result;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1[20];
+	void *buffer;
+	unsigned long size;
+	unsigned char tree_sha1[20];
+
+	switch (argc) {
+	case 3:
+		basedir = argv[2];
+		/* FALLTHROUGH */
+	case 2:
+		if (get_sha1_hex(argv[1], sha1) < 0)
+			usage(tar_tree_usage);
+		break;
+	default:
+		usage(tar_tree_usage);
+	}
+
+	sha1_file_directory = getenv(DB_ENVIRONMENT);
+	if (!sha1_file_directory)
+		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
+
+	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, tree_sha1);
+	if (!buffer)
+		die("unable to read sha1 file");
+	if (memcmp(sha1, tree_sha1, 20))	/* is sha1 a commit object? */
+		archive_time = commit_time(sha1);
+	if (!archive_time)
+		archive_time = time(NULL);
+	if (basedir)
+		write_header("0", NULL, NULL, basedir, 040755, 0);
+	traverse_tree(buffer, size, NULL);
+	free(buffer);
+	write_trailer();
+	return 0;
+}
