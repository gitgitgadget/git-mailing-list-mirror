From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Add git-zip-tree
Date: Sat, 26 Aug 2006 23:19:21 +0200
Message-ID: <44F0BAD9.40408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 26 23:19:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH5Yq-00041H-GZ
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 23:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWHZVTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 17:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHZVTV
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 17:19:21 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59817
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750709AbWHZVTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 17:19:20 -0400
Received: from [10.0.1.3] (p508E58D8.dip.t-dialin.net [80.142.88.216])
	by neapel230.server4you.de (Postfix) with ESMTP id 647967034;
	Sat, 26 Aug 2006 23:19:18 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26070>

In the Windows world ZIP files are better supported than tar files.
Windows even includes built-in support for ZIP files nowadays.

git-zip-tree is similar to git-tar-tree; it creates ZIP files out of
git trees.  It stores the commit ID (if available) in a ZIP file comment
which can be extracted by unzip.

There's still quite some room for improvement: this initial version
supports no symlinks, calls write() way too often (three times per file)
and there is no unit test.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

 Documentation/git-zip-tree.txt |   67 +++++++
 Makefile                       |    3
 builtin-zip-tree.c             |  352 +++++++++++++++++++++++++++++++++++++++++
 builtin.h                      |    1
 git.c                          |    1
 5 files changed, 423 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-zip-tree.txt b/Documentation/git-zip-tree.txt
new file mode 100644
index 0000000..2e9d981
--- /dev/null
+++ b/Documentation/git-zip-tree.txt
@@ -0,0 +1,67 @@
+git-zip-tree(1)
+===============
+
+NAME
+----
+git-zip-tree - Creates a ZIP archive of the files in the named tree
+
+
+SYNOPSIS
+--------
+'git-zip-tree' [-0|...|-9] <tree-ish> [ <base> ]
+
+DESCRIPTION
+-----------
+Creates a ZIP archive containing the tree structure for the named tree.
+When <base> is specified it is added as a leading path to the files in the
+generated ZIP archive.
+
+git-zip-tree behaves differently when given a tree ID versus when given
+a commit ID or tag ID.  In the first case the current time is used as
+modification time of each file in the archive.  In the latter case the
+commit time as recorded in the referenced commit object is used instead.
+Additionally the commit ID is stored as an archive comment.
+
+Currently git-zip-tree can handle only files and directories, symbolic
+links are not supported.
+
+OPTIONS
+-------
+
+-0::
+	Store the files instead of deflating them.
+
+-9::
+	Highest and slowest compression level.  You can specify any
+	number from 1 to 9 to adjust compression speed and ratio.
+
+<tree-ish>::
+	The tree or commit to produce ZIP archive for.  If it is
+	the object name of a commit object.
+
+<base>::
+	Leading path to the files in the resulting ZIP archive.
+
+EXAMPLES
+--------
+git zip-tree v1.4.0 git-1.4.0 >git-1.4.0.zip::
+
+	Create a ZIP file for v1.4.0 release.
+
+git zip-tree HEAD:Documentation/ git-docs >docs.zip::
+
+	Put everything in the current head's Documentation/ directory
+	into 'docs.zip', with the prefix 'git-docs/'.
+
+Author
+------
+Written by Rene Scharfe.
+
+Documentation
+--------------
+Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index b15b420..d9741f9 100644
--- a/Makefile
+++ b/Makefile
@@ -292,7 +292,8 @@ BUILTIN_OBJS = \
 	builtin-update-ref.o \
 	builtin-upload-tar.o \
 	builtin-verify-pack.o \
