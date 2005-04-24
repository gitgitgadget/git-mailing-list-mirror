From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Add archive-tree, a cpio archive creator
Date: Sun, 24 Apr 2005 03:43:46 +0200
Message-ID: <20050424014346.GA23083@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Apr 24 03:40:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPW6L-0004c1-UL
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 03:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVDXBoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 21:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVDXBok
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 21:44:40 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:51900 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262224AbVDXBnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 21:43:49 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id A60DF55E; Sun, 24 Apr 2005 03:43:46 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds archive-tree, a program to create a cpio archive of all
files referenced by a given tree or commit object.  Why cpio and not
e.g., tar?  The cpio format I chose (GNU cpio calls it "odc") is dead
simple compared to any tar variant.  I was simply being lazy. :-P

archive-tree optionally accepts a basedir, i.e. a prefix added to all
names in the archive.  Example usage:

   $ ./archive-tree `tree-id` frob-1.1 | gzip -9 > frob-1.1.cpio.gz

Directory permissions are not handled properly, yet.  All directories
get a mode of (at least) 0755.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

--- git-pasky/Makefile~	2005-04-20 01:43:51.000000000 +0200
+++ git-pasky/Makefile	2005-04-24 02:02:22.000000000 +0200
@@ -29,7 +29,7 @@
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
 	check-files ls-tree merge-base merge-cache unpack-file git-export \
-	diff-cache convert-cache
+	diff-cache convert-cache archive-tree
 
 SCRIPT=	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremote.sh \
 	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
--- /dev/null	2004-12-03 19:50:49.000000000 +0100
+++ git-pasky/archive-tree.c	2005-04-24 03:31:39.000000000 +0200
@@ -0,0 +1,206 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+#include "cache.h"
+
+const char *basedir = NULL;
+
+struct path_prefix {
+	struct path_prefix *prev;
+	const char *name;
+};
+
+static void append_string(char **buffer, const char *s)
+{
+	unsigned int len = strlen(s);
+	memcpy(*buffer, s, len);
+	*buffer += len;
+}
+
+static void append_char(char **buffer, char c)
+{
+	**buffer = c;
+	*buffer += 1;
+}
+
+static unsigned int path_prefix_len(struct path_prefix *prefix)
+{
+	if (!prefix)
+		return 0;
+	return path_prefix_len(prefix->prev) + strlen(prefix->name) + 1;
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
+static unsigned long loopy_write(void *buf, unsigned long size)
+{
+	while (size > 0) {
+		long ret = write(1, buf, size);
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				continue;
+			/* Ignore epipe */
+			if (errno == EPIPE)
+				break;
+			die("archive-tree: %s", strerror(errno));
+		} else if (!ret) {
+			die("archive-tree: disk full?");
+		}
+		size -= ret;
+		buf += ret;
+	}
+	return size;
+}
+
+static long write_header(const char *basepath,
+                         struct path_prefix *prefix,
+                         const char *path,
+                         unsigned int mode,
+                         unsigned long size)
+{
+	unsigned int namelen; 
+	char *header, *p;
+	long ret;
+
+	namelen = path_prefix_len(prefix) + strlen(path) + 1;
+	if (basepath)
+		namelen += strlen(basepath) + 1;
+
+	header = malloc(76 + namelen);
+	if (!header)
+		die("archive-tree: %s", strerror(errno));
+
+	sprintf(header, "%06o%06o%06o%06o%06o%06o%06o%06o%011o%06o%011lo",
+		070707,		/* magic */
+		0,		/* dev */
+		0,		/* ino */
+		S_ISDIR(mode) ? mode | 0755 : mode,	/* mode */ /*FIXME*/
+		0,		/* uid */
+		0,		/* gid */
+		1,		/* nlink */
+		0,		/* rdev */
+		0,		/* mtime */
+		namelen,	/* namesize */
+		S_ISDIR(mode) ? 0 : size);	/* filesize */
+
+	p = header + 76;
+	if (basepath) {
+		append_string(&p, basepath);
+		append_char(&p, '/');
+	}
+	append_path_prefix(&p, prefix);
+	append_string(&p, path);
+	append_char(&p, '\0');
+
+	ret = loopy_write(header, 76 + namelen);
+	free(header);
+	return ret;
+}
+
+static void write_trailer(void)
+{
+	write_header(NULL, NULL, "TRAILER!!!", 0, 0);
+}
+
+static void list_recursive(void *buffer,
+			   const unsigned char *type,
+			   unsigned long size,
+			   struct path_prefix *prefix)
+{
+	struct path_prefix this_prefix;
+	this_prefix.prev = prefix;
+
+	if (strcmp(type, "tree"))
+		die("expected a 'tree' node");
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
+		if (! (eltbuf = read_sha1_file(sha1, elttype, &eltsize)) ) {
+			error("cannot read %s", sha1_to_hex(sha1));
+			continue;
+		}
+
+		if (write_header(basedir, prefix, path, mode, eltsize))
+			die("archive-tree: could not write header");
+
+		if (S_ISDIR(mode)) {
+			this_prefix.name = path;
+			list_recursive(eltbuf, elttype, eltsize, &this_prefix);
+		} else {
+			if (loopy_write(eltbuf, eltsize))
+				die("archive-tree: could not write body");
+		}
+
+		free(eltbuf);
+	}
+}
+
+static int list(unsigned char *sha1)
+{
+	void *buffer;
+	unsigned long size;
+
+	buffer = read_tree_with_tree_or_commit_sha1(sha1, &size, 0);
+	if (!buffer)
+		die("unable to read sha1 file");
+	if (basedir)
+		write_header(NULL, NULL, basedir, 040755, 0);	/*FIXME*/
+	list_recursive(buffer, "tree", size, NULL);
+	free(buffer);
+	return 0;
+}
+
+static const char *archive_tree_usage = "archive-tree <key> [basedir]";
+
+int main(int argc, char **argv)
+{
+	unsigned char sha1[20];
+
+	while (1 < argc && argv[1][0] == '-') {
+		switch (argv[1][1]) {
+		default:
+			usage(archive_tree_usage);
+		}
+		argc--; argv++;
+	}
+
+	switch (argc) {
+		case 3:
+			basedir = argv[2];
+			/* FALLTHROUGH */
+		case 2:
+			if (get_sha1_hex(argv[1], sha1) < 0)
+				usage(archive_tree_usage);
+			break;
+		default:
+			usage(archive_tree_usage);
+	}
+	sha1_file_directory = getenv(DB_ENVIRONMENT);
+	if (!sha1_file_directory)
+		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
+	if (list(sha1) < 0)
+		die("list failed");
+	write_trailer();
+	return 0;
+}
