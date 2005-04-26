From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] GIT: Create tar archives of tree on the fly
Date: Tue, 26 Apr 2005 16:42:23 +0200
Message-ID: <20050426144222.GA12035@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 16:39:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQRCo-0007P0-7S
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 16:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDZOnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 10:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVDZOnm
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 10:43:42 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:10894 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261575AbVDZOm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 10:42:26 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 105E422E; Tue, 26 Apr 2005 16:42:23 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch introduces tar-tree, a tool to generate tar archives out of
git repositories.  Basically I took ls-tree and cat-file and melted them
together.  That means tar-tree doesn't create any temporary files, it
just streams out the archive as it goes.

This could be useful for the web interface(s) to provide a downloadable
tarball for any commit or tree object.  For bigger repositories like the
Linux kernel caching the resulting files might be a good idea,
though. :-P

On my machine it's also a bit faster than directly tarring up the
checked out files.  I only ran a few basic checks to make sure the
performance is in the same ballpark, YMMV.

Example usage:

  $ tar-tree a2755a80f40e5794ddc20e00f781af9d6320fafb linux-2.6.12-rc3 |
        bzip2 -9 > linux-2.6.12-rc3.tar.bz2

tar-tree accepts tree IDs and commit IDs.  In the former case all files
within the archive get the current time set as mtime.  Given a commit ID
tar-tree tries to figure out the commit date and sets mtime of all files
to that instead.

Currently the size of a file within the created archive is limited to
2^33-1.  This could be fixed easily within the archive format (with a
Pax extended header), but size is unsigned long throughout GIT, so this
would need to be fixed first.  OTOH I think putting 4GB+ files into a
GIT archive is insane anyway. :]

Path names are limited to 500 characters at the moment.  This can be
stretched if the need should arise.

Patch is against d1df5743809614241883ecad51876607cf432034.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff -Nur a/Makefile b/Makefile
--- a/Makefile	2005-04-26 03:26:45.000000000 +0200
+++ b/Makefile	2005-04-26 08:09:03.000000000 +0200
@@ -18,7 +18,7 @@
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
 	check-files ls-tree merge-base merge-cache unpack-file git-export \
 	diff-cache convert-cache http-pull rpush rpull rev-list git-mktag \
-	diff-tree-helper
+	diff-tree-helper tar-tree
 
 all: $(PROG)
 