-	builtin-write-tree.o
+	builtin-write-tree.o \
+	builtin-zip-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-zip-tree.c b/builtin-zip-tree.c
new file mode 100644
index 0000000..8dfe421
--- /dev/null
+++ b/builtin-zip-tree.c
@@ -0,0 +1,352 @@
+/*
+ * Copyright (c) 2006 Rene Scharfe
+ */
+#include <time.h>
+#include "cache.h"
+#include "commit.h"
+#include "blob.h"
+#include "tree.h"
+#include "quote.h"
+#include "builtin.h"
+
+static const char zip_tree_usage[] =
+"git-zip-tree [-0|...|-9] <tree-ish> [ <base> ]";
+
+static int zip_date;
+static int zip_time;
+
+static unsigned char *zip_dir;
+static unsigned int zip_dir_size;
+
+static unsigned int zip_offset;
+static unsigned int zip_dir_offset;
+static unsigned int zip_dir_entries;
+
+#define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)
+
+struct zip_local_header {
+	unsigned char magic[4];
+	unsigned char version[2];
+	unsigned char flags[2];
+	unsigned char compression_method[2];
+	unsigned char mtime[2];
+	unsigned char mdate[2];
+	unsigned char crc32[4];
+	unsigned char compressed_size[4];
+	unsigned char size[4];
+	unsigned char filename_length[2];
+	unsigned char extra_length[2];
+};
+
+struct zip_dir_header {
+	unsigned char magic[4];
+	unsigned char creator_version[2];
+	unsigned char version[2];
+	unsigned char flags[2];
+	unsigned char compression_method[2];
+	unsigned char mtime[2];
+	unsigned char mdate[2];
+	unsigned char crc32[4];
+	unsigned char compressed_size[4];
+	unsigned char size[4];
+	unsigned char filename_length[2];
+	unsigned char extra_length[2];
+	unsigned char comment_length[2];
+	unsigned char disk[2];
+	unsigned char attr1[2];
+	unsigned char attr2[4];
+	unsigned char offset[4];
+};
+
+struct zip_dir_trailer {
+	unsigned char magic[4];
+	unsigned char disk[2];
+	unsigned char directory_start_disk[2];
+	unsigned char entries_on_this_disk[2];
+	unsigned char entries[2];
+	unsigned char size[4];
+	unsigned char offset[4];
+	unsigned char comment_length[2];
+};
+
+static void copy_le16(unsigned char *dest, unsigned int n)
+{
+	dest[0] = 0xff & n;
+	dest[1] = 0xff & (n >> 010);
+}
+
+static void copy_le32(unsigned char *dest, unsigned int n)
+{
+	dest[0] = 0xff & n;
+	dest[1] = 0xff & (n >> 010);
+	dest[2] = 0xff & (n >> 020);
+	dest[3] = 0xff & (n >> 030);
+}
+
+static void *zlib_deflate(void *data, unsigned long size,
+                          unsigned long *compressed_size)
+{
+	z_stream stream;
+	unsigned long maxsize;
+	void *buffer;
+	int result;
+
+	memset(&stream, 0, sizeof(stream));
+	deflateInit(&stream, zlib_compression_level);
+	maxsize = deflateBound(&stream, size);
+	buffer = xmalloc(maxsize);
+
+	stream.next_in = data;
+	stream.avail_in = size;
+	stream.next_out = buffer;
+	stream.avail_out = maxsize;
+
+	do {
+		result = deflate(&stream, Z_FINISH);
+	} while (result == Z_OK);
+
+	if (result != Z_STREAM_END) {
+		free(buffer);
+		return NULL;
+	}
+
+	deflateEnd(&stream);
+	*compressed_size = stream.total_out;
+
+	return buffer;
+}
+
+static char *construct_path(const char *base, int baselen,
+                            const char *filename, int isdir, int *pathlen)
+{
+	int filenamelen = strlen(filename);
+	int len = baselen + filenamelen;
+	char *path, *p;
+
+	if (isdir)
+		len++;
+	p = path = xmalloc(len + 1);
+
+	memcpy(p, base, baselen);
+	p += baselen;
+	memcpy(p, filename, filenamelen);
+	p += filenamelen;
+	if (isdir)
+		*p++ = '/';
+	*p = '\0';
+
+	*pathlen = len;
+
+	return path;
+}
+
+static int write_zip_entry(const unsigned char *sha1,
+                           const char *base, int baselen,
+                           const char *filename, unsigned mode, int stage)
+{
+	struct zip_local_header header;
+	struct zip_dir_header dirent;
+	unsigned long compressed_size;
+	unsigned long uncompressed_size;
+	unsigned long crc;
+	unsigned long direntsize;
+	unsigned long size;
+	int method;
+	int result = -1;
+	int pathlen;
+	unsigned char *out;
+	char *path;
+	char type[20];
+	void *buffer = NULL;
+	void *deflated = NULL;
+
+	crc = crc32(0, Z_NULL, 0);
+
+	path = construct_path(base, baselen, filename, S_ISDIR(mode), &pathlen);
+	if (pathlen > 0xffff) {
+		error("path too long (%d chars, SHA1: %s): %s", pathlen,
+		      sha1_to_hex(sha1), path);
+		goto out;
+	}
+
+	if (S_ISDIR(mode)) {
+		method = 0;
+		result = READ_TREE_RECURSIVE;
+		out = NULL;
+		uncompressed_size = 0;
+		compressed_size = 0;
+	} else if (S_ISREG(mode)) {
+		method = zlib_compression_level == 0 ? 0 : 8;
+		result = 0;
+		buffer = read_sha1_file(sha1, type, &size);
+		if (!buffer)
+			die("cannot read %s", sha1_to_hex(sha1));
+		crc = crc32(crc, buffer, size);
+		out = buffer;
+		uncompressed_size = size;
+		compressed_size = size;
+	} else {
+		error("unsupported file mode: 0%o (SHA1: %s)", mode,
+		      sha1_to_hex(sha1));
+		goto out;
+	}
+
+	if (method == 8) {
+		deflated = zlib_deflate(buffer, size, &compressed_size);
+		if (deflated && compressed_size - 6 < size) {
+			/* ZLIB --> raw compressed data (see RFC 1950) */
+			out = deflated + 2;	/* CMF and FLG ... */
+			compressed_size -= 6;	/* ... and ADLER32 */
+		} else {
+			method = 0;
+			compressed_size = size;
+		}
+	}
+
+	/* make sure we have enough free space in the dictionary */
+	direntsize = sizeof(struct zip_dir_header) + pathlen;
+	while (zip_dir_size < zip_dir_offset + direntsize) {
+		zip_dir_size += ZIP_DIRECTORY_MIN_SIZE;
+		zip_dir = xrealloc(zip_dir, zip_dir_size);
+	}
+
+	copy_le32(dirent.magic, 0x02014b50);
+	copy_le16(dirent.creator_version, 0);
+	copy_le16(dirent.version, 20);
+	copy_le16(dirent.flags, 0);
+	copy_le16(dirent.compression_method, method);
+	copy_le16(dirent.mtime, zip_time);
+	copy_le16(dirent.mdate, zip_date);
+	copy_le32(dirent.crc32, crc);
+	copy_le32(dirent.compressed_size, compressed_size);
+	copy_le32(dirent.size, uncompressed_size);
+	copy_le16(dirent.filename_length, pathlen);
+	copy_le16(dirent.extra_length, 0);
+	copy_le16(dirent.comment_length, 0);
+	copy_le16(dirent.disk, 0);
+	copy_le16(dirent.attr1, 0);
+	copy_le32(dirent.attr2, 0);
+	copy_le32(dirent.offset, zip_offset);
+	memcpy(zip_dir + zip_dir_offset, &dirent, sizeof(struct zip_dir_header));
+	zip_dir_offset += sizeof(struct zip_dir_header);
+	memcpy(zip_dir + zip_dir_offset, path, pathlen);
+	zip_dir_offset += pathlen;
+	zip_dir_entries++;
+
+	copy_le32(header.magic, 0x04034b50);
+	copy_le16(header.version, 20);
+	copy_le16(header.flags, 0);
+	copy_le16(header.compression_method, method);
+	copy_le16(header.mtime, zip_time);
+	copy_le16(header.mdate, zip_date);
+	copy_le32(header.crc32, crc);
+	copy_le32(header.compressed_size, compressed_size);
+	copy_le32(header.size, uncompressed_size);
+	copy_le16(header.filename_length, pathlen);
+	copy_le16(header.extra_length, 0);
+	write_or_die(1, &header, sizeof(struct zip_local_header));
+	zip_offset += sizeof(struct zip_local_header);
+	write_or_die(1, path, pathlen);
+	zip_offset += pathlen;
+	if (compressed_size > 0) {
+		write_or_die(1, out, compressed_size);
+		zip_offset += compressed_size;
+	}
+
+out:
+	free(buffer);
+	free(deflated);
+	free(path);
+
+	return result;
+}
+
+static void write_zip_trailer(const unsigned char *sha1)
+{
+	struct zip_dir_trailer trailer;
+
+	copy_le32(trailer.magic, 0x06054b50);
+	copy_le16(trailer.disk, 0);
+	copy_le16(trailer.directory_start_disk, 0);
+	copy_le16(trailer.entries_on_this_disk, zip_dir_entries);
+	copy_le16(trailer.entries, zip_dir_entries);
+	copy_le32(trailer.size, zip_dir_offset);
+	copy_le32(trailer.offset, zip_offset);
+	copy_le16(trailer.comment_length, sha1 ? 40 : 0);
+
+	write_or_die(1, zip_dir, zip_dir_offset);
+	write_or_die(1, &trailer, sizeof(struct zip_dir_trailer));
+	if (sha1)
+		write_or_die(1, sha1_to_hex(sha1), 40);
+}
+
+static void dos_time(time_t *time, int *dos_date, int *dos_time)
+{
+	struct tm *t = localtime(time);
+
+	*dos_date = t->tm_mday + (t->tm_mon + 1) * 32 +
+	            (t->tm_year + 1900 - 1980) * 512;
+	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
+}
+
+int cmd_zip_tree(int argc, const char **argv, const char *prefix)
+{
+	unsigned char sha1[20];
+	struct tree *tree;
+	struct commit *commit;
+	time_t archive_time;
+	char *base;
+	int baselen;
+
+	git_config(git_default_config);
+
+	if (argc > 1 && argv[1][0] == '-') {
+		if (isdigit(argv[1][1]) && argv[1][2] == '\0') {
+			zlib_compression_level = argv[1][1] - '0';
+			argc--;
+			argv++;
+		}
+	}
+
+	switch (argc) {
+	case 3:
+		base = strdup(argv[2]);
+		baselen = strlen(base);
+		break;
+	case 2:
+		base = strdup("");
+		baselen = 0;
+		break;
+	default:
+		usage(zip_tree_usage);
+	}
+
+	if (get_sha1(argv[1], sha1))
+		die("Not a valid object name %s", argv[1]);
+
+	commit = lookup_commit_reference_gently(sha1, 1);
+	archive_time = commit ? commit->date : time(NULL);
+	dos_time(&archive_time, &zip_date, &zip_time);
+
+	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
+	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
+
+	tree = parse_tree_indirect(sha1);
+	if (!tree)
+		die("not a tree object");
+
+	if (baselen > 0) {
+		write_zip_entry(tree->object.sha1, "", 0, base, 040777, 0);
+		base = xrealloc(base, baselen + 1);
+		base[baselen] = '/';
+		baselen++;
+		base[baselen] = '\0';
+	}
+	read_tree_recursive(tree, base, baselen, 0, NULL, write_zip_entry);
+	write_zip_trailer(commit ? commit->object.sha1 : NULL);
+
+	free(zip_dir);
+	free(base);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index ade58c4..25431d7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -52,6 +52,7 @@ extern int cmd_show(int argc, const char
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_zip_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index a01d195..ded89fb 100644
--- a/git.c
+++ b/git.c
@@ -263,6 +263,7 @@ static void handle_internal_command(int 
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree, RUN_SETUP },
+		{ "zip-tree", cmd_zip_tree, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
