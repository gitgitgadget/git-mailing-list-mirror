From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/4] Support for refs directory
Date: Fri, 13 May 2005 02:53:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505130249390.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 08:46:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWTvs-0008Jr-M2
	for gcvg-git@gmane.org; Fri, 13 May 2005 08:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVEMGxt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 02:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVEMGxt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 02:53:49 -0400
Received: from iabervon.org ([66.92.72.58]:46853 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262266AbVEMGxg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 02:53:36 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWU2q-0007no-00; Fri, 13 May 2005 02:53:12 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add support for reading and writing files in the refs directory.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 2a5e43fa9318a648bfb4dbf64208f4c26905a5f8/Makefile  (mode:100644 sha1:6afcb3e867a6857f9128dba877e433c12366c1f4)
+++ adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/Makefile  (mode:100644 sha1:653912b7290d1a28860db41f602fbf15ca2d9aa5)
@@ -36,9 +36,10 @@
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o
+	 tag.o date.o refs.o
+
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h refs.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
Index: cache.h
===================================================================
--- 2a5e43fa9318a648bfb4dbf64208f4c26905a5f8/cache.h  (mode:100644 sha1:c06b94107e0e1149be0ad642812e8d4a42f2193c)
+++ adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/cache.h  (mode:100644 sha1:ca9d13a972e05d8d0aa15babd5a963688fdd5968)
@@ -110,8 +110,10 @@
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
+#define REFS_ENVIRONMENT "GIT_REFS_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 
+extern char *get_refs_directory(void);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
 
Index: init-db.c
===================================================================
--- 2a5e43fa9318a648bfb4dbf64208f4c26905a5f8/init-db.c  (mode:100644 sha1:b6bb78356762bd28261949da54638f46776e6d4b)
+++ adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/init-db.c  (mode:100644 sha1:3441a35d7c2eb88e76db4886e8c068ca898ea8fd)
@@ -40,6 +40,7 @@
 	memcpy(path, sha1_dir, len);
 
 	safe_create_dir(sha1_dir);
+	safe_create_dir(get_refs_directory());
 	for (i = 0; i < 256; i++) {
 		sprintf(path+len, "/%02x", i);
 		safe_create_dir(path);
Index: refs.c
===================================================================
--- /dev/null  (tree:2a5e43fa9318a648bfb4dbf64208f4c26905a5f8)
+++ adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/refs.c  (mode:100644 sha1:9ba5696c15d8597236e1f5b7a4dbd609045efc81)
@@ -0,0 +1,139 @@
+#include "refs.h"
+#include "cache.h"
+
+#include <errno.h>
+
+static char *split_ref_file_name(const char *dir, const char *name)
+{
+	char *base = get_refs_directory();
+	int baselen = strlen(base);
+	int dirlen = strlen(dir);
+	int namelen = strlen(name);
+	char *ret;
+	if (dir[0] == '.')
+		return NULL;
+	if (strchr(dir, '/'))
+		return NULL;
+	if (strchr(name, '/'))
+		return NULL;
+	ret = xmalloc(baselen + 3 + dirlen + namelen);
+	strcpy(ret, base);
+	ret[baselen] = '/';
+	strcpy(ret + baselen + 1, dir);
+	ret[baselen + 1 + dirlen] = '/';
+	strcpy(ret + baselen + 2 + dirlen, name);
+	ret[baselen + 2 + dirlen + namelen] = '\0';
+	return ret;
+}
+
+static char *ref_file_name(const char *ref)
+{
+	char *base = get_refs_directory();
+	int baselen = strlen(base);
+	int reflen = strlen(ref);
+	char *ret;
+	char *check;
+	if (ref[0] == '.')
+		return NULL;
+	check = strchr(ref, '/');
+	if (!check)
+		return NULL;
+	if (strchr(check + 1, '/'))
+		return NULL;
+	ret = xmalloc(baselen + 2 + reflen);
+	strcpy(ret, base);
+	ret[baselen] = '/';
+	strcpy(ret + baselen + 1, ref);
+	ret[baselen + 1 + reflen] = '\0';
+	return ret;
+}
+
+static int read_ref_file(char *filename, unsigned char *sha1) {
+	int fd = open(filename, O_RDONLY);
+	char hex[41];
+	if (fd < 0) {
+		return error("Couldn't open %s\n", filename);
+	}
+	if ((read(fd, hex, 41) < 41) ||
+	    (hex[40] != '\n') ||
+	    get_sha1_hex(hex, sha1)) {
+		error("Couldn't read a hash from %s\n", filename);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+	return 0;
+}
+
+int get_split_ref_sha1(const char *dir, const char *name, unsigned char *sha1)
+{
+	char *filename = split_ref_file_name(dir, name);
+	int retval;
+	if (!filename)
+		return -1;
+	retval = read_ref_file(filename, sha1);
+	free(filename);
+	return retval;
+}
+
+int get_ref_sha1(const char *ref, unsigned char *sha1)
+{
+	char *filename = ref_file_name(ref);
+	int retval;
+	if (!filename)
+		return -1;
+	retval = read_ref_file(filename, sha1);
+	free(filename);
+	return retval;
+}
+
+int write_split_ref_sha1(const char *dir, const char *name,
+			 unsigned char *sha1)
+{
+	char *filename = split_ref_file_name(dir, name);
+	char *hex = sha1_to_hex(sha1);
+	char term = '\n';
+	int fd;
+	if (!filename)
+		return -1;
+	unlink(filename);
+	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	if (fd < 0 && errno == ENOENT) {
+		char *dirname = split_ref_file_name(dir, "");
+		mkdir(dirname, 0755);
+		free(dirname);
+		fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	}
+	if (fd < 0) {
+		error("Couldn't open for writing %s: %s\n", filename,
+		      strerror(errno));
+		free(filename);
+		return -1;
+	}
+	if (write(fd, hex, 40) < 40 ||
+	    write(fd, &term, 1) < 1) {
+		error("Couldn't write %s\n", filename);
+		free(filename);
+		close(fd);
+		return -1;
+	}
+	close(fd);
+	return 0;
+	
+}
+
+int split_ref(char **dir, char **name, const char *ref)
+{
+	char *middle = strchr(ref, '/');
+	if (ref[0] == '.')
+		return -1;
+	if (!middle)
+		return -1;
+	if (strchr(middle + 1, '/'))
+		return -1;
+	*dir = xmalloc(middle - ref + 1);
+	*name = strdup(middle + 1);
+	(*dir)[middle - ref] = '\0';
+	memcpy(*dir, ref, middle - ref);
+	return 0;
+}
Index: refs.h
===================================================================
--- /dev/null  (tree:2a5e43fa9318a648bfb4dbf64208f4c26905a5f8)
+++ adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/refs.h  (mode:100644 sha1:9ef6ed7563f70273aef6574a01d5626fee28345a)
@@ -0,0 +1,20 @@
+#ifndef REFS_H
+#define REFS_H
+
+/** Reads the refs file specified into sha1 **/
+extern int get_split_ref_sha1(const char *dir, const char *name,
+			      unsigned char *sha1);
+
+/** Reads the refs file specified into sha1 **/
+extern int get_ref_sha1(const char *ref, unsigned char *sha1);
+
+/** Writes sha1 into the refs file specified **/
+extern int write_split_ref_sha1(const char *dir, const char *name, 
+				unsigned char *sha1);
+
+/** Sets dir and name to the directory and name parts of ref, in new
+ * storage. 
+ **/
+extern int split_ref(char **dir, char **name, const char *ref);
+
+#endif /* REFS_H */
Index: sha1_file.c
===================================================================
--- 2a5e43fa9318a648bfb4dbf64208f4c26905a5f8/sha1_file.c  (mode:100644 sha1:942b673dc3c7fa9f057c5c452e3a1b73eaeb8707)
+++ adc28203a55e7e9d3c0b4f6546ea0c2b99106f24/sha1_file.c  (mode:100644 sha1:a3ab45fbb39f37622ae191fe5c3cbaf30389ec74)
@@ -59,7 +59,7 @@
 	return get_sha1_hex(buffer, result);
 }
 
-static char *git_dir, *git_object_dir, *git_index_file;
+static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir;
 static void setup_git_env(void)
 {
 	git_dir = gitenv(GIT_DIR_ENVIRONMENT);
@@ -70,6 +70,11 @@
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
 	}
+	git_refs_dir = gitenv(REFS_ENVIRONMENT);
+	if (!git_refs_dir) {
+		git_refs_dir = xmalloc(strlen(git_dir) + 6);
+		sprintf(git_refs_dir, "%s/refs", git_dir);
+	}
 	git_index_file = gitenv(INDEX_ENVIRONMENT);
 	if (!git_index_file) {
 		git_index_file = xmalloc(strlen(git_dir) + 7);
@@ -91,6 +96,13 @@
 	return git_index_file;
 }
 
+char *get_refs_directory(void)
+{
+	if (!git_refs_dir)
+		setup_git_env();
+	return git_refs_dir;
+}
+
 int get_sha1(const char *str, unsigned char *sha1)
 {
 	static char pathname[PATH_MAX];

