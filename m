From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 3/8] Builtin git-tar-tree.
Date: Tue, 23 May 2006 10:31:15 +0200
Message-ID: <26427.9620176696$1148373114@news.gmane.org>
References: <11483730803527-git-send-email->
Reply-To: Patches/0001-Builtin-git-ls-files.txt@bohr.gbar.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 10:31:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiSIc-0001bZ-PB
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWEWIbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWEWIbZ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:31:25 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:54507 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932118AbWEWIbW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 04:31:22 -0400
Received: (qmail 8461 invoked by uid 5842); 23 May 2006 10:31:20 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483730803527-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20583>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

9860ed2d4a598ad100c3b4f6b07dd0a88a4547a6
 Makefile           |    8 +
 builtin-tar-tree.c |  351 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h          |    1 
 git.c              |    3 
 tar-tree.c         |  350 ----------------------------------------------------
 5 files changed, 359 insertions(+), 354 deletions(-)
 create mode 100644 builtin-tar-tree.c
 delete mode 100644 tar-tree.c

9860ed2d4a598ad100c3b4f6b07dd0a88a4547a6
diff --git a/Makefile b/Makefile
index 9b02264..966f7ee 100644
--- a/Makefile
+++ b/Makefile
@@ -161,7 +161,7 @@ PROGRAMS = \
 	git-receive-pack$X git-rev-parse$X \
 	git-send-pack$X git-show-branch$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