diff -Nur a/tar-tree.c b/tar-tree.c
--- a/tar-tree.c	1970-01-01 01:00:00.000000000 +0100
+++ b/tar-tree.c	2005-04-26 08:23:05.000000000 +0200
@@ -0,0 +1,328 @@
+#include <time.h>
+#include "cache.h"
+
+static const char *tar_tree_usage = "tar-tree <key> [basedir]";
+static const char *basedir;
+static time_t archive_time;
+
+struct path_prefix {
+	struct path_prefix *prev;
+	const char *name;
+};
+
+static unsigned long write_out(void *buf, unsigned long size)
+{
+	while (size > 0) {
+		long ret = write(1, buf, size);
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				continue;
+			/* Ignore epipe */
+			if (errno == EPIPE)
+				break;
+			die("tar-tree: %s", strerror(errno));
+		} else if (!ret) {
+			die("tar-tree: disk full?");
+		}
+		size -= ret;
+		buf += ret;
+	}
+	return size;
+}
+
+static unsigned long write_block(void *buf, unsigned long size)
+{
+	unsigned long ret = write_out(buf, size);
+	if (!ret) {
+		unsigned long slack = 512 - size % 512;
+		if (slack % 512) {
+			char padding[511];
+			memset(padding, 0, slack);
+			ret = write_out(padding, slack);
+		}
+	}
+	return ret;
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
+			struct path_prefix *prefix, const char *path)
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
+			     struct path_prefix *prefix, const char *path)
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
+static void append_extended_header_prefix(char **p, const char *keyword,
+					  int valuelen)
+{
+	int reclen = 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
+	if (reclen > 9)
+		reclen++;
+	if (reclen > 99)
+		reclen++;
+	if (reclen > 512)
+		die("tar-tree: extended header too big, wtf?");
+	append_long(p, reclen);
+	append_char(p, ' ');
+	append_string(p, keyword);
+	append_char(p, '=');
+}
+
+static long write_header(const char *, const char *, struct path_prefix *,
+			 const char *, unsigned int, unsigned long);
+
+static long write_extended_header(const char *headerfilename, int is_dir,
+				  const char *basepath,
+				  struct path_prefix *prefix,
+				  const char *path, unsigned int namelen)
+{
+	char records[512], *p;
+	unsigned long ret;
+
+	memset(records, 0, sizeof(records));
+	p = records;
+	append_extended_header_prefix(&p, "path", namelen);
+	append_path(&p, is_dir, basepath, prefix, path);
+	append_char(&p, '\n');
+	ret = write_header(NULL, NULL, NULL, headerfilename, 0100600,
+	                   p - records);
+	if (!ret)
+		ret = write_out(records, sizeof(records));
+	return ret;
+}
+
+static long write_header(const char *sha1, const char *basepath,
+			 struct path_prefix *prefix, const char *path,
+			 unsigned int mode, unsigned long size)
+{
+	unsigned int namelen; 
+	char *p, header[512];
+	unsigned int checksum = 0;
+	int i;
+
+	memset(header, 0, sizeof(header));
+
+	namelen = path_len(S_ISDIR(mode), basepath, prefix, path);
+	if (namelen > 500) {
+		fprintf(stderr, "tar-tree: name too log of object %s\n",
+		        sha1_to_hex(sha1));
+		return size;
+	} else if (namelen > 100) {
+		unsigned long ret;
+		char *sha1_hex = sha1_to_hex(sha1);
+		char headerfilename[51];
+
+		sprintf(header, "%s.data", sha1_hex);
+		sprintf(headerfilename, "%s.paxheader", sha1_hex);
+		ret = write_extended_header(headerfilename, S_ISDIR(mode),
+		                            basepath, prefix, path, namelen);
+		if (ret)
+			return ret;
+	} else {
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
+	strcpy(&header[257], "ustar");
+	strcpy(&header[263], "00");
+
+	printf(&header[329], "%07o", 0);	/* devmajor */
+	printf(&header[337], "%07o", 0);	/* devminor */
+
+	memset(&header[148], ' ', 8);
+	for (i = 0; i < sizeof(header); i++)
+		checksum += header[i];
+	sprintf(&header[148], "%07o", checksum & 0x1fffff);
+
+	return write_out(header, sizeof(header));
+}
+
+static unsigned long write_trailer(void)
+{
+	char block[1024];
+	memset(block, 0, sizeof(block));
+	return write_out(block, sizeof(block));
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
+		if (!eltbuf) {
+			error("cannot read %s", sha1_to_hex(sha1));
+			continue;
+		}
+		if (write_header(sha1, basedir, prefix, path, mode, eltsize))
+			exit(0);
+		if (!strcmp(elttype, "tree")) {
+			this_prefix.name = path;
+			traverse_tree(eltbuf, eltsize, &this_prefix);
+		} else if (!strcmp(elttype, "blob")) {
+			if (write_block(eltbuf, eltsize))
+				exit(0);
+		}
+		free(eltbuf);
+	}
+}
+
+time_t commit_time(const unsigned char *sha1)
+{
+	char type[20];
+	void *buffer;
+	unsigned long size;
+	time_t result = 0;
+
+	buffer = read_sha1_file(sha1, type, &size);
+	if (buffer) {
+		char *p = buffer;
+		while (size > 0) {
+			char *endp = memchr(p, '\n', size);
+			if (!endp)
+				break;
+			*endp = '\0';
+			if (endp - p > 10 && !memcmp(p, "committer ", 10)) {
+				char *nump = strrchr(p, ' ');
+				if (!nump)
+					break;
+				*nump = '\0';
+				nump = strrchr(p, ' ');
+				if (!nump)
+					break;
+				result = strtoul(nump, &endp, 10);
+				if (*endp != '\0')
+					result = 0;
+				break;
+			}
+			size -= endp - p - 1;
+			p = endp + 1;
+		}
+	}
+	free(buffer);
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
