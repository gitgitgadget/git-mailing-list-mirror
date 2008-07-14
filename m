From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/6] archive: centralize archive entry writing
Date: Mon, 14 Jul 2008 21:22:24 +0200
Message-ID: <487BA770.2000703@lsrfire.ath.cx>
References: <487B92FC.5030103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:36:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITql-0001Bx-Ki
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbYGNTfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754935AbYGNTf2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:35:28 -0400
Received: from india601.server4you.de ([85.25.151.105]:45940 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbYGNTfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:35:10 -0400
Received: from [10.0.1.200] (p57B7FF09.dip.t-dialin.net [87.183.255.9])
	by india601.server4you.de (Postfix) with ESMTPSA id 8084B2F81F0;
	Mon, 14 Jul 2008 21:24:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <487B92FC.5030103@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88460>

Add the exported function write_archive_entries() to archive.c, which uses
the new ability of read_tree_recursive() to pass a context pointer to its
callback in order to centralize previously duplicated code.

The new callback function write_archive_entry() does the work that every
archiver backend needs to do: loading file contents, entering subdirectories,
handling file attributes, constructing the full path of the entry.  All that
done, it calls the backend specific write_archive_entry_fn_t function.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c     |   77 ++++++++++++++++++++++++++++++++++++++
 archive.h     |    4 ++
 archive-tar.c |  116 ++++++++++++++++++--------------------------------------
 archive-zip.c |   90 +++++++-------------------------------------
 4 files changed, 133 insertions(+), 154 deletions(-)

diff --git a/archive.c b/archive.c
index 6502b76..58de55e 100644
--- a/archive.c
+++ b/archive.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "attr.h"
+#include "archive.h"
 
 static void format_subst(const struct commit *commit,
                          const char *src, size_t len,
@@ -95,3 +96,79 @@ int is_archive_path_ignored(const char *path)
 		return 0;
 	return ATTR_TRUE(check[0].value);
 }
+
+struct archiver_context {
+	struct archiver_args *args;
+	write_archive_entry_fn_t write_entry;
+};
+
+static int write_archive_entry(const unsigned char *sha1, const char *base,
+		int baselen, const char *filename, unsigned mode, int stage,
+		void *context)
+{
+	static struct strbuf path = STRBUF_INIT;
+	struct archiver_context *c = context;
+	struct archiver_args *args = c->args;
+	write_archive_entry_fn_t write_entry = c->write_entry;
+	int err;
+	enum object_type type;
+	unsigned long size;
+	void *buffer;
+
+	strbuf_reset(&path);
+	strbuf_grow(&path, PATH_MAX);
+	strbuf_add(&path, base, baselen);
+	strbuf_addstr(&path, filename);
+
+	if (is_archive_path_ignored(path.buf + args->baselen))
+		return 0;
+
+	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
+		strbuf_addch(&path, '/');
+		if (args->verbose)
+			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
+		err = write_entry(args, sha1, path.buf, path.len, mode, NULL, 0);
+		if (err)
+			return err;
+		return READ_TREE_RECURSIVE;
+	}
+
+	buffer = sha1_file_to_archive(path.buf + args->baselen, sha1, mode,
+			&type, &size, args->commit);
+	if (!buffer)
+		return error("cannot read %s", sha1_to_hex(sha1));
+	if (args->verbose)
+		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
+	err = write_entry(args, sha1, path.buf, path.len, mode, buffer, size);
+	free(buffer);
+	return err;
+}
+
+int write_archive_entries(struct archiver_args *args,
+		write_archive_entry_fn_t write_entry)
+{
+	struct archiver_context context;
+	int err;
+
+	if (args->baselen > 0 && args->base[args->baselen - 1] == '/') {
+		size_t len = args->baselen;
+
+		while (len > 1 && args->base[len - 2] == '/')
+			len--;
+		if (args->verbose)
+			fprintf(stderr, "%.*s\n", (int)len, args->base);
+		err = write_entry(args, args->tree->object.sha1, args->base,
+				len, 040777, NULL, 0);
+		if (err)
+			return err;
+	}
+
+	context.args = args;
+	context.write_entry = write_entry;
+
+	err =  read_tree_recursive(args->tree, args->base, args->baselen, 0,
+			args->pathspec, write_archive_entry, &context);
+	if (err == READ_TREE_RECURSIVE)
+		err = 0;
+	return err;
+}
diff --git a/archive.h b/archive.h
index 34151f4..4e44549 100644
--- a/archive.h
+++ b/archive.h
@@ -20,6 +20,8 @@ typedef int (*write_archive_fn_t)(struct archiver_args *);
 
 typedef void *(*parse_extra_args_fn_t)(int argc, const char **argv);
 
+typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsigned char *sha1, const char *path, size_t pathlen, unsigned int mode, void *buffer, unsigned long size);
+
 struct archiver {
 	const char *name;
 	write_archive_fn_t write_archive;
@@ -44,4 +46,6 @@ extern void *parse_extra_zip_args(int argc, const char **argv);
 extern void *sha1_file_to_archive(const char *path, const unsigned char *sha1, unsigned int mode, enum object_type *type, unsigned long *size, const struct commit *commit);
 extern int is_archive_path_ignored(const char *path);
 
+extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
+
 #endif	/* ARCHIVE_H */
diff --git a/archive-tar.c b/archive-tar.c
index 63cc2ec..f9eb726 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -13,11 +13,7 @@
 static char block[BLOCKSIZE];
 static unsigned long offset;
 
-static time_t archive_time;
 static int tar_umask = 002;
-static int verbose;
-static const struct commit *commit;
-static size_t base_len;
 
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
@@ -114,22 +110,24 @@ static unsigned int ustar_header_chksum(const struct ustar_header *header)
 	return chksum;
 }
 
-static int get_path_prefix(const struct strbuf *path, int maxlen)
+static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 {
-	int i = path->len;
+	size_t i = pathlen;
 	if (i > maxlen)
 		i = maxlen;
 	do {
 		i--;
-	} while (i > 0 && path->buf[i] != '/');
+	} while (i > 0 && path[i] != '/');
 	return i;
 }
 