-	git-ssh-upload$X git-tar-tree$X git-unpack-file$X \
+	git-ssh-upload$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X \
@@ -171,7 +171,8 @@ PROGRAMS = \
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-rev-list$X git-check-ref-format$X \
-	git-init-db$X git-ls-files$X git-ls-tree$X
+	git-init-db$X git-ls-files$X git-ls-tree$X \
+	git-tar-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -220,7 +221,8 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
-	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o
+	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
+        builtin-tar-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
new file mode 100644
index 0000000..6ada04c
--- /dev/null
+++ b/builtin-tar-tree.c
@@ -0,0 +1,351 @@
+/*
+ * Copyright (c) 2005, 2006 Rene Scharfe
+ */
+#include <time.h>
+#include "cache.h"
+#include "tree-walk.h"
+#include "commit.h"
+#include "strbuf.h"
+#include "tar.h"
+#include "builtin.h"
+
+#define RECORDSIZE	(512)
+#define BLOCKSIZE	(RECORDSIZE * 20)
+
+static const char tar_tree_usage[] = "git-tar-tree <key> [basedir]";
+
+static char block[BLOCKSIZE];
+static unsigned long offset;
+
+static time_t archive_time;
+
+/* tries hard to write, either succeeds or dies in the attempt */
+static void reliable_write(void *buf, unsigned long size)
+{
+	while (size > 0) {
+		long ret = xwrite(1, buf, size);
+		if (ret < 0) {
+			if (errno == EPIPE)
+				exit(0);
+			die("git-tar-tree: %s", strerror(errno));
+		} else if (!ret) {
+			die("git-tar-tree: disk full?");
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
+/* acquire the next record from the buffer; user must call write_if_needed() */
+static char *get_record(void)
+{
+	char *p = block + offset;
+	memset(p, 0, RECORDSIZE);
+	offset += RECORDSIZE;
+	return p;
+}
+
+/*
+ * The end of tar archives is marked by 1024 nul bytes and after that
+ * follows the rest of the block (if any).
+ */
+static void write_trailer(void)
+{
+	get_record();
+	write_if_needed();
+	get_record();
+	write_if_needed();
+	while (offset) {
+		get_record();
+		write_if_needed();
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
+static void strbuf_append_string(struct strbuf *sb, const char *s)
+{
+	int slen = strlen(s);
+	int total = sb->len + slen;
+	if (total > sb->alloc) {
+		sb->buf = xrealloc(sb->buf, total);
+		sb->alloc = total;
+	}
+	memcpy(sb->buf + sb->len, s, slen);
+	sb->len = total;
+}
+
+/*
+ * pax extended header records have the format "%u %s=%s\n".  %u contains
+ * the size of the whole string (including the %u), the first %s is the
+ * keyword, the second one is the value.  This function constructs such a
+ * string and appends it to a struct strbuf.
+ */
+static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
+                                     const char *value, unsigned int valuelen)
+{
+	char *p;
+	int len, total, tmp;
+
+	/* "%u %s=%s\n" */
+	len = 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
+	for (tmp = len; tmp > 9; tmp /= 10)
+		len++;
+
+	total = sb->len + len;
+	if (total > sb->alloc) {
+		sb->buf = xrealloc(sb->buf, total);
+		sb->alloc = total;
+	}
+
+	p = sb->buf;
+	p += sprintf(p, "%u %s=", len, keyword);
+	memcpy(p, value, valuelen);
+	p += valuelen;
+	*p = '\n';
+	sb->len = total;
+}
+
+static unsigned int ustar_header_chksum(const struct ustar_header *header)
+{
+	char *p = (char *)header;
+	unsigned int chksum = 0;
+	while (p < header->chksum)
+		chksum += *p++;
+	chksum += sizeof(header->chksum) * ' ';
+	p += sizeof(header->chksum);
+	while (p < (char *)header + sizeof(struct ustar_header))
+		chksum += *p++;
+	return chksum;
+}
+
+static int get_path_prefix(const struct strbuf *path, int maxlen)
+{
+	int i = path->len;
+	if (i > maxlen)
+		i = maxlen;
+	while (i > 0 && path->buf[i] != '/')
+		i--;
+	return i;
+}
+
+static void write_entry(const unsigned char *sha1, struct strbuf *path,
+                        unsigned int mode, void *buffer, unsigned long size)
+{
+	struct ustar_header header;
+	struct strbuf ext_header;
+
+	memset(&header, 0, sizeof(header));
+	ext_header.buf = NULL;
+	ext_header.len = ext_header.alloc = 0;
+
+	if (!sha1) {
+		*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
+		mode = 0100666;
+		strcpy(header.name, "pax_global_header");
+	} else if (!path) {
+		*header.typeflag = TYPEFLAG_EXT_HEADER;
+		mode = 0100666;
+		sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
+	} else {
+		if (S_ISDIR(mode)) {
+			*header.typeflag = TYPEFLAG_DIR;
+			mode |= 0777;
+		} else if (S_ISLNK(mode)) {
+			*header.typeflag = TYPEFLAG_LNK;
+			mode |= 0777;
+		} else if (S_ISREG(mode)) {
+			*header.typeflag = TYPEFLAG_REG;
+			mode |= (mode & 0100) ? 0777 : 0666;
+		} else {
+			error("unsupported file mode: 0%o (SHA1: %s)",
+			      mode, sha1_to_hex(sha1));
+			return;
+		}
+		if (path->len > sizeof(header.name)) {
+			int plen = get_path_prefix(path, sizeof(header.prefix));
+			int rest = path->len - plen - 1;
+			if (plen > 0 && rest <= sizeof(header.name)) {
+				memcpy(header.prefix, path->buf, plen);
+				memcpy(header.name, path->buf + plen + 1, rest);
+			} else {
+				sprintf(header.name, "%s.data",
+				        sha1_to_hex(sha1));
+				strbuf_append_ext_header(&ext_header, "path",
+				                         path->buf, path->len);
+			}
+		} else
+			memcpy(header.name, path->buf, path->len);
+	}
+
+	if (S_ISLNK(mode) && buffer) {
+		if (size > sizeof(header.linkname)) {
+			sprintf(header.linkname, "see %s.paxheader",
+			        sha1_to_hex(sha1));
+			strbuf_append_ext_header(&ext_header, "linkpath",
+			                         buffer, size);
+		} else
+			memcpy(header.linkname, buffer, size);
+	}
+
+	sprintf(header.mode, "%07o", mode & 07777);
+	sprintf(header.size, "%011lo", S_ISREG(mode) ? size : 0);
+	sprintf(header.mtime, "%011lo", archive_time);
+
+	/* XXX: should we provide more meaningful info here? */
+	sprintf(header.uid, "%07o", 0);
+	sprintf(header.gid, "%07o", 0);
+	strncpy(header.uname, "git", 31);
+	strncpy(header.gname, "git", 31);
+	sprintf(header.devmajor, "%07o", 0);
+	sprintf(header.devminor, "%07o", 0);
+
+	memcpy(header.magic, "ustar", 6);
+	memcpy(header.version, "00", 2);
+
+	sprintf(header.chksum, "%07o", ustar_header_chksum(&header));
+
+	if (ext_header.len > 0) {
+		write_entry(sha1, NULL, 0, ext_header.buf, ext_header.len);
+		free(ext_header.buf);
+	}
+	write_blocked(&header, sizeof(header));
+	if (S_ISREG(mode) && buffer && size > 0)
+		write_blocked(buffer, size);
+}
+
+static void write_global_extended_header(const unsigned char *sha1)
+{
+	struct strbuf ext_header;
+	ext_header.buf = NULL;
+	ext_header.len = ext_header.alloc = 0;
+	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
+	write_entry(NULL, NULL, 0, ext_header.buf, ext_header.len);
+	free(ext_header.buf);
+}
+
+static void traverse_tree(struct tree_desc *tree, struct strbuf *path)
+{
+	int pathlen = path->len;
+
+	while (tree->size) {
+		const char *name;
+		const unsigned char *sha1;
+		unsigned mode;
+		void *eltbuf;
+		char elttype[20];
+		unsigned long eltsize;
+
+		sha1 = tree_entry_extract(tree, &name, &mode);
+		update_tree_entry(tree);
+
+		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
+		if (!eltbuf)
+			die("cannot read %s", sha1_to_hex(sha1));
+
+		path->len = pathlen;
+		strbuf_append_string(path, name);
+		if (S_ISDIR(mode))
+			strbuf_append_string(path, "/");
+
+		write_entry(sha1, path, mode, eltbuf, eltsize);
+
+		if (S_ISDIR(mode)) {
+			struct tree_desc subtree;
+			subtree.buf = eltbuf;
+			subtree.size = eltsize;
+			traverse_tree(&subtree, path);
+		}
+		free(eltbuf);
+	}
+}
+
+int cmd_tar_tree(int argc, const char **argv, char** envp)
+{
+	unsigned char sha1[20], tree_sha1[20];
+	struct commit *commit;
+	struct tree_desc tree;
+	struct strbuf current_path;
+
+	current_path.buf = xmalloc(PATH_MAX);
+	current_path.alloc = PATH_MAX;
+	current_path.len = current_path.eof = 0;
+
+	setup_git_directory();
+	git_config(git_default_config);
+
+	switch (argc) {
+	case 3:
+		strbuf_append_string(&current_path, argv[2]);
+		strbuf_append_string(&current_path, "/");
+		/* FALLTHROUGH */
+	case 2:
+		if (get_sha1(argv[1], sha1))
+			die("Not a valid object name %s", argv[1]);
+		break;
+	default:
+		usage(tar_tree_usage);
+	}
+
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (commit) {
+		write_global_extended_header(commit->object.sha1);
+		archive_time = commit->date;
+	} else
+		archive_time = time(NULL);
+
+	tree.buf = read_object_with_reference(sha1, tree_type, &tree.size,
+	                                      tree_sha1);
+	if (!tree.buf)
+		die("not a reference to a tag, commit or tree object: %s",
+		    sha1_to_hex(sha1));
+
+	if (current_path.len > 0)
+		write_entry(tree_sha1, &current_path, 040777, NULL, 0);
+	traverse_tree(&tree, &current_path);
+	write_trailer();
+	free(current_path.buf);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 951f206..d210543 100644
--- a/builtin.h
+++ b/builtin.h
@@ -29,5 +29,6 @@ extern int cmd_check_ref_format(int argc
 extern int cmd_init_db(int argc, const char **argv, char **envp);
 extern int cmd_ls_files(int argc, const char **argv, char **envp);
 extern int cmd_ls_tree(int argc, const char **argv, char **envp);
+extern int cmd_tar_tree(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 8574775..c253e60 100644
--- a/git.c
+++ b/git.c
@@ -54,7 +54,8 @@ static void handle_internal_command(int 
 		{ "init-db", cmd_init_db },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "ls-files", cmd_ls_files },
-		{ "ls-tree", cmd_ls_tree }
+		{ "ls-tree", cmd_ls_tree },
+		{ "tar-tree", cmd_tar_tree }
 	};
 	int i;
 
diff --git a/tar-tree.c b/tar-tree.c
deleted file mode 100644
index 3308736..0000000
--- a/tar-tree.c
+++ /dev/null
@@ -1,350 +0,0 @@
-/*
- * Copyright (c) 2005, 2006 Rene Scharfe
- */
-#include <time.h>
-#include "cache.h"
-#include "tree-walk.h"
-#include "commit.h"
-#include "strbuf.h"
-#include "tar.h"
-
-#define RECORDSIZE	(512)
-#define BLOCKSIZE	(RECORDSIZE * 20)
-
-static const char tar_tree_usage[] = "git-tar-tree <key> [basedir]";
-
-static char block[BLOCKSIZE];
-static unsigned long offset;
-
-static time_t archive_time;
-
-/* tries hard to write, either succeeds or dies in the attempt */
-static void reliable_write(void *buf, unsigned long size)
-{
-	while (size > 0) {
-		long ret = xwrite(1, buf, size);
-		if (ret < 0) {
-			if (errno == EPIPE)
-				exit(0);
-			die("git-tar-tree: %s", strerror(errno));
-		} else if (!ret) {
-			die("git-tar-tree: disk full?");
-		}
-		size -= ret;
-		buf += ret;
-	}
-}
-
-/* writes out the whole block, but only if it is full */
-static void write_if_needed(void)
-{
-	if (offset == BLOCKSIZE) {
-		reliable_write(block, BLOCKSIZE);
-		offset = 0;
-	}
-}
-
-/* acquire the next record from the buffer; user must call write_if_needed() */
-static char *get_record(void)
-{
-	char *p = block + offset;
-	memset(p, 0, RECORDSIZE);
-	offset += RECORDSIZE;
-	return p;
-}
-
-/*
- * The end of tar archives is marked by 1024 nul bytes and after that
- * follows the rest of the block (if any).
- */
-static void write_trailer(void)
-{
-	get_record();
-	write_if_needed();
-	get_record();
-	write_if_needed();
-	while (offset) {
-		get_record();
-		write_if_needed();
-	}
-}
-
-/*
- * queues up writes, so that all our write(2) calls write exactly one
- * full block; pads writes to RECORDSIZE
- */
-static void write_blocked(void *buf, unsigned long size)
-{
-	unsigned long tail;
-
-	if (offset) {
-		unsigned long chunk = BLOCKSIZE - offset;
-		if (size < chunk)
-			chunk = size;
-		memcpy(block + offset, buf, chunk);
-		size -= chunk;
-		offset += chunk;
-		buf += chunk;
-		write_if_needed();
-	}
-	while (size >= BLOCKSIZE) {
-		reliable_write(buf, BLOCKSIZE);
-		size -= BLOCKSIZE;
-		buf += BLOCKSIZE;
-	}
-	if (size) {
-		memcpy(block + offset, buf, size);
-		offset += size;
-	}
-	tail = offset % RECORDSIZE;
-	if (tail)  {
-		memset(block + offset, 0, RECORDSIZE - tail);
-		offset += RECORDSIZE - tail;
-	}
-	write_if_needed();
-}
-
-static void strbuf_append_string(struct strbuf *sb, const char *s)
-{
-	int slen = strlen(s);
-	int total = sb->len + slen;
-	if (total > sb->alloc) {
-		sb->buf = xrealloc(sb->buf, total);
-		sb->alloc = total;
-	}
-	memcpy(sb->buf + sb->len, s, slen);
-	sb->len = total;
-}
-
-/*
- * pax extended header records have the format "%u %s=%s\n".  %u contains
- * the size of the whole string (including the %u), the first %s is the
- * keyword, the second one is the value.  This function constructs such a
- * string and appends it to a struct strbuf.
- */
-static void strbuf_append_ext_header(struct strbuf *sb, const char *keyword,
-                                     const char *value, unsigned int valuelen)
-{
-	char *p;
-	int len, total, tmp;
-
-	/* "%u %s=%s\n" */
-	len = 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
-	for (tmp = len; tmp > 9; tmp /= 10)
-		len++;
-
-	total = sb->len + len;
-	if (total > sb->alloc) {
-		sb->buf = xrealloc(sb->buf, total);
-		sb->alloc = total;
-	}
-
-	p = sb->buf;
-	p += sprintf(p, "%u %s=", len, keyword);
-	memcpy(p, value, valuelen);
-	p += valuelen;
-	*p = '\n';
-	sb->len = total;
-}
-
-static unsigned int ustar_header_chksum(const struct ustar_header *header)
-{
-	char *p = (char *)header;
-	unsigned int chksum = 0;
-	while (p < header->chksum)
-		chksum += *p++;
-	chksum += sizeof(header->chksum) * ' ';
-	p += sizeof(header->chksum);
-	while (p < (char *)header + sizeof(struct ustar_header))
-		chksum += *p++;
-	return chksum;
-}
-
-static int get_path_prefix(const struct strbuf *path, int maxlen)
-{
-	int i = path->len;
-	if (i > maxlen)
-		i = maxlen;
-	while (i > 0 && path->buf[i] != '/')
-		i--;
-	return i;
-}
-
-static void write_entry(const unsigned char *sha1, struct strbuf *path,
-                        unsigned int mode, void *buffer, unsigned long size)
-{
-	struct ustar_header header;
-	struct strbuf ext_header;
-
-	memset(&header, 0, sizeof(header));
-	ext_header.buf = NULL;
-	ext_header.len = ext_header.alloc = 0;
-
-	if (!sha1) {
-		*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
-		mode = 0100666;
-		strcpy(header.name, "pax_global_header");
-	} else if (!path) {
-		*header.typeflag = TYPEFLAG_EXT_HEADER;
-		mode = 0100666;
-		sprintf(header.name, "%s.paxheader", sha1_to_hex(sha1));
-	} else {
-		if (S_ISDIR(mode)) {
-			*header.typeflag = TYPEFLAG_DIR;
-			mode |= 0777;
-		} else if (S_ISLNK(mode)) {
-			*header.typeflag = TYPEFLAG_LNK;
-			mode |= 0777;
-		} else if (S_ISREG(mode)) {
-			*header.typeflag = TYPEFLAG_REG;
-			mode |= (mode & 0100) ? 0777 : 0666;
-		} else {
-			error("unsupported file mode: 0%o (SHA1: %s)",
-			      mode, sha1_to_hex(sha1));
-			return;
-		}
-		if (path->len > sizeof(header.name)) {
-			int plen = get_path_prefix(path, sizeof(header.prefix));
-			int rest = path->len - plen - 1;
-			if (plen > 0 && rest <= sizeof(header.name)) {
-				memcpy(header.prefix, path->buf, plen);
-				memcpy(header.name, path->buf + plen + 1, rest);
-			} else {
-				sprintf(header.name, "%s.data",
-				        sha1_to_hex(sha1));
-				strbuf_append_ext_header(&ext_header, "path",
-				                         path->buf, path->len);
-			}
-		} else
-			memcpy(header.name, path->buf, path->len);
-	}
-
-	if (S_ISLNK(mode) && buffer) {
-		if (size > sizeof(header.linkname)) {
-			sprintf(header.linkname, "see %s.paxheader",
-			        sha1_to_hex(sha1));
-			strbuf_append_ext_header(&ext_header, "linkpath",
-			                         buffer, size);
-		} else
-			memcpy(header.linkname, buffer, size);
-	}
-
-	sprintf(header.mode, "%07o", mode & 07777);
-	sprintf(header.size, "%011lo", S_ISREG(mode) ? size : 0);
-	sprintf(header.mtime, "%011lo", archive_time);
-
-	/* XXX: should we provide more meaningful info here? */
-	sprintf(header.uid, "%07o", 0);
-	sprintf(header.gid, "%07o", 0);
-	strncpy(header.uname, "git", 31);
-	strncpy(header.gname, "git", 31);
-	sprintf(header.devmajor, "%07o", 0);
-	sprintf(header.devminor, "%07o", 0);
-
-	memcpy(header.magic, "ustar", 6);
-	memcpy(header.version, "00", 2);
-
-	sprintf(header.chksum, "%07o", ustar_header_chksum(&header));
-
-	if (ext_header.len > 0) {
-		write_entry(sha1, NULL, 0, ext_header.buf, ext_header.len);
-		free(ext_header.buf);
-	}
-	write_blocked(&header, sizeof(header));
-	if (S_ISREG(mode) && buffer && size > 0)
-		write_blocked(buffer, size);
-}
-
-static void write_global_extended_header(const unsigned char *sha1)
-{
-	struct strbuf ext_header;
-	ext_header.buf = NULL;
-	ext_header.len = ext_header.alloc = 0;
-	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
-	write_entry(NULL, NULL, 0, ext_header.buf, ext_header.len);
-	free(ext_header.buf);
-}
-
-static void traverse_tree(struct tree_desc *tree, struct strbuf *path)
-{
-	int pathlen = path->len;
-
-	while (tree->size) {
-		const char *name;
-		const unsigned char *sha1;
-		unsigned mode;
-		void *eltbuf;
-		char elttype[20];
-		unsigned long eltsize;
-
-		sha1 = tree_entry_extract(tree, &name, &mode);
-		update_tree_entry(tree);
-
-		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
-		if (!eltbuf)
-			die("cannot read %s", sha1_to_hex(sha1));
-
-		path->len = pathlen;
-		strbuf_append_string(path, name);
-		if (S_ISDIR(mode))
-			strbuf_append_string(path, "/");
-
-		write_entry(sha1, path, mode, eltbuf, eltsize);
-
-		if (S_ISDIR(mode)) {
-			struct tree_desc subtree;
-			subtree.buf = eltbuf;
-			subtree.size = eltsize;
-			traverse_tree(&subtree, path);
-		}
-		free(eltbuf);
-	}
-}
-
-int main(int argc, char **argv)
-{
-	unsigned char sha1[20], tree_sha1[20];
-	struct commit *commit;
-	struct tree_desc tree;
-	struct strbuf current_path;
-
-	current_path.buf = xmalloc(PATH_MAX);
-	current_path.alloc = PATH_MAX;
-	current_path.len = current_path.eof = 0;
-
-	setup_git_directory();
-	git_config(git_default_config);
-
-	switch (argc) {
-	case 3:
-		strbuf_append_string(&current_path, argv[2]);
-		strbuf_append_string(&current_path, "/");
-		/* FALLTHROUGH */
-	case 2:
-		if (get_sha1(argv[1], sha1))
-			die("Not a valid object name %s", argv[1]);
-		break;
-	default:
-		usage(tar_tree_usage);
-	}
-
-	commit = lookup_commit_reference_gently(sha1, 1);
-	if (commit) {
-		write_global_extended_header(commit->object.sha1);
-		archive_time = commit->date;
-	} else
-		archive_time = time(NULL);
-
-	tree.buf = read_object_with_reference(sha1, tree_type, &tree.size,
-	                                      tree_sha1);
-	if (!tree.buf)
-		die("not a reference to a tag, commit or tree object: %s",
-		    sha1_to_hex(sha1));
-
-	if (current_path.len > 0)
-		write_entry(tree_sha1, &current_path, 040777, NULL, 0);
-	traverse_tree(&tree, &current_path);
-	write_trailer();
-	free(current_path.buf);
-	return 0;
-}
-- 
1.3.3.g288c