-static void write_entry(const unsigned char *sha1, struct strbuf *path,
-                        unsigned int mode, void *buffer, unsigned long size)
+static int write_tar_entry(struct archiver_args *args,
+		const unsigned char *sha1, const char *path, size_t pathlen,
+		unsigned int mode, void *buffer, unsigned long size)
 {
 	struct ustar_header header;
 	struct strbuf ext_header;
+	int err = 0;
 
 	memset(&header, 0, sizeof(header));
 	strbuf_init(&ext_header, 0);
@@ -143,8 +141,6 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 		mode = 0100666;
 		sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
 	} else {
-		if (verbose)
-			fprintf(stderr, "%.*s\n", (int)path->len, path->buf);
 		if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 			*header.typeflag = TYPEFLAG_DIR;
 			mode = (mode | 0777) & ~tar_umask;
@@ -155,24 +151,24 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 			*header.typeflag = TYPEFLAG_REG;
 			mode = (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
 		} else {
-			error("unsupported file mode: 0%o (SHA1: %s)",
-			      mode, sha1_to_hex(sha1));
-			return;
+			return error("unsupported file mode: 0%o (SHA1: %s)",
+					mode, sha1_to_hex(sha1));
 		}
-		if (path->len > sizeof(header.name)) {
-			int plen = get_path_prefix(path, sizeof(header.prefix));
-			int rest = path->len - plen - 1;
+		if (pathlen > sizeof(header.name)) {
+			size_t plen = get_path_prefix(path, pathlen,
+					sizeof(header.prefix));
+			size_t rest = pathlen - plen - 1;
 			if (plen > 0 && rest <= sizeof(header.name)) {
-				memcpy(header.prefix, path->buf, plen);
-				memcpy(header.name, path->buf + plen + 1, rest);
+				memcpy(header.prefix, path, plen);
+				memcpy(header.name, path + plen + 1, rest);
 			} else {
 				sprintf(header.name, "%s.data",
 				        sha1_to_hex(sha1));
 				strbuf_append_ext_header(&ext_header, "path",
-				                         path->buf, path->len);
+						path, pathlen);
 			}
 		} else
-			memcpy(header.name, path->buf, path->len);
+			memcpy(header.name, path, pathlen);
 	}
 
 	if (S_ISLNK(mode) && buffer) {
@@ -187,7 +183,7 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 
 	sprintf(header.mode, "%07o", mode & 07777);
 	sprintf(header.size, "%011lo", S_ISREG(mode) ? size : 0);
-	sprintf(header.mtime, "%011lo", archive_time);
+	sprintf(header.mtime, "%011lo", args->time);
 
 	sprintf(header.uid, "%07o", 0);
 	sprintf(header.gid, "%07o", 0);
@@ -202,22 +198,30 @@ static void write_entry(const unsigned char *sha1, struct strbuf *path,
 	sprintf(header.chksum, "%07o", ustar_header_chksum(&header));
 
 	if (ext_header.len > 0) {
-		write_entry(sha1, NULL, 0, ext_header.buf, ext_header.len);
+		err = write_tar_entry(args, sha1, NULL, 0, 0, ext_header.buf,
+				ext_header.len);
+		if (err)
+			return err;
 	}
 	strbuf_release(&ext_header);
 	write_blocked(&header, sizeof(header));
 	if (S_ISREG(mode) && buffer && size > 0)
 		write_blocked(buffer, size);
+	return err;
 }
 
-static void write_global_extended_header(const unsigned char *sha1)
+static int write_global_extended_header(struct archiver_args *args)
 {
+	const unsigned char *sha1 = args->commit_sha1;
 	struct strbuf ext_header;
+	int err;
 
 	strbuf_init(&ext_header, 0);
 	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
-	write_entry(NULL, NULL, 0, ext_header.buf, ext_header.len);
+	err = write_tar_entry(args, NULL, NULL, 0, 0, ext_header.buf,
+			ext_header.len);
 	strbuf_release(&ext_header);
+	return err;
 }
 
 static int git_tar_config(const char *var, const char *value, void *cb)
@@ -234,63 +238,17 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int write_tar_entry(const unsigned char *sha1, const char *base,
-		int baselen, const char *filename, unsigned mode, int stage,
-		void *context)
-{
-	static struct strbuf path = STRBUF_INIT;
-	void *buffer;
-	enum object_type type;
-	unsigned long size;
-
-	strbuf_reset(&path);
-	strbuf_grow(&path, PATH_MAX);
-	strbuf_add(&path, base, baselen);
-	strbuf_addstr(&path, filename);
-	if (is_archive_path_ignored(path.buf + base_len))
-		return 0;
-	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-		strbuf_addch(&path, '/');
-		buffer = NULL;
-		size = 0;
-	} else {
-		buffer = sha1_file_to_archive(path.buf + base_len, sha1, mode,
-				&type, &size, commit);
-		if (!buffer)
-			die("cannot read %s", sha1_to_hex(sha1));
-	}
-
-	write_entry(sha1, &path, mode, buffer, size);
-	free(buffer);
-
-	return READ_TREE_RECURSIVE;
-}
-
 int write_tar_archive(struct archiver_args *args)
 {
-	git_config(git_tar_config, NULL);
+	int err = 0;
 
-	archive_time = args->time;
-	verbose = args->verbose;
-	commit = args->commit;
-	base_len = args->baselen;
+	git_config(git_tar_config, NULL);
 
 	if (args->commit_sha1)
-		write_global_extended_header(args->commit_sha1);
-
-	if (args->baselen > 0 && args->base[args->baselen - 1] == '/') {
-		char *base = xstrdup(args->base);
-		int baselen = strlen(base);
-
-		while (baselen > 0 && base[baselen - 1] == '/')
-			base[--baselen] = '\0';
-		write_tar_entry(args->tree->object.sha1, "", 0, base, 040777,
-				0, NULL);
-		free(base);
-	}
-	read_tree_recursive(args->tree, args->base, args->baselen, 0,
-			    args->pathspec, write_tar_entry, NULL);
-	write_trailer();
-
-	return 0;
+		err = write_global_extended_header(args);
+	if (!err)
+		err = write_archive_entries(args, write_tar_entry);
+	if (!err)
+		write_trailer();
+	return err;
 }
diff --git a/archive-zip.c b/archive-zip.c
index d18254c..8131289 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -9,11 +9,8 @@
 #include "builtin.h"
 #include "archive.h"
 
-static int verbose;
 static int zip_date;
 static int zip_time;
-static const struct commit *commit;
-static size_t base_len;
 
 static unsigned char *zip_dir;
 static unsigned int zip_dir_size;
@@ -128,33 +125,9 @@ static void *zlib_deflate(void *data, unsigned long size,
 	return buffer;
 }
 
-static char *construct_path(const char *base, int baselen,
-                            const char *filename, int isdir, int *pathlen)
-{
-	int filenamelen = strlen(filename);
-	int len = baselen + filenamelen;
-	char *path, *p;
-
-	if (isdir)
-		len++;
-	p = path = xmalloc(len + 1);
-
-	memcpy(p, base, baselen);
-	p += baselen;
-	memcpy(p, filename, filenamelen);
-	p += filenamelen;
-	if (isdir)
-		*p++ = '/';
-	*p = '\0';
-
-	*pathlen = len;
-
-	return path;
-}
-
-static int write_zip_entry(const unsigned char *sha1, const char *base,
-		int baselen, const char *filename, unsigned mode, int stage,
-		void *context)
+static int write_zip_entry(struct archiver_args *args,
+		const unsigned char *sha1, const char *path, size_t pathlen,
+		unsigned int mode, void *buffer, unsigned long size)
 {
 	struct zip_local_header header;
 	struct zip_dir_header dirent;
@@ -163,33 +136,20 @@ static int write_zip_entry(const unsigned char *sha1, const char *base,
 	unsigned long uncompressed_size;
 	unsigned long crc;
 	unsigned long direntsize;
-	unsigned long size;
 	int method;
-	int result = -1;
-	int pathlen;
 	unsigned char *out;
-	char *path;
-	enum object_type type;
-	void *buffer = NULL;
 	void *deflated = NULL;
 
 	crc = crc32(0, NULL, 0);
 
-	path = construct_path(base, baselen, filename, S_ISDIR(mode), &pathlen);
-	if (is_archive_path_ignored(path + base_len))
-		return 0;
-	if (verbose)
-		fprintf(stderr, "%s\n", path);
 	if (pathlen > 0xffff) {
-		error("path too long (%d chars, SHA1: %s): %s", pathlen,
-		      sha1_to_hex(sha1), path);
-		goto out;
+		return error("path too long (%d chars, SHA1: %s): %s",
+				(int)pathlen, sha1_to_hex(sha1), path);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		method = 0;
 		attr2 = 16;
-		result = (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 		out = NULL;
 		uncompressed_size = 0;
 		compressed_size = 0;
@@ -199,19 +159,13 @@ static int write_zip_entry(const unsigned char *sha1, const char *base,
 			(mode & 0111) ? ((mode) << 16) : 0;
 		if (S_ISREG(mode) && zlib_compression_level != 0)
 			method = 8;
-		result = 0;
-		buffer = sha1_file_to_archive(path + base_len, sha1, mode,
-				&type, &size, commit);
-		if (!buffer)
-			die("cannot read %s", sha1_to_hex(sha1));
 		crc = crc32(crc, buffer, size);
 		out = buffer;
 		uncompressed_size = size;
 		compressed_size = size;
 	} else {
-		error("unsupported file mode: 0%o (SHA1: %s)", mode,
-		      sha1_to_hex(sha1));
-		goto out;
+		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
+				sha1_to_hex(sha1));
 	}
 
 	if (method == 8) {
@@ -278,12 +232,9 @@ static int write_zip_entry(const unsigned char *sha1, const char *base,
 		zip_offset += compressed_size;
 	}
 
-out:
-	free(buffer);
 	free(deflated);
-	free(path);
 
-	return result;
+	return 0;
 }
 
 static void write_zip_trailer(const unsigned char *sha1)
@@ -316,31 +267,20 @@ static void dos_time(time_t *time, int *dos_date, int *dos_time)
 
 int write_zip_archive(struct archiver_args *args)
 {
+	int err;
+
 	dos_time(&args->time, &zip_date, &zip_time);
 
 	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
 	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
-	verbose = args->verbose;
-	commit = args->commit;
-	base_len = args->baselen;
-
-	if (args->baselen > 0 && args->base[args->baselen - 1] == '/') {
-		char *base = xstrdup(args->base);
-		int baselen = strlen(base);
-
-		while (baselen > 0 && base[baselen - 1] == '/')
-			base[--baselen] = '\0';
-		write_zip_entry(args->tree->object.sha1, "", 0, base, 040777,
-				0, NULL);
-		free(base);
-	}
-	read_tree_recursive(args->tree, args->base, args->baselen, 0,
-			    args->pathspec, write_zip_entry, NULL);
-	write_zip_trailer(args->commit_sha1);
+
+	err = write_archive_entries(args, write_zip_entry);
+	if (!err)
+		write_zip_trailer(args->commit_sha1);
 
 	free(zip_dir);
 
-	return 0;
+	return err;
 }
 
 void *parse_extra_zip_args(int argc, const char **argv)
-- 
1.5.6.2.212.g08b51
